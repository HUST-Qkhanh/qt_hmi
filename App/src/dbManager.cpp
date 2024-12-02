#include "dbManager.h"

MongoDBClient *MongoDBClient::pinstance_{nullptr};
std::mutex MongoDBClient::mutex_;

MongoDBClient *MongoDBClient::getInstance() {
    std::lock_guard<std::mutex> lock(mutex_);

    if (pinstance_ == nullptr) {
        pinstance_ = new MongoDBClient();
    }
    return pinstance_;
}
// MongoDBClient::~MongoDBClient() {
//     if (pinstance_) {
//         delete pinstance_;
//         pinstance_ = nullptr;
//     }
// }

MongoDBClient::MongoDBClient() {
    std::cout << "Created new MongoDB Client.\n";
}

void MongoDBClient::initialize(const std::string &uri) {
    if (!isInitialized_) {
        try {
            pool_ = std::make_shared<mongocxx::pool>(mongocxx::uri{uri});
            // dbClient_ = mongocxx::client(mongocxx::uri{uri});
        } catch (const std::exception &e) {
            std::cerr << "mongoDb init error: " << e.what() << '\n';
            return;
        }

        isInitialized_ = true;
        std::cout << "MongoDB pool initialized with URI: " << uri << "\n";
    } else {
        std::cerr
            << "MongoDB client already initialized. Initialization skipped.\n";
    }
}

mongocxx::pool::entry MongoDBClient::getClient() {  // Synchronize pool access
    if (!isInitialized_) {
        throw std::runtime_error("MongoDB pool not initialized.");
    }
    auto client = pool_->acquire();
    return client;
}

mongocxx::database MongoDBClient::getDatabase(const std::string &dbName) {
    auto client = getClient();
    return client->database(dbName);
}

void MongoDBClient::writeToCollection(const std::string &dbName,
                                      const std::string &collectionName,
                                      const std::string &doc) {
    auto client = getClient();
    auto db = client->database(dbName);
    auto collection = db[collectionName];
    auto bsonDoc = bsoncxx::from_json(doc);
    collection.insert_one(bsonDoc.view());
    std::cout << "Document inserted into " << dbName << "." << collectionName
              << "\n";
}

void MongoDBClient::editInCollection(const std::string &dbName,
                                     const std::string &collectionName,
                                     const std::string &filter,
                                     const std::string &update) {
    try {
        auto client = getClient();
        auto db = client->database(dbName);
        auto collection = db[collectionName];
        auto bsonFilter = bsoncxx::from_json(filter);
        auto bsonDoc = bsoncxx::from_json(update);

        // Check if the update document starts with an operator (i.e., '$')
        if (std::string(bsonDoc.view().begin()->key())[0] != '$') {
            // If not, add $set to the document
            bsoncxx::builder::basic::document newDoc;
            newDoc.append(bsoncxx::builder::basic::kvp("$set", bsonDoc.view()));

            // Extract the BSON document value
            bsonDoc = newDoc.extract();  // Now bsonDoc is a proper BSON document value
        }

        // Execute the update
        auto result = collection.update_one(bsonFilter.view(), bsonDoc.view());
        if (result && result->matched_count() > 0) {
            std::cout << "Document updated successfully.\n";
        } else {
            std::cerr << "No document matched the given filter.\n";
        }
    } catch (const std::exception &e) {
        std::cerr << "Error updating document: " << e.what() << std::endl;
    }
}

void MongoDBClient::fetchFromCollection(const std::string &dbName,
                                        const std::string &collectionName,
                                        const std::string &filter,
                                        std::string &fetchedStr) {
    auto client = getClient();
    auto db = client->database(dbName);
    auto collection = db[collectionName];
    auto bsonFilter = bsoncxx::from_json(filter);
    // std::cout << "fetch filter: " << filter << "\n";
    auto result = collection.find_one(bsonFilter.view());
    if (result) {
        // Chuyển đổi tài liệu thành JSON
        bsoncxx::document::view view = result->view();
        fetchedStr = bsoncxx::to_json(view);
        // std::cout << "Fetch document successfully: " << fetchedStr << "\n";
        // std::cout << "Fetch document successfully: \n";
    } else {
        std::cerr << "No document matched the given filter.\n";
    }
}

void MongoDBClient::fetchAllCollection(const std::string &dbName,
                                       const std::string &collectionName,
                                       const std::string &indexKey,
                                       std::vector<std::string> &fetchedDocs) {
    auto client = getClient();
    auto db = client->database(dbName);
    auto collection = db[collectionName];
    auto sizeOfCollection = collection.count_documents({});
    // std::cout << "collection: " << collectionName << " - size: " << sizeOfCollection << "\n";
    for (size_t i = 0; i < sizeOfCollection; i++) {
        json filter;
        filter[indexKey] = i + 1;
        std::string cellProperties = "";
        fetchFromCollection(dbName, collectionName, filter.dump(), cellProperties);
        // std::cout << "cell properties: " << cellProperties << "\n";
        if (cellProperties == "") {
            fetchedDocs.clear();  // if error empty the result
            break;
        };
        fetchedDocs.push_back(cellProperties);
    }
}

void MongoDBClient::eraseFromCollection(const std::string &dbName,
                                        const std::string &collectionName,
                                        const std::string &filter) {
    auto client = getClient();
    auto db = client->database(dbName);
    auto collection = db[collectionName];
    auto bsonFilter = bsoncxx::from_json(filter);

    // Use delete_many to remove all documents matching the filter
    auto result = collection.delete_many(bsonFilter.view());

    if (result) {
        std::cout << "Deleted " << result->deleted_count() << " documents from "
                  << dbName << "." << collectionName << "\n";
    } else {
        std::cerr << "No documents matched the filter.\n";
    }
}

void MongoDBClient::addMidleCollection(const std::string &dbName, const std::string &collectionName, const std::string &filter, const std::string &doc) {
    auto client = getClient();
    auto db = client->database(dbName);
    auto collection = db[collectionName];
    // find the indexKey
    json filterJson = json::parse(filter);
    auto indexKey = filterJson.begin().key();
    auto indexValue = filterJson.begin().value().get<int>();
    std::cout << "filter: " << indexKey << " - " << indexValue << "\n";
    std::cerr << "addMiddle of collection: " << dbName << "." << collectionName << " - indexKey: " << indexKey << "\n";

    // find docs and increase all value of indexKey that larger than the added doc's indexKey
    bsoncxx::builder::stream::document filter_builder, update_builder;

    filter_builder << indexKey << bsoncxx::builder::stream::open_document
                   << "$gte" << indexValue
                   << bsoncxx::builder::stream::close_document;

    update_builder << "$inc" << bsoncxx::builder::stream::open_document
                   << indexKey << 1
                   << bsoncxx::builder::stream::close_document;

    auto result = collection.update_many(filter_builder.view(), update_builder.view());
    if (result) {
        std::cout << "Matched documents: " << result->matched_count() << std::endl;
        std::cout << "Modified documents: " << result->modified_count() << std::endl;
    } else {
        std::cout << "Update operation failed." << std::endl;
        return;
    }
    writeToCollection(dbName, collectionName, doc);
}

void MongoDBClient::removeMidleCollection(const std::string &dbName, const std::string &collectionName, const std::string &filter) {
    auto client = getClient();
    auto db = client->database(dbName);
    auto collection = db[collectionName];
    eraseFromCollection(dbName, collectionName, filter);
    // find the indexKey
    json filterJson = json::parse(filter);
    auto indexKey = filterJson.begin().key();
    auto indexValue = filterJson.begin().value().get<int>();
    std::cout << "filter: " << indexKey << " - " << indexValue << "\n";
    std::cerr << "addMiddle of collection: " << dbName << "." << collectionName << " - indexKey: " << indexKey << "\n";

    // find docs and increase all value of indexKey that larger than the added doc's indexKey
    bsoncxx::builder::stream::document filter_builder, update_builder;

    filter_builder << indexKey << bsoncxx::builder::stream::open_document
                   << "$gte" << indexValue
                   << bsoncxx::builder::stream::close_document;

    update_builder << "$inc" << bsoncxx::builder::stream::open_document
                   << indexKey << -1
                   << bsoncxx::builder::stream::close_document;

    auto result = collection.update_many(filter_builder.view(), update_builder.view());
    if (result) {
        std::cout << "Matched documents: " << result->matched_count() << std::endl;
        std::cout << "Modified documents: " << result->modified_count() << std::endl;
    } else {
        std::cout << "Update operation failed." << std::endl;
        return;
    }
}

bool MongoDBClient::checkChangeStream(const std::string &dbName, const std::string &collectionName) {
    auto client = getClient();
    auto db = client->database(dbName);
    auto collection = db[collectionName];
    try {
        auto changeStream = collection.watch();
        if (auto change = changeStream.begin(); change != changeStream.end()) {
            std::cout << "changes detected in" << dbName << "." << collectionName << "\n";
            return true;
        }
        return false;

    } catch (const std::exception &e) {
        std::cerr << "Error in change stream " << e.what() << '\n';
        return false;
    }
}

int MongoDBClient::getCollectionSize(const std::string &dbName, const std::string &collectionName) {
    // Count all documents in the collection
    auto client = getClient();
    auto db = client->database(dbName);
    auto collection = db[collectionName];
    auto count = collection.count_documents({});
    // std::cout << "Collection size: " << count << " documents" << std::endl;
    return count;
}

// FIX: change
void MongoDBClient::getUniqueList(const std::string &dbName,
                                  const std::string &collectionName,
                                  const std::string &key,
                                  std::vector<std::string> &uniqueList) {
    auto client = getClient();
    auto db = client->database(dbName);
    auto collection = db[collectionName];

    // Get distinct values for the key
    auto cursor = collection.distinct(key, {});

    // Iterate over the distinct values
    for (const auto &element : cursor) {
        uniqueList.push_back(bsoncxx::to_json(element));
    }

    // Print the unique values
    std::cout << "Unique " << key << " values:" << std::endl;
    for (const auto &val : uniqueList) {
        std::cout << val << std::endl;
    }
}

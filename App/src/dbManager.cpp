#include "dbManager.h"

MongoDBClient *MongoDBClient::pinstance_{nullptr};
std::mutex MongoDBClient::mutex_;

MongoDBClient *MongoDBClient::getInstance(const std::string &value)
{
    std::lock_guard<std::mutex> lock(mutex_);

    if (pinstance_ == nullptr)
    {
        pinstance_ = new MongoDBClient(value);
    }
    return pinstance_;
}

MongoDBClient::MongoDBClient(const std::string &value) : value_(value), client_(mongocxx::uri{})
{
    std::cout << "MongoDB client initialized with default URI.\n";
    isInitialized_ = true;
}

void MongoDBClient::initialize(const std::string &uri)
{
    if (!isInitialized_)
    {
        client_ = mongocxx::client(mongocxx::uri{uri});
        isInitialized_ = true;
        std::cout << "MongoDB client initialized with URI: " << uri << "\n";
    }
    else
    {
        std::cout << "MongoDB client already initialized. Initialization skipped.\n";
    }
}

mongocxx::database MongoDBClient::getDatabase(const std::string &dbName)
{
    return client_[dbName];
}

void MongoDBClient::writeToCollection(const std::string &dbName, const std::string &collectionName, const bsoncxx::document::view_or_value &doc)
{
    auto collection = client_[dbName][collectionName];
    collection.insert_one(doc);
    std::cout << "Document inserted into " << dbName << "." << collectionName << "\n";
}

void MongoDBClient::editInCollection(const std::string &dbName, const std::string &collectionName, const bsoncxx::document::view_or_value &filter, const bsoncxx::document::view_or_value &update)
{
    auto collection = client_[dbName][collectionName];
    auto result = collection.update_one(filter, update);
    if (result && result->matched_count() > 0)
    {
        std::cout << "Document updated successfully.\n";
    }
    else
    {
        std::cout << "No document matched the given filter.\n";
    }
}

void MongoDBClient::eraseFromCollection(const std::string &dbName, const std::string &collectionName, const bsoncxx::document::view_or_value &filter)
{
    auto collection = client_[dbName][collectionName];

    // Use delete_many to remove all documents matching the filter
    auto result = collection.delete_many(filter);

    if (result)
    {
        std::cout << "Deleted " << result->deleted_count() << " documents from " << dbName << "." << collectionName << "\n";
    }
    else
    {
        std::cout << "No documents matched the filter.\n";
    }
}
#include "model_queue.h"

// Constructor to initialize from nlohmann::json
ModelQueue::ModelQueue(const nlohmann::json& json, int queue_size) {
    Id = json.at("Id").get<std::string>();
    Time = json.at("Time").get<std::string>();
    Barcode = json.at("Barcode").get<std::string>();
    PalletInfo = json.at("PalletInfo").get<std::string>();
    Model = json.at("Model").get<std::string>();
    Merchandise = json.at("Merchandise").get<std::string>();
    NameModel = json.at("NameModel").get<std::string>();
    Destination = json.at("Destination").get<std::string>();
    Count = json.at("Count").get<std::string>();
    ZoneId = json.at("ZoneId").get<std::string>();
    ColumnId = json.at("ColumnId").get<std::string>();
    LocationId = json.at("LocationId").get<std::string>();
    queue = queue_size;
}

// Method to convert the object to BSON
bsoncxx::document::value ModelQueue::to_bson() const {
    return bsoncxx::builder::stream::document{}
        << "Id" << Id
        << "Time" << Time
        << "Barcode" << Barcode
        << "PalletInfo" << PalletInfo
        << "Model" << Model
        << "Merchandise" << Merchandise
        << "NameModel" << NameModel
        << "Destination" << Destination
        << "Count" << Count
        << "ZoneId" << ZoneId
        << "ColumnId" << ColumnId
        << "LocationId" << LocationId
        << "queue" << queue
        << bsoncxx::builder::stream::finalize;
}

// Method to insert the object into MongoDB
int ModelQueue::insert(mongocxx::collection& collection) const {
    auto result = collection.insert_one(to_bson().view());
    if (result) {
        std::cout << "Inserted with id: " << result->inserted_id().get_oid().value.to_string() << std::endl;
        return 1;
    } else {
        std::cerr << "Insert failed" << std::endl;
        return 0;
    }
}

// Method to update the object in MongoDB
int ModelQueue::update(mongocxx::collection& collection, const bsoncxx::document::view_or_value& filter) const {
    bsoncxx::document::value update_document = bsoncxx::builder::stream::document{}
        << "$set" << to_bson().view()
        << bsoncxx::builder::stream::finalize;

    auto result = collection.update_one(filter, update_document.view());
    if (result && result->matched_count() > 0) {
        std::cout << "Document updated, matched count: " << result->matched_count()
                  << ", modified count: " << result->modified_count() << std::endl;
        return 1;
    } else {
        std::cerr << "Update failed or no document matched the filter" << std::endl;
        return 0;
    }
}

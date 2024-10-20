#include "model_buffer.h"

// Constructor to initialize from nlohmann::json
ModelBuffer::ModelBuffer(const nlohmann::json& json, int queue_size) {
    id = json.at("id").get<std::string>();
    id_hang = json.at("id_hang").get<std::string>();
    status = json.at("status").get<std::string>();
    stt = json.at("stt").get<int32_t>();
    type = json.at("type").get<int32_t>();
    height = json.at("height").get<double>();
    width = json.at("width").get<double>();
    length = json.at("length").get<double>();
    zone_id = json.at("zone_id").get<int32_t>();
    column_id = json.at("column_id").get<int32_t>();
    location_id = json.at("location_id").get<int32_t>();
}

// Method to convert the object to BSON
bsoncxx::document::value ModelBuffer::to_bson() const {
    return bsoncxx::builder::stream::document{} 
        << "id" << id
        << "id_hang" << id_hang
        << "status" << status
        << "stt" << stt
        << "type" << type
        << "height" << height
        << "width" << width
        << "length" << length
        << "zone_id" << zone_id
        << "column_id" << column_id
        << "location_id" << location_id
        << bsoncxx::builder::stream::finalize;
}

// Method to insert the object into MongoDB
int ModelBuffer::insert(mongocxx::collection& collection) const {
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
int ModelBuffer::update(mongocxx::collection& collection, const bsoncxx::document::view_or_value& filter) const {
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

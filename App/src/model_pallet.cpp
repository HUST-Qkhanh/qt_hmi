#include "model_pallet.h"

// Constructor to initialize from nlohmann::json
ModelPallet::ModelPallet(const nlohmann::json& json) {
    Merchandise = json.at("Merchandise").get<std::string>();
    Count = json.at("Count").get<std::string>();
    length = json.at("length").get<std::string>();
    height = json.at("height").get<std::string>();
    width = json.at("width").get<std::string>();
    pallet_type = json.at("pallet_type").get<std::string>();
}

// Method to convert the object to BSON
bsoncxx::document::value ModelPallet::to_bson() const {
    return bsoncxx::builder::stream::document{}
        << "Merchandise" << Merchandise
        << "Count" << Count
        << "length" << length
        << "height" << height
        << "width" << width
        << "pallet_type" << pallet_type
        << bsoncxx::builder::stream::finalize;
}

// Method to insert the object into MongoDB
int ModelPallet::insert(mongocxx::collection& collection) const {
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
int ModelPallet::update(mongocxx::collection& collection, const bsoncxx::document::view_or_value& filter) const {
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

#ifndef __MODEL_PALLET__
#define __MODEL_PALLET__

#include <bsoncxx/builder/stream/document.hpp>
#include <mongocxx/client.hpp>
#include <mongocxx/instance.hpp>
#include <mongocxx/uri.hpp>
#include <nlohmann/json.hpp>
#include <iostream>
#include <string>

class ModelPallet {
public:
    // Constructor to initialize from nlohmann::json
    ModelPallet(const nlohmann::json& json);

    // Method to convert the object to BSON
    bsoncxx::document::value to_bson() const;

    // Method to insert the object into MongoDB
    int insert(mongocxx::collection& collection) const;

    // Method to update the object in MongoDB
    int update(mongocxx::collection& collection, const bsoncxx::document::view_or_value& filter) const;

private:
    std::string Merchandise;
    std::string Count;
    std::string length;
    std::string height;
    std::string width;
    std::string pallet_type;
};

#endif

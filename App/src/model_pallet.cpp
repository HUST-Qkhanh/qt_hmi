#include "model_pallet.h"

// Constructor to initialize from nlohmann::json
ModelPallet::ModelPallet(const nlohmann::json& json) {
    try {
        Merchandise = json.at("Merchandise").get<std::string>();
        Count = json.at("Count").get<std::string>();
        length = json.at("length").get<std::string>();
        height = json.at("height").get<std::string>();
        width = json.at("width").get<std::string>();
        pallet_type = json.at("pallet_type").get<std::string>();
    } catch (nlohmann::json::exception& e) {
        throw std::runtime_error("Missing key in model JSON: " + std::string(e.what()));
    }
}

// Method to convert the object to JSON
std::string ModelPallet::getDoc() const {
    nlohmann::json json;
    json["Merchandise"] = Merchandise;
    json["Count"] = Count;
    json["length"] = length;
    json["height"] = height;
    json["width"] = width;
    json["pallet_type"] = pallet_type;
    return json.dump();
}
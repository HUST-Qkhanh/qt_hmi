#include "model_queue.h"

// Constructor to initialize from nlohmann::json
ModelQueue::ModelQueue(const nlohmann::json& json) {
    try {
        Id = "3";
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
        queue = json.at("LocationId").get<int>();
    } catch (nlohmann::json::exception& e) {
        throw std::runtime_error("Missing key in JSON: " + std::string(e.what()));
    }
}

// Method to convert the object to JSON
std::string ModelQueue::getDoc() const {
    nlohmann::json json;
    json["Id"] = Id;
    json["Barcode"] = Barcode;
    json["PalletInfo"] = PalletInfo;
    json["Model"] = Model;
    json["Merchandise"] = Merchandise;
    json["NameModel"] = NameModel;
    json["Destination"] = Destination;
    json["Count"] = Count;
    json["ZoneId"] = ZoneId;
    json["ColumnId"] = ColumnId;
    json["LocationId"] = LocationId;
    return json.dump();
}
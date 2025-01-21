#include "responseFormat.h"

// Constructor to initialize from nlohmann::json
ResponseFormat::ResponseFormat(const nlohmann::json &json)
{
    try
    {
        // Barcode = json.at("Barcode").get<std::string>();
        PalletInfo = json.at("PalletInfo").get<std::string>();
        Model = json.at("Model").get<std::string>();
        Merchandise = json.at("Merchandise").get<std::string>();
        NameModel = json.at("NameModel").get<std::string>();
        Destination = json.at("Destination").get<std::string>();
        Count = json.at("Count").get<std::string>();
        ZoneId = json.at("ZoneId").get<std::string>();
        ColumnId = json.at("ColumnId").get<std::string>();
        LocationId = json.at("LocationId").get<std::string>();
        length = json.at("length").get<std::string>();
        height = json.at("height").get<std::string>();
        width = json.at("width").get<std::string>();
        pallet_type = json.at("pallet_type").get<std::string>();
    }
    catch (nlohmann::json::exception &e)
    {
        throw std::runtime_error("Missing key in response JSON: " + std::string(e.what()));
    }
}

// Method to convert the object to JSON
std::string ResponseFormat::getDoc() const
{
    nlohmann::json json;
    // json["Barcode"] = Barcode;
    json["PalletInfo"] = PalletInfo;
    json["Model"] = Model;
    json["Merchandise"] = Merchandise;
    json["NameModel"] = NameModel;
    json["Destination"] = Destination;
    json["Count"] = Count;
    json["ZoneId"] = ZoneId;
    json["ColumnId"] = ColumnId;
    json["LocationId"] = LocationId;
    json["length"] = length;
    json["height"] = height;
    json["width"] = width;
    json["pallet_type"] = pallet_type;
    return json.dump();
}
#include "model_buffer.h"

// Constructor to initialize from nlohmann::json
ModelBuffer::ModelBuffer(const nlohmann::json& json) {
    try {
        id = json.at("id").get<std::string>();
        id_hang = json.at(keys.bufferMerchandise).get<std::string>();
        status = json.at(keys.bufferStatus).get<std::string>();
        stt = json.at("stt").get<int>();
        type = json.at(keys.bufferType).get<int>();
        height = json.at(keys.height).get<double>();
        width = json.at(keys.width).get<double>();
        length = json.at(keys.length).get<double>();
        zone_id = json.at(keys.zoneId).get<int>();
        column_id = json.at(keys.columnId).get<int>();
        location_id = json.at(keys.columnId).get<int>();
    } catch (nlohmann::json::exception& e) {
        throw std::runtime_error("Missing key in JSON: " + std::string(e.what()));
    }
}

std::string ModelBuffer::getDoc() const {
    nlohmann::json json;
    json["id"] = id;
    json[keys.bufferMerchandise] = id_hang;
    json[keys.bufferStatus] = status;
    json["stt"] = stt;
    json[keys.bufferType] = type;
    json[keys.height] = height;
    json[keys.width] = width;
    json[keys.length] = length;
    json[keys.zoneId] = zone_id;
    json[keys.columnId] = column_id;
    json[keys.columnId] = location_id;
    return json.dump();
}

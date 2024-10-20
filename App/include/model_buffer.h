#ifndef __MODEL_BUFFER_H__
#define __MODEL_BUFFER_H__

#include <bsoncxx/builder/stream/document.hpp>
#include <mongocxx/client.hpp>
#include <mongocxx/instance.hpp>
#include <mongocxx/uri.hpp>
#include <nlohmann/json.hpp>
#include <iostream>
#include <string>

class ModelBuffer {
public:
    // Constructor to initialize from nlohmann::json
    ModelBuffer(const nlohmann::json& json, int queue_size = 8);

    // Method to convert the object to BSON
    bsoncxx::document::value to_bson() const;

    // Method to insert the object into MongoDB
    int insert(mongocxx::collection& collection) const;

    // Method to update the object in MongoDB
    int update(mongocxx::collection& collection, const bsoncxx::document::view_or_value& filter) const;

private:
    std::string id;
    std::string id_hang;
    std::string status;
    int stt;
    int type;
    double height;
    double width;
    double length;
    int zone_id;
    int column_id;
    int location_id;
};

#endif

#ifndef __MODEL_QUEUE_H__
#define __MODEL_QUEUE_H__

#include <bsoncxx/builder/stream/document.hpp>
#include <mongocxx/client.hpp>
#include <mongocxx/instance.hpp>
#include <mongocxx/uri.hpp>
#include <nlohmann/json.hpp>
#include <iostream>
#include <string>

class ModelQueue {
public:
    // Constructor to initialize from nlohmann::json
    ModelQueue(const nlohmann::json& json, int queue_size = 15);

    // Method to convert the object to BSON
    bsoncxx::document::value to_bson() const;

    // Method to insert the object into MongoDB
    int insert(mongocxx::collection& collection) const;

    // Method to update the object in MongoDB
    int update(mongocxx::collection& collection, const bsoncxx::document::view_or_value& filter) const;

private:
    std::string Id;
    std::string PalletInfo;
    std::string Model;
    std::string Merchandise;
    std::string NameModel;
    std::string Destination;
    std::string Count;
    std::string ZoneId;
    std::string ColumnId;
    std::string LocationId;
    std::string Time;
    std::string Barcode;
    int queue;
};

#endif

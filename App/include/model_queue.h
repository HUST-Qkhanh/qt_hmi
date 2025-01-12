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
    ModelQueue(const nlohmann::json& json);

    /**
     * @brief Converts the pallet queue to a BSON document string.
     * @return A string representing the BSON document.
     */
    std::string getDoc() const;

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
    std::string Barcode;
    int queue;
};

#endif

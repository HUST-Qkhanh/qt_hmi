#ifndef __MODEL_BUFFER_H__
#define __MODEL_BUFFER_H__

#include <bsoncxx/builder/stream/document.hpp>
#include <mongocxx/client.hpp>
#include <mongocxx/instance.hpp>
#include <mongocxx/uri.hpp>
#include <nlohmann/json.hpp>
#include <iostream>
#include <string>
#include "ultis.h"

class ModelBuffer
{
public:
    // Constructor to initialize from nlohmann::json
    ModelBuffer(const nlohmann::json &json);

    /**
     * @brief Converts the pallet bufer to a BSON document string.
     * @return A string representing the BSON document.
     */
    std::string getDoc() const;

    /**
     * @brief convert float to string to fix the display issue
     * 
     * @return std::string 
     */
    std::string stringFormat() const;

private:
    std::string id;
    std::string id_hang;
    std::string status;
    JsonKeys keys;
    int stt;
    int type;
    double height;
    double width;
    double length;
    std::string heightStr;
    std::string widthStr;
    std::string lengthStr;
    int zone_id;
    int column_id;
    int location_id;
    std::string outputDoc;
};

#endif

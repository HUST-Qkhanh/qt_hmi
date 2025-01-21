#ifndef __RESPONSE_FORMAT_H_
#define __RESPONSE_FORMAT_H_

#include <bsoncxx/builder/stream/document.hpp>
#include <mongocxx/client.hpp>
#include <mongocxx/instance.hpp>
#include <mongocxx/uri.hpp>
#include <nlohmann/json.hpp>
#include <iostream>
#include <string>

class ResponseFormat
{
public:
    // Constructor to initialize from nlohmann::json
    ResponseFormat(const nlohmann::json &json);

    /**
     * @brief Converts the response to a BSON document string.
     * @return A string representing the BSON document.
     */
    std::string getDoc() const;

private:
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
    std::string length;
    std::string height;
    std::string width;
    std::string pallet_type;
};

#endif

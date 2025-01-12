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
    /**
     * @brief Converts the pallet model to a BSON document string.
     * @return A string representing the BSON document.
     */
    std::string getDoc() const;

private:
    std::string Merchandise;
    std::string Count;
    std::string length;
    std::string height;
    std::string width;
    std::string pallet_type;
};

#endif

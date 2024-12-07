#include <nlohmann/json.hpp>
#include <string>
#include <vector>
using json = nlohmann::json;
class jsonKeys {
   public:
    jsonKeys(/* args */){}
    ~jsonKeys(){}
    std::string queueIndex = "queue";
    std::string bufferIndex = "id";
    std::string merchandise = "Merchandise";
    std::string count = "Count";
    std::string palletType = "pallet_type";
    std::string height = "height";
    std::string width = "width";
    std::string length = "length";
    std::string palletInfo = "PalletInfo";
    std::string locationId = "location_id";
    std::string columnId = "column_id";
    std::string zoneId = "zone_id";
    std::string bufferType = "type";
    std::string bufferStatus = "status";
    std::string bufferMerchandise = "id_hang";

    bool hasRequiredKeys(const json& obj, const std::vector<std::string>& keys) {
        for (const auto& key : keys) {
            if (!obj.contains(key)) {
                return false;  // Key is missing
            }
        }
        return true;  // All keys are present
    }
};

// jsonKeys::jsonKeys(/* args */) {
// }
// jsonKeys::~jsonKeys() {
// }

// class BackendVar {
//    private:
//     /* data */
//    public:
//     BackendVar(/* args */);
//     ~BackendVar();
// };

// BackendVar::BackendVar(/* args */)
// {
// }

// BackendVar::~BackendVar()
// {
// }

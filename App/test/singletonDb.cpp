#include <bsoncxx/builder/stream/document.hpp>
#include <bsoncxx/json.hpp>
#include <iostream>
#include <nlohmann/json.hpp>
#include <thread>

#include "include/dbManager.h"

using json = nlohmann::json;

const std::string dbName = "test_db";
const std::string collectionName = "test_collection";

std::mutex mtx_;

void threadFoo() {
    std::this_thread::sleep_for(std::chrono::milliseconds(1000));
    MongoDBClient *client = MongoDBClient::getInstance("FOO");
    client->initialize("mongodb://localhost:27017");
    std::lock_guard<std::mutex> lock(mtx_);
    std::cout << "FOO: " << client->value() << "\n";

    bsoncxx::builder::stream::document filter;
    filter << "queue" << 2;

    // Define JSON data to insert
    json jsonData = {{"Id", "0630C001AA"},
                     {"Time", "-----"},
                     {"Barcode", "0630C001AA"},
                     {"PalletInfo", "-----"},
                     {"Model", "-----"},
                     {"Merchandise", "0630C001AA"},
                     {"NameModel", "F36"},
                     {"Destination", "-----"},
                     {"Count", "16"},
                     {"ZoneId", "1"},
                     {"ColumnId", "1"},
                     {"LocationId", "1"},
                     {"queue", 12}};

    jsonData = {{"$set", jsonData}};

    bsoncxx::document::value update = bsoncxx::from_json(jsonData.dump());

    client->editInCollection("admin", "pallet_queue", filter.view(),
                             update.view());

    // client->
}

void threadBar() {
    std::this_thread::sleep_for(std::chrono::milliseconds(1000));
    MongoDBClient *client = MongoDBClient::getInstance("BAR");
    client->initialize("mongodb://localhost:27017");
    std::lock_guard<std::mutex> lock(mtx_);

    std::cout << "BAR: " << client->value() << "\n";

    // Define JSON data to insert
    json jsonData = {{"Id", "-----"},
                     {"Time", "-----"},
                     {"Barcode", "-----"},
                     {"PalletInfo", "-----"},
                     {"Model", "-----"},
                     {"Merchandise", "0630C001AA"},
                     {"NameModel", "-----"},
                     {"Destination", "-----"},
                     {"Count", "16"},
                     {"ZoneId", "-----"},
                     {"ColumnId", "-----"},
                     {"LocationId", "-----"},
                     {"queue", 5}};

    // Convert JSON data to BSON document and insert into MongoDB
    bsoncxx::document::value doc = bsoncxx::from_json(jsonData.dump());
    client->writeToCollection("admin", "pallet_queue", doc.view());
}

void threadBone() {
    std::this_thread::sleep_for(std::chrono::milliseconds(1000));
    MongoDBClient *client = MongoDBClient::getInstance("BAR");
    client->initialize("mongodb://localhost:27017");
    std::lock_guard<std::mutex> lock(mtx_);

    std::cout << "BAR: " << client->value() << "\n";

    // Define JSON data to insert
    json jsonData = {{"Id", "-----"},
                     {"Time", "-----"},
                     {"Barcode", "-----"},
                     {"PalletInfo", "-----"},
                     {"Model", "-----"},
                     {"Merchandise", "0630C001AA"},
                     {"NameModel", "-----"},
                     {"Destination", "-----"},
                     {"Count", "16"},
                     {"ZoneId", "-----"},
                     {"ColumnId", "-----"},
                     {"LocationId", "-----"},
                     {"queue", 5}};

    // Convert JSON data to BSON document and insert into MongoDB
    bsoncxx::document::value doc = bsoncxx::from_json(jsonData.dump());
    client->writeToCollection("admin", "pallet_queue", doc.view());
}

int main() {
    std::cout << "If you see the same value, then singleton was reused (yay!)\n"
              << "If you see different values, then 2 singletons were created "
                 "(booo!!)\n\n"
              << "RESULT:\n";

    std::thread t1(threadFoo);
    std::thread t2(threadBar);

    t1.join();
    t2.join();

    return 0;
}

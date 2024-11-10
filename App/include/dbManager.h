#ifndef MONGODBCLIENT_H
#define MONGODBCLIENT_H

#include <mongocxx/client.hpp>
#include <mongocxx/instance.hpp>
#include <mongocxx/uri.hpp>
#include <bsoncxx/document/view_or_value.hpp>
#include <bsoncxx/builder/stream/document.hpp>
#include <bsoncxx/json.hpp>
#include <string>
#include <mutex>
#include <iostream>
#include <nlohmann/json.hpp>

using json = nlohmann::json;

class MongoDBClient
{
public:
    // Static method to get the singleton instance
    static MongoDBClient *getInstance(const std::string &value);

    // Method to initialize the MongoDB client with a custom URI (optional)
    void initialize(const std::string &uri = "mongodb://localhost:27017");

    mongocxx::database getDatabase(const std::string &dbName);

    void writeToCollection(const std::string &dbName, const std::string &collectionName, const bsoncxx::document::view_or_value &doc);

    void editInCollection(const std::string &dbName, const std::string &collectionName, const bsoncxx::document::view_or_value &filter, const bsoncxx::document::view_or_value &update);

    void eraseFromCollection(const std::string &dbName, const std::string &collectionName, const bsoncxx::document::view_or_value &filter);
    // void jsonFetchCollection(const std::string &dbName, const std::string &collectionName, const bsoncxx::document::view_or_value &filter, json &result);
    // void jsonWriteCollection(const std::string &dbName, const std::string &collectionName, const std::string &newJson);
    // void jsonEditCollection(const std::string &dbName, const std::string &collectionName, const std::string &editJson);
    std::string value() const
    {
        return value_;
    }

private:
    // Private constructor for Singleton pattern
    MongoDBClient(const std::string &value);

    // Delete copy constructor and assignment operator to prevent copies
    MongoDBClient(const MongoDBClient &) = delete;
    MongoDBClient &operator=(const MongoDBClient &) = delete;

    std::string value_;
    static std::mutex mutex_;
    static MongoDBClient *pinstance_;

    mongocxx::instance instance_; // MongoDB driver instance
    mongocxx::client client_;     // MongoDB client to manage connections
    bool isInitialized_ = false;  // Track if client has been initialized
};

#endif // MONGODBCLIENT_H

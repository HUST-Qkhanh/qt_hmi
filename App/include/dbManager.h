#ifndef MONGODBCLIENT_H
#define MONGODBCLIENT_H

#include <bsoncxx/builder/stream/document.hpp>
#include <bsoncxx/document/view_or_value.hpp>
#include <bsoncxx/json.hpp>
#include <bsoncxx/types.hpp>
#include <iostream>
#include <memory>
#include <mongocxx/client.hpp>
#include <mongocxx/instance.hpp>
#include <mongocxx/options/change_stream.hpp>
#include <mongocxx/pool.hpp>
#include <mongocxx/uri.hpp>
#include <mutex>
#include <nlohmann/json.hpp>
#include <string>
#include <vector>

using json = nlohmann::json;

class MongoDBClient {
   public:
    // Static method to get the singleton instance
    static MongoDBClient *getInstance();

    // Method to initialize the MongoDB client with a custom URI (optional)
    void initialize(const std::string &uri = "mongodb://localhost:27017/?minPoolSize=3&maxPoolSize=3");

    // Get a client from the pool
    mongocxx::pool::entry getClient();

    mongocxx::database getDatabase(const std::string &dbName);

    int writeToCollection(const std::string &dbName, const std::string &collectionName, const std::string &doc);

    void editInCollection(const std::string &dbName, const std::string &collectionName, const std::string &filter, const std::string &update);

    int eraseFromCollection(const std::string &dbName, const std::string &collectionName, const std::string &filter);

    void fetchFromCollection(const std::string &dbName, const std::string &collectionName, const std::string &filter, std::string &fetchedStr);

    /**
     * @brief Make a query of all documents in collection and return a json vector contains all documents
     *
     * @param dbName
     * @param collectionName
     * @param filter
     * @param fetchedStr
     */
    void fetchAllCollection(const std::string &dbName, const std::string &collectionName, const std::string &indexKey, std::vector<std::string> &fetchedDocs);

    /**
     * @brief Add document in existed queue
     *
     * @param dbName
     * @param collectionName
     * @param filter
     * @param doc
     */
    void addMidleCollection(const std::string &dbName, const std::string &collectionName, const std::string &filter, const std::string &doc);

    void removeMidleCollection(const std::string &dbName, const std::string &collectionName, const std::string &filter);

    bool checkChangeStream(const std::string &dbName, const std::string &collectionName);

    int getCollectionSize(const std::string &dbName, const std::string &collectionName);
    std::string value() const {
        return value_;
    }

    void getUniqueList(const std::string &dbName, const std::string &collectionName, const std::string &key, std::vector<std::string> &uniqueList);

   private:
    // Private constructor for Singleton pattern
    MongoDBClient();

    // Delete copy constructor and assignment operator to prevent copies
    MongoDBClient(const MongoDBClient &) = delete;
    MongoDBClient &operator=(const MongoDBClient &) = delete;

    std::string value_;
    static std::mutex mutex_;
    static MongoDBClient *pinstance_;

    mongocxx::instance instance_;  // MongoDB driver instance
    mongocxx::client dbClient_;    // MongoDB client to manage connections
    std::string uri_ = "mongodb://localhost:27017/?minPoolSize=3&maxPoolSize=3";
    // mongocxx::pool pool_;
    std::shared_ptr<mongocxx::pool> pool_;
    bool isInitialized_ = false;  // Track if client has been initialized

    // std::optional<bsoncxx::document::value> queueLatestResumeToken;
    // std::optional<bsoncxx::document::value> bufferLatestResumeToken;
    // std::optional<bsoncxx::document::value> modelLatestResumeToken;
};

#endif  // MONGODBCLIENT_H

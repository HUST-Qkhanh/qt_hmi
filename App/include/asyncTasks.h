// PrintTask.h
#ifndef ASYNCTASK_H
#define ASYNCTASK_H

#include <dbManager.h>

#include <QDebug>
#include <QObject>
#include <QRunnable>
#include <QThread>
#include <bsoncxx/builder/stream/document.hpp>
#include <bsoncxx/json.hpp>
#include <mongocxx/client.hpp>
#include <mongocxx/collection.hpp>
#include <mongocxx/database.hpp>
#include <mongocxx/exception/exception.hpp>
#include <mongocxx/instance.hpp>
#include <mongocxx/result/update.hpp>
#include <mongocxx/stdx.hpp>
#include <mongocxx/uri.hpp>
#include <nlohmann/json.hpp>
#include <thread>

/*

   _____  _    ____  _  __  ___ ____    _     ___ ____ _____
  |_   _|/ \  / ___|| |/ / |_ _|  _ \  | |   |_ _/ ___|_   _|
    | | / _ \ \___ \| ' /   | || | | | | |    | |\___ \ | |
    | |/ ___ \ ___) | . \   | || |_| | | |___ | | ___) || |
    |_/_/   \_\____/|_|\_\ |___|____/  |_____|___|____/ |_|


*/

const int PALLET_QUEUE_GET = 0;
const int PALLET_BUFFER_GET = 1;
const int PALLET_MODEL_GET = 2;
const int PALLET_QUEUE_EDIT = 3;
const int PALLET_BUFFER_EDIT = 4;
const int PALLET_MODEL_EDIT = 5;
const int PALLET_QUEUE_ERASE = 6;
const int PALLET_BUFFER_ERASE = 7;
const int PALLET_MODEL_ERASE = 8;
const int PALLET_QUEUE_ADD = 9;
const int PALLET_BUFFER_ADD = 10;
const int PALLET_MODEL_ADD = 11;
const int PALLET_QUEUE_CHANGED = 12;
const int PALLET_BUFFER_CHANGED = 13;

using json = nlohmann::json;

class AsyncTask : public QObject, public QRunnable {
    Q_OBJECT
   public:
    /**
     * @brief Construct a new Base Task object
     *
     * @param resultPtr
     * @param parent
     */
    explicit AsyncTask(QObject *parent = nullptr) : QObject(parent) {
        qDebug() << "base";
    }
    virtual ~AsyncTask() = default;

    virtual void run() = 0;  // Pure virtual run() for subclasses to implement

    std::mutex mtx_;

   signals:
    void taskFinished(const int &task_id, const QString &result);
    void taskFailed(const int &task_id, const QString &errorCode);
};
/*

   _____ _____ _____ ____ _   _   ____  ____     ____ ___  _     _     _____ ____ _____ ___ ___  _   _   _____  _    ____  _  __
  |  ___| ____|_   _/ ___| | | | |  _ \| __ )   / ___/ _ \| |   | |   | ____/ ___|_   _|_ _/ _ \| \ | | |_   _|/ \  / ___|| |/ /
  | |_  |  _|   | || |   | |_| | | | | |  _ \  | |  | | | | |   | |   |  _|| |     | |  | | | | |  \| |   | | / _ \ \___ \| ' /
  |  _| | |___  | || |___|  _  | | |_| | |_) | | |__| |_| | |___| |___| |__| |___  | |  | | |_| | |\  |   | |/ ___ \ ___) | . \
  |_|   |_____| |_| \____|_| |_| |____/|____/   \____\___/|_____|_____|_____\____| |_| |___\___/|_| \_|   |_/_/   \_\____/|_|\_\


*/

class GetQueueTask : public AsyncTask {
    Q_OBJECT

   public:
    explicit GetQueueTask(MongoDBClient *client, const int &id,
                          QObject *parent = nullptr)
        : AsyncTask(parent), client_(client), id_(id) {
        setAutoDelete(true);
    };
    void run() override;

   private:
    MongoDBClient *client_;
    int id_;
};

class GetBufferTask : public AsyncTask {
    Q_OBJECT

   public:
    explicit GetBufferTask(MongoDBClient *client, const int &id,
                           QObject *parent = nullptr)
        : AsyncTask(parent), client_(client), id_(id) {
        setAutoDelete(true);
    };
    void run() override;

   private:
    MongoDBClient *client_;
    int id_;
};

class GetModelTask : public AsyncTask {
    Q_OBJECT

   public:
    explicit GetModelTask(MongoDBClient *client, const std::string &merchandise,
                          const int &count, QObject *parent = nullptr)
        : AsyncTask(parent),
          client_(client),
          merchandise_(merchandise),
          count_(count) {
        setAutoDelete(true);
    };
    void run() override;

   private:
    MongoDBClient *client_;
    std::string merchandise_;
    int count_;
};

/*

   _____ ____ ___ _____   ____  ____     ____ ___  _     _     _____ ____ _____ ___ ___  _   _   _____  _    ____  _  __
  | ____|  _ \_ _|_   _| |  _ \| __ )   / ___/ _ \| |   | |   | ____/ ___|_   _|_ _/ _ \| \ | | |_   _|/ \  / ___|| |/ /
  |  _| | | | | |  | |   | | | |  _ \  | |  | | | | |   | |   |  _|| |     | |  | | | | |  \| |   | | / _ \ \___ \| ' /
  | |___| |_| | |  | |   | |_| | |_) | | |__| |_| | |___| |___| |__| |___  | |  | | |_| | |\  |   | |/ ___ \ ___) | . \
  |_____|____/___| |_|   |____/|____/   \____\___/|_____|_____|_____\____| |_| |___\___/|_| \_|   |_/_/   \_\____/|_|\_\


*/

class EditQueueTask : public AsyncTask {
    Q_OBJECT

   public:
    explicit EditQueueTask(MongoDBClient *client,
                           const std::string &editStr,
                           QObject *parent = nullptr)
        : AsyncTask(parent), client_(client), editStr_(editStr) {
        setAutoDelete(true);
    };
    void run() override;

   private:
    MongoDBClient *client_;
    std::string editStr_;
};

class EditBufferTask : public AsyncTask {
    Q_OBJECT

   public:
    explicit EditBufferTask(MongoDBClient *client, const int &id,
                            const std::string &editStr,
                            QObject *parent = nullptr)
        : AsyncTask(parent), client_(client), id_(id), editStr_(editStr) {
        setAutoDelete(true);
    };
    void run() override;

   private:
    MongoDBClient *client_;
    int id_;
    std::string editStr_;
};

class EditModelTask : public AsyncTask {
    Q_OBJECT

   public:
    explicit EditModelTask(MongoDBClient *client,
                           const std::string &merchandise, const int &count,
                           const std::string &editStr,
                           QObject *parent = nullptr)
        : AsyncTask(parent),
          client_(client),
          merchandise_(merchandise),
          count_(count),
          editStr_(editStr) {
        setAutoDelete(true);
    };
    void run() override;

   private:
    MongoDBClient *client_;
    std::string merchandise_;
    int count_;
    std::string editStr_;
};

/*

   _____ ____      _    ____  _____   ____  ____     ____ ___  _     _     _____ ____ _____ ___ ___  _   _   _____  _    ____  _  __
  | ____|  _ \    / \  / ___|| ____| |  _ \| __ )   / ___/ _ \| |   | |   | ____/ ___|_   _|_ _/ _ \| \ | | |_   _|/ \  / ___|| |/ /
  |  _| | |_) |  / _ \ \___ \|  _|   | | | |  _ \  | |  | | | | |   | |   |  _|| |     | |  | | | | |  \| |   | | / _ \ \___ \| ' /
  | |___|  _ <  / ___ \ ___) | |___  | |_| | |_) | | |__| |_| | |___| |___| |__| |___  | |  | | |_| | |\  |   | |/ ___ \ ___) | . \
  |_____|_| \_\/_/   \_\____/|_____| |____/|____/   \____\___/|_____|_____|_____\____| |_| |___\___/|_| \_|   |_/_/   \_\____/|_|\_\


*/

class EraseQueueTask : public AsyncTask {
    Q_OBJECT

   public:
    explicit EraseQueueTask(MongoDBClient *client, const int &id,
                            QObject *parent = nullptr)
        : AsyncTask(parent), client_(client), id_(id) {
        setAutoDelete(true);
    };
    void run() override;

   private:
    MongoDBClient *client_;
    int id_;
};
class EraseBufferTask : public AsyncTask {
    Q_OBJECT

   public:
    explicit EraseBufferTask(MongoDBClient *client, const std::string &filter,
                             QObject *parent = nullptr)
        : AsyncTask(parent), client_(client), filter_(filter) {
        setAutoDelete(true);
    };
    void run() override;

   private:
    MongoDBClient *client_;
    std::string filter_;
};
class EraseModelTask : public AsyncTask {
    Q_OBJECT

   public:
    explicit EraseModelTask(MongoDBClient *client, const std::string &filter,
                            QObject *parent = nullptr)
        : AsyncTask(parent), client_(client), filter_(filter) {
        setAutoDelete(true);
    };
    void run() override;

   private:
    MongoDBClient *client_;
    std::string filter_;
};

/*

      _       _     _   _          ____  ____              _ _           _   _               _            _
     / \   __| | __| | | |_ ___   |  _ \| __ )    ___ ___ | | | ___  ___| |_(_) ___  _ __   | |_ __ _ ___| | _____
    / _ \ / _` |/ _` | | __/ _ \  | | | |  _ \   / __/ _ \| | |/ _ \/ __| __| |/ _ \| '_ \  | __/ _` / __| |/ / __|
   / ___ \ (_| | (_| | | || (_) | | |_| | |_) | | (_| (_) | | |  __/ (__| |_| | (_) | | | | | || (_| \__ \   <\__ \
  /_/   \_\__,_|\__,_|  \__\___/  |____/|____/   \___\___/|_|_|\___|\___|\__|_|\___/|_| |_|  \__\__,_|___/_|\_\___/


*/

class AddQueueTask : public AsyncTask {
    Q_OBJECT

   public:
    explicit AddQueueTask(MongoDBClient *client,
                          const std::string &editStr,
                          QObject *parent = nullptr)
        : AsyncTask(parent), client_(client), editStr_(editStr) {
        setAutoDelete(true);
    };
    void run() override;

   private:
    MongoDBClient *client_;
    std::string editStr_;
};
class AddBufferTask : public AsyncTask {
    Q_OBJECT

   public:
    explicit AddBufferTask(MongoDBClient *client, const int &id,
                           const std::string &editStr,
                           QObject *parent = nullptr)
        : AsyncTask(parent), client_(client), id_(id), editStr_(editStr) {
        setAutoDelete(true);
    };
    void run() override;

   private:
    MongoDBClient *client_;
    int id_;
    std::string editStr_;
};
class AddModelTask : public AsyncTask {
    Q_OBJECT

   public:
    explicit AddModelTask(MongoDBClient *client,
                          const std::string &merchandise, const int &count,
                          const std::string &editStr,
                          QObject *parent = nullptr)
        : AsyncTask(parent),
          client_(client),
          merchandise_(merchandise),
          count_(count),
          editStr_(editStr) {
        setAutoDelete(true);
    };
    void run() override;

   private:
    MongoDBClient *client_;
    std::string merchandise_;
    int count_;
    std::string editStr_;
};

/*

   _                  _          _ _     _            _                                   _            _
  | |_ _ __ __ _  ___| | __   __| | |__ ( )___    ___| |__   __ _ _ __   __ _  ___  ___  | |_ __ _ ___| | __
  | __| '__/ _` |/ __| |/ /  / _` | '_ \|// __|  / __| '_ \ / _` | '_ \ / _` |/ _ \/ __| | __/ _` / __| |/ /
  | |_| | | (_| | (__|   <  | (_| | |_) | \__ \ | (__| | | | (_| | | | | (_| |  __/\__ \ | || (_| \__ \   <
   \__|_|  \__,_|\___|_|\_\  \__,_|_.__/  |___/  \___|_| |_|\__,_|_| |_|\__, |\___||___/  \__\__,_|___/_|\_\
                                                                        |___/

*/

class TrackDBChanges : public AsyncTask {
    Q_OBJECT

   public:
    explicit TrackDBChanges(MongoDBClient *client,
                                   const std::vector<std::string> &collectionList, QObject *parent = nullptr)
        : AsyncTask(parent),
          client_(client),
          collectionList_(collectionList)
    {
        setAutoDelete(true);
    };
    void run() override;

   private:
    MongoDBClient *client_;
    std::vector<std::string> collectionList_;
};
#endif  // ASYNCTASK_H

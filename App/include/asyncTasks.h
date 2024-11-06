// PrintTask.h
#ifndef ASYNCTASK_H
#define ASYNCTASK_H

#include <QDebug>
#include <QThread>
#include <QObject>
#include <QRunnable>
#include <mongocxx/client.hpp>
#include <mongocxx/instance.hpp>
#include <mongocxx/uri.hpp>
#include <mongocxx/collection.hpp>
#include <bsoncxx/builder/stream/document.hpp>
#include <bsoncxx/json.hpp>
#include <nlohmann/json.hpp>
#include <mongocxx/database.hpp>
#include <mongocxx/collection.hpp>
#include <mongocxx/exception/exception.hpp>
#include <bsoncxx/builder/stream/document.hpp>
#include <mongocxx/stdx.hpp>
#include <mongocxx/result/update.hpp>

using json = nlohmann::json;

class AsyncTask : public QObject, public QRunnable
{
    Q_OBJECT
public:
    /**
     * @brief Construct a new Base Task object
     *
     * @param resultPtr
     * @param parent
     */
    explicit AsyncTask(QObject *parent = nullptr)
        : QObject(parent) {
        qDebug() << "base";
    }
    virtual ~AsyncTask() = default;

    virtual void run() = 0; // Pure virtual run() for subclasses to implement

signals:
    void taskFinished(const QString &result);
};

class FetchPalletTask : public AsyncTask
{
    Q_OBJECT

public:
    explicit FetchPalletTask(const mongocxx::collection &palletCollection, const int &id, json &palletJson, QObject *parent = nullptr)
        : AsyncTask(parent),
          palletCollection_(palletCollection), id_(id), palletJson_(palletJson)
    {
        setAutoDelete(true);
    };
    void run() override;

private:
    mongocxx::collection palletCollection_;
    int id_;
    json palletJson_;
};

#endif // ASYNCTASK_H

// ThreadPoolManager.h
#ifndef THREADPOOLMANAGER_H
#define THREADPOOLMANAGER_H

#include <QObject>
#include <QThreadPool>
#include <vector>

#include "asyncTasks.h"

class ThreadPoolManager : public QObject {
    Q_OBJECT

   public:
    explicit ThreadPoolManager(QObject *parent = nullptr);
    ~ThreadPoolManager();

    Q_INVOKABLE void executeTask(AsyncTask *task);

    /*

   _   _    _    _   _ ____  _     _____   ____  ____    _____  _    ____  _  ______
  | | | |  / \  | \ | |  _ \| |   | ____| |  _ \| __ )  |_   _|/ \  / ___|| |/ / ___|
  | |_| | / _ \ |  \| | | | | |   |  _|   | | | |  _ \    | | / _ \ \___ \| ' /\___ \
  |  _  |/ ___ \| |\  | |_| | |___| |___  | |_| | |_) |   | |/ ___ \ ___) | . \ ___) |
  |_| |_/_/   \_\_| \_|____/|_____|_____| |____/|____/    |_/_/   \_\____/|_|\_\____/


*/
   signals:
    void taskStarted();

    void getQueueTaskCompleted(const QString &result);
    void getBufferTaskCompleted(const QString &result);
    void getModelTaskCompleted(const QString &result);

    void editQueueTaskCompleted(const QString &result);
    void editBufferTaskCompleted(const QString &result);
    void editModelTaskCompleted(const QString &result);

    void eraseQueueTaskCompleted(const QString &result);
    void eraseBufferTaskCompleted(const QString &result);
    void eraseModelTaskCompleted(const QString &result);

    void addQueueTaskCompleted(const QString &result);
    void addBufferTaskCompleted(const QString &result);
    void addModelTaskCompleted(const QString &result);

    void getAllQueueCompleted(const std::vector<std::string> results);
    void getAllBufferCompleted(const std::vector<std::string> results);

    void getQueueTaskFailed(const QString &error);
    void getBufferTaskFailed(const QString &error);
    void getModelTaskFailed(const QString &error);

    void editQueueTaskFailed(const QString &error);
    void editBufferTaskFailed(const QString &error);
    void editModelTaskFailed(const QString &error);

    void eraseQueueTaskFailed(const QString &error);
    void eraseBufferTaskFailed(const QString &error);
    void eraseModelTaskFailed(const QString &error);

    void addQueueTaskFailed(const QString &error);
    void addBufferTaskFailed(const QString &error);
    void addModelTaskFailed(const QString &error);

   public slots:
    void handleTaskFinished(const int &task_id, const QString &result);
    void handleVectorTaskFinished(const int &task_id, const std::vector<std::string> &result);
    void handleTaskFailed(const int &task_id, const QString &error);
};

#endif  // THREADPOOLMANAGER_H

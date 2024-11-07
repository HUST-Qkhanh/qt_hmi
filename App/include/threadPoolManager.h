// ThreadPoolManager.h
#ifndef THREADPOOLMANAGER_H
#define THREADPOOLMANAGER_H

#include <QObject>
#include <QThreadPool>
#include "asyncTasks.h"

class ThreadPoolManager : public QObject
{
    Q_OBJECT

public:
    explicit ThreadPoolManager(QObject *parent = nullptr);
    ~ThreadPoolManager();

    Q_INVOKABLE void executeTask(AsyncTask *task);

signals:
    void taskStarted();
    void queueTaskCompleted(const QString &result);
    void bufferTaskCompleted(const QString &result);

public slots:
    void handleTaskFinished(const int &task_id, const QString &result);
};

#endif // THREADPOOLMANAGER_H

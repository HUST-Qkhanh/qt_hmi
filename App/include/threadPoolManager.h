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
    void taskCompleted(const QString &result);

public slots:
    void handleTaskFinished(const QString &result);
};

#endif // THREADPOOLMANAGER_H

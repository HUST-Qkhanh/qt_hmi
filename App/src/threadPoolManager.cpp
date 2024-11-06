// ThreadPoolManager.cpp
#include "threadPoolManager.h"
#include "asyncTasks.h"

ThreadPoolManager::ThreadPoolManager(QObject *parent) : QObject(parent)
{
    QThreadPool::globalInstance()->setMaxThreadCount(4);
}

ThreadPoolManager::~ThreadPoolManager()
{
    QThreadPool::globalInstance()->waitForDone();
}

void ThreadPoolManager::handleTaskFinished(const QString &result)
{
    qDebug("Task completed");
    emit taskCompleted(result);

    // Clean up
    // currentTask->deleteLater();
    // currentTask = nullptr;
}

/**
 * @brief move task to threadPool
 *
 * @param task
 */
void ThreadPoolManager::executeTask(AsyncTask *task)
{
    if (task)
    {
        bool connected = connect(task, &AsyncTask::taskFinished, this, &ThreadPoolManager::handleTaskFinished);
        if (connected)
        {
            qWarning("Connected taskFinished signal");
        }
        emit taskStarted();
        QThreadPool::globalInstance()->start(task); // Execute the task in the thread pool
        // task->setAutoDelete(true);
        // handleTaskFinished();
        qWarning("Added task to thread pool");
    }
    else
    {
        qWarning("Deleted task from thread pool");
        delete task; // Clean up if the task can't be executed
    }
}

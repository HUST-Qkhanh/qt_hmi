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

void ThreadPoolManager::handleTaskFinished(const int &task_id, const QString &result)
{


    if (task_id == 1)
    {
        qDebug() << "Task is of type GetQueueTask";
        // Perform actions specific to SpecificTaskType
        emit queueTaskCompleted(result);
    }
    else if (task_id == 2)
    {
        qDebug() << "Task is of type GetBufferTask";
        // Perform actions specific to AnotherTaskType
        emit bufferTaskCompleted(result);
    }
    else
    {
        qDebug() << "Task is of an unknown or base type AsyncTask";
    }

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
        bool connected = connect(task, &AsyncTask::taskFinished, this, &ThreadPoolManager::handleTaskFinished, Qt::UniqueConnection);
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

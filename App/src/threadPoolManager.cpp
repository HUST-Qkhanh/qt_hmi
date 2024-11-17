// ThreadPoolManager.cpp
#include "threadPoolManager.h"

#include "asyncTasks.h"

ThreadPoolManager::ThreadPoolManager(QObject *parent) : QObject(parent) {
    QThreadPool::globalInstance()->setMaxThreadCount(4);
}

ThreadPoolManager::~ThreadPoolManager() {
    QThreadPool::globalInstance()->waitForDone();
}

void ThreadPoolManager::handleTaskFinished(const int &task_id,
                                           const QString &result) {
    switch (task_id) {
        case PALLET_QUEUE_GET:
            // qDebug() << "Task is of type QueueTask";
            // Perform actions specific to QueueTask
            emit getQueueTaskCompleted(result);
            break;

        case PALLET_BUFFER_GET:
            // qDebug() << "Task is of type BufferTask";
            // Perform actions specific to BufferTask
            emit getBufferTaskCompleted(result);
            break;

        case PALLET_MODEL_GET:
            // qDebug() << "Task is of type ModelTask";
            // Perform actions specific to ModelTask
            emit getModelTaskCompleted(result);
            break;

        case PALLET_QUEUE_EDIT:
            // qDebug() << "Task is of type QueueTask";
            // Perform actions specific to QueueTask
            emit editQueueTaskCompleted(result);
            break;

        case PALLET_BUFFER_EDIT:
            // qDebug() << "Task is of type BufferTask";
            // Perform actions specific to BufferTask
            emit editBufferTaskCompleted(result);
            break;

        case PALLET_MODEL_EDIT:
            // qDebug() << "Task is of type ModelTask";
            // Perform actions specific to ModelTask
            emit editModelTaskCompleted(result);
            break;

        case PALLET_QUEUE_ERASE:
            // qDebug() << "Task is of type QueueTask";
            // Perform actions specific to QueueTask
            emit eraseQueueTaskCompleted(result);
            break;

        case PALLET_BUFFER_ERASE:
            // qDebug() << "Task is of type BufferTask";
            // Perform actions specific to BufferTask
            emit eraseBufferTaskCompleted(result);
            break;

        case PALLET_MODEL_ERASE:
            // qDebug() << "Task is of type ModelTask";
            // Perform actions specific to ModelTask
            emit eraseModelTaskCompleted(result);
            break;

        case PALLET_QUEUE_ADD:
            // qDebug() << "Task is of type QueueTask";
            // Perform actions specific to QueueTask
            emit addQueueTaskCompleted(result);
            break;

        case PALLET_BUFFER_ADD:
            // qDebug() << "Task is of type BufferTask";
            // Perform actions specific to BufferTask
            emit addBufferTaskCompleted(result);
            break;

        case PALLET_MODEL_ADD:
            // qDebug() << "Task is of type ModelTask";
            // Perform actions specific to ModelTask
            emit addModelTaskCompleted(result);
            break;

        default:
            qDebug() << "Task is of an unknown or base type AsyncTask";
            break;
    }
}

void ThreadPoolManager::handleTaskFailed(const int &task_id,
                                         const QString &error) {
    switch (task_id) {
        case PALLET_QUEUE_GET:
            // qDebug() << "Failed Task is of type QueueTask";
            // Perform actions specific to QueueTask
            emit getQueueTaskFailed(error);
            break;

        case PALLET_BUFFER_GET:
            // qDebug() << "Failed Task is of type BufferTask";
            // Perform actions specific to BufferTask
            emit getBufferTaskFailed(error);
            break;

        case PALLET_MODEL_GET:
            // qDebug() << "Failed Task is of type ModelTask";
            // Perform actions specific to ModelTask
            emit getModelTaskFailed(error);
            break;

        case PALLET_QUEUE_EDIT:
            // qDebug() << "Failed Task is of type QueueTask";
            // Perform actions specific to QueueTask
            emit editQueueTaskFailed(error);
            break;

        case PALLET_BUFFER_EDIT:
            // qDebug() << "Failed Task is of type BufferTask";
            // Perform actions specific to BufferTask
            emit editBufferTaskFailed(error);
            break;

        case PALLET_MODEL_EDIT:
            // qDebug() << " Failed Task is of type ModelTask";
            // Perform actions specific to ModelTask
            emit editModelTaskFailed(error);
            break;

        case PALLET_QUEUE_ADD:
            // qDebug() << "Failed Task is of type QueueTask";
            // Perform actions specific to QueueTask
            emit addQueueTaskFailed(error);
            break;

        case PALLET_BUFFER_ADD:
            // qDebug() << "Failed Task is of type BufferTask";
            // Perform actions specific to BufferTask
            emit addBufferTaskFailed(error);
            break;

        case PALLET_MODEL_ADD:
            // qDebug() << "Failed Task is of type ModelTask";
            // Perform actions specific to ModelTask
            emit addModelTaskFailed(error);
            break;

        default:
            qDebug() << "Failed Task is of an unknown or base type AsyncTask";
            break;
    }
}

/**
 * @brief move task to threadPool
 *
 * @param task
 */
void ThreadPoolManager::executeTask(AsyncTask *task) {
    if (task) {
        bool finishedConnection = connect(
            task, &AsyncTask::taskFinished, this,
            &ThreadPoolManager::handleTaskFinished, Qt::UniqueConnection);

        bool failedConnection = connect(
            task, &AsyncTask::taskFailed, this,
            &ThreadPoolManager::handleTaskFailed, Qt::UniqueConnection);

        if (finishedConnection & failedConnection) {
            qWarning("Connected taskFinished signal");
        }
        emit taskStarted();
        QThreadPool::globalInstance()->start(
            task);  // Execute the task in the thread pool
        // task->setAutoDelete(true);
        // handleTaskFinished();
        qWarning("Added task to thread pool");
    } else {
        qWarning("Deleted task from thread pool");
        delete task;  // Clean up if the task can't be executed
    }
}

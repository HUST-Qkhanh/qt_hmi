#include "asyncTasks.h"

/**
 * @brief find pallet info at queue_id
 *
 */
void GetQueueTask::run()
{
    auto cursor = palletCollection_.find({}); // Replace with your query criteria
    qDebug() << "Queue Query Task started on thread:" << QThread::currentThread();
    bsoncxx::builder::stream::document filter_builder;
    filter_builder << "queue" << id_;
    auto result = palletCollection_.find_one(filter_builder.view());

    if (result)
    {
        // Chuyển đổi tài liệu thành JSON
        bsoncxx::document::view view = result->view();
        std::string obj_filter = bsoncxx::to_json(view);

        QString result = QString::fromStdString(obj_filter);
        // palletJson_ = json::parse(obj_filter);

        // qDebug() << "queue_pallet at:" <<  id_ << "is: " << palletJson_.dump(2);
        QThread::msleep(2000);
        qDebug() << "Queue Query Task finished.";
        emit taskFinished(1, result);
        qDebug() << "Queue taskFinished signal emitted.";
    }
    else
    {
        qDebug() << "task failed";
    }
}

void GetBufferTask::run()
{
    auto cursor = palletCollection_.find({}); // Replace with your query criteria
    qDebug() << "Buffer Query Task started on thread:" << QThread::currentThread();
    bsoncxx::builder::stream::document filter_builder;
    filter_builder << "stt" << id_;
    auto result = palletCollection_.find_one(filter_builder.view());
    if (result)
    {
        // Chuyển đổi tài liệu thành JSON
        bsoncxx::document::view view = result->view();
        std::string obj_filter = bsoncxx::to_json(view);

        QString result = QString::fromStdString(obj_filter);
        // palletJson_ = json::parse(obj_filter);

        // qDebug() << "queue_pallet at:" <<  id_ << "is: " << palletJson_.dump(2);
        QThread::msleep(2000);
        qDebug() << "Buffer Query Task finished.";
        emit taskFinished(2, result);
        qDebug() << "Buffer taskFinished signal emitted.";
    }
    else
    {
        qDebug() << "task failed";
    }
}

void GetModelTask::run()
{
    auto cursor = palletCollection_.find({}); // Replace with your query criteria
    qDebug() << "Model Query Task started on thread:" << QThread::currentThread();
    bsoncxx::builder::stream::document filter_builder;
    filter_builder << "Merchandise" << id_ << "Count" << count_;
    auto result = palletCollection_.find_one(filter_builder.view());
    if (result)
    {
        // Chuyển đổi tài liệu thành JSON
        bsoncxx::document::view view = result->view();
        std::string obj_filter = bsoncxx::to_json(view);

        QString result = QString::fromStdString(obj_filter);
        // palletJson_ = json::parse(obj_filter);

        // qDebug() << "queue_pallet at:" <<  id_ << "is: " << palletJson_.dump(2);
        QThread::msleep(2000);
        qDebug() << "Buffer Query Task finished.";
        emit taskFinished(2, result);
        qDebug() << "Buffer taskFinished signal emitted.";
    }
    else
    {
        qDebug() << "task failed";
    }
}
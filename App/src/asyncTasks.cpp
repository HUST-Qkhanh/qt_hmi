#include "asyncTasks.h"

/**
 * @brief find pallet info at queue_id
 *
 */
void FetchPalletTask::run()
{
    // Perform a sample query
    auto cursor = palletCollection_.find({}); // Replace with your query criteria
    qDebug() << "MongoDB Query Task started on thread:" << QThread::currentThread();
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
        qDebug() << "MongoDB Query Task finished.";
        emit taskFinished(result);
        qDebug() << "taskFinished signal emitted.";
    }
    else
    {
        qDebug() << "task failed";
    }
}
#include "asyncTasks.h"

void GetQueueTask::run()
{
    std::lock_guard<std::mutex> lock(mtx_);
    // qDebug() << "GetQueueTask started on thread:" << QThread::currentThread();
    json filter;
    filter["queue"] = id_;
    std::string fetchedStr = "";

    // std::cout << "FILTER: " << filter.dump() << "\n";
    client_->fetchFromCollection("admin", "pallet_queue", filter.dump(),
                                 fetchedStr);
    // std::cout << "FETCHED JSON: " << fetchedStr << "\n";
    if (fetchedStr != "")
    {
        QString result = QString::fromStdString(fetchedStr);
        QThread::msleep(200);
        // qDebug() << "GetQueueTask Task finished.";
        emit taskFinished(PALLET_QUEUE_GET, result);
    }
    else
    {
        // qDebug() << "task failed";
        emit taskFailed(PALLET_QUEUE_GET, "GetQueueTask failed.");
    }
}
void EditQueueTask::run()
{
    std::lock_guard<std::mutex> lock(mtx_);
    // qDebug() << "Model Query Task started on thread:" << QThread::currentThread();

    json modelFilter;
    std::string modelStr = ""; // fetched model
    json jsonToFilter;
    json jsonToSave;
    json filter;

    // qDebug() << "request save: " << editStr_ << "\n";

    json editQueueData = json::parse(editStr_);
    if (!(editQueueData.contains("Merchandise") &&
          editQueueData.contains("Count")))
    {
        emit taskFailed(PALLET_QUEUE_EDIT, "AddQueueTask failed.");
        return;
    }
    // TODO: Look for model of request edit
    modelFilter["Merchandise"] = editQueueData["Merchandise"];
    modelFilter["Count"] = editQueueData["Count"];
    // Search for model
    try
    {
        client_->fetchFromCollection("admin", "pallet_model", modelFilter.dump(), modelStr);
    }
    catch (const std::exception &e)
    {
        // qDebug() << e.what() << '\n';
        emit taskFailed(PALLET_QUEUE_EDIT, "AddQueueTask failed.");
        return;
    }
    if (modelStr == "")
    {
        // qDebug() << "MODEL IS NOT IN DataBase" << '\n';
        emit taskFailed(PALLET_QUEUE_EDIT, "AddQueueTask failed.");
        return;
    }

    json modelJson = json::parse(modelStr);
    // TODO: concat request save json and model json to make a json which will be saved
    jsonToSave["$set"] = {
        {"Merchandise", editQueueData["Merchandise"]},
        {"Count", editQueueData["Count"]},
        {"height", modelJson["height"]},
        {"width", modelJson["width"]},
        {"length", modelJson["length"]},
        {"pallet_type", modelJson["pallet_type"]}};

    filter["queue"] = std::stoi(editQueueData["queue"].get<std::string>());
    try
    {
        client_->editInCollection("admin", "pallet_queue", filter.dump(),
                                  jsonToSave.dump());
    }
    catch (const std::exception &e)
    {
        std::cerr << e.what() << '\n';
        // qDebug() << "task failed";
        emit taskFailed(PALLET_QUEUE_EDIT, "EditQueueTask failed.");
    }
    QString result = "OK";
    // qDebug() << "EditQueueTask finished.";
    emit taskFinished(PALLET_QUEUE_EDIT, result);
}
// TODO: add queue_id for added document
void AddQueueTask::run()
{
    std::lock_guard<std::mutex> lock(mtx_);
    // qDebug() << "AddQueueTask started on thread:" << QThread::currentThread();

    json modelFilter;
    std::string modelStr = ""; // fetched model
    json jsonToSave;
    json queueFilter;

    // qDebug() << "request save: " << editStr_ << "\n";
    json editQueueData = json::parse(editStr_);
    if (!(editQueueData.contains("Merchandise") &&
          editQueueData.contains("Count")))
    {
        // qDebug() << "No input merchandise and count to add";
        emit taskFailed(PALLET_QUEUE_ADD, "AddQueueTask failed.");
        return;
    }

    // TODO: Look for model of request edit
    modelFilter["Merchandise"] = editQueueData["Merchandise"];
    modelFilter["Count"] = editQueueData["Count"];
    // Search for model
    try
    {
        client_->fetchFromCollection("admin", "pallet_model", modelFilter.dump(), modelStr);
    }
    catch (const std::exception &e)
    {
        // qDebug() << e.what() << '\n';
        emit taskFailed(PALLET_QUEUE_ADD, "AddQueueTask failed.");
        return;
    }
    if (modelStr == "")
    {
        // qDebug() << "MODEL IS NOT IN DataBase" << '\n';
        emit taskFailed(PALLET_QUEUE_ADD, "AddQueueTask failed.");
        return;
    }

    json modelJson = json::parse(modelStr);

    // TODO: concat request save json and model json to make a json which will be saved
    jsonToSave["Merchandise"] = editQueueData["Merchandise"];
    jsonToSave["Count"] = editQueueData["Count"];
    jsonToSave["queue"] = std::stoi(editQueueData["queue"].get<std::string>());
    jsonToSave["height"] = modelJson["height"];
    jsonToSave["width"] = modelJson["width"];
    jsonToSave["length"] = modelJson["length"];
    jsonToSave["pallet_type"] = modelJson["pallet_type"];

    // TODO: when add to queue -> check the size of collection -> insert new doc to collection -> increase the queue of doc which queue > inserted doc's queue
    queueFilter["queue"] = std::stoi(editQueueData["queue"].get<std::string>());

    try
    {
        client_->addMidleCollection("admin", "pallet_queue", queueFilter.dump(), jsonToSave.dump());
    }
    catch (const std::exception &e)
    {
        // qDebug() << e.what() << '\n';
        emit taskFailed(PALLET_QUEUE_ADD, "AddQueueTask failed.");
        return;
    }
    QThread::msleep(2000);
    QString result = "OK";
    // qDebug() << "AddQueueTask finished.";
    emit taskFinished(PALLET_QUEUE_ADD, result);
}
void EraseQueueTask::run()
{
    std::lock_guard<std::mutex> lock(mtx_);
    // qDebug() << "EraseQueueTask started on thread:" << QThread::currentThread();
    json filter;
    filter["queue"] = id_;

    try
    {
        client_->removeMidleCollection("admin", "pallet_queue", filter.dump());
    }
    catch (const std::exception &e)
    {
        std::cerr << e.what() << '\n';
        // qDebug() << "task failed";
        emit taskFailed(PALLET_QUEUE_ERASE, "EraseQueueTask failed.");
    }
    QString result = "OK";
    // qDebug() << "EraseQueueTask finished.";
    emit taskFinished(PALLET_QUEUE_ERASE, result);
}

void GetBufferTask::run()
{
    std::lock_guard<std::mutex> lock(mtx_);
    // qDebug() << "GetBufferTask started on thread:" << QThread::currentThread();
    json filter;
    filter["stt"] = id_;
    std::string fetchedStr = "";

    client_->fetchFromCollection("admin", "pallet_buffer", filter.dump(),
                                 fetchedStr);
    if (fetchedStr != "")
    {
        QString result = QString::fromStdString(fetchedStr);
        QThread::msleep(200);
        // qDebug() << "GetBufferTask finished.";
        emit taskFinished(PALLET_BUFFER_GET, result);
    }
    else
    {
        // qDebug() << "task failed";
        emit taskFailed(PALLET_BUFFER_GET, "GetBufferTask failed.");
    }
}
void EditBufferTask::run()
{
    // //qDebug() << "Model Query Task started on thread:"
    //          << QThread::currentThread();
    // json filter;
    // filter["stt"] = id_;
    // std::string editStr_ = "";
    //
    // try {
    //     client_->editInCollection("admin", "pallet_queue", filter.dump(),
    //                               editStr_);
    // } catch (const std::exception& e) {
    //     std::cerr << e.what() << '\n';
    //     //qDebug() << "task failed";
    //     emit taskFailed(PALLET_BUFFER_EDIT, "EditBufferTask failed.");
    // }
    // QString result = "OK";
    // //qDebug() << "EditBufferTask finished.";
    // emit taskFinished(PALLET_BUFFER_EDIT, result);
}
void AddBufferTask::run()
{
    // //qDebug() << "AddBufferTask started on thread:"
    //          << QThread::currentThread();
    // std::string fetchedStr = "";
    //
    // try {
    //     client_->eraseFromCollection("admin", "pallet_buffer", filter.dump());
    // } catch (const std::exception& e) {
    //     std::cerr << e.what() << '\n';
    //     //qDebug() << "task failed";
    //     emit taskFailed(PALLET_BUFFER_ERASE, "AddBufferTask failed.");
    // }
    // QString result = "OK";
    // //qDebug() << "AddBufferTask finished.";
    // emit taskFinished(PALLET_BUFFER_ERASE, result);
}
void EraseBufferTask::run()
{
    // //qDebug() << "EraseBufferTask started on thread:"
    //          << QThread::currentThread();
    // std::string fetchedStr = "";
    //
    // try {
    //     client_->eraseFromCollection("admin", "pallet_buffer", filter_);
    // } catch (const std::exception& e) {
    //     std::cerr << e.what() << '\n';
    //     //qDebug() << "task failed";
    //     emit taskFailed(PALLET_BUFFER_ERASE, "EraseBufferTask failed.");
    // }
    // QString result = "OK";
    // //qDebug() << "EraseBufferTask finished.";
    // emit taskFinished(PALLET_BUFFER_ERASE, result);
}

void GetModelTask::run()
{
    // //qDebug() << "GetModelTask started on thread:" << QThread::currentThread();
    // json filter;
    // filter["Merchandise"] = merchandise_;
    // filter["Count"] = count_;

    // std::string fetchedStr = "";
    //
    // client_->fetchFromCollection("admin", "pallet_buffer", filter.dump(),
    //                              fetchedStr);
    // if (fetchedStr != "") {
    //     QString result = QString::fromStdString(fetchedStr);
    //     QThread::msleep(200);
    //     //qDebug() << "GetModelTask finished.";
    //     emit taskFinished(PALLET_MODEL_GET, result);
    // } else {
    //     //qDebug() << "task failed";
    //     emit taskFailed(PALLET_MODEL_GET, "Buffer Query Task failed.");
    //     //qDebug() << "Model taskFailed signal emitted.";
    // }
}
void EditModelTask::run()
{
    // //qDebug() << "EditModelTask started on thread:";
    // json filter;
    // filter["Merchandise"] = merchandise_;
    // filter["Count"] = count_;
    // std::string editStr_ = "";
    //
    // try {
    //     client_->editInCollection("admin", "pallet_model", filter.dump(),
    //                               editStr_);
    // } catch (const std::exception& e) {
    //     std::cerr << e.what() << '\n';
    //     //qDebug() << "task failed";
    //     emit taskFailed(PALLET_MODEL_EDIT, "EditModelTask failed.");
    // }
    // QString result = "OK";
    // //qDebug() << "EditModelTask finished.";
    // emit taskFinished(PALLET_MODEL_EDIT, result);
}
void EraseModelTask::run()
{
    // //qDebug() << "EraseModelTask started on thread:"
    //          << QThread::currentThread();
    // std::string fetchedStr = "";
    //
    // try {
    //     client_->eraseFromCollection("admin", "pallet_model", filter_);
    // } catch (const std::exception& e) {
    //     std::cerr << e.what() << '\n';
    //     //qDebug() << "task failed";
    //     emit taskFailed(PALLET_MODEL_ERASE, "EraseModelTask failed.");
    // }
    // QString result = "OK";
    // //qDebug() << "EraseModelTask finished.";
    // emit taskFinished(PALLET_MODEL_ERASE, result);
}
void AddModelTask::run()
{
    // //qDebug() << "AddModelTask started on thread:"
    //          << QThread::currentThread();
    // std::string fetchedStr = "";
    //
    // try {
    //     client_->eraseFromCollection("admin", "pallet_model", filter_);
    // } catch (const std::exception& e) {
    //     std::cerr << e.what() << '\n';
    //     //qDebug() << "task failed";
    //     emit taskFailed(PALLET_MODEL_ERASE, "AddModelTask failed.");
    // }
    // QString result = "OK";
    // //qDebug() << "AddModelTask finished.";
    // emit taskFinished(PALLET_MODEL_ERASE, result);
}

/*

   _                  _          _ _     _            _                                   _            _
  | |_ _ __ __ _  ___| | __   __| | |__ ( )___    ___| |__   __ _ _ __   __ _  ___  ___  | |_ __ _ ___| | __
  | __| '__/ _` |/ __| |/ /  / _` | '_ \|// __|  / __| '_ \ / _` | '_ \ / _` |/ _ \/ __| | __/ _` / __| |/ /
  | |_| | | (_| | (__|   <  | (_| | |_) | \__ \ | (__| | | | (_| | | | | (_| |  __/\__ \ | || (_| \__ \   <
   \__|_|  \__,_|\___|_|\_\  \__,_|_.__/  |___/  \___|_| |_|\__,_|_| |_|\__, |\___||___/  \__\__,_|___/_|\_\
                                                                        |___/

*/

void TrackDBChanges::run()
{
    // std::lock_guard<std::mutex> lock(mtx_);
    // while (true) {
    //     for (auto collectionName : collectionList_) {
    //         std::cout << "Checking change for " << collectionName << "\n";
    //         auto status = client_->checkChangeStream("admin", collectionName);
    //         if (collectionName == "pallet_queue" && status == true) {
    //             QString result = "OK";
    //             //qDebug() << "Pallet queue change";
    //             emit taskFinished(PALLET_QUEUE_CHANGED, result);
    //         } else if (collectionName == "pallet_buffer" && status == true) {
    //             QString result = "OK";
    //             //qDebug() << "Pallet buffer change";
    //             emit taskFinished(PALLET_BUFFER_CHANGED, result);
    //         }
    //         QThread::msleep(2000);
    //     }
    // }
}

void GetCellsProperties::run()
{
    // std::lock_guard<std::mutex> lock(mtx_);  // lock MongoDBClient
    // qDebug() << "Start get cell properties \n";
    // TODO: get each query of collection and create json result "collection_name"
    for (auto &&collection : collectionList_)
    {
        if (collection == "pallet_queue")
        {
            std::string indexKey = "queue";
            std::vector<std::string> cellsProperties;
            try
            {
                client_->fetchAllCollection("admin", collection, indexKey, cellsProperties);
            }
            catch (const std::exception &e)
            {
                std::cerr << e.what() << '\n';
            }

            if (cellsProperties.empty())
            {
                // qDebug() << "task failed" << "\n";
                emit taskFailed(PALLET_QUEUE_GET_ALL, "GetCellsProperties failed.");
                return;
            }
            // qDebug() << "vectortask finished: " << collection << "\n";
            emit vectorTaskFinished(PALLET_QUEUE_GET_ALL, cellsProperties);
        }
        else if (collection == "pallet_buffer")
        {
            // qDebug() << "fetch buffer\n";
            std::string indexKey = "stt";
            std::vector<std::string> cellsProperties;
            client_->fetchAllCollection("admin", collection, indexKey, cellsProperties);
            if (cellsProperties.empty())
            {
                qDebug() << "task failed" << "\n";
                emit taskFailed(PALLET_BUFFER_GET_ALL, "GetCellsProperties failed.");
                return;
            }
            std::vector<std ::string> cellsProperties2;
            for (std::string doc : cellsProperties)
            {
                ModelBuffer mb(json::parse(doc));
                cellsProperties2.push_back(mb.stringFormat());
                // std::cout << "buffer string: " << mb.stringFormat() << "\n";
            }

            // get correct display format
            // TODO: change the db format to string to avoid floating number issue
            //  qDebug() << "vectortask finished: " << collection << "\n";
            emit vectorTaskFinished(PALLET_BUFFER_GET_ALL, cellsProperties2);
        }
    }
}

#include "backend.h"

#include <asyncTasks.h>
#include <dbManager.h>
#include <std_stamped_msgs/EmptyStamped.h>
#include <threadPoolManager.h>
#include <unistd.h>

#include <QQmlComponent>
#include <cstdio>
#include <fstream>
#include <iostream>
#include <nlohmann/json.hpp>
#include <regex>
#include <sstream>
#include <string>

using json = nlohmann::json;
Backend::Backend(QObject *parent)
    : QObject(parent), nh()
{
    // Initialize the subscriber in the constructor
    // TODO:
    dbClient_->initialize(uri);

    battery_percent_sub = nh.subscribe("/arduino_driver/float_param/battery_percent", 1, &Backend::batteryPercentCallback, this);
    battery_voltage_sub = nh.subscribe("/arduino_driver/float_param/battery_voltage", 1, &Backend::batteryVoltageCallback, this);
    battery_current_sub = nh.subscribe("/arduino_driver/float_param/battery_ampe", 1, &Backend::batteryCurrentCallback, this);
    robot_mode_sub = nh.subscribe("/robot_mode", 1, &Backend::robotModeCallback, this);
    robot_status_sub = nh.subscribe("/robot_status", 1, &Backend::robotStatusCallback, this);
    fastech_input_sub = nh.subscribe("/fastech_input", 1, &Backend::fastechInputCallBack, this);
    fastech_output_sub = nh.subscribe("/fastech_output", 1, &Backend::fastechOutputCallBack, this);
    velocity_sub = nh.subscribe("/final_cmd_vel_mux/output", 1, &Backend::cmdVelCallBack, this);
    pallet_status_sub = nh.subscribe("/empty_topic", 1, &Backend::palletStatusCallback, this);
    system_status_sub = nh.subscribe("/current_triggered_mission", 1, &Backend::systemStatusCallback, this);

    request_run_stop_pub = nh.advertise<std_stamped_msgs::StringStamped>("/request_run_stop", 1);
    reset_error_pub = nh.advertise<std_stamped_msgs::EmptyStamped>("/reset_error", 1);
    robot_mode_pub = nh.advertise<std_stamped_msgs::StringStamped>("/request_mode", 1);
    robot_control_pub = nh.advertise<std_stamped_msgs::StringStamped>("/request_working_stt", 1);

    robot_stop_pub = nh.advertise<std_stamped_msgs::StringStamped>("/request_start_mission", 1);

    // Service

    pop_last_pallet = nh.advertiseService("/conveyor_buffer/pop_buffer_last", &Backend::servicePopPalletCallback, this);
    append_head_pallet = nh.advertiseService("/conveyor_buffer/append_buffer_head", &Backend::serviceAppendPalletCallback, this);
    get_last_pallet = nh.advertiseService("/conveyor_buffer/get_buffer_last", &Backend::serviceLookupPalletCallback, this);
    stop_error_agf = nh.serviceClient<std_stamped_msgs::StringService>("/stop_trigger_manager");
    reset_error_agf = nh.serviceClient<std_stamped_msgs::StringService>("/reset_trigger_manager");
    bug_manual_mode = true;
    index = 0;
    max_index = 0;
    _queue = "_queue";
    zone_ = "zone_";
    QTranslator *translator = new QTranslator();
    // m_translator.load(QStringLiteral(":/simplequick.qm"));
    // qApp->installTranslator(&m_translator);
    // qApp->removeTranslator(&m_translator);

    // std::cout << 9.87654321f << '\n';
    std::string name = "";
    // try {
    //     YAML::Node config = YAML::LoadFile("/home/mkac/robot_config/robot_define.yaml");

    //     // The outer element is an array
    //     if (config["agv_name"] && config["agv_name"].IsScalar()) {
    //         std::string name = config["agv_name"].as<std::string>();
    //         // std::string ip_server = config["server_address"].as<std::string>();
    //         std::string ip_server = "_";
    //         server_address = QString::fromStdString(ip_server);

    //         agv_name = QString::fromStdString(name);
    //     }

    // }
    // catch (const YAML::BadFile& e) {
    //     ROS_WARN("Cannot get AGV name");
    // }
    // catch (const YAML::ParserException& e) {
    //     ROS_WARN("Cannot get AGV name");
    // }
    // // updateMerchandiseList();
    // std::vector<std::string> collectionList = {collection_queue, collection};
    // TrackDBChanges *trackDbchanges = new TrackDBChanges(dbClient_, collectionList);
    // std::lock_guard<std::mutex> lock(mutex_);
    // threadManager.executeTask(trackDbchanges);
    // updateFetchedList();
}

std::vector<std::string> Backend::splitString(std::string str, char delimiter)
{
    std::vector<std::string> result;
    std::stringstream ss(str);
    std::string item;

    while (std::getline(ss, item, delimiter))
    {
        result.push_back(item);
    }

    return result;
}

void Backend::batteryPercentCallback(const std_stamped_msgs::Float32Stamped &msg)
{
    batteryPercentageStr = double(msg.data);
    if (batteryPercentageStr >= 99)
        batteryPercentageStr = 100;
    emit batteryPercentageChanged();
}

void Backend::batteryVoltageCallback(const std_stamped_msgs::Float32Stamped &msg)
{
    batteryVoltageStr = double(msg.data);
    emit batteryVoltageChanged();
}

void Backend::batteryCurrentCallback(const std_stamped_msgs::Float32Stamped &msg)
{
    batteryCurrentStr = double(msg.data);
    emit batteryCurrentChanged();
}

void Backend::robotModeCallback(const std_stamped_msgs::StringStamped::ConstPtr &msg)
{
    // robot_mode = std::string(msg ->data);
    robotModeStr = QString::fromStdString(msg->data);
    emit robotModeChanged();
}

void Backend::robotStatusCallback(const std_stamped_msgs::StringStamped::ConstPtr &msg)
{
    std::string data = msg->data;
    try
    {
        json jsondata = json::parse(data);
        statusValue = jsondata["status"];
        detailValue = jsondata["detail"];
        robot_mode = jsondata["mode"];
        errorValue = jsondata["error_code"];
    }
    catch (...)
    {
        ROS_WARN("Loi chuyen doi json callback /robot_status");
    }
    getControlStr = QString::fromStdString(statusValue);
    emit getControlChanged();

    if (robot_mode == "AUTO")
    {
        bug_manual_mode = true;
    }
    robotStatusStr = QString::fromStdString(statusValue);
    emit robotStatusChanged();

    robotDetailStr = QString::fromStdString(detailValue);
    emit robotDetailChanged();

    robotErrorStr = QString::fromStdString(errorValue);
    emit robotErrorChanged();

    // robotModeStr = QString::fromStdString(modeValue);
    // emit robotModeChanged();
}

// trigger mission topic
void Backend::systemStatusCallback(const std_stamped_msgs::StringStamped::ConstPtr &msg)
{
    std::string data = msg->data;
    try
    {
        json jsondata = json::parse(data);
        stateValueSystem = jsondata["state"];
        statusValueSystem = jsondata["status"];
    }
    catch (...)
    {
        ROS_WARN("Loi chuyen doi json callback /current_triggered_mission");
    }
    stateValueSystemStr = QString::fromStdString(stateValueSystem);

    statusValueSystemStr = QString::fromStdString(statusValueSystem);
    emit systemStatusChanged();
}
QString Backend::getStateSystem()
{
    return stateValueSystemStr;
}

void Backend::fastechInputCallBack(const std_msgs::Int16MultiArray::ConstPtr &msg)
{
    std::vector<int16_t> data_ = msg->data;
    fastechData.clear();
    fastechData.reserve(data_.size());
    for (int i = 0; i < data_.size(); i++)
    {
        fastechData.push_back(static_cast<int>(data_[i]));
    }
    emit getFastechInputChanged();
}

void Backend::fastechOutputCallBack(const std_msgs::Int16MultiArray::ConstPtr &msg)
{
    // fastechDataOutput.clear();
    // fastechDataOutput.reserve(msg->data.size());
    // for (int value : msg->data) {
    //     fastechDataOutput.push_back(static_cast<int>(value));
    // }
    std::vector<int16_t> data_ = msg->data;
    fastechDataOutput.clear();
    fastechDataOutput.reserve(data_.size());
    for (int i = 0; i < data_.size(); i++)
    {
        fastechDataOutput.push_back(static_cast<int>(data_[i]));
    }

    emit getFastechOutputChanged();
}

void Backend::cmdVelCallBack(const geometry_msgs::Twist &msg)
{
    vel_linear = double(msg.linear.x);
    vel_angular = double(msg.angular.z);

    emit velChanged();
}

int Backend::getFastechRear(int index)
{
    return fastechData[int(index) - 1];
}

int Backend::getFastechFront(int index)
{
    return fastechDataOutput[int(index) - 1];
}

double Backend::batteryPercentage() const
{
    return batteryPercentageStr;
}

double Backend::batteryVoltage() const
{
    return batteryVoltageStr;
}

double Backend::batteryCurrent() const
{
    return batteryCurrentStr;
}

QString Backend::robotMode() const
{
    return robotModeStr;
}

QString Backend::robotStatus() const
{
    return robotStatusStr;
}

QString Backend::robotDetail() const
{
    if (bug_manual_mode == 0)
    {
        return QString::fromStdString("Please change AGV mode to AUTO");
    }
    return robotDetailStr;
}

QString Backend::robotError() const
{
    return robotErrorStr;
}

QString Backend::getControl() const
{
    return getControlStr;
}

QString Backend::getNameAGV()
{
    return agv_name;
}

double Backend::getLinear() const
{
    return vel_linear;
}

double Backend::getAngular() const
{
    return vel_angular;
}

QString Backend::systemStatus() const
{
    return statusValueSystemStr;
}

QString Backend::updateStatus() const
{
    return updateStatusStr;
}

QString Backend::getQueueJson() const
{
    return QString::fromStdString(fetchedQueueStr);
}

QString Backend::getQueueSeekModel() const
{
    return QString::fromStdString(queueSeekModelJson);
}
QString Backend::getBufferJson() const
{
    return QString::fromStdString(fetchedBufferStr);
}

QString Backend::getModelJson() const
{
    return QString::fromStdString(fetchedModelStr);
}

void Backend::resetError()
{
    std_stamped_msgs::EmptyStamped msg;
    if (robotModeStr.toStdString() == "AUTO")
    {
        reset_error_pub.publish(msg);
    }
    else
    {
        bug_manual_mode = false;
        // ROS_INFO_STREAM(robotModeStr.toStdString());
    }
}

void Backend::requestMode(const QString &str)
{
    std_stamped_msgs::StringStamped request_mode_msg;
    request_mode_msg.stamp = ros::Time::now();
    request_mode_msg.data = str.toStdString();
    robot_mode_pub.publish(request_mode_msg);
}

void Backend::requestControl(const QString &str)
{
    std_stamped_msgs::StringStamped request_control_msg;
    request_control_msg.stamp = ros::Time::now();
    if (robotModeStr.toStdString() == "AUTO")
    {
        if (str.toStdString() == "STOP")
        {
            request_control_msg.data = "STOP";
            request_run_stop_pub.publish(request_control_msg);
        }
        else
        {
            request_control_msg.data = "RUN";
            request_run_stop_pub.publish(request_control_msg);
        }
    }
    else
    {
        bug_manual_mode = false;
        // ROS_INFO_STREAM(robotModeStr.toStdString());
    }
}

int Backend::getVolume()
{
    std::string result = exec("amixer -D pulse sget Master");

    int volumePercentage = getVolumePercentage(result);

    return volumePercentage;
}

int Backend::setVolume(int percent)
{
    std::string command = "amixer -D pulse sset Master " + std::to_string(percent) + "%";
    system(command.c_str());
    return percent;
}

void Backend::shutdown(int state)
{
    if (state == 1)
    {
        std::string command = " ";
    }
}

void Backend::getVolume_on_off(int i)
{
    if (i == 0)
    {
        std::string result = exec("pactl set-sink-mute @DEFAULT_SINK@ true");
    }
    else
        std::string result = exec("pactl set-sink-mute @DEFAULT_SINK@ false");
}

void Backend::change_to_japan()
{
    // qApp ->installTranslator(&m_translator);
}

void Backend::change_to_eng()
{
    qApp->removeTranslator(&m_translator);
}

QString Backend::getIP()
{
    std::string ip = " ";
    FILE *pipe = popen("ip -4 addr show dev enp3s0", "r");
    if (!pipe)
    {
        return QString::fromStdString(ip);
    }

    char buffer[128];
    std::string result = "";
    while (fgets(buffer, sizeof(buffer), pipe) != nullptr)
    {
        result += buffer;
    }

    // Close the pipe
    pclose(pipe);

    // Use regular expression to find the IP address
    std::regex ipRegex(R"((\d{1,3}\.){3}\d{1,3})");
    std::smatch ipMatch;
    if (std::regex_search(result, ipMatch, ipRegex))
    {
        return QString::fromStdString(ipMatch.str());
    }
    return QString::fromStdString(ip);
}

QString Backend::getIPServer()
{
    return server_address;
}

/*

    ____    _    _     _     ____    _    ____ _  ______
   / ___|  / \  | |   | |   | __ )  / \  / ___| |/ / ___|
  | |     / _ \ | |   | |   |  _ \ / _ \| |   | ' /\___ \
  | |___ / ___ \| |___| |___| |_) / ___ \ |___| . \ ___) |
   \____/_/   \_\_____|_____|____/_/   \_\____|_|\_\____/


*/

void Backend::palletStatusCallback(const std_msgs::Empty &msg)
{
    // updateFetchedList();
}

// Hàm chuyển đổi số thực thành chuỗi với độ chính xác mong muốn
// std::string Backend::toStringWithPrecision(float value, int precision) {
//     std::ostringstream out;
//     out << std::fixed << std::setprecision(precision) << value;
//     return out.str();
// }
json Backend::lookupPalletModel(std::string model, std::string count)
{
    json object_pallet;
    json filter;
    filter[keys.merchandise] = model;
    filter[keys.count] = count;

    std::string result;
    std::lock_guard<std::mutex> lock(mutex_);
    dbClient_->fetchFromCollection(database, collection_model, filter.dump(), result);

    if (!result.empty())
    {
        object_pallet = json::parse(result);
        return object_pallet;
    }
    else
    {
        // ROS_ERROR("Can't find Merchandise2");
        return object_pallet;
    }
}
bool Backend::servicePopPalletCallback(std_stamped_msgs::StringService::Request &req, std_stamped_msgs::StringService::Response &res)
{
    // arrangeQueue();
    // json delete_result = deleteObjQueue(1);
    // res.respond = delete_result.dump();
    // // updateFetchedList();
    return 1;
}
bool Backend::serviceLookupPalletCallback(std_stamped_msgs::StringService::Request &req, std_stamped_msgs::StringService::Response &res)
{
    arrangeQueue();
    json empty = {};
    json filter;
    filter[keys.queueIndex] = 1;
    std::string result = "";
    std::lock_guard<std::mutex> lock(mutex_);
    dbClient_->fetchFromCollection(database, collection_queue, filter.dump(), result);

    if (!result.empty())
    {
        // Chuyển đổi tài liệu thành JSON
        json object_ = json::parse(result);
        object_.erase("_id");
        object_.erase(keys.queueIndex);

        // Update collection_model
        std::string model_pallet = object_[keys.merchandise];
        std::string count_pallet = object_[keys.count];

        json result_pallet = lookupPalletModel(model_pallet, count_pallet);
        // Kiểm tra và in ra kết quả
        if (!result_pallet.empty())
        {
            result_pallet.erase("_id");
            object_.merge_patch(result_pallet);
        }
        else
            ROS_ERROR("Can't find Model");

        res.respond = object_.dump();
    }
    else
        res.respond = empty.dump();
    ;

    return 1;
}
bool Backend::serviceAppendPalletCallback(std_stamped_msgs::StringService::Request &req, std_stamped_msgs::StringService::Response &res)
{
    arrangeQueue();
    json data_obj = json::parse(req.request);
    ROS_INFO_STREAM("call service append success");
    // ModelQueue model(data_obj);
    std::string model_pallet = data_obj[keys.merchandise];
    std::string count_pallet = data_obj[keys.count];

    json result_pallet = lookupPalletModel(model_pallet, count_pallet);
    // Kiểm tra và in ra kết quả
    if (result_pallet.empty())
    {
        res.respond = " CAN NOT FIND Merchandise OR COUNT";
        ROS_ERROR(" CAN NOT FIND Merchandise OR COUNT");
        return false;
    }

    // Chèn vào MongoDB
    try
    {
        dbClient_->writeToCollection(database, collection_queue, req.request);
    }
    catch (const std::exception &e)
    {
        std::cerr << e.what() << '\n';
        return false;
    }

    // updateFetchedList();
    res.respond = "service success";
    return true;
}

void Backend::arrangeQueue()
{
    // // Lấy tất cả các document từ collection và sắp xếp theo trường keys.queueIndex
    // auto cursor = collection_queue.find(
    //     bsoncxx::builder::stream::document{} << bsoncxx::builder::stream::finalize,
    //     mongocxx::options::find{}.sort(bsoncxx::builder::stream::document{} << keys.queueIndex << 1 << bsoncxx::builder::stream::finalize));

    // std::vector<bsoncxx::document::value> documents;
    // for (auto &&doc : cursor) {
    //     documents.push_back(bsoncxx::document::value(doc));
    // }

    // // Cập nhật lại các giá trị queue
    // int new_queue_value = 1;
    // for (auto &doc : documents) {
    //     auto id = doc["_id"].get_oid().value;
    //     auto filter = bsoncxx::builder::stream::document{} << "_id" << id << bsoncxx::builder::stream::finalize;
    //     auto update = bsoncxx::builder::stream::document{} << "$set" << bsoncxx::builder::stream::open_document
    //                                                        << keys.queueIndex << new_queue_value++
    //                                                        << bsoncxx::builder::stream::close_document << bsoncxx::builder::stream::finalize;
    //     collection_queue.update_one(filter.view(), update.view());
    // }
}
std::string Backend::switchColorType(int type)
{
    if (type == 0)
    {
        return "#ffeb3b";
    }
    else if (type == 1)
    {
        return "#ff9800";
    }
    else if (type == 3)
    {
        return "#2196f3";
    }
    else if (type == 4)
    {
        return "#4caf50";
    }
    return "#CFD8DC";
}
void Backend::colorPalletQueue(const std::vector<std::string> &result)
{
    // // qDebug() << "Now color pallet queue: " << result.size() << "\n";
    // std::string color = "";
    // rootObject = engine->rootObjects().first();

    // int index = 1; // start from cell 1

    // for (auto &&doc : result)
    // {
    //     json palletJson = json::parse(doc);
    //     if (!(palletJson.contains(keys.palletType) && palletJson[keys.palletType].is_string()))
    //     {
    //         // qDebug() << "Queue cell has invalid data. \n";
    //         ++index;
    //         continue;
    //     }

    //     int type = std::stoi(palletJson[keys.palletType].get<std::string>());

    //     // Switch color base on pallet_type
    //     color = switchColorType(type);

    //     // create object name
    //     std::string obj_ = "zone_" + std::to_string(index) + "_queue";

    //     QObject *item = rootObject->findChild<QObject *>(QString::fromStdString(obj_));
    //     if (!item)
    //     {
    //         // qDebug() << "Can't find cell object_name: " << obj_ << "\n";
    //         ++index;
    //         continue;
    //     }
    //     // qDebug() << "found " << obj_ << "\n";
    //     item->setProperty("color", QColor(QString::fromStdString(color)));
    //     ++index;
    // }
    // // set color for the rest of cell
    // int queueCells = 14;
    // for (size_t i = index; i < queueCells + 1; i++)
    // {
    //     std::string obj_ = "zone_" + std::to_string(i) + "_queue";
    //     QObject *item = rootObject->findChild<QObject *>(QString::fromStdString(obj_));
    //     if (!item)
    //     {
    //         // qDebug() << "Can't find empty cell object_name: " << obj_ << "\n";
    //         continue;
    //     }
    //     item->setProperty("color", QColor(QString::fromStdString("#CFD8DC")));
    // }
}

void Backend::colorPalletBuffer(const std::vector<std::string> &result)
{
    // std::string color = "";
    // rootObject = engine->rootObjects().first();

    // int index = 1; // start from cell 1

    // for (auto &&doc : result)
    // {
    //     json palletJson = json::parse(doc);
    //     if (!(palletJson.contains("type") && palletJson["type"].is_number_integer()))
    //     {
    //         qDebug() << "Buffer cell has invalid data. \n";
    //         ++index;
    //         continue;
    //     }

    //     int type = palletJson["type"].get<int>();

    //     // Switch color base on pallet_type
    //     color = switchColorType(type);

    //     // create object name
    //     std::string obj_ = "zone_" + std::to_string(index);

    //     QObject *item = rootObject->findChild<QObject *>(QString::fromStdString(obj_));
    //     if (!item)
    //     {
    //         // qDebug() << "Can't find cell object_name: " << obj_ << "\n";
    //         ++index;
    //         continue;
    //     }
    //     // qDebug() << "found " << obj_ << "\n";
    //     item->setProperty("color", QColor(QString::fromStdString(color)));
    //     ++index;
    // }
}

/**
 * @brief color all pallet cells
 *
 */
void Backend::updateFetchedList()
{
    // std::cout << " update init\n";
    connect(&threadManager, &ThreadPoolManager::getAllQueueCompleted, this, &Backend::initQueueListModel, Qt::UniqueConnection);
    connect(&threadManager, &ThreadPoolManager::getAllBufferCompleted, this, &Backend::initBufferListModel, Qt::UniqueConnection);
    std::lock_guard<std::mutex> lock(mutex_);
    std::vector<std::string> collectionList = {collection_queue, collection};
    GetCellsProperties *getAllQueue = new GetCellsProperties(dbClient_, collectionList);
    threadManager.executeTask(getAllQueue);
}

/*

                                 ____  ____    _                     _ _
    __ _ _   _  ___ _   _  ___  |  _ \| __ )  | |__   __ _ _ __   __| | | ___ _ __ ___
   / _` | | | |/ _ \ | | |/ _ \ | | | |  _ \  | '_ \ / _` | '_ \ / _` | |/ _ \ '__/ __|
  | (_| | |_| |  __/ |_| |  __/ | |_| | |_) | | | | | (_| | | | | (_| | |  __/ |  \__ \
   \__, |\__,_|\___|\__,_|\___| |____/|____/  |_| |_|\__,_|_| |_|\__,_|_|\___|_|  |___/
      |_|

*/

void Backend::getDataQueue(const int &id)
{
    ROS_ERROR_STREAM("set QUEUE for " << id);
    json filter;
    filter[keys.queueIndex] = id;
    std::string fetchedQueue = "";

    // std::cout << "FILTER: " << filter.dump() << "\n";
    dbClient_->fetchFromCollection(database, collection_queue, filter.dump(),
                                   fetchedQueue);
    // std::cout << "FETCHED JSON: " << fetchedStr << "\n";

    if (fetchedQueue == "")
    {
        qDebug() << "GetQueueTask Task failed.";
        return;
    }
    json fetchedQueueJson;
    try
    {
        fetchedQueueJson = json::parse(fetchedQueue);
    }
    catch (const std::exception &e)
    {
        std::cerr << e.what() << '\n';
        return;
    }

    // search model to get dimensions and type
    std::string merchandise, count;
    merchandise = fetchedQueueJson.at(keys.merchandise).get<std::string>();
    count = fetchedQueueJson.at(keys.count).get<std::string>();
    json filterModel;
    if (merchandise == "" || count == "")
    {
        return;
    }
    filterModel[keys.merchandise] = merchandise;
    filterModel[keys.count] = count;
    std::string fetchedModel = "";
    std::lock_guard<std::mutex> lock(mutex_);
    dbClient_->fetchFromCollection(database, collection_model, filterModel.dump(),
                                   fetchedModel);

    if (fetchedModel == "")
    {
        // std::cerr << "Can not find model\n";
        emit queueJsonFetched(QString::fromStdString(fetchedQueueJson.dump())); // leave unknown fields empty
        return;
    }
    json fetchedModelJson;
    try
    {
        fetchedModelJson = json::parse(fetchedModel);
    }
    catch (const std::exception &e)
    {
        std::cerr << e.what() << '\n';
        emit queueJsonFetched(QString::fromStdString(fetchedQueueJson.dump()));
        return;
    }

    // add missing data to queue view
    fetchedQueueJson[keys.height] = fetchedModelJson.at(keys.height);
    fetchedQueueJson[keys.width] = fetchedModelJson.at(keys.width);
    fetchedQueueJson[keys.length] = fetchedModelJson.at(keys.length);
    fetchedQueueJson[keys.palletType] = fetchedModelJson.at(keys.palletType);

    // show the data to queue view
    emit queueJsonFetched(QString::fromStdString(fetchedQueueJson.dump()));
}
void Backend::addDataQueue(const QString &jsonStr)
{
    ROS_ERROR_STREAM("add new doc toQUEUE");
    // qDebug() << "AddQueueTask started on thread:" << QThread::currentThread();

    json editQueueData;
    try
    {
        editQueueData = json::parse(jsonStr.toStdString());
        std::cout << "request save:" << editQueueData.dump() << "\n";
    }
    catch (const std::exception &e)
    {
        qDebug() << e.what() << '\n';
        emit queueJsonAddFailed("AddQueueTask failed.");
        return;
    }

    if (!(editQueueData.contains(keys.merchandise) &&
          editQueueData.contains(keys.count) &&
          editQueueData.contains(keys.queueIndex) &&
          editQueueData.contains(keys.palletInfo)))
    {
        qDebug() << "No input merchandise and count to add";
        emit queueJsonAddFailed("AddQueueTask failed.");
        return;
    }
    // Check position availability
    json queueFilter;
    std::string queueStr = ""; // fetched queue
    if (false)
    {
        queueFilter[keys.queueIndex] = editQueueData[keys.queueIndex];
        try
        {
            std::lock_guard<std::mutex> lock(mutex_);
            dbClient_->fetchFromCollection(database, collection_queue, queueFilter.dump(), queueStr);
        }
        catch (const std::exception &e)
        {
            // Error when fetching queue
            emit queueJsonAddFailed("AddQueueTask failed.");
            return;
        }
        // if (queueStr != "")
        // {
        //     // Already have a queue at this position
        //     emit queueJsonAddFailed("Already have a queue at this position.");
        //     return;
        // }
    }

    // check for model
    json modelFilter;
    std::string modelStr = ""; // fetched model
    if (false)
    {
        modelFilter[keys.merchandise] = editQueueData[keys.merchandise];
        modelFilter[keys.count] = editQueueData[keys.count];
        try
        {
            std::lock_guard<std::mutex> lock(mutex_);
            dbClient_->fetchFromCollection(database, collection_model, modelFilter.dump(), modelStr);
        }
        catch (const std::exception &e)
        {
            // Error when fetching model
            emit queueJsonAddFailed("AddQueueTask failed.");
            return;
        }

        json modelJson = json::parse(modelStr);
    }

    // TODO: when add to queue -> check the size of collection -> insert new doc to collection -> increase the queue of doc which queue > inserted doc's queue
    queueFilter[keys.queueIndex] = editQueueData[keys.queueIndex].is_number() ? editQueueData[keys.queueIndex].get<int>() : std::stoi(editQueueData[keys.queueIndex].get<std::string>());

    try
    {
        dbClient_->addMidleCollection(database, collection_queue, queueFilter.dump(), editQueueData.dump());
    }
    catch (const std::exception &e)
    {
        qDebug() << e.what() << '\n';
        emit queueJsonAddFailed("AddQueueTask failed.");
        return;
    }
    emit queueJsonAdded();
}

void Backend::saveDataQueue(const QString &jsonstr)
{
    json modelFilter;
    std::string modelStr = ""; // fetched model
    json jsonToFilter;
    json jsonToSave;
    json filter;
    json modelJson;

    json editQueueData;
    try
    {
        std::string palletStr = jsonstr.toStdString();
        editQueueData = json::parse(palletStr);
    }
    catch (const std::exception &e)
    {
        // qDebug() << e.what() << '\n';
        emit queueJsonEditFailed("Save data failed.");
        return;
    }

    if (!(editQueueData.contains(keys.merchandise) &&
          editQueueData.contains(keys.count)))
    {
        emit queueJsonEditFailed("Save data failed.");
        return;
    }
    // TODO: Look for model of request edit
    modelFilter[keys.merchandise] = editQueueData[keys.merchandise];
    modelFilter[keys.count] = editQueueData[keys.count];
    // Search for model
    if (false)
    {
        try
        {
            std::lock_guard<std::mutex> lock(mutex_);
            dbClient_->fetchFromCollection(database, collection_model, modelFilter.dump(), modelStr);
        }
        catch (const std::exception &e)
        {
            // qDebug() << e.what() << '\n';
            emit queueJsonEditFailed("Save data failed.");
            return;
        }
        if (modelStr == "")
        {
            // qDebug() << "MODEL IS NOT IN DataBase" << '\n';
            emit queueJsonEditFailed("Save data failed: Model not found.");
            return;
        }
        modelJson = json::parse(modelStr);
    }

    // TODO: concat request save json and model json to make a json which will be saved
    jsonToSave["$set"] = {
        {keys.merchandise, editQueueData[keys.merchandise]},
        {keys.count, editQueueData[keys.count]},
        {keys.palletInfo, editQueueData[keys.palletInfo]}};

    filter[keys.queueIndex] = std::stoi(editQueueData[keys.queueIndex].get<std::string>());
    try
    {
        std::lock_guard<std::mutex> lock(mutex_);
        dbClient_->editInCollection(database, collection_queue, filter.dump(),
                                    jsonToSave.dump());
    }
    catch (const std::exception &e)
    {
        std::cerr << e.what() << '\n';
        // qDebug() << "task failed";
        emit queueJsonEditFailed("Save data failed.");
    }
    QString result = "OK";
    // qDebug() << "EditQueueTask finishe                                                                                                                                                                                                               d.";
    emit queueJsonEdited();
}

void Backend::deleteDataQueue(const int &id)
{
    ROS_ERROR_STREAM("delete QUEUE for " << id);
    std::lock_guard<std::mutex> lock(mutex_);
    json filter;
    filter[keys.queueIndex] = id;

    try
    {
        dbClient_->removeMidleCollection(database, collection_queue, filter.dump());
    }
    catch (const std::exception &e)
    {
        std::cerr << e.what() << '\n';
        // qDebug() << "task failed";
        emit queueJsonDeleteFailed("Delete data failed.");
    }
    emit queueJsonDeleted();
}

/**
 * @brief Getter for QVariantList
 *
 * @return QVariantList
 */
QVariantList Backend::getQueueListModel() const
{
    // qDebug() << "pQueueListModel_: " << pQueueListModel_ << "\n";
    return pQueueListModel_;
}

/**
 * @brief Update the QVariantList base on the result
 *
 * @param result
 */
void Backend::initQueueListModel(const std::vector<std::string> &result)
{
    // std::cout << "updateQueueModel\n";
    pQueueListModel_.clear();

    for (const auto &jsonString : result)
    {
        json fetchedQueueJson;
        try
        {
            fetchedQueueJson = json::parse(jsonString);
        }
        catch (const std::exception &e)
        {
            std::cerr << e.what() << '\n';
            return;
        }

        // search model to get dimensions and type
        std::string merchandise, count;
        merchandise = fetchedQueueJson.at(keys.merchandise).get<std::string>();
        count = fetchedQueueJson.at(keys.count).get<std::string>();
        json filterModel;
        if (merchandise == "" || count == "")
        {
            continue;
        }
        filterModel[keys.merchandise] = merchandise;
        filterModel[keys.count] = count;
        std::string fetchedModel = "";
        std::lock_guard<std::mutex> lock(mutex_);
        dbClient_->fetchFromCollection(database, collection_model, filterModel.dump(),
                                       fetchedModel);

        if (fetchedModel == "")
        {
            // std::cerr << "Can not find model\n";
            // add the data to queue view model
            QJsonDocument doc = QJsonDocument::fromJson(QByteArray::fromStdString(fetchedQueueJson.dump()));
            if (doc.isObject())
            {
                pQueueListModel_.append(doc.object().toVariantMap());
            }
            continue;
        }
        json fetchedModelJson;
        try
        {
            fetchedModelJson = json::parse(fetchedModel);
        }
        catch (const std::exception &e)
        {
            std::cerr << e.what() << '\n';
            // add the data to queue view model
            QJsonDocument doc = QJsonDocument::fromJson(QByteArray::fromStdString(fetchedQueueJson.dump()));
            if (doc.isObject())
            {
                pQueueListModel_.append(doc.object().toVariantMap());
            }
            continue;
        }

        // add missing data to queue view
        fetchedQueueJson[keys.height] = fetchedModelJson.at(keys.height);
        fetchedQueueJson[keys.width] = fetchedModelJson.at(keys.width);
        fetchedQueueJson[keys.length] = fetchedModelJson.at(keys.length);
        fetchedQueueJson[keys.palletType] = fetchedModelJson.at(keys.palletType);

        // add the data to queue view model
        QJsonDocument doc = QJsonDocument::fromJson(QByteArray::fromStdString(fetchedQueueJson.dump()));
        if (doc.isObject())
        {
            pQueueListModel_.append(doc.object().toVariantMap());
        }
    }
    // qDebug() << "pQueueListModel_: " << pQueueListModel_ << "\n";
    emit pQueueListModelChanged();
}

void Backend::addDataModel(QString jsonstring)
{
    // TODO: check fields
    json fetchedQueueJson;
    try
    {
        fetchedQueueJson = json::parse(jsonstring.toStdString());
    }
    catch (const std::exception &e)
    {
        std::cerr << e.what() << '\n';
        emit modelJsonAddFailed(QString::fromStdString(e.what()));
        return;
    }
    std::string merchandise, count;
    merchandise = fetchedQueueJson.at(keys.merchandise).get<std::string>();
    count = fetchedQueueJson.at(keys.count).get<std::string>();
    json filterModel;
    if (merchandise == "" || count == "")
    {
        emit modelJsonAddFailed(QString::fromStdString("Filter error"));
    }
    filterModel[keys.merchandise] = merchandise;
    filterModel[keys.count] = count;
    std::string fetchedModel = "";
    std::lock_guard<std::mutex> lock(mutex_);
    std::cout << "fetch: " << merchandise << " - " << count <<"\n";
    dbClient_->fetchFromCollection(database, collection_model, filterModel.dump(),
                                   fetchedModel);

    // TODO: Do not add if model and count is existed
    if (fetchedModel != "")
    {
        emit modelJsonAddFailed(QString::fromStdString("Model is already existed"));
        return;
    }

    try
    {
        dbClient_->writeToCollection(database, collection_model, jsonstring.toStdString());
    }
    catch (const std::exception &e)
    {
        // std::cerr << e.what() << '\n';
        emit modelJsonAddFailed(QString::fromStdString(e.what()));
        return;
    }
    emit modelJsonAdded();
}
void Backend::saveDataModel(QString jsonstring)
{
    // TODO: check fields
    json fetchedQueueJson;
    try
    {
        fetchedQueueJson = json::parse(jsonstring.toStdString());
    }
    catch (const std::exception &e)
    {
        std::cerr << e.what() << '\n';
        emit modelJsonEditFailed(QString::fromStdString(e.what()));
        return;
    }
    std::string merchandise, count;
    merchandise = fetchedQueueJson.at(keys.merchandise).get<std::string>();
    count = fetchedQueueJson.at(keys.count).get<std::string>();
    json filterModel;
    if (merchandise == "" || count == "")
    {
        emit modelJsonEditFailed(QString::fromStdString("Filter error"));
    }
    filterModel[keys.merchandise] = merchandise;
    filterModel[keys.count] = count;
    std::string fetchedModel = "";
    std::lock_guard<std::mutex> lock(mutex_);
    dbClient_->fetchFromCollection(database, collection_model, filterModel.dump(),
                                   fetchedModel);

    // TODO: Do not save if model and count is not existed
    if (fetchedModel == "")
    {
        emit modelJsonEditFailed(QString::fromStdString("No saved model"));
        return;
    }
    try
    {
        json filter, jsonToSave;
        json editBufferData = json::parse(jsonstring.toStdString());

        filter[keys.merchandise] = editBufferData[keys.merchandise].get<std::string>();
        filter[keys.count] = editBufferData[keys.count].is_number() ? std::to_string(editBufferData[keys.count].get<int>()) : editBufferData[keys.count].get<std::string>();
        std::cout << "filter" << filter.dump() << "\n";
        jsonToSave["$set"] = {
            {keys.merchandise, editBufferData[keys.merchandise]},
            {keys.count, editBufferData[keys.count]},
            {keys.palletType, editBufferData[keys.palletType]},
            {keys.height, editBufferData[keys.height]},
            {keys.width, editBufferData[keys.width]},
            {keys.length, editBufferData[keys.length]}};

        dbClient_->editInCollection(database, collection_model, filter.dump(), jsonToSave.dump());
    }
    catch (const std::exception &e)
    {
        // std::cerr << e.what() << '\n';
        emit modelJsonEditFailed(QString::fromStdString(e.what()));
        return;
    }
    emit modelJsonEdited();
}
void Backend::deleteDataModel(QString jsonstring)
{
    try
    {
        std::cout << "filter: " << jsonstring.toStdString() << "\n";
        std::lock_guard<std::mutex> lock(mutex_);
        dbClient_->eraseFromCollection(database, collection_model, jsonstring.toStdString());
    }
    catch (const std::exception &e)
    {
        // std::cerr << e.what() << '\n';
        // // qDebug() << "task failed";
        emit modelJsonDeleteFailed(QString::fromStdString(e.what()));
        return;
    }
    emit modelJsonDeleted();
}

/**
 * @brief Search model base on Merchandise and count
 *
 * @param merchandise
 * @param count
 */
void Backend::searchModel(const QString &merchandise, const QString &count)
{
    std::cout << "search: " << merchandise.toStdString() << "&&" << count.toStdString() << "\n";
    json filter;
    if (merchandise == "" || count == "")
    {
        return;
    }
    filter[keys.merchandise] = merchandise.toStdString();
    filter[keys.count] = count.toStdString();
    std::string fetchedStr = "";
    std::lock_guard<std::mutex> lock(mutex_);
    dbClient_->fetchFromCollection(database, collection_model, filter.dump(),
                                   fetchedStr);
    json fetchedJson;
    if (fetchedStr == "")
    {
        std::cerr << "Can not find model\n";
        queueSeekModelDone(QString::fromStdString(fetchedJson.dump()));
        modelJsonFetched(QString::fromStdString(fetchedJson.dump()));
        return;
    }
    // set the position index to max
    fetchedJson = json::parse(fetchedStr);
    auto queueSize = dbClient_->getCollectionSize(database, collection_queue);

    // TODO: keep the current queue being displayed
    std::string obj_ = "_Id__";
    QObject *item = rootObject->findChild<QObject *>(QString::fromStdString(obj_));
    if (item)
    {
        QVariant current_queue = item->property("text");
        fetchedJson[keys.queueIndex] = current_queue.isValid() ? current_queue.toInt() : (queueSize + 1);
    }
    // Output a string to be update on screen
    queueSeekModelDone(QString::fromStdString(fetchedJson.dump()));
    modelJsonFetched(QString::fromStdString(fetchedJson.dump()));
}

/**
 * @brief Increase size of queue collection
 *
 */
void Backend::expandQueue()
{
    auto queueSize = dbClient_->getCollectionSize(database, collection_queue);
    json fetchedJson;
    fetchedJson[keys.queueIndex] = 1;
    emit queueJsonFetched(QString::fromStdString(fetchedJson.dump()));
}

/**
 * @brief Change index of 2 documents for switching their position in Listview
 *
 * @param from
 * @param to
 */
void Backend::switchDocs(int from, int to)
{
    std::string currentDoc, destDoc;
    json filter, update;

    // Fetch doc at queue number
    filter = json::object();
    filter[keys.queueIndex] = from + 1;
    dbClient_->fetchFromCollection(database, collection_queue, filter.dump(), currentDoc);

    filter = json::object();
    filter[keys.queueIndex] = to + 1;
    dbClient_->fetchFromCollection(database, collection_queue, filter.dump(), destDoc);

    if (currentDoc == "" && destDoc == "")
    {
        std::cerr << "Fetch empty doc" << "\n";
        return;
    }

    json currentDoc_json = json::parse(currentDoc);
    json destDoc_json = json::parse(destDoc);

    std::cout << "currentDoc_json: " << currentDoc_json << "\n";
    std::cout << "destDoc_json: " << destDoc_json << "\n";

    // Switch queue number of destination doc and current doc
    currentDoc_json[keys.queueIndex] = to + 1;
    destDoc_json[keys.queueIndex] = from + 1;

    filter = json::object();
    filter["_id"]["$oid"] = currentDoc_json["_id"]["$oid"].get<std::string>();
    std::cout << "currentDoc_json OID: " << filter.dump() << "\n";
    dbClient_->editInCollection(database, collection_queue, filter.dump(), currentDoc_json.dump());

    filter = json::object();
    filter["_id"]["$oid"] = destDoc_json["_id"]["$oid"].get<std::string>();
    dbClient_->editInCollection(database, collection_queue, filter.dump(), destDoc_json.dump());

    // Trigger update view
    emit pQueueListModelChanged();
}

/*

   _            __  __             ____  ____    _                     _ _
  | |__  _   _ / _|/ _| ___ _ __  |  _ \| __ )  | |__   __ _ _ __   __| | | ___ _ __ ___
  | '_ \| | | | |_| |_ / _ \ '__| | | | |  _ \  | '_ \ / _` | '_ \ / _` | |/ _ \ '__/ __|
  | |_) | |_| |  _|  _|  __/ |    | |_| | |_) | | | | | (_| | | | | (_| | |  __/ |  \__ \
  |_.__/ \__,_|_| |_|  \___|_|    |____/|____/  |_| |_|\__,_|_| |_|\__,_|_|\___|_|  |___/


*/

void Backend::getDataBuffer(const int &id)
{
    ROS_ERROR_STREAM("set BUFFER for " << id);
    std::lock_guard<std::mutex> lock(mutex_);
    // qDebug() << "GetBufferTask started on thread:" << QThread::currentThread();
    json filter;
    filter["stt"] = id;
    std::string fetchedStr = "";

    dbClient_->fetchFromCollection(database, collection, filter.dump(),
                                   fetchedStr);
    if (fetchedStr != "")
    {
        QString result = QString::fromStdString(fetchedStr);
        emit bufferJsonFetched(result);
    }
}

/**
 * @brief Add new data to buffer collection
 *
 * @param id
 * @param jsonStr
 */
void Backend::addDataBuffer(const QString &jsonStr)
{
    // // List of required keys for each JSON object
    // std::vector<std::string> modelJsonKeys = {keys.merchandise, keys.count};
    // std::vector<std::string> addBufferKeys = {
    //     keys.height, keys.width, keys.length, keys.palletType,
    //     keys.zoneId, keys.columnId, keys.locationId, keys.palletInfo};

    // json modelFilter;
    // std::string modelStr = "";  // fetched model
    // json jsonToSave;
    // json bufferFilter;

    // // qDebug() << "request save: " << editStr_ << "\n";
    // json addBufferData = json::parse(jsonStr);

    // // Check for model keys first
    // if (keys.hasRequiredKeys(addBufferData, modelJsonKeys)) {
    //     // Search for model
    //     modelFilter[keys.merchandise] = addBufferData[keys.merchandise];
    //     modelFilter[keys.count] = addBufferData[keys.count];
    //     try {
    //         std::lock_guard<std::mutex> lock(mutex_);
    //         dbClient_->fetchFromCollection(database, collection_model, modelFilter.dump(), modelStr);
    //     } catch (const std::exception &e) {
    //         // qDebug() << e.what() << '\n';
    //         emit bufferJsonAddFail(QString::fromStdString(e.what()));
    //         return;
    //     }
    //     if (modelStr == "") {
    //         // qDebug() << "MODEL IS NOT IN DataBase" << '\n';
    //         emit bufferJsonAddFail(QString::fromStdString("MODEL IS NOT IN DATABASE"));
    //         return;
    //     }
    //     json modelJson = json::parse(modelStr);

    //     // Check for keys availability in final docs which will be add to collection
    //     if (keys.hasRequiredKeys(addBufferData, addBufferKeys)) {
    //         // Data from text fields
    //         jsonToSave[keys.merchandise] = addBufferData[keys.merchandise];
    //         jsonToSave[keys.count] = addBufferData[keys.count];
    //         jsonToSave["stt"] = addBufferData["stt"].get<int>();
    //         jsonToSave[keys.zoneId] = addBufferData[keys.zoneId];
    //         jsonToSave[keys.columnId] = addBufferData[keys.columnId];
    //         jsonToSave[keys.locationId] = addBufferData[keys.locationId];
    //         jsonToSave[keys.palletInfo] = addBufferData[keys.palletInfo];
    //         // Data from model collection
    //         jsonToSave[keys.height] = modelJson[keys.height];
    //         jsonToSave[keys.width] = modelJson[keys.width];
    //         jsonToSave[keys.length] = modelJson[keys.length];
    //         jsonToSave[keys.palletType] = modelJson[keys.palletType];
    //     } else {
    //         emit bufferJsonAddFail(QString::fromStdString("Missing input param"));
    //         return;
    //     }

    //     // TODO: when add to queue -> check the size of collection -> insert new doc to collection -> increase the queue of doc which queue > inserted doc's queue
    //     bufferFilter["stt"] = addBufferData["stt"].get<int>();

    //     try {
    //         std::lock_guard<std::mutex> lock(mutex_);
    //         dbClient_->addMidleCollection(database, collection_queue, bufferFilter.dump(), jsonToSave.dump());
    //     } catch (const std::exception &e) {
    //         // qDebug() << e.what() << '\n';
    //         emit bufferJsonAddFail(QString::fromStdString(e.what()));
    //         return;
    //     }
    //     // qDebug() << "AddQueueTask finished.";
    //     emit bufferJsonAdded();
}
void Backend::saveDataBuffer(const QString &jsonstring)
{
    json modelFilter;
    std::string modelStr = ""; // fetched model
    json jsonToSave;
    json filter;

    json editBufferData = json::parse(jsonstring.toStdString());
    // Search for buffer id
    modelFilter[keys.bufferIndex] = editBufferData[keys.bufferIndex];
    try
    {
        dbClient_->fetchFromCollection(database, collection, modelFilter.dump(), modelStr);
    }
    catch (const std::exception &e)
    {
        // qDebug() << e.what() << '\n';
        emit bufferJsonEditFailed(QString::fromStdString(e.what()));
        return;
    }
    if (modelStr == "")
    {
        // qDebug() << "MODEL IS NOT IN DataBase" << '\n';
        emit bufferJsonEditFailed(QString::fromStdString("THIS BUFFER IS NOT IN DATABASE"));
        return;
    }

    json modelJson = json::parse(modelStr);
    jsonToSave["$set"] = {
        {keys.bufferMerchandise, editBufferData[keys.bufferMerchandise]},
        {keys.bufferStatus, editBufferData[keys.bufferStatus]},
        {keys.count, editBufferData[keys.count]},
        {keys.zoneId, editBufferData[keys.zoneId]},
        {keys.locationId, editBufferData[keys.locationId]},
        {keys.columnId, editBufferData[keys.columnId]},
        {keys.bufferType, editBufferData[keys.bufferType]},
        {keys.height, editBufferData[keys.height]},
        {keys.width, editBufferData[keys.width]},
        {keys.length, editBufferData[keys.length]}};

    filter[keys.bufferIndex] = editBufferData[keys.bufferIndex];
    try
    {
        std::lock_guard<std::mutex> lock(mutex_);
        dbClient_->editInCollection(database, collection, filter.dump(),
                                    jsonToSave.dump());
    }
    catch (const std::exception &e)
    {
        // std::cerr << e.what() << '\n';
        emit bufferJsonEditFailed(QString::fromStdString(e.what()));
        return;
    }
    emit bufferJsonEdited();
}
void Backend::deleteDataBuffer(const QString &id)
{
    // qDebug() << "EraseQueueTask started on thread:" << QThread::currentThread();
    // Clear the data from doc

    json filter, jsonToSave;
    jsonToSave["$set"] = {
        {keys.bufferMerchandise, "free"},
        {keys.bufferStatus, "free"},
        {keys.bufferType, -1},
        {keys.zoneId, 1},
        {keys.locationId, 1},
        {keys.columnId, 1},
        {keys.bufferType, -1},
        {keys.height, 0},
        {keys.width, 0},
        {keys.length, 0}};
    filter[keys.bufferIndex] = id.toStdString();
    try
    {
        std::lock_guard<std::mutex> lock(mutex_);
        dbClient_->editInCollection(database, collection, filter.dump(),
                                    jsonToSave.dump());
    }
    catch (const std::exception &e)
    {
        // std::cerr << e.what() << '\n';
        // // qDebug() << "task failed";
        emit bufferJsonDeleteFailed(QString::fromStdString(e.what()));
    }
    emit bufferJsonDeleted();
}
/**
 * @brief Getter for QVariantList
 *
 * @return QVariantList
 */
QVariantList Backend::getBufferListModel() const
{
    // qDebug() << "pQueueListModel_: " << pQueueListModel_ << "\n";
    return pBufferListModel_;
}

/**
 * @brief Update the QVariantList base on the result
 *
 * @param result
 */
void Backend::initBufferListModel(const std::vector<std::string> &result)
{
    pBufferListModel_.clear();

    for (const auto &jsonString : result)
    {
        QJsonDocument doc = QJsonDocument::fromJson(QByteArray::fromStdString(jsonString));
        if (doc.isObject())
        {
            pBufferListModel_.append(doc.object().toVariantMap());
        }
    }
    // qDebug() << "pBufferListModel_: " << pBufferListModel_ << "\n";
    emit pBufferListModelChanged();
}

/*

                       _      _   ____  ____    _                     _ _
   _ __ ___   ___   __| | ___| | |  _ \| __ )  | |__   __ _ _ __   __| | | ___ _ __ ___
  | '_ ` _ \ / _ \ / _` |/ _ \ | | | | |  _ \  | '_ \ / _` | '_ \ / _` | |/ _ \ '__/ __|
  | | | | | | (_) | (_| |  __/ | | |_| | |_) | | | | | (_| | | | | (_| | |  __/ |  \__ \
  |_| |_| |_|\___/ \__,_|\___|_| |____/|____/  |_| |_|\__,_|_| |_|\__,_|_|\___|_|  |___/


*/

// void Backend::setModelBuffer(const int &id) {
//     ROS_ERROR_STREAM("set BUFFER for " << id);
//     // ThreadPoolManager threadManager;
//     connect(&threadManager, &ThreadPoolManager::getBufferTaskCompleted, this, &Backend::bufferJsonFetched, Qt::UniqueConnection);

//     json palletJson;

//     GetBufferTask *getBufferPallet = new GetBufferTask(dbClient_, id);
//     threadManager.executeTask(getBufferPallet);

//     //updateFetchedList();
// }
// void Backend::addModelBuffer(const int &id, const QString &jsonStr){
//     connect(&threadManager, &ThreadPoolManager::addBufferTaskCompleted, this, &Backend::BufferDbAdded, Qt::UniqueConnection);

//     std::string palletStr = QString::toStdString(jsonStr);

//     AddBufferTask *addBufferPallet = new AddBufferTask(dbClient_, id, palletStr);
//     threadManager.executeTask(addBufferPallet);
// }
// void Backend::saveModelBuffer(QString jsonstring) {
//     // nlohmann::json jsonObj = nlohmann::json::parse(jsonstring.toStdString());
//     // jsonObj["Buffer"] = std::stoi(jsonObj["Buffer"].get<std::string>());
//     // mongocxx::cursor cursor = collection_Buffer.find({});

//     // std::string id_ = jsonObj["_id"].get<std::string>();
//     // bsoncxx::oid id(id_);  // Thay bằng _id thực tế của bạn
//     // bsoncxx::builder::stream::document filter_builder;
//     // filter_builder << "_id" << id;

//     // ModelBuffer modelupdate(jsonObj, jsonObj["Buffer"]);
//     // modelupdate.update(collection_Buffer, filter_builder.view());
//     //updateFetchedList();
// }
// void Backend::deleteModelBuffer(QString jsonstring) {
//     // nlohmann::json jsonObj = nlohmann::json::parse(jsonstring.toStdString());
//     // jsonObj["Buffer"] = std::stoi(jsonObj["Buffer"].get<std::string>());
//     // mongocxx::cursor cursor = collection_Buffer.find({});

//     // std::string id_ = jsonObj["_id"].get<std::string>();
//     // bsoncxx::oid id(id_);  // Thay bằng _id thực tế của bạn
//     // bsoncxx::builder::stream::document filter_builder;
//     // filter_builder << "_id" << id;

//     // ModelBuffer modelupdate(jsonObj, jsonObj["Buffer"]);
//     // modelupdate.update(collection_Buffer, filter_builder.view());
//     //updateFetchedList();
// }

void Backend::switchColorBuffer(mongocxx::collection coll, std::string old_id)
{
}

void Backend::switchColorQueue(mongocxx::collection coll, std::string old_id, std::string update_id)
{
    std::string obj__ = "zone_" + old_id + "_queue";
    QObject *item = rootObject->findChild<QObject *>(QString::fromStdString(obj__));

    if (item)
    {
        item->setProperty("color", QColor(QString::fromStdString("#CFD8DC")));
    }
    std::string obj_ = "zone_" + update_id + "_queue";
    // std::cout << obj_ << std::endl;
    QObject *itemz = rootObject->findChild<QObject *>(QString::fromStdString(obj_));

    if (itemz)
    {
        itemz->setProperty("color", QColor(QString::fromStdString("#EF5350")));
    }
}

void Backend::requestStop(const QString &str)
{
    std_stamped_msgs::StringStamped request_stop_msg;
    request_stop_msg.stamp = ros::Time::now();
    std::string data_ = "STOP";
    request_stop_msg.data = data_;
    robot_stop_pub.publish(request_stop_msg);

    std_stamped_msgs::StringService::Request req;
    std_stamped_msgs::StringService::Response res;
    std_stamped_msgs::StringService srv;
    req.request = "Hello, this is a request stop_trigger_manager ";

    // Đợi tối đa 2 giây để service sẵn sàng
    if (ros::service::waitForService("/stop_trigger_manager", ros::Duration(2)))
    {
        if (stop_error_agf.call(req, res))
        {
            ROS_INFO("Response: %s", res.respond.c_str());
        }
        else
        {
            ROS_ERROR("Failed to call service string_service");
        }
    }
    else
    {
        ROS_ERROR("Service /stop_trigger_manager not available after timeout.");
        emit serviceTimeout();
    }
}

void Backend::requestReset(const QString &str)
{
    std_stamped_msgs::StringService::Request req;
    std_stamped_msgs::StringService::Response res;

    req.request = "Hello, this is a request reset_trigger_manager";

    // Đợi tối đa 2 giây để service sẵn sàng
    if (ros::service::waitForService("/reset_error_agf", ros::Duration(2)))
    {
        if (reset_error_agf.call(req, res))
        {
            ROS_INFO("Response: %s", res.respond.c_str());
        }
        else
        {
            ROS_ERROR("Failed to call service string_service");
        }
    }
    else
    {
        ROS_ERROR("Service /reset_error_agf not available after timeout.");
        emit serviceTimeout();
    }
}

void Backend::updateMerchandiseList()
{
    qDebug() << "updapteMerchandiseList\n";
    // Look for all unique merchandise in pallet_model collection
    std::vector<std::string> merchandiseList;
    dbClient_->getUniqueList(database, collection_model, keys.merchandise, merchandiseList);
    // convert std::string to QString
    for (const auto &item : merchandiseList)
    {
        modelMerchandiseList_ << QString::fromStdString(item);
    }
}
void Backend::updateCountList()
{
    // Look for all unique count in pallet_model collection
    std::vector<std::string> countList;
    dbClient_->getUniqueList(database, collection_model, keys.count, countList);
    // convert std::string to QString
    for (const auto &item : countList)
    {
        modelCountList_ << QString::fromStdString(item);
    }
}

QStringList Backend::getMerchandiseList()
{
    return modelMerchandiseList_;
}
QStringList Backend::getCountList()
{
    return modelCountList_;
}
void Backend::updateComboBox(QString model, QString count)
{
    // std::string model_string = model.toStdString();
    // std::string count_string = count.toStdString();
    // json model_data = lookupPalletModel(model_string, count_string);
    // // std::cout << model_string << std::endl;
    // if (!model_data.empty()) {
    //     // model_data.erase("_id");

    //     model_data.erase(keys.merchandise);
    //     model_data.erase(keys.count);

    //     for (auto it = model_data.begin(); it != model_data.end(); ++it) {
    //         std::string key = "_" + it.key() + "__";  // Lấy tên key
    //         auto value = it.value();                  // Lấy giá trị
    //         rootObject = engine->rootObjects().first();
    //         if (key == "__id__") {
    //             bsoncxx::builder::stream::document filter_model_pallet;
    //             filter_model_pallet << "$and" << bsoncxx::builder::stream::open_array
    //                                 << bsoncxx::builder::stream::open_document
    //                                 << keys.merchandise << model_string  // Điều kiện 1
    //                                 << bsoncxx::builder::stream::close_document
    //                                 << bsoncxx::builder::stream::open_document
    //                                 << keys.count << count_string  // Điều kiện 2
    //                                 << bsoncxx::builder::stream::close_document
    //                                 << bsoncxx::builder::stream::close_array;

    //             // Thực hiện tìm kiếm một tài liệu
    //             auto result_pallet = collection_model.find_one(filter_model_pallet.view());
    //             if (result_pallet) {
    //                 bsoncxx::document::view view_pallet = result_pallet->view();
    //                 QObject *itempp = rootObject->findChild<QObject *>(QString::fromStdString("__id__"));
    //                 if (itempp) {
    //                     itempp->setProperty("text", QString::fromStdString(view_pallet["_id"].get_oid().value.to_string()));
    //                 }
    //             }
    //         } else {
    //             QObject *item = rootObject->findChild<QObject *>(QString::fromStdString(key));
    //             if (item) {
    //                 QString propertyValue = QString::fromStdString(value.get<std::string>());

    //                 item->setProperty("text", propertyValue);
    //             }
    //         }
    //     }
    // }
    // std::cout << model_string << std::endl;
    // //updateFetchedList();
}
void Backend::deleteModelImport()
{
    dbClient_->eraseFromCollection(database, collection_model, "{}");
    emit modelDbClear();
}
QString Backend::openFileDialog()
{
    std::string status = "";
    updateStatusStr = QString::fromStdString(status);
    QString fileName = QFileDialog::getOpenFileName(nullptr, "Chọn file", "", "All Files (*)");
    if (!fileName.isEmpty())
    {
        int result = dbClient_->eraseFromCollection(database, collection_model, "{}");
        if (result)
        {
            std::ostringstream oss;
            oss << "Đã xóa " << result << " model. \n";
            status = oss.str();
        }
        else
        {
            status = "Không có model nào được xóa. \n";
        }
        updateStatusStr = QString::fromStdString(status);
        emit updateStatusChanged();

        // update model tu file

        // Mở file CSV
        std::ifstream file(fileName.toStdString());
        if (!file.is_open())
        {
            status = "Không thể mở file \n";
            updateStatusStr = QString::fromStdString(status);
            emit updateStatusChanged();
            return fileName;
        }

        // Đọc file dòng theo dòng
        std::vector<std::string> current_line;
        std::vector<std::string> pre_line;
        std::vector<std::string> next_line;

        std::string line;
        int line_count = 0;
        while (std::getline(file, line))
        {
            line_count++;
            // std::cout << line << std::endl;
            json row_json;
            int pallet_type;

            // Tách các giá trị theo dấu phẩy
            std::stringstream ss(line);
            std::string value;
            std::vector<std::string> row;

            while (std::getline(ss, value, ','))
            {
                // Thêm giá trị vào vector
                row.push_back(value);
            }
            if (line_count >= 3)
            {
                pre_line = current_line;
                current_line = next_line;
                next_line = row;
            }
            else if (line_count == 2)
            {
                current_line = next_line;
                next_line = row;
                continue;
            }
            else if (line_count == 1)
            {
                next_line = row;
                continue;
            }
            row_json[keys.merchandise] = current_line[1];
            row_json[keys.count] = current_line[8];
            row_json[keys.palletType] = std::to_string(check_line(current_line, pre_line, next_line));
            row_json[keys.length] = current_line[5];
            row_json[keys.width] = current_line[6];
            row_json[keys.height] = std::to_string(stringToFloat(current_line[7]) * 1000);

            int result = dbClient_->writeToCollection(database, collection_model, row_json.dump());

            if (result == 0)
            {
                std::ostringstream oss;
                oss << " import success - " << line_count << " - " << current_line[1] << "\n";
                status = oss.str();
                updateStatusStr = QString::fromStdString(status);
                emit updateStatusChanged();
            }
            else
            {
                std::ostringstream oss;
                oss << " import false - " << line_count << " - " << current_line[1] << "\n";
                status = oss.str();
                updateStatusStr = QString::fromStdString(status);
                emit updateStatusChanged();
            }
        }
        json row_j;
        row_j[keys.merchandise] = next_line[1];
        row_j[keys.count] = next_line[8];
        row_j[keys.palletType] = std::to_string(check_line(next_line, pre_line, pre_line));
        row_j[keys.length] = next_line[5];
        row_j[keys.width] = next_line[6];
        row_j[keys.height] = std::to_string(stringToFloat(next_line[7]) * 1000);

        int result1 = dbClient_->writeToCollection(database, collection_model, row_j.dump());

        if (result1 == 0)
        {
            status = " import success - " + next_line[1] + "\n";

            updateStatusStr = QString::fromStdString(status);
            emit updateStatusChanged();
        }
        else
        {
            status = " import false - " + next_line[1];
            updateStatusStr = QString::fromStdString(status);
            emit updateStatusChanged();
        }

        // Đóng file Excel
        file.close();
    }

    return fileName;
}

int Backend::check_line(std::vector<std::string> &current_line, std::vector<std::string> &pre_line, std::vector<std::string> &next_line)
{
    if (current_line[1] == pre_line[1])
    {
        if (stringToFloat(current_line[8]) > stringToFloat(pre_line[8]))
        {
            return 1;
        }
        else
            return 0;
    }
    else if (current_line[1] == next_line[1])
    {
        if (stringToFloat(current_line[8]) > stringToFloat(next_line[8]))
        {
            return 1;
        }
        else
            return 0;
    }
    else
        return 3;
}
#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QString>
#include <QQmlApplicationEngine>
#include <QFileDialog>
#include <ros/ros.h>
#include <std_stamped_msgs/Float32Stamped.h>
#include <std_stamped_msgs/StringStamped.h>
#include <std_stamped_msgs/EmptyStamped.h>
#include <string>
#include <iostream>
#include <nlohmann/json.hpp>
#include "model_queue.h"
#include "model_buffer.h"
#include "model_pallet.h"
#include <fstream> 
#include <cmath> 
#include <std_msgs/Int16MultiArray.h>
#include <vector>
#include <geometry_msgs/Twist.h>
#include <sstream>
#include <cstdio>
#include <memory>
#include <QTranslator>
#include <yaml-cpp/yaml.h>
#include <cstdlib>
#include <std_msgs/Int16.h>
#include <std_msgs/Int8.h>
#include <std_msgs/String.h>
#include <std_msgs/UInt32.h>
#include <std_msgs/Empty.h>
#include <std_srvs/Empty.h>
#include <std_stamped_msgs/StringService.h>
#include <QGuiApplication>
#include <QColor>
#include <bsoncxx/json.hpp>
#include <bsoncxx/builder/stream/document.hpp>
#include <mongocxx/client.hpp>
#include <mongocxx/instance.hpp>
#include <mongocxx/uri.hpp>
#include <mongocxx/database.hpp>
#include <mongocxx/collection.hpp>
#include <mongocxx/exception/exception.hpp>
#include <bsoncxx/builder/stream/document.hpp>
#include <mongocxx/stdx.hpp>
#include <mongocxx/result/update.hpp>
#include <QQuickItem>
#include <QStringList>
#include <QJsonDocument>
#include <QJsonObject>
#include <QVariant>
#include <thread>
#include <QQmlContext>
// #include <OpenXLSX.hpp>

using json = nlohmann::json;
class Backend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double batteryPercentage READ batteryPercentage NOTIFY batteryPercentageChanged)
    Q_PROPERTY(double batteryVoltage READ batteryVoltage NOTIFY batteryVoltageChanged)
    Q_PROPERTY(double batteryCurrent READ batteryCurrent NOTIFY batteryCurrentChanged)
    Q_PROPERTY(QString robotStatus READ robotStatus NOTIFY robotStatusChanged)
    Q_PROPERTY(QString robotDetail READ robotDetail NOTIFY robotDetailChanged)
    Q_PROPERTY(QString robotError READ robotError NOTIFY robotErrorChanged)
    Q_PROPERTY(QString getControl READ getControl NOTIFY getControlChanged)
    Q_PROPERTY(QString robotMode READ robotMode NOTIFY robotModeChanged)
    Q_PROPERTY(double getLinear READ getLinear NOTIFY velChanged)
    Q_PROPERTY(double getAngular READ getAngular NOTIFY velChanged)
    Q_PROPERTY(QString systemStatus READ systemStatus NOTIFY systemStatusChanged)
    Q_PROPERTY(QString updateStatus READ updateStatus NOTIFY updateStatusChanged)
    // Q_PROPERTY(NOTIFY colorChanged)
private:
    ros::NodeHandle nh;
    QQmlApplicationEngine *engine = nullptr;
    QObject *rootObject;
    ros::Subscriber battery_percent_sub;
    ros::Subscriber battery_voltage_sub;
    ros::Subscriber battery_current_sub;
    ros::Subscriber robot_mode_sub;
    ros::Subscriber robot_status_sub;
    ros::Subscriber standard_io_sub;
    ros::Subscriber fastech_input_sub;
    ros::Subscriber fastech_output_sub;
    ros::Subscriber velocity_sub;
    // ros::Subscriber run_pause_sub;
    ros::Subscriber pallet_status_sub;
    ros::Subscriber system_status_sub;

    
    ros::Publisher robot_mode_pub;
    ros::Publisher request_run_stop_pub;
    ros::Publisher request_working_stt_pub;
    ros::Publisher reset_error_pub;
    ros::Publisher robot_control_pub;
    ros::Publisher robot_stop_pub;

    ros::ServiceServer pop_last_pallet;
    bool servicePopPalletCallback(std_stamped_msgs::StringService::Request& req, std_stamped_msgs::StringService::Response& res );

    ros::ServiceServer append_head_pallet;
    bool serviceAppendPalletCallback(std_stamped_msgs::StringService::Request& req, std_stamped_msgs::StringService::Response& res );
    
    ros::ServiceClient reset_error_agf;
    ros::ServiceClient stop_error_agf;
    ros::ServiceServer get_last_pallet;
    bool serviceLookupPalletCallback(std_stamped_msgs::StringService::Request& req, std_stamped_msgs::StringService::Response& res);


    // QString formatJsonString(const QString& rawJson);
    // json toJson(const char* jsonString);
    std::vector<std::string> splitString(std::string str, char delimiter);

    void batteryPercentCallback(const std_stamped_msgs::Float32Stamped &msg);
    void batteryVoltageCallback(const std_stamped_msgs::Float32Stamped &msg);
    void batteryCurrentCallback(const std_stamped_msgs::Float32Stamped &msg);
    void robotModeCallback(const std_stamped_msgs::StringStamped::ConstPtr &msg);
    void palletStatusCallback(const std_msgs::Empty &msg);
    void robotStatusCallback(const std_stamped_msgs::StringStamped::ConstPtr &msg);
    void fastechInputCallBack(const std_msgs::Int16MultiArray::ConstPtr &msg);
    void fastechOutputCallBack(const std_msgs::Int16MultiArray::ConstPtr &msg);
    void cmdVelCallBack(const geometry_msgs::Twist &msg);
    void systemStatusCallback(const std_stamped_msgs::StringStamped::ConstPtr &msg);
    // void standardIoCallback(const std_stamped_msgs::StringStamped &msg);


    double batteryVoltageStr;
    double batteryPercentageStr;
    double batteryCurrentStr;
    QString robotModeStr;
    QString qRosHostname;
    QString robotStatusStr;
    QString robotDetailStr;
    QString robotErrorStr;
    QString getControlStr;
    QString agv_name;
    QString server_address;
    QColor randomColor;
    QString statusValueSystemStr;
    QString stateValueSystemStr;
    mongocxx::uri uri;
    mongocxx::client client;
    mongocxx::database db;
    mongocxx::collection collection;
    mongocxx::collection collection_queue;
    mongocxx::collection collection_model;
    

    std::vector<int> fastechData;
    std::vector<int> fastechDataOutput;
    QString updateStatusStr;
    std::string statusValue;
    std::string robot_mode;
    std::string detailValue;
    std::string errorValue;
    std::string stateValueSystem;
    std::string statusValueSystem;
    std::string _queue;
    std::string zone_;
    bool bug_manual_mode;
    int index;
    int max_index;

    QStringList* models = new QStringList();
    QStringList* counts = new QStringList();

    double start_time = ros::Time::now().toSec();
    double vel_linear;
    double vel_angular;
    json deleteObjQueue(int queue);
    void arrangeQueue();
    void colorPalletQueue(mongocxx::collection coll,std::string prefix,std::string id_,std::string suffix);
    void colorPallet(mongocxx::collection coll,std::string prefix,std::string id_,std::string suffix);
    void delayFunction(int milliseconds) {
        std::this_thread::sleep_for(std::chrono::milliseconds(milliseconds));
    }
    void switchColorBuffer(mongocxx::collection coll,std::string old_id);
    void switchColorQueue(mongocxx::collection coll,std::string old_id, std::string update_id);
    json lookupPalletModel(std::string model, std::string count);

    std::string exec(const char* cmd) {
        std::array<char, 128> buffer;
        std::string result;
        std::shared_ptr<FILE> pipe(popen(cmd, "r"), pclose);
        if (!pipe) throw std::runtime_error("popen() failed!");
        while (!feof(pipe.get())) {
            if (fgets(buffer.data(), 128, pipe.get()) != nullptr)
                result += buffer.data();
        }
        return result;
    }

    int getVolumePercentage(const std::string& mixerOutput) {
        std::istringstream ss(mixerOutput);
        std::string line;
        while (std::getline(ss, line)) {
            size_t pos = line.find("[");
            if (pos != std::string::npos && line.find("%]") != std::string::npos) {
                std::string percentage = line.substr(pos + 1, line.find("%") - pos - 1);
                // ROS_INFO_STREAM(std::stoi(percentage));
                return std::stoi(percentage);
            }
        }
        return -1; // return -1 if not found
    }
    // std::string getStringWithPrecision(float value, int precision) ;
    float stringToFloat(const std::string& str) {
        std::stringstream ss(str);
        float result;
        ss >> result;
        return result;
    }
    double stringToDouble(const std::string& str) {
        std::stringstream ss(str);
        double result;
        ss >> result;
        return result;
    }

    int check_line( std::vector<std::string> &current_line , std::vector<std::string> &pre_line, std::vector<std::string> &next_line) ;
    

public:
    explicit Backend(QObject *parent = nullptr);
    QTranslator m_translator;
    void setEngine(QQmlApplicationEngine *eng) { 
        engine = eng;
        arrangeQueue();
        while ( engine->rootObjects().isEmpty()) {};
        rootObject = engine->rootObjects().first();
        colorPallet(collection,"zone_","zone_id","");
        colorPalletQueue(collection_queue,"zone_","queue","_queue");        
    }

    // SUBCRIBER
    double batteryPercentage() const;
    double batteryVoltage() const;
    double batteryCurrent() const;
    QString robotMode() const;
    QString robotStatus() const;
    QString robotDetail() const;
    QString robotError() const;
    QString getControl() const;
    QString systemStatus() const;
    QString updateStatus() const;
    double getLinear() const;
    double getAngular() const;
    
    
    // int getFastechRear(int index) const;




    // PUBLISHER
    Q_INVOKABLE  int getFastechRear(int index);
    Q_INVOKABLE  int getFastechFront(int index);
    Q_INVOKABLE void resetError() ;
    Q_INVOKABLE void requestMode(const QString &str) ;
    Q_INVOKABLE void requestControl(const QString &str) ;
    Q_INVOKABLE  int setVolume(int percent) ;
    Q_INVOKABLE  int getVolume() ;
    Q_INVOKABLE  void shutdown(int state);
    Q_INVOKABLE void getVolume_on_off(int i);

    Q_INVOKABLE void requestStop(const QString &str) ;
    Q_INVOKABLE void requestReset(const QString &str) ;

    Q_INVOKABLE  void change_to_japan() ;
    Q_INVOKABLE  void change_to_eng() ;
    Q_INVOKABLE  QString getNameAGV() ;
    Q_INVOKABLE  QString getIP() ;
    Q_INVOKABLE  QString getIPServer() ;
    Q_INVOKABLE void initColor() ;
    Q_INVOKABLE void setDataBuffer(QString id) ;
    Q_INVOKABLE void setDataQueue(int id) ;
    Q_INVOKABLE void saveDataBuffer(QString jsonstring) ;
    Q_INVOKABLE void saveDataQueue(QString jsonstring) ;
    Q_INVOKABLE void saveDataModel(QString jsonstring) ;
    Q_INVOKABLE void deleteDataBuffer(QString jsonstring) ;
    Q_INVOKABLE void deleteDataQueue(QString jsonstring) ;
    Q_INVOKABLE void deleteDataModel(QString jsonstring) ;

    Q_INVOKABLE void addDataBuffer(QString jsonstring) ;
    Q_INVOKABLE void addDataQueue(QString jsonstring) ;
    Q_INVOKABLE void addDataModel(QString jsonstring) ;

    Q_INVOKABLE QString getStateSystem() ;
    Q_INVOKABLE void getDataComboBox() ;
    Q_INVOKABLE void getDataComboBox2() ;
    Q_INVOKABLE void updateComboBox(QString model, QString count) ;
    Q_INVOKABLE QStringList getListModel() {
        return *models;
    }
    Q_INVOKABLE QStringList getListCount() {
        return *counts;
    }
    Q_INVOKABLE void set_color() {
        initColor();
    }

    Q_INVOKABLE QString openFileDialog() ;

    


signals:
    void batteryPercentageChanged();
    void batteryVoltageChanged();
    void batteryCurrentChanged();
    void robotModeChanged();
    void robotStatusChanged();
    void robotDetailChanged();
    void robotErrorChanged();
    void getNameChanged();
    void getIPChanged();
    void getControlChanged();
    void getFastechInputChanged();
    void getFastechOutputChanged();
    void velChanged();
    void volumePercentageChanged();
    void systemStatusChanged();
    void updateStatusChanged();
};

#endif // BACKEND_H

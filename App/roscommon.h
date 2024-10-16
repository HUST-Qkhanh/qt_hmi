#ifndef ROSCOMMON_H
#define ROSCOMMON_H

// #include <QObject>
#ifndef Q_MOC_RUN
#include <ros/ros.h>
#include <std_msgs/Bool.h>
#include <std_msgs/String.h>
#include <std_msgs/Int16.h>
#include <std_msgs/Int64.h>
#include <std_msgs/Float64.h>
#include <sensor_msgs/NavSatFix.h>
#endif
#include <string>
#include <QThread>
#include <QStringListModel>

class RosCommon : public QObject
{
    Q_OBJECT
public:
    explicit RosCommon(QObject *parent = nullptr);

signals:
};

#endif // ROSCOMMON_H

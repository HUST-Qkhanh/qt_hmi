#ifndef __CONFIG_MANAGER_H__
#define __CONFIG_MANAGER_H__

#include <QObject>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QVariantMap>
#include <QQmlApplicationEngine>
#include <QQmlContext>

class ConfigManager : public QObject {
    Q_OBJECT
public:
    explicit ConfigManager(QObject *parent = nullptr); // Constructor declaration
    ~ConfigManager(); // Destructor declaration

    Q_INVOKABLE void saveConfig(const QVariantMap &configData, const QString &configPath); // Method declaration
    Q_INVOKABLE QVariantMap loadConfig(const QString &configPath); // Method declaration
};

#endif // __CONFIG_MANAGER_H__

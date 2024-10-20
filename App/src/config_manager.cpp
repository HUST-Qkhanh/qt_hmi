#include "config_manager.h"
#include <QDebug>

// Constructor implementation
ConfigManager::ConfigManager(QObject *parent) : QObject(parent) {
    // Optionally, you can initialize other members here if needed
}

// Destructor implementation
ConfigManager::~ConfigManager() {
    // Any necessary cleanup can go here
}

// saveConfig method implementation
void ConfigManager::saveConfig(const QVariantMap &configData, const QString &configPath) {
    QJsonObject jsonObject = QJsonObject::fromVariantMap(configData);
    QJsonDocument jsonDoc(jsonObject);

    QFile configFile(configPath);
    if (configFile.open(QIODevice::WriteOnly)) {
        configFile.write(jsonDoc.toJson());
        configFile.close();
        qWarning() << "save success:" << configPath;
    }
}

// loadConfig method implementation
QVariantMap ConfigManager::loadConfig(const QString &configPath) {
    QFile configFile(configPath);
    if (!configFile.open(QIODevice::ReadOnly)) {
        qWarning() << "Could not open config file:" << configPath;
        return QVariantMap();
    }

    QByteArray fileData = configFile.readAll();
    QJsonDocument jsonDoc = QJsonDocument::fromJson(fileData);
    return jsonDoc.object().toVariantMap();
}

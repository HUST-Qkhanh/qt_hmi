#include <QtQml/qqmlprivate.h>
#include <QtCore/qdir.h>
#include <QtCore/qurl.h>
#include <QtCore/qhash.h>
#include <QtCore/qstring.h>

namespace QmlCacheGeneratedCode {
namespace _qt_qml_RosQML2Content_Screen02_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_RosQML2Content_Screen03_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_RosQML2Content_KeyboardStyle_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_RosQML2Content_App_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_RosQML2Content_component_test_2_ui_0x2e_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_RosQML2Content_component_test_ui_0x2e_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_RosQML2Content_Screen01_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_RosQML2Content_Mission_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}

}
namespace {
struct Registry {
    Registry();
    ~Registry();
    QHash<QString, const QQmlPrivate::CachedQmlUnit*> resourcePathToCachedUnit;
    static const QQmlPrivate::CachedQmlUnit *lookupCachedUnit(const QUrl &url);
};

Q_GLOBAL_STATIC(Registry, unitRegistry)


Registry::Registry() {
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/RosQML2Content/Screen02.qml"), &QmlCacheGeneratedCode::_qt_qml_RosQML2Content_Screen02_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/RosQML2Content/Screen03.qml"), &QmlCacheGeneratedCode::_qt_qml_RosQML2Content_Screen03_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/RosQML2Content/KeyboardStyle.qml"), &QmlCacheGeneratedCode::_qt_qml_RosQML2Content_KeyboardStyle_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/RosQML2Content/App.qml"), &QmlCacheGeneratedCode::_qt_qml_RosQML2Content_App_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/RosQML2Content/component_test_2.ui.qml"), &QmlCacheGeneratedCode::_qt_qml_RosQML2Content_component_test_2_ui_0x2e_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/RosQML2Content/component_test.ui.qml"), &QmlCacheGeneratedCode::_qt_qml_RosQML2Content_component_test_ui_0x2e_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/RosQML2Content/Screen01.qml"), &QmlCacheGeneratedCode::_qt_qml_RosQML2Content_Screen01_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/RosQML2Content/Mission.qml"), &QmlCacheGeneratedCode::_qt_qml_RosQML2Content_Mission_qml::unit);
    QQmlPrivate::RegisterQmlUnitCacheHook registration;
    registration.structVersion = 0;
    registration.lookupCachedQmlUnit = &lookupCachedUnit;
    QQmlPrivate::qmlregister(QQmlPrivate::QmlUnitCacheHookRegistration, &registration);
}

Registry::~Registry() {
    QQmlPrivate::qmlunregister(QQmlPrivate::QmlUnitCacheHookRegistration, quintptr(&lookupCachedUnit));
}

const QQmlPrivate::CachedQmlUnit *Registry::lookupCachedUnit(const QUrl &url) {
    if (url.scheme() != QLatin1String("qrc"))
        return nullptr;
    QString resourcePath = QDir::cleanPath(url.path());
    if (resourcePath.isEmpty())
        return nullptr;
    if (!resourcePath.startsWith(QLatin1Char('/')))
        resourcePath.prepend(QLatin1Char('/'));
    return unitRegistry()->resourcePathToCachedUnit.value(resourcePath, nullptr);
}
}
int QT_MANGLE_NAMESPACE(qInitResources_qmlcache_RosQML2Content)() {
    ::unitRegistry();
    return 1;
}
Q_CONSTRUCTOR_FUNCTION(QT_MANGLE_NAMESPACE(qInitResources_qmlcache_RosQML2Content))
int QT_MANGLE_NAMESPACE(qCleanupResources_qmlcache_RosQML2Content)() {
    return 1;
}

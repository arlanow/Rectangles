#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include "googleplayserviesapi.h"
#include <QIcon>
//#include <QtAndroidExtras>
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setOrganizationName("Aleksandr Arlanov");
    app.setOrganizationDomain("arlanov.com");
    app.setApplicationName("rectangles");
    app.setWindowIcon(QIcon("qrc:/icons/icon.ico"));
    //auto gps = new GooglePlayServiesApi();
    QQmlApplicationEngine engine;
    QQuickStyle::setStyle("Material");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}

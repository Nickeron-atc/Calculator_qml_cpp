#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFontDatabase>
#include <QDir>

#include <exception>

#include "backend.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    qmlRegisterType<Backend>("backend", 1, 0,"Backend");

    const QUrl url("qrc:/path/main.qml");
    engine.load(url);
    return app.exec();
}

#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

#include "weeklymenu.h"
#include "weeklymenumodel.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    qmlRegisterType<WeeklyMenu>("WeeklyMenu", 1, 0, "WeeklyMenu");
    qmlRegisterType<WeeklyMenuModel>("WeeklyMenuModel", 1, 0, "WeeklyMenuModel");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}

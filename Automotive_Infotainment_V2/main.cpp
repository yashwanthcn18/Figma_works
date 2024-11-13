#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "screensaver.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/Main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     }, Qt::QueuedConnection);
    engine.load(url);

    // Store root objects in a variable to avoid detaching
    const auto rootObjects = engine.rootObjects();
    QQuickWindow* window = qobject_cast<QQuickWindow*>(rootObjects.first());
    if (window) {
        ScreenSaverController* screenSaverController = new ScreenSaverController(window);
        app.installEventFilter(screenSaverController);  // Install the event filter to monitor user activity
    }

    return app.exec();
}

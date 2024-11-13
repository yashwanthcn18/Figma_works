#ifndef SCREENSAVER_H
#define SCREENSAVER_H

#include <QObject>
#include <QQuickWindow>
#include <QEvent>

class ScreenSaverController : public QObject {
    Q_OBJECT
public:
    ScreenSaverController(QQuickWindow* window = nullptr);

protected:
    bool eventFilter(QObject* obj, QEvent* event)  {
        if (event->type() == QEvent::MouseButtonPress || event->type() == QEvent::KeyPress) {
            // Call the resetTimer function in QML whenever user interaction is detected
            QMetaObject::invokeMethod(mainWindow, "resetTimer");
        }
        return QObject::eventFilter(obj, event);
    }

private:
    QQuickWindow* mainWindow;
};

#endif // SCREENSAVER_H

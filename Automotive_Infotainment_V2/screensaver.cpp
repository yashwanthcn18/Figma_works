#include "screensaver.h"

ScreenSaverController::ScreenSaverController(QQuickWindow* window)
    : QObject(window), mainWindow(window) {}


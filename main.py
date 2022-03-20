# IMPORTED LIBRARIES
import sys
from os.path import join, dirname
from PySide2.QtQuickControls2 import QQuickStyle
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from src import res_rc
from src.backend import Backend

"""
# 0.0623564
# 0.0466098
# 0.0119737
"""

# SET STYLE
QQuickStyle.setStyle('Material')


# MAIN FUNCTION
def main():
    app = QGuiApplication(sys.argv)
    app.setOrganizationName('Al-Taie')
    app.setOrganizationDomain('instagram.com/9_tay')
    app.setApplicationName('Password Generator')
    backend = Backend()

    engine = QQmlApplicationEngine()
    engine.rootContext().setContextProperty("backend", backend)
    path = dirname(__file__)

    # Load splash screen
    engine.load(join(path, 'qml/splash.qml'))

    if not engine.rootObjects():
        sys.exit(-1)
    app.exec_()

    # Load Main Window
    engine.load(join(path, 'qml/main.qml'))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())


if __name__ == "__main__":
    main()

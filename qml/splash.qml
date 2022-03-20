import QtQuick 2.15
import QtQuick.Controls.Material 2.12
import QtQuick.Controls 2.15

ApplicationWindow {
    id: splash
    width: 540
    height: 360
    visible: true
    flags: Qt.SplashScreen

    property int timeoutInterval: 3500

    // SPLASH IMAGE
    Image {
        anchors.fill: parent
        source: "qrc:/password"
        fillMode: Image.PreserveAspectFit

        AnimatedImage {
            id: lock
            opacity: 1
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            source: "qrc:/lock"
            speed: 0.8
            anchors.bottomMargin: 183
            anchors.rightMargin: 285
            anchors.topMargin: 21
            anchors.leftMargin: 100
            playing: true
            paused: false
            fillMode: Image.PreserveAspectFit

        }

    }
    Text {
        color: "#3f3d56"
        text: '© Al-Taie 2021'
        font.bold: true
        font.pointSize: 7
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
    }

    ProgressBar {
        id: progressBar
        y: 300
        anchors.horizontalCenter: parent.horizontalCenter
        value: 0
        Material.accent: '#00BCD4'
    }
    // END IMAGE

    // TIMER
    Timer {
        id: timer
        interval: 155
        running: true
        repeat: true
        onTriggered: {

            if (progressBar.value === 1) {
                timer.stop()
                splash.close()
            } else if (progressBar.value >= 0.90) {
                lock.playing = false
                progressBar.value += 0.09
            } else {
                progressBar.value += 0.09
            }
        }
    }

    // END TIMER
}



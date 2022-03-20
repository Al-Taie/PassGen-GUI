import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12


Rectangle {
    id: control
    width: 300
    height: 180
    color: "#00000000"

    property bool hideBoy: true
    property alias image: img.source
    property alias sleep: sleepTimer.running
    property alias autoType: autoType.running
    property alias fsize: lblText.font.pointSize
    property alias message: lblText.text
    property alias msgColor: lblText.color
    property alias lblColor: label.color
    property alias lblOpacity: label.opacity
    property var model: []

    Image {
        id: img
        visible: hideBoy
        height: 150
        width: 120
        opacity: 1
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        source: "../../res/images/hi.png"
        anchors.leftMargin: 0
        anchors.bottomMargin: 5
        fillMode: Image.PreserveAspectFit
        Material.elevation: 3
    }

    Rectangle {
        id: label
        visible: hideBoy
        width: 140
        height: 50
        anchors.left: img.right
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.leftMargin: 0
        radius: control.width / 2
        Behavior on width { NumberAnimation { duration: 150 } }

        Text {
            id: lblText
            font.bold: true
            visible: hideBoy
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Timer {
        id: sleepTimer
        interval: 555
        running: false
        repeat: false
        onTriggered: {
            if (autoType.m===model.length) {
                message = 'Move Mouse to Highlight'
                label.width = 200
                hideBoy = false
            } else
                message = ''
        }
    }

    Timer {
        id: autoType
        interval: 135
        running: !(sleep)
        repeat: true
        property int m: 0
        property int i: 0
        onTriggered: if (m === model.length) {
                         running = false
                         m = 0
                     } else if ((model[m]).length === i) {
                         i = 0
                         m++
                         sleepTimer.start()
                     } else {
                         message += model[m][i]
                         i++
                     }
    }

    function restart() {
        autoType.i = 0
        autoType.m = 0
        autoType.running = false
        sleepTimer.stop()
        message = ''
    }
}

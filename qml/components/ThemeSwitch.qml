import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12


Switch {
    id: control
    property alias tooltipX: toolTip.x
    property alias tooltipY: toolTip.y
    property alias tooltipText: toolTip.text
    property alias tooltipDelay: toolTip.delay
    property alias cursorShape: mouseArea.cursorShape

    checked: false
    checkable: true

    cursorShape: Qt.PointingHandCursor
    tooltipDelay: 150
    tooltipText: control.checked? qsTr('Light') : qsTr('Drak')

    indicator: Rectangle {
        implicitWidth: 30
        implicitHeight: 30
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        z: 0
        radius: control.width / 2
        color: control.checked? '#303030' : '#fff'
        Behavior on color { ColorAnimation { easing.type: Easing.InOutQuad } }

        Text {
            z: 1
            anchors.fill: parent
            text: control.checked ? '\ueee0' : '\ueee1'
            font.family: fontello.name
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12
            color: control.checked? '#fff' : '#000000'
            Behavior on color { ColorAnimation { easing.type: Easing.InOutQuad } }
        }

        ToolTip {
            id: toolTip
            x: 50
            y: 5
            parent: control
            visible: control.hovered
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
//            propagateComposedEvents: true
//            onClicked: mouse.accepted = false
            onPressed: mouse.accepted = false
//            onReleased: mouse.accepted = false
//            onDoubleClicked: mouse.accepted = false
//            onPositionChanged: mouse.accepted = false
//            onPressAndHold: mouse.accepted = false
        }
    }

}

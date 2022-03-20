import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12


RoundButton {
    id: control
    implicitHeight: 45
    implicitWidth: implicitHeight
    text: '+'
    font.pointSize: 13
    Material.elevation: 0
    font.family: fontello.name

    property alias isTooltip: toolTip.visible
    property alias tooltipX: toolTip.x
    property alias tooltipY: toolTip.y
    property alias tooltipText: toolTip.text
    property alias tooltipDelay: toolTip.delay
    property alias tooltipVisible: toolTip.visible
    property alias cursorShape: mouseArea.cursorShape
    property alias containsMouse: mouseArea.containsMouse
    cursorShape: Qt.PointingHandCursor

    ToolTip {
        id: toolTip
        parent: control
        visible: control.hovered
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        propagateComposedEvents: true
        onClicked: mouse.accepted = false
        onPressed: mouse.accepted = false
        onReleased: mouse.accepted = false
        onDoubleClicked: mouse.accepted = false
        onPositionChanged: mouse.accepted = false
        onPressAndHold: mouse.accepted = false
    }

}

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12


ToolButton {
    id: control
    icon.source: ''

    property alias isTooltip: toolTip.visible
    property alias tooltipX: toolTip.x
    property alias tooltipY: toolTip.y
    property alias radius: rect.radius
    property alias color: rect.color
    property alias tooltipText: toolTip.text
    property alias tooltipDelay: toolTip.delay
    property alias cursorShape: mouseArea.cursorShape

    cursorShape: Qt.PointingHandCursor
    tooltipText: qsTr('Button')
    tooltipDelay: 150
    color: "#00000000"

    indicator: Rectangle {
        id: rect
        anchors.fill: parent
        radius: control.width/2
    }

    ToolTip {
        id: toolTip
        x: 45
        y: 5
        parent: control
        visible: control.hovered
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onPressed: mouse.accepted = false
    }
}

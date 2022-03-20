import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.11

RowLayout {
    id: controlersLayout
    height: 50
    spacing: 3

    property alias isTooltip: toolTip.visible
    property alias tooltipX: toolTip.x
    property alias tooltipY: toolTip.y
    property alias tooltipText: toolTip.text
    property alias tooltipDelay: toolTip.delay
    property alias captionWidth: caption.width
    property alias stepSize: control.stepSize
    property alias to: control.to
    property alias from: control.from
    property alias value: control.value

    CustomRoundButton {
        id: btnMinus
        text: '\ueef9'
        font.pointSize: 11
        enabled: false
        tooltipVisible: false
        onPressed: control.value -= 1
        onPressAndHold: {
            numberAnimation.easing.type = Easing.OutQuad
            numberAnimation.to = from
            numberAnimation.start()
        }
    }

    Slider {
        id: control
        property color colorDefault: '#ff007f'
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        onValueChanged: {
                        if (value === from || from === 0) {
                            btnMinus.enabled = false
                            btnPlus.enabled = true
                        } else if (value===to) {
                            btnPlus.enabled = false
                            btnMinus.enabled = true
                         } else if (value > from && value < to) {
                            btnMinus.enabled = true
                            btnPlus.enabled = true
                         }
        }

        CustomRoundButton{
            id: caption
            height: width
            width: 47
            text: value
            anchors.verticalCenter: parent.verticalCenter
            clip: true
            anchors.horizontalCenter: parent.horizontalCenter
            highlighted: true
            font.bold: true
            font.pointSize: 7.5
            tooltipVisible: false
        }
    }

    CustomRoundButton {
        id: btnPlus
        text: '\ueef8'
        font.pointSize: 11
        tooltipVisible: false
        onPressed: control.value += 1
        onPressAndHold: {
            numberAnimation.to = to
            numberAnimation.easing.type = Easing.InOutQuad
            numberAnimation.start()
        }
    }

    NumberAnimation {
        id: numberAnimation
        target: control
        property: "value"
        easing.type: Easing.InQuad
        duration: 500
        from: value
        to: control.to
    }

    ToolTip {
        id: toolTip
        x: 45
        y: 5
        parent: control
        visible: control.hovered
    }
}


/*##^##
Designer {
    D{i:0;height:40;width:286}
}
##^##*/

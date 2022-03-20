import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.11
import "components"
import QtQuick.Timeline 1.0
import QtQuick.Window 2.15
import Qt.labs.settings 1.0


ApplicationWindow {
    id: root
    width: 920
    height: 640
    visible: true

    // REMOVE TITLE BAR
    flags: (Qt.FramelessWindowHint | Qt.Window)
    
    // GLOBAL VARIABLES
    property bool firstStart: true
    property string lnkInsta: 'https://www.instagram.com/9_tay'
    property string themeColor: Material.color(Material.Cyan)
    property int themeMode: Material.Light

    Material.theme: themeMode
    Material.accent: themeColor
    Material.primary: themeColor
    Behavior on color { ParallelAnimation { ColorAnimation { easing.type: Easing.InOutQuad } }}
    Behavior on x { NumberAnimation { duration: 70; easing.type: Easing.InOutQuad } }
    Behavior on y { NumberAnimation {  duration: 70; easing.type: Easing.InOutQuad} }

    Image {
        id: logoImage
        height: 280
        opacity: 1
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: listView.right
        anchors.right: parent.right
        source: "../res/images/password.svg"
        anchors.verticalCenterOffset: -12
        anchors.leftMargin: 45
        anchors.rightMargin: 45
        fillMode: Image.PreserveAspectFit
        Material.elevation: 3

        property alias toolTip: btnGen.isTooltip

        CustomToolButton {
            id: btnGen
            width: 52
            tooltipText: "Generate"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 106
            anchors.rightMargin: 168
            anchors.leftMargin: 67
            anchors.bottomMargin: 120
            tooltipX: 60
            onClicked: {
                backend.is_running = true
            }
        }
    }

    CustomSlider {
        id: sliderLength
        opacity: 1
        anchors.left: listView.right
        anchors.right: parent.right
        anchors.top: logoImage.bottom
        anchors.leftMargin: 40
        anchors.topMargin: -10
        anchors.rightMargin: 35
        stepSize: 1
        to: 64
        from: 8
        value: 8
        tooltipX: 30
        tooltipY: -45
        tooltipText: qsTr('Password Length')
        onValueChanged: backend.length = value
    }

    CustomSlider {
        id: sliderQuantity
        opacity: 1
        captionWidth: 51
        anchors.left: listView.right
        anchors.right: parent.right
        anchors.top: sliderLength.bottom
        anchors.leftMargin: 40
        anchors.topMargin: 10
        anchors.rightMargin: 35
        stepSize: 1
        to: 999
        from: 1
        value: 1
        tooltipX: 27
        tooltipY: 55
        tooltipText: qsTr('Passwords Quantity')
        onValueChanged: backend.quantity = value
    }

    RowLayout {
        id: controlersLayout
        height: 50
        opacity: 1
        anchors.left: listView.right
        anchors.right: parent.right
        anchors.top: parent.top
        spacing: 0
        anchors.topMargin: 15
        anchors.leftMargin: 50
        anchors.rightMargin: 25

        property alias toolTip: toolTip.visible

        ToolTip {
            id: toolTip
            x: 100
            y: 55
            text: qsTr('Control panel')
            parent: controlersLayout
            visible: false
        }

        CheckBox {
            id: chkUpper
            text: qsTr("ABC")
            checked: true
            onCheckedChanged: backend.is_uppercase = checked
        }

        CheckBox {
            id: chkLower
            text: qsTr("abc")
            checked: true
            onCheckedChanged: backend.is_lowercase = checked
        }

        CheckBox {
            id: chkDigit
            text: qsTr("123")
            checked: true
            onCheckedChanged: backend.is_digit = checked
        }

        CheckBox {
            id: chkSymbol
            text: qsTr("!$&")
            onCheckedChanged: backend.is_symbol = checked
        }
    }

    WarningMsg {
        id: warning
        x: root.width + 50
        y: 90

        PropertyAnimation {
            id: propertyAnimation
            target: warning
            duration: 1200
            properties: "x"
            easing.type: Easing.InOutElastic

            property int pos: root.width - 285
            to: (warning.x === pos) ? (root.width + 50) : pos
            onFinished: if (warning.x === pos)
                            colorAnimation.start()
                        else
                            warning.color = themeColor
        }

        ColorAnimation {
            id: colorAnimation
            target: warning
            property: "color"
            duration: 400
            easing.type: Easing.InOutBack
            onFinished: timer.start()
        }

        Timer {
            id: timer
            interval: 2100
            repeat: false
            running: false
            onTriggered: propertyAnimation.start()
        }

    }

    CustomListView {
        id: listView
        width: 550
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.topMargin: 10
        model: listModel
        tooltipText: qsTr('Listview of passwords')

        //        footerPositioning: ListView.OverlayFooter // comment out this line to make the button responsive
        //        footer:

    }

    FontLoader {
        id: fontello
        source: 'qrc:/fontello'
    }

    ListModel {
        id: listModel
    }

    Timeline {
        id: timeline
        animations: [
            TimelineAnimation {
                id: timelineAnimation
                easing.bezierCurve: [0.218,0.00696,0.226,1.01,1,1]
                duration: 2150
                running: true
                loops: 1
                to: 2150
                from: 0
                onFinished: {
                    root.x = Screen.width / 2 - root.width / 2
                    root.y = Screen.height / 2 - root.height / 2
                }
            }
        ]
        enabled: true
        startFrame: 0
        endFrame: 2150


        KeyframeGroup {
            target: controlersLayout
            property: "opacity"
            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 500
                value: 1
            }
        }

        KeyframeGroup {
            target: logoImage
            property: "opacity"
            Keyframe {
                frame: 400
                value: 0
            }

            Keyframe {
                frame: 900
                value: 1
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        KeyframeGroup {
            target: sliderLength
            property: "opacity"
            Keyframe {
                frame: 802
                value: 0
            }

            Keyframe {
                frame: 1300
                value: 1
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        KeyframeGroup {
            target: sliderQuantity
            property: "opacity"
            Keyframe {
                frame: 1199
                value: 0
            }

            Keyframe {
                frame: 1700
                value: 1
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        KeyframeGroup {
            target: root
            property: "width"
            Keyframe {
                frame: 0
                value: 380
            }

            Keyframe {
                frame: 1493
                value: 380
            }

            Keyframe {
                frame: 2145
                value: 920
            }
        }

        KeyframeGroup {
            target: listView
            property: "width"
            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 1495
                value: 0
            }

            Keyframe {
                frame: 2148
                value: 540
            }
        }

    }

    Connections {
        target: backend

        function onResult(result) {
            listModel.clear()

            for (var i in result) {
                if (i>=5000)
                    break
                listModel.append({name: result[i]})
            }

            listView.positionViewAtBeginning()
        }

        function onError(error) {
            warning.message = qsTr("Select one box at least") + '!'
            colorAnimation.to = Material.color(Material.Red)
            propertyAnimation.start()
        }
    }

    Settings {
        id: settengs
        property alias themeMode: root.themeMode
        property alias firstStart: root.firstStart
        property alias lengthValue: sliderLength.value
        property alias quantityValue: sliderQuantity.value
        property alias upperChecked: chkUpper.checked
        property alias lowerChecked: chkLower.checked
        property alias digitChecked: chkDigit.checked
        property alias symbolChecked: chkSymbol.checked
    }

    property alias isTour: tour.visible
    property alias hideBoy: tour.hideBoy

    Tour {
        id: tour
        anchors.fill: parent
        visible: false
        onVisibleChanged: {
            autoType.restart()
            head.isTour = isTour
        }
    }

    header: CustomHeader { id: head }
    footer: CustomFooter { id: foot }
}

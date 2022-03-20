import QtQuick 2.15
import QtQuick.Controls.Material 2.12
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Item {
    id: item
    property alias autoType: notify
    property alias hideBoy: notify.hideBoy

    MouseArea {
        id: mouseArea
        property int count: 0
        anchors.fill: parent
        onClicked:
            switch (count) { 
                case 0:
                    notify.hideBoy = false
                    mask.maskH = controlersLayout.height
                    mask.maskW = controlersLayout.width
                    mask.maskX = controlersLayout.x
                    mask.maskY = controlersLayout.y
                    var cursorX = root.x + mask.maskX + mask.maskW/2 - 190
                    var cursorY = root.y + mask.maskY + 70 + 20
                    backend.move_cursor(cursorX, cursorY)
                    controlersLayout.toolTip = true
                    count++; break
                case 1:
                    mask.maskH = sliderLength.height
                    mask.maskW = sliderLength.width
                    mask.maskX = sliderLength.x
                    mask.maskY = sliderLength.y
                    cursorX = root.x + mask.maskX + mask.maskW/2 - 190
                    cursorY = root.y + mask.maskY + 70 + 20
                    backend.move_cursor(cursorX, cursorY)
                    sliderLength.isTooltip = true
                    count++; break
                case 2:
                    mask.maskH = sliderQuantity.height
                    mask.maskW = sliderQuantity.width
                    mask.maskX = sliderQuantity.x
                    mask.maskY = sliderQuantity.y
                    cursorX = root.x + mask.maskX + mask.maskW/2 - 190
                    cursorY = root.y + mask.maskY + 70 + 10
                    backend.move_cursor(cursorX, cursorY)
                    sliderQuantity.isTooltip = true
                    count++; break
                case 3:
                    mask.maskH = 50
                    mask.maskW = 50
                    mask.maskX = logoImage.x + 69
                    mask.maskY = logoImage.y + 109
                    cursorX = root.x + mask.maskX + mask.maskH/2 - 55
                    cursorY = root.y + mask.maskY + 70 + 20
                    backend.move_cursor(cursorX, cursorY)
                    logoImage.toolTip = true
                    backend.is_running = true
                    count++; break
                case 4:
                    mask.maskH = listView.height
                    mask.maskW = listView.width
                    mask.maskX = listView.x
                    mask.maskY = listView.y
                    cursorX = root.x + mask.maskX + mask.maskW/2 - 55
                    cursorY = root.y + mask.maskY + 70 + 20
                    backend.move_cursor(cursorX, cursorY)
                    listView.tooltipX = cursorX + 10
                    listView.tooltipY = cursorY - 10
//                    listView.isTooltip = true
                    count++; break
                default:
                    count = 0
                    item.visible = false
                    backend.restore_cursor()
            }
    }

    Mask {
        id: mask
        anchors.fill: parent
        visible: true
    }

    Mask {
        id: mask2
        anchors.fill: parent
        visible: true
        maskW: mask.maskW + 10
        maskH: mask.maskH + 10
        maskX: mask.maskX - 5
        maskY: mask.maskY - 5
        radius: 60
    }

    Mask {
        id: mask3
        radius: 70
        visible: true
        anchors.fill: parent
        maskW: mask.maskW + 20
        maskH: mask.maskH + 20
        maskX: mask.maskX - 10
        maskY: mask.maskY - 10
    }

    Notification {
        id: notify
        visible: true
        fsize: 8.75
        sleep: true
        model: msgs
        lblOpacity: 0.9
        msgColor: "#f6f6f6"
        lblColor: themeColor    
        anchors.verticalCenterOffset: 0
        anchors.horizontalCenterOffset: -130
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    property var msgs: [
        'Hello dear :)',
        "Let's take a tour",
        'Are you ready?'
    ]

}

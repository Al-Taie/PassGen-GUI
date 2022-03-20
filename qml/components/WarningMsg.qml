import QtQuick 2.15


Rectangle {
    id: rectangle
    width: 175
    height: 45
    opacity: 0.85
    color: themeColor
    radius: 25

    property alias message: warningsMessage.text
    message: 'Message'

    Text {
        id: warningsMessage
        color: "white"
        font.bold: true
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}

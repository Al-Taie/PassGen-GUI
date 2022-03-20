import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

TextField {
    id: textField

    // Custom Properties
    property color colorDefault: "#282c34"
    property color colorOnFocus: "#242831"
    property color colorMouseOver: "#2B2F38"

    QtObject{
        id: internal

        property var dynamicColor: if (textField.focus)
                                        textField.focus ? colorOnFocus : colorDefault
                                   else
                                       textField.hovered ? colorMouseOver : colorDefault
        property bool isHover: false
    }

    implicitWidth: 300
    implicitHeight: 40
    placeholderText: qsTr("Type something")
    color: "#ffffff"
    background: Rectangle {
        color: internal.dynamicColor
        radius: parent.width/2
        border.color: "#ff007f"
        border.width: (internal.isHover)? 2.5 : 0
    }

    selectByMouse: true
    selectedTextColor: "#FFFFFF"
    selectionColor: "#ff007f"
    placeholderTextColor: "#81848c"
    onFocusChanged: (mouseArea.visible)? mouseArea.visible = false :
                                         mouseArea.visible = true
    MouseArea {
        id: mouseArea
        visible: true
        hoverEnabled: true
        anchors.fill: parent
        onHoveredChanged: (textField.activeFocus)? null :
                                                   internal.isHover = containsMouse

        onClicked: textField.forceActiveFocus()
        cursorShape: Qt.IBeamCursor
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:40;width:640}
}
##^##*/

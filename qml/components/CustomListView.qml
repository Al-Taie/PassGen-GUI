import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12


ListView {
        id: control
        width: 150
        height: 250
        clip: true
        antialiasing: true

        property alias isTooltip: toolTip.visible
        property alias tooltipX: toolTip.x
        property alias tooltipY: toolTip.y
        property alias tooltipText: toolTip.text
        property alias tooltipDelay: toolTip.delay
        property alias cursorShape: mouseArea.cursorShape
        cursorShape: Qt.ArrowCursor

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: contextMenu.popup()
            acceptedButtons: Qt.RightButton
        }

        Menu {
                id: contextMenu
                width: 130

                MenuItem {
                    text: '\ueee4 ' + qsTr("Copy")
                    enabled: (count !== 0)
                    onClicked: clipboard.setText(control.model.get(control.currentIndex).name)
                }

                MenuItem {
                    text: '\ueee4 ' + qsTr("Copy all")
                    enabled: (count !== 0)
                    onClicked: backend.copy()
                }

                MenuItem {
                    text: '\ueee5 ' + qsTr("Remove")
                    enabled: (count !== 0)
                    onClicked: control.model.remove(control.currentIndex)
                }

                MenuItem {
                    text: '\ueee5 ' + qsTr("Remove all")
                    enabled: (count !== 0)
                    onClicked: control.model.clear()
                }
            }

        TextEdit {
            id: clipboard
            visible: false
            function setText(value) {
                text = value
                selectAll()
                copy()
            }
        }

        delegate: SwipeDelegate {
            id: delegate
            text: modelData
            font.pointSize: 9
            width: control.width
            LayoutMirroring.enabled: false
            LayoutMirroring.childrenInherit: false
            onHoveredChanged: control.currentIndex = index

            swipe.right: Rectangle {
                width: parent.width
                height: parent.height
                clip: true
                SwipeDelegate.onClicked: delegate.swipe.close()
                color: themeColor
                Behavior on color { ColorAnimation { } }

                Label {
                    font.family: fontello.name
                    text: "\ueee4 " + qsTr('Copied')
                    padding: 15
                    anchors.fill: parent
                    horizontalAlignment: Qt.AlignRight
                    verticalAlignment: Qt.AlignVCenter
                    opacity: delegate.swipe.position * -1
                    color: '#fff'
            }
         }

            //! [delegate]
            swipe.left: Rectangle {
                width: parent.width
                height: parent.height
                clip: true
                color: Material.color(Material.Grey, SwipeDelegate.pressed ? Material.Shade500
                                                                           : Material.Shade700)
                Label {
                    font.family: fontello.name
                    text: delegate.swipe.complete ? "\ueee2 " + qsTr('Restore')
                                                  : "\ueee3 " + qsTr('Remove')
                    padding: 15
                    anchors.fill: parent
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                    opacity: delegate.swipe.position
                    color: Material.color(delegate.swipe.complete ? Material.Green
                                                                  : Material.Red, Material.Purple)
                    Behavior on color { ColorAnimation { } }
                }

                SwipeDelegate.onClicked: delegate.swipe.close()
                SwipeDelegate.onPressedChanged: undoTimer.stop()
            }
            //! [delegate]

            //! [removal]

            Timer {
                property bool isLeft: (swipe.position===1)
                id: undoTimer
                interval: (isLeft)? 2600 : 1000
                onTriggered: (isLeft)? control.model.remove(index)
                                     : delegate.swipe.close()
            }
            swipe.onCompleted: {
                undoTimer.start()
                if (swipe.position==-1)
                    clipboard.setText(control.model.get(index).name)
            }

            //! [removal]
        }

//        headerPositioning: control.OverlayHeader
        header: Row {
            CustomRoundButton {
                        text: '\ueef7'
                        visible: (count > 9)
                        Material.foreground: themeColor
                        onPressed: positionViewAtEnd()
                        tooltipX: 45
                        tooltipY: 5
                        tooltipText: qsTr('Down')
            }

            CustomRoundButton {
                        text: '\ueff0'
                        visible: (count > 0)
                        Material.foreground: themeColor
                        onPressed: backend.export()
                        tooltipX: -10
                        tooltipY: -33
                        tooltipText: qsTr('Save')
            }

            CustomRoundButton {
                        text: '\ueee7'
                        visible: (count > 0)
                        Material.foreground: themeColor
                        onPressed: backend.folder()
                        tooltipX: -10
                        tooltipY: -33
                        tooltipText: qsTr('Folder')
            }

            CustomRoundButton {
                        text: '\ueee4'
                        visible: (count > 0)
                        Material.foreground: themeColor
                        onPressed: backend.copy()
                        tooltipX: -20
                        tooltipY: -33
                        tooltipText: qsTr('Copy All')
            }

            CustomRoundButton {
                        text: '\ueee5'
                        visible: (count > 0)
                        Material.foreground: themeColor
                        onPressed: listModel.clear()
                        tooltipX: -10
                        tooltipY: -33
                        tooltipText: qsTr('Clear')
            }
        }

//        footerPositioning: control.OverlayFooterer
        footer: CustomRoundButton {
            text: '\ueef6'
            visible: (count > 9)
            Material.foreground: themeColor
            onPressed: positionViewAtBeginning()
            tooltipX: 45
            tooltipY: 5
            tooltipText: qsTr('UP')
        }

        ToolTip {
            id: toolTip
            x: 45
            y: 5
            parent: control
            visible: false
        }
}

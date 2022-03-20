import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.11


ToolBar {
    id: toolBar
      Material.foreground: 'white'
      //        Material.primary: themeColor

      property alias isTour: btnTour.checked

      // Attach AND DROP WINDOW
      MouseArea {
          id: dragWindow
          height: 45
          anchors.leftMargin: 55
          anchors.rightMargin: 55
          anchors.left: parent.left
          anchors.right: parent.right
          property real lastMouseX: 0
          property real lastMouseY: 0
          onPressed: {
              lastMouseX = mouseX
              lastMouseY = mouseY
          }
          onMouseXChanged: root.x += (mouseX - lastMouseX)
          onMouseYChanged: root.y += (mouseY - lastMouseY)
      }

      // HEADER ITEMS
      RowLayout {
          spacing: -7
          anchors.fill: parent

          // HEADER LOGO
          TabButton {
              id: btnLogo
              Layout.leftMargin: 7
              Layout.preferredHeight: 35
              Layout.preferredWidth: 35
              display: AbstractButton.IconOnly

              MouseArea {
                  anchors.fill: parent
                  cursorShape: Qt.PointingHandCursor
                  onClicked: Qt.openUrlExternally(lnkInsta)
              }

              ToolTip {
                  x: -195
                  y: 0
                  delay: 150
                  parent: btnLogo
                  visible: btnLogo.hovered
                  text: qsTr('Follow Dev. on instagram')
              }

              Image {
                  source: 'qrc:/logo'
                  anchors.fill: parent
                  Material.elevation: 6
              }
          }

          // HEADER TITLE
          Label {
              id: titleLabel
              text: "Password Generator"
              font.pixelSize: (root.width === 380)? 15 : 20
              font.bold: true
              elide: Label.ElideRight
              horizontalAlignment: Qt.AlignHCenter
              verticalAlignment: Qt.AlignVCenter
              Layout.leftMargin: (root.width === 380)? 20 : 90
              Layout.fillWidth: true

              Behavior on font.pointSize { NumberAnimation { easing.type: Easing.InOutQuad} }
              Behavior on Layout.leftMargin { NumberAnimation { easing.type: Easing.InOutQuad} }
          }


          // TOUR GUIDE
          CustomRoundButton {
              id: btnTour
              tooltipX: 0
              tooltipY: -35
              text: '\ueff1'
              checkable: true
              checked: false
              font.pointSize: 12
              onCheckedChanged: {
                root.hideBoy = true
                root.isTour = checked
              }
              tooltipText: qsTr('Tour UI')
          }

          // MINIMIZE
          CustomToolButton {
              id: btnMinimize
              tooltipX: 0
              tooltipY: -35
              icon.source: 'qrc:/minimize'
              onClicked: root.showMinimized()
              tooltipText: qsTr('Minimize')
          }

          // QUIT
          CustomToolButton {
              id: btnClose
              tooltipX: 0
              tooltipY: -35
              icon.source: 'qrc:/quit'
              onClicked: root.close()
              tooltipText: qsTr('Quit')
          }

          // THEME SWITCH
          ThemeSwitch {
              id: themeSwitch
              checked: (settengs.themeMode===Material.Dark)
              checkable: true
              tooltipX: 0
              tooltipY: -35
              onCheckedChanged: themeMode = themeSwitch.checked? Material.Dark
                                                                : Material.Light
          }

      }
  }

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

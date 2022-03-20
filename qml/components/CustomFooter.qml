import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.11


ToolBar {
      Material.foreground: 'white'
//              Material.primary: themeColor

      // FOOTER TITLE
      Label {
          id: titleLabel
          text: "© Al-Taie 2021"
          font.bold: true
          font.pixelSize: 13
          anchors.verticalCenter: parent.verticalCenter
          anchors.horizontalCenter: parent.horizontalCenter
      }

  }

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

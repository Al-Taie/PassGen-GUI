import QtQuick 2.15
import QtQuick.Controls.Material 2.12
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15


Item {
    property int maskX
    property int maskY
    property int maskH
    property int maskW
    property alias radius: mask.radius

    Rectangle {
        id: bk
        anchors.fill: parent
        color: "#33000000"
        visible: false
        layer.enabled: true
        layer.smooth: true
    }

    Rectangle {
        id: mask
        anchors.fill: parent
        color: "transparent"
        visible: true

        Rectangle {
            id: circle
            width: maskW
            height: maskH
            x: maskX; y: maskY
            radius: 50
            color: "#000"
            Behavior on x {
                NumberAnimation {
                    duration: 400
                    easing.type: Easing.OutBack
                    easing.overshoot: 1.4
                }
            }

            Behavior on y {
                NumberAnimation {
                    duration: 400
                    easing.type: Easing.OutBack
                    easing.overshoot: 1.4
                }
            }
        }
        layer.enabled: true
        layer.samplerName: "maskSource"
        layer.effect: ShaderEffect {
            property variant source: bk
            fragmentShader: "
                varying highp vec2 qt_TexCoord0;
                uniform highp float qt_Opacity;
                uniform lowp sampler2D source;
                uniform lowp sampler2D maskSource;
                void main(void) {
                    gl_FragColor = texture2D(source, qt_TexCoord0.st) * (1.0-texture2D(maskSource, qt_TexCoord0.st).a) * qt_Opacity;
                }
            "
        }
    }


}

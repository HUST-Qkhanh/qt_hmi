import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick3D 6.7
// import QtQuick3D.Materials 6.7
import QtQuick3D.Helpers 6.7
import QtQuick3D.Particles3D 6.7
import QtQuick3D.Physics
import Generated.QtQuick3D.Forklift

Rectangle {
    property int angleModel: 0
    id: page
    visible: true
    width: 400
    height: 400
    // title: "Hình chữ nhật với tâm và góc xoay"

    // Các thông số chiều dài, rộng, vị trí tâm và góc xoay
    property real rectWidth: 100
    property real rectHeight: 50
    property real centerX: 200
    property real centerY: 200
    property real rotationAngle: 45

    // Điều khiển thay đổi giá trị của x, y, w (rotation)
    View3D {
        visible: true
        anchors.fill: parent
        clip: true
        importScene: perspectiveCamera2
        camera: perspectiveCamera2

        PerspectiveCamera {
            id: perspectiveCamera2
            x: 125
            y: 32.599
            eulerRotation.z: 0
            eulerRotation.y: 90.00002
            eulerRotation.x: 0
            z: 18
        }

        DirectionalLight {
            id: directionalLight2
            x: 133
            y: 187
            brightness: 1.44
            z: 13
            eulerRotation.z: 76.0437
            eulerRotation.y: 120.67021
            eulerRotation.x: -59.35477
        }

        Forklift {
            id: forklift
            scale.z: 30
            scale.y: 30
            scale.x: 30
            // eulerRotation.y: angleModel
            // NumberAnimation on eulerRotation.y {
            //     running: false
            //     loops: 1
            //     from: 0
            //     to: page.angleModel
            //     duration: 1000
            // }
        }

        NumberAnimation {
            id: rotationAnimation
            target: forklift
            property: "eulerRotation.y"
            from: forklift.eulerRotation.y
            to: angleModel
            duration: 1000
        }

        Button {
            id: button
            x: 153
            y: 340
            text: qsTr("Button")
            onClicked: {
                angleModel += 45;
                rotationAnimation.restart();
            }
        }
    }

    Item {
        id: __materialLibrary__
    }
}

/*##^##
Designer {
    D{i:0}D{i:1;cameraSpeed3d:55;cameraSpeed3dMultiplier:1}
}
##^##*/


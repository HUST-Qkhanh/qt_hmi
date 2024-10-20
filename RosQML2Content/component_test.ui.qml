import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    visible: true
    width: 400
    height: 400
    title: "Hình chữ nhật với tâm và góc xoay"

    // Các thông số chiều dài, rộng, vị trí tâm và góc xoay
    property real rectWidth: 100
    property real rectHeight: 50
    property real centerX: 200
    property real centerY: 200
    property real rotationAngle: 45

    Rectangle {
        width: rectWidth
        height: rectHeight
        color: "blue"

        // Đặt tâm của hình chữ nhật
        x: centerX - width / 2
        y: centerY - height / 2

        // Góc xoay của hình chữ nhật
        rotation: rotationAngle

        // Đặt điểm xoay là tâm của hình chữ nhật
        transformOrigin: Item.Center
    }

    // Điều khiển thay đổi giá trị của x, y, w (rotation)
    Slider {
        id: xSlider
        from: 0
        to: 400
        value: centerX
        onValueChanged: centerX = value
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Slider {
        id: ySlider
        from: 0
        to: 400
        value: centerY
        onValueChanged: centerY = value
        width: parent.width
        anchors.bottom: xSlider.top
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Slider {
        id: rotationSlider
        from: 0
        to: 360
        value: rotationAngle
        onValueChanged: rotationAngle = value
        width: parent.width
        anchors.bottom: ySlider.top
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
    }
}

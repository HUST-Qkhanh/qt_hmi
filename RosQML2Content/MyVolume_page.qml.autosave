import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Page {
    id: volume_page
    property double volume_current
    

    Slider {
        id: slider
        value: volume_current
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        Layout.fillHeight: true
        Layout.fillWidth: true
        stepSize: 1
        to: 100
        onValueChanged: {
            volume_current = backend.setVolume(value)
        }
    }

    RowLayout {
        id: rowLayout
        x: 0
        y: 203
        height: 0.2 * parent.height
        anchors.right: parent.right
        anchors.top: slider.bottom
        anchors.rightMargin: 30
        anchors.topMargin: 20
        spacing: 30
        Layout.fillWidth: true
        Layout.fillHeight: false
        anchors.horizontalCenter: parent.horizontalCenter


        RoundButton {
            id: mute_button
            width: volume_page.width * 0.25
            height: volume_page.width * 0.25
            Layout.fillWidth: true
            Layout.fillHeight: true
            icon.height: 50
            icon.width: 50
            display: AbstractButton.IconOnly
            icon.source: "asset/mute.svg"

            onPressedChanged: {
                if (pressed) {
                    background.color = "#B0BEC5"
                } else {
                    background.color = "#F5F5F5"
                }
            }
            onClicked: {
                slider.value = backend.setVolume(0)
                volume_current = 0
            }
        }
        RoundButton {
            id: sound_button

            width: volume_page.width * 0.25
            height: volume_page.width * 0.25
            Layout.fillWidth: true
            Layout.fillHeight: true
            anchors.verticalCenterOffset: 9
            icon.width: 50
            icon.source: "asset/sound.svg"
            icon.height: 50
            display: AbstractButton.IconOnly
            onPressedChanged: {
                if (pressed) {
                    background.color = "#B0BEC5"
                } else {
                    background.color = "#F5F5F5"
                }
            }
            onClicked: {
                slider.value = backend.setVolume(100)
                volume_current = 100
            }
        }
    }

}

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts
import RosQML2

Rectangle {
    id: volume_page
    property double volume_current
    radius: Constants.borderRadiusMedium
    

    ColumnLayout {
        id: columnLayout
        width: parent.width * 0.8
        height: parent.height * 0.3
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Slider {
            id: slider
            value: volume_current
            Layout.fillHeight: false
            Layout.fillWidth: true
            stepSize: 1
            to: 100
            onValueChanged: {
                volume_current = backend.setVolume(value)
            }
        }

        RowLayout {
            id: rowLayout
            Layout.preferredWidth: parent.width * 0.5
            spacing: 30
            Layout.fillWidth: false
            Layout.fillHeight: true
            anchors.horizontalCenter: parent.horizontalCenter


            RoundButton {
                id: mute_button
                radius: Constants.borderRadiusMedium
                Layout.fillWidth: true
                Layout.fillHeight: true
                icon.height: parent.height * 0.5
                icon.width: parent.height * 0.5
                display: AbstractButton.IconOnly
                icon.source: "asset/mute.svg"

                onClicked: {
                    slider.value = backend.setVolume(0)
                    volume_current = 0
                }
            }
            RoundButton {
                id: sound_button
                radius: Constants.borderRadiusMedium
                Layout.fillWidth: true
                Layout.fillHeight: true
                anchors.verticalCenterOffset: 9
                icon.height: parent.height * 0.5
                icon.width: parent.height * 0.5
                icon.source: "asset/sound.svg"
                display: AbstractButton.IconOnly
                onClicked: {
                    slider.value = backend.setVolume(100)
                    volume_current = 100
                }
            }
        }


    }


}

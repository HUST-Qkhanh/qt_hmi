import QtQuick 2.15
import QtQuick.Controls 2.15
import RosQML2
import QtQuick.Layouts
import QtQuick.Studio.DesignEffects

Rectangle {
    id: page2
    color: "#00d8d8d8"

    Rectangle {
        id: rectangle
        height: parent.height * 0.12
        radius: Constants.borderRadiusMedium
        anchors.left: rectangle3.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 6
        anchors.rightMargin: 6
        anchors.topMargin: 6
        color: Constants.secondaryColor

        Text {
            id: text1
            color: "#ffffff"
            text: qsTr("SETUP")
            anchors.fill: parent
            anchors.rightMargin: 0
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.italic: true
            font.bold: true
            font.pointSize: 0.4 * parent.heigth
        }
    }

    Loader {
        id: loader
        anchors.left: rectangle3.right
        anchors.right: parent.right
        anchors.top: rectangle.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: 6
        anchors.rightMargin: 6
        anchors.topMargin: 6
        anchors.bottomMargin: 6
        source: "MyVolume_page.qml"
    }

    Rectangle {
        id: rectangle3
        width: parent.width * 0.25
        color: Constants.backgroundColor
        radius: Constants.borderRadiusMedium
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 6
        anchors.topMargin: 6
        anchors.bottomMargin: 6
        Layout.fillWidth: true
        Layout.fillHeight: true

        ColumnLayout {
            property real buttonWidth: (width - (spacing * (children.length - 1))) / children.length
            anchors.fill: parent
            spacing: 0
            id: toolBar

            RoundButton {
                id: volume_button
                visible: true
                radius: Constants.borderRadiusMedium
                text: qsTr("Volume")
                padding: 0
                Layout.fillWidth: true
                Layout.preferredHeight: 0.15 * parent.height
                highlighted: true
                font.italic: false
                font.pointSize: 0.2 * height
                onClicked: {
                    loader.source = "MyVolume_page.qml"
                    // stackView.push(volume_component)
                    // volume_current = backend.getVolume()
                }
            }

            RoundButton {
                id: maintain_button
                visible: true
                radius: Constants.borderRadiusMedium
                text: qsTr("Update Model")
                Layout.fillWidth: true
                Layout.preferredHeight: 0.15 * parent.height
                font.pointSize: 0.2 * height
                font.italic: false
                onClicked: {
                    loader.source = "MyUpdate_model_page.qml"
                    // stackView.push(update_comp)
                }
            }

            Rectangle {
                id: rectangle4
                width: 200
                height: 200
                color: "#00ffffff"
                Layout.fillWidth: true
                Layout.fillHeight: true
            }




        }
    }
}

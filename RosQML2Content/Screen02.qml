import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    id: page2

    Rectangle {
        id: rectangle
        height: 72
        color: "#2196F3"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0

        Text {
            id: text1
            color: "#ffffff"
            text: qsTr("SETUP")
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.italic: true
            font.bold: true
            font.pointSize: 0.5 * parent.heigth
        }
    }

    ToolBar {
        id: toolBar
        width: page2.width * 0.15
        anchors.left: parent.left
        anchors.top: rectangle.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0

        Button {
            id: volume_button
            height: parent.height * 0.15
            text: qsTr("Volume")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 0
            font.italic: false
            font.pointSize: 0.1 * width
            onClicked: {
                loader.source = "MyVolume_page.qml"
                // stackView.push(volume_component)
                // volume_current = backend.getVolume()
            }
        }

        Button {
            id: maintain_button
            height: parent.height * 0.15
            text: qsTr("Update Model")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: volume_button.bottom
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 0
            font.pointSize: 0.1 * width
            font.italic: false
            onClicked: {
                loader.source = "MyUpdate_model_page.qml"
                // stackView.push(update_comp)
            }
        }
    }

    Loader {
        id: loader
        anchors.left: toolBar.right
        anchors.right: parent.right
        anchors.top: rectangle.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        source: "MyVolume_page.qml"
    }
}

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Page {
    id: update_model_page
    property string status_update_info: ""

    Connections {
        target: backend
        onUpdateStatusChanged: {
            status_update_info += backend.updateStatus;
        }
    }

    Text {
        id: status_header
        x: 239
        text: qsTr("Upload model to AGF database")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 30
        anchors.rightMargin: 30
        anchors.topMargin: 30
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
    }

    ScrollView {
        id: scrollView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: status_header.bottom
        anchors.bottom: rowLayout.top
        anchors.leftMargin: 30
        anchors.rightMargin: 30
        anchors.topMargin: 30
        anchors.bottomMargin: 30

        Text {
            id: status
            // text: status_update_info
            text: "asdasdasdasd"
            anchors.fill: parent
            font.pixelSize: 10
            horizontalAlignment: Text.AlignHCenter
        }
    }

    RowLayout {
        id: rowLayout
        y: 273
        height: 0.15 * parent.height
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: 0

        Button {
            id: update_model_button
            text: qsTr("Upload models")
            highlighted: true
            Layout.margins: 10
            Layout.fillHeight: true
            Layout.preferredWidth: 0.3 * parent.width
            Layout.minimumWidth: 0.3 * parent.width
            font.pointSize: 0.2 * height

            display: AbstractButton.TextOnly
            onClicked: {
                var filePath = backend.openFileDialog();
                if (filePath !== "") {
                    console.log("Đường dẫn file đã chọn: " + filePath);
                }
            }
        }

        Button {
            id: deleteAllModel
            text: qsTr("Clear models data")
            flat: false
            highlighted: false
            Layout.margins: 10
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.preferredWidth: 0.3 * parent.width
            Layout.minimumWidth: 0.3 * parent.width
            Layout.fillHeight: true
            font.pointSize: 0.2 * height
            display: AbstractButton.TextOnly
        }
    }

}

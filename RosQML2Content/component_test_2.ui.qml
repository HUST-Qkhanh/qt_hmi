import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.VirtualKeyboard

// Page {
//     id: update_model_page

//     Button {
//         id: update_model_button
//         width: update_model_page.width * 0.25
//         height: update_model_page.height * 0.25
//         text: qsTr("Chọn File")
//         anchors.verticalCenter: parent.verticalCenter
//         anchors.left: parent.left
//         anchors.leftMargin: 50
//         font.family: "Times New Roman"
//         font.pointSize: 30

//         display: AbstractButton.TextOnly
//         background: Rectangle {
//             color: "#F5F5F5"
//             radius: 50
//             border.color: "#FFFFFF"
//             border.width: 5
//         }
//         // onClicked: backend.shutdown(0)
//         // onPressedChanged: {
//         //     if (pressed) {
//         //         background.color = "#B0BEC5"
//         //     } else {
//         //         background.color = "#F5F5F5"
//         //     }
//         // }
//     }

//     Text {
//         id: status_header
//         text: qsTr("Trạng thái update")
//         anchors.left: update_model_button.right
//         anchors.right: parent.right
//         anchors.top: parent.top
//         anchors.leftMargin: 50
//         anchors.rightMargin: 0
//         anchors.topMargin: 50
//         font.pixelSize: 20
//         font.family: "Times New Roman"
//     }

//     Text {
//         id: status
//         text: ""
//         anchors.left: update_model_button.right
//         anchors.right: parent.right
//         anchors.top: status_header.bottom
//         anchors.bottom: parent.bottom
//         anchors.leftMargin: 50
//         anchors.rightMargin: 50
//         anchors.topMargin: 50
//         anchors.bottomMargin: 50
//         font.pixelSize: 20
//         font.family: "Times New Roman"
//     }
// }
GridLayout {
    id: note

    // width: parent.width * 0.15
    // anchors.right: parent.right
    anchors.left: parent.left
    anchors.bottom: parent.bottom
    // anchors.bottom: waiting.bottom
    anchors.leftMargin: 20
    anchors.bottomMargin: 20
    // anchors.bottomMargin: 0
    ColumnLayout {
        id: layout_note_1
        width: 50
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        spacing: 5
        Rectangle {
            color: "#CFD8DC"
            Layout.preferredWidth: 50
            Layout.fillHeight: true
        }
        Rectangle {
            color: "#FFEB3B"
            Layout.preferredWidth: 50
            Layout.fillHeight: true
        }
        Rectangle {
            color: "#FF9800"
            Layout.preferredWidth: 50
            Layout.fillHeight: true
        }
        Rectangle {
            color: "#4CAF50"
            Layout.preferredWidth: 50
            Layout.fillHeight: true
        }
        Rectangle {
            color: "#2196F3"
            Layout.preferredWidth: 50
            Layout.fillHeight: true
        }
    }
    ColumnLayout {

        id: layout_note_2
        anchors.left: layout_note_1.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        spacing: 5
        Text {
            height: 50
            text: "Trống (type: -1)"
            font.pixelSize: 35 * up_panel.height / 588
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        Text {

            height: 50
            text: "Pallet thấp (type: 0)"
            font.pixelSize: 35 * up_panel.height / 588
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        Text {

            height: 50
            text: "Pallet cao (type: 1)"
            font.pixelSize: 35 * up_panel.height / 588
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        Text {

            height: 50
            text: "Pallet kép (type: 2)"
            font.pixelSize: 35 * up_panel.height / 588
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        Text {

            height: 50
            text: "Pallet đơn (type: 3)"
            font.pixelSize: 35 * up_panel.height / 588
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}

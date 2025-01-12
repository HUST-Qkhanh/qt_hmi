import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Studio.DesignEffects
import RosQML2 1.0

Item {
    id: root
    width: 400
    height: 200

    property int header_type
    property alias header_text: header.text
    property alias info_text: _text.text
    property alias icon: headerIcon.source
    // property string error_info: qsTr("This is error information")
    
    property alias showCancel: roundButton1.visible
    

    signal confirmPressed
    signal cancelPressed

    function init() {
        switch (header_type) {
        case 0:
            header_text = qsTr("Insert");
            info_text = qsTr("Insert new pallet ?");
            // icon = "asset/add_square_fill.svg";
            icon = "qrc:/RosQML2Content/asset/add_square_fill.svg";
            showCancel = true;
            break;
        case 1:
            header_text = qsTr("Edit");
            info_text = qsTr("Save changes to the pallet ?");
            // icon = "asset/edit.svg";
            icon = "qrc:/RosQML2Content/asset/edit.svg";
            showCancel = true;
            break;
        case 2:
            header_text = qsTr("Erase");
            info_text = qsTr("Erase this pallet from database ?");
            // icon = "asset/trash.svg";
            icon = "qrc:/RosQML2Content/asset/trash.svg";
            showCancel = true;
            break;
        case 3:
            header_text = qsTr("Error");
            // info_text = error_info;
            // icon = "asset/close_round.svg";
            icon = "qrc:/RosQML2Content/asset/close_round.svg";
            showCancel = true;

            break;
        case 4:
            header_text = qsTr("Done");
            info_text = qsTr("Ok!");
            // icon = "asset/done_all_alt_round.svg";
            icon = "qrc:/RosQML2Content/asset/done_all_alt_round.svg";
            showCancel = true;
            break;
        case 5:
            header_text = qsTr("Timeout");
            // info_text = qsTr("Request Timeout!");
            // icon = "asset/done_all_alt_round.svg";
            icon = "qrc:/RosQML2Content/asset/close_round.svg";
            showCancel = true;
            break;
        case 6:
            header_text = qsTr("Confirmation");
            icon = "qrc:/RosQML2Content/asset/done_all_alt_round.svg";
            showCancel = true;
            break;

        default:
            break;
        }
    }

    Component.onCompleted: init()
    onHeader_typeChanged: init()
    // onInfo_textChanged: init()
    

    Rectangle {
        color: "#ffffff"
        radius: Constants.borderRadiusMedium
        border.width: 0
        anchors.fill: parent
        ColumnLayout {
            anchors.fill: parent
            anchors.bottomMargin: 0
            spacing: 0
            Rectangle {
                id: rectangle
                width: 200
                height: 200
                color: "transparent"
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillWidth: true
                Layout.maximumHeight: parent.height * 0.3

                Image {
                    id: headerIcon
                    anchors.fill: parent
                    source: "asset/done_all_alt_round.svg"
                    sourceSize.height: 200
                    sourceSize.width: 200
                    antialiasing: false
                    fillMode: Image.PreserveAspectFit
                }
            }

            ColumnLayout {
                id: columnLayout
                width: 100
                height: 100
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                spacing: 0
                Layout.fillHeight: true
                Layout.fillWidth: true

                Text {
                    id: header
                    text: qsTr("Insert new pallet")
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillHeight: true
                    font.styleName: "Medium"
                    font.bold: false
                    Layout.fillWidth: true
                    Layout.maximumHeight: parent.height * 0.5
                    font.pointSize: 18 * parent.width / 400
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                }

                Text {
                    id: _text
                    text: qsTr("Insert new document to database ?")
                    font.pixelSize: 14 * parent.width / 400
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignTop
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
            }

            RowLayout {
                id: rowLayout
                spacing: 0
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillWidth: true
                Layout.maximumHeight: parent.height * 0.25

                RoundButton {
                    id: roundButton
                    radius: 5
                    text: "Confirm"
                    Layout.fillHeight: true
                    // Layout.fillWidth: true
                    Layout.preferredWidth: parent.width * 0.5
                    highlighted: false
                    font.pixelSize: 10 * scaleFactor
                    onPressed: {
                        confirmPressed();
                    }
                }

                RoundButton {
                    id: roundButton1
                    radius: 5
                    text: "Cancel"
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    // Layout.preferredWidth: parent.width * 0.5
                    highlighted: true
                    font.pixelSize: 10 * scaleFactor
                    onPressed: {
                        cancelPressed()
                    }
                }
            }
        }
    }
}

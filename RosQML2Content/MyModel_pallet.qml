import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.2
import RosQML2

Item {
    id: model_pallet
    height: 300
    width: 600

    RowLayout {
        id: rowLayout
        anchors.fill: parent
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        anchors.topMargin: 5
        anchors.bottomMargin: 5
        spacing: 50


        GridLayout {
            id: gridLayout
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.preferredWidth: parent.width * 0.45
            Layout.maximumHeight: parent.height * 0.3

            Text {
                text: qsTr("Merchandise :")
                verticalAlignment: Text.AlignVCenter
                clip: true
                font.pointSize: 12 * model_pallet.height / 364
                font.family: "Ubuntu"
                font.bold: false
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.row: 0
                Layout.column: 0
            }

            Text {
                text: qsTr("Count :")
                verticalAlignment: Text.AlignVCenter
                Layout.fillHeight: true
                clip: true
                font.pointSize: 12 * model_pallet.height / 364
                font.family: "Ubuntu"
                font.bold: false
                Layout.fillWidth: true
                Layout.row: 1
                Layout.column: 0
            }

            ComboBox {
                id: list_count
                editable: true
                font.pixelSize: 10 * model_pallet.height / 300
                Layout.fillHeight: true
                // Layout.preferredHeight: 31
                // Layout.fillHeight: true
                Layout.preferredWidth: parent.width * 0.6
                Layout.row: 1
                Layout.column: 1
                currentIndex: 0

                property var count_pallet: [6, 8, 10, 12, 14, 16, 18]
                model: ListModel {
                    id: list_count_pallet
                }

                delegate: ItemDelegate {
                    text: model.text
                }

                Component.onCompleted: {
                    // Khởi tạo danh sách ban đầu
                    for (var i = 0; i < count_pallet.length; i++) {
                        list_count_pallet.append({
                                                     "text": count_pallet[i]
                                                 });
                    }
                }
                onEditTextChanged: {
                    count_data = editText;

                    __id__.text = "-----";
                    _height__.text = "-----";
                    _width__.text = "-----";
                    _length__.text = "-----";
                    _pallet_type__.text = "-----";
                    console.log("Selected fruit: " + editText);
                    backend.updateComboBox(model_data, count_data);
                }
            }

            ComboBox {
                id: list_model
                editable: true
                font.pixelSize: 10 * model_pallet.height / 300
                Layout.fillHeight: true
                // Layout.preferredHeight: 31

                Layout.preferredWidth: parent.width * 0.6
                Layout.row: 0
                Layout.column: 1
                currentIndex: 0

                // property var model_pallet_: backend.getListModel()
                model: ListModel {
                    id: list_model_pallet
                }

                delegate: ItemDelegate {
                    text: model.text
                }

                Component.onCompleted: {
                    // Khởi tạo danh sách ban đầu
                    for (var i = 0; i < model_pallet_.length; i++) {
                        list_model_pallet.append({
                                                     "text": model_pallet_[i]
                                                 });
                    }
                }
                onEditTextChanged: {
                    model_data = editText;
                    __id__.text = "-----";
                    _height__.text = "-----";
                    _width__.text = "-----";
                    _length__.text = "-----";
                    _pallet_type__.text = "-----";
                    backend.updateComboBox(model_data, count_data);
                    console.log("Selected fruit: " + editText);
                }
            }
        }
        GridLayout {
            Layout.alignment: Qt.AlignRight | Qt.AlignTop
            Layout.maximumHeight: model_pallet.height * 0.65
            Layout.fillWidth: true
            rowSpacing: 15
            columnSpacing: 20
            rows: 6
            columns: 4

            // Text {
            //     text: qsTr("Unique ID")
            //     font.pointSize: 12 * parent.height / 364
            //     font.family: "Ubuntu"
            //     font.bold: true

            //     Layout.fillWidth: true
            //     Layout.fillHeight: true
            //     Layout.preferredHeight: parent.width * 0.25
            //     Layout.row: 0
            //     Layout.column: 0
            // }
            Text {
                text: qsTr("height :")
                verticalAlignment: Text.AlignVCenter
                clip: true
                font.pointSize: 12 * model_pallet.height / 364
                font.family: "Ubuntu"
                font.bold: false
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.row: 0
                Layout.column: 2
            }
            Text {
                text: qsTr("width :")
                verticalAlignment: Text.AlignVCenter
                clip: true
                font.pointSize: 12 * model_pallet.height / 364
                font.family: "Ubuntu"
                font.bold: false

                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.row: 1
                Layout.column: 2
            }
            Text {
                text: qsTr("length :")
                verticalAlignment: Text.AlignVCenter
                clip: true
                font.pointSize: 12 * model_pallet.height / 364
                font.family: "Ubuntu"
                font.bold: false
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.row: 2
                Layout.column: 2
            }

            Text {
                text: qsTr("pallet_type :")
                verticalAlignment: Text.AlignVCenter
                clip: true
                font.pointSize: 12 * model_pallet.height / 364
                font.family: "Ubuntu"
                font.bold: false
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.row: 3
                Layout.column: 2
            }

            // TextField {
            //     id: __id__
            //     objectName: "__id__"
            //     font.pixelSize: 20 * _height__.height / 45
            //     text: "-----"

            //     readOnly: true
            //     property bool isBold: false
            //     property real radius: 5
            //     // width: 150
            //     Layout.fillWidth: true
            //     Layout.fillHeight: true
            //     Layout.preferredHeight: parent.height * 0.25
            //     Layout.preferredWidth: parent.width * 0.35
            //     Layout.row: 0
            //     Layout.column: 1
            //

            //     background: Rectangle {
            //         anchors.fill: parent
            //         radius: 5
            //         border.color: "#3850ff"
            //     }
            // }
            TextField {
                id: _height__
                objectName: "_height__"
                font.pixelSize: 10 * parent.height / 300
                Layout.fillHeight: true

                placeholderText: qsTr("Empty")
                placeholderTextColor: Constants.textColorSecondary
                focus: true
                property bool isBold: false
                property real radius: 5
                Layout.preferredWidth: parent.width * 0.6
                Layout.row: 0
                Layout.column: 3

                background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }
            }
            TextField {
                id: _width__
                objectName: "_width__"
                font.pixelSize: 10 * parent.height / 300
                Layout.fillHeight: true
                focus: true
                placeholderText: qsTr("Empty")
                placeholderTextColor: Constants.textColorSecondary

                property bool isBold: false
                property real radius: 5
                Layout.preferredWidth: parent.width * 0.6
                Layout.row: 1
                Layout.column: 3

                background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }
            }
            TextField {
                id: _length__
                objectName: "_length__"
                font.pixelSize: 10 * parent.height / 300
                Layout.fillHeight: true
                focus: true
                placeholderText: qsTr("Empty")
                placeholderTextColor: Constants.textColorSecondary
                property bool isBold: false
                property real radius: 5
                Layout.preferredWidth: parent.width * 0.6
                Layout.row: 2
                Layout.column: 3


                background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }
            }
            TextField {
                id: _pallet_type__
                objectName: "_pallet_type__"
                font.pixelSize: 10 * parent.height / 300
                Layout.fillHeight: true
                focus: true
                placeholderText: qsTr("Empty")
                placeholderTextColor: Constants.textColorSecondary
                property bool isBold: false
                property real radius: 5
                Layout.preferredWidth: parent.width * 0.6
                Layout.row: 3
                Layout.column: 3


                background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }
            }
        }
    }
}

import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.2
import RosQML2

Item {
    id: model_pallet
    height: 300
    width: 600

    // property alias _merchandise: _Merchandise_.text
    // property alias _count: _Count_.text
    // property alias _height: _height_.text
    // property alias _width: _width_.text
    // property alias _length: _length_.text
    // property alias _palletType: _pallet_type_.text

    property string jsonQueue: ''
    function clearTextFields() {
        // _id = qsTr("");

        // _zone = qsTr("");
        // _column = qsTr("");
        // _location = qsTr("");

        // _palletStatus = qsTr("");
        // _merchandise = qsTr("");
        // _palletType = qsTr("");

        // _palletHeight = qsTr("");
        // _palletWidth = qsTr("");
        // _palletLength = qsTr("");
    }

    function updateModelPallet(jsonStr) {
        var jsonObj = JSON.parse(jsonStr); // Parse the JSON string into a JavaScript object

        // Update the text fields with parsed data
        _id = jsonObj.stt.toString() || "";
        _zone = jsonObj.zone_id.toString() || "";
        _column = jsonObj.column_id.toString() || "";
        _location = jsonObj.location_id.toString() || "";
        _palletStatus = jsonObj.status.toString() || "";
        _merchandise = jsonObj.id_hang.toString() || "";
        _palletType = jsonObj.type.toString() || "";
        _palletHeight = jsonObj.height.toString() || "";
        _palletWidth = jsonObj.width.toString() || "";
        _palletLength = jsonObj.length.toString() || "";

        console.log("buffer_id: " + _id);
    }

    function addModelPallet() {
        if (_merchandise !== "" && _count !== "" && _id !== "") {
            var jsonObject = {
                "Merchandise": _merchandise,
                "Count": _count,
                "queue": _id
            };
            backend.addDataQueue(JSON.stringify(jsonObject, null, 2));
        } else {
            confirmShow.info_text = qsTr("Please input required fields");
            confirmShow.header_type = 3;
            statusIndicate.open();
        }
    }

    function deleteModelPallet(queueId) {
    }

    function saveModelPallet(queueId) {
    // body...
    }

    /*

                                   _   _
    ___ ___  _ __  _ __   ___  ___| |_(_) ___  _ __  ___
   / __/ _ \| '_ \| '_ \ / _ \/ __| __| |/ _ \| '_ \/ __|
  | (_| (_) | | | | | | |  __/ (__| |_| | (_) | | | \__ \
   \___\___/|_| |_|_| |_|\___|\___|\__|_|\___/|_| |_|___/


*/
    //TODO: connection for updating dataview when cell is pressed
    Connections {
        target: backend
        onModelJsonChanged: {
            var jsonModel = backend.fetchedModelJson;
            console.log("Fetched queue json:" + jsonModel);
            updateModelPallet(jsonModel);
        }
        onModelJsonAdded: {
            confirmShow.info_text = qsTr("Added to collection");
            confirmShow.header_type = 4;
            statusIndicate.open();
        }
        onModelJsonDeleted: {
            confirmShow.info_text = qsTr("Removed from collection");
            confirmShow.header_type = 4;
            statusIndicate.open();
        }
        //TODO: update curent popup view when data is changed
    }
    //NOTE: Handle the action when button is pressed
    Connections {
        target: userPopup
        onPopupLoaded: {
            clearTextFields();
            backend.updateMerchandiseList();
            backend.updateCountList();
        }
        onAddDataRequest: {
            console.log("model get add request");
            addModelPallet();
        }
        onSaveDataRequest: {
            console.log("model get save request");
            saveModelPallet();
        }
        onDeleteModelRequest: {
            console.log("model get remove request");
            deleteModelPallet();
        }
    }

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
            Layout.maximumHeight: parent.height * 0.4

            // Text {
                
            //     text: qsTr("Merchandise :")
            //     verticalAlignment: Text.AlignVCenter
            //     clip: true
            //     font.pointSize: 12 * model_pallet.height / 364
            //     font.family: "Ubuntu"
            //     font.bold: false
            //     Layout.fillWidth: true
            //     Layout.fillHeight: true
            //     Layout.row: 0
            //     Layout.column: 0
            // }

            // Text {
            //     id: modelCount
            //     text: qsTr("Count :")
            //     verticalAlignment: Text.AlignVCenter
            //     Layout.fillHeight: true
            //     clip: true
            //     font.pointSize: 12 * model_pallet.height / 364
            //     font.family: "Ubuntu"
            //     font.bold: false
            //     Layout.fillWidth: true
            //     Layout.row: 1
            //     Layout.column: 0
            // }

            ComboBox {
                id: list_count
                editable: true
                font.pixelSize: 10 * model_pallet.height / 300
                Layout.fillWidth: true
                Layout.fillHeight: true
                // Layout.preferredHeight: 31
                // Layout.fillHeight: true
                Layout.preferredWidth: parent.width * 0.6
                Layout.row: 1
                Layout.column: 1
                currentIndex: 0
                property var count_pallet: [6, 8, 10, 12, 14, 16, 18]
                model: backend.pModelCountList

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

                    // __id__.text = "-----";
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
                Layout.fillWidth: true
                Layout.fillHeight: true

                // Layout.preferredHeight: 31

                Layout.preferredWidth: parent.width * 0.6
                Layout.row: 0
                Layout.column: 1
                currentIndex: 0
                /* background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }*/

                // property var model_pallet_: backend.getListModel()
                model: backend.pModelMerchandiseList

                delegate: ItemDelegate {
                    text: model.text
                }

                Component.onCompleted:
                // // Khởi tạo danh sách ban đầu
                // for (var i = 0; i < model_pallet_.length; i++) {
                //     list_model_pallet.append({
                //         "text": model_pallet_[i]
                //     });
                // }
                {}
                onEditTextChanged: {
                    model_data = editText;
                    // __id__.text = "-----";
                    _height__.text = "-----";
                    _width__.text = "-----";
                    _length__.text = "-----";
                    _pallet_type__.text = "-----";
                    backend.updateComboBox(model_data, count_data);
                    console.log("Selected fruit: " + editText);
                }
            }

            RoundButton {
                id: roundButton
                radius: Constants.borderRadiusSmall
                text: qsTr("Search")
                icon.source: "asset/search_light.svg"
                Layout.row: 2
                Layout.preferredWidth: 300 * grid_queue.width / 1000
                Layout.preferredHeight: 50 * grid_queue.height / 600
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.column: 1
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

                /* background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }*/
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

                /* background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }*/
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

                /* background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }*/
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

                /* background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }*/
            }
        }
    }
}

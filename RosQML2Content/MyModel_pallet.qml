import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.2
import RosQML2

Item {
    id: model_pallet
    height: 300
    width: 600

    property alias _merchandise: list_model.currentText
    property alias _merchandiseChanged: list_model.editText
    property alias _count: list_count.currentText
    property alias _countChanged: list_count.editText
    property alias _height: _height__.text
    property alias _width: _width__.text
    property alias _length: _length__.text
    property alias _pallet_type: _pallet_type__.text

    property string jsonQueue: ''
    function clearTextFields() {
        // _count = qsTr("");
        // _merchandise = qsTr("");
        _pallet_type = qsTr("");

        _height = qsTr("");
        _width = qsTr("");
        _length = qsTr("");
    }

    function updateModelPallet(jsonStr) {
        var jsonObj = JSON.parse(jsonStr); // Parse the JSON string into a JavaScript object

        // Update the text fields with parsed data
        _pallet_type = jsonObj.pallet_type.toString() || "";
        _height = jsonObj.height.toString() || "";
        _width = jsonObj.width.toString() || "";
        _length = jsonObj.length.toString() || "";

        console.log("buffer_id: " + jsonObj.Merchandise.toString() || "");
    }

    function addModelPallet() {
        if (_merchandiseChanged !== "" && _countChanged !== "" && _height !== "" && _width !== "" && _length !== "" && _pallet_type !== "") {
            var jsonObject = {
                "Merchandise": _merchandiseChanged,
                "Count": _countChanged,
                "height": _height,
                "width": _width,
                "length": _length,
                "pallet_type": _pallet_type
            };

            console.log("jsonObject: " + JSON.stringify(jsonObject));

            backend.addDataModel(JSON.stringify(jsonObject, null, 2));
        } else {
            confirmShow.info_text = qsTr("Please input required fields");
            confirmShow.header_type = 3;
            statusIndicate.open();
        }
    }

    function deleteModelPallet() {
        var jsonObject = {
            "Merchandise": _merchandiseChanged,
            "Count": _countChanged
        };
        clearTextFields();
        backend.deleteDataModel(JSON.stringify(jsonObject, null, 2));
    }

    function saveModelPallet() {
        if (_merchandiseChanged !== "" && _count !== "" && _height !== "" && _width !== "" && _length !== "" && _pallet_type !== "") {
            var jsonObject = {
                "Merchandise": _merchandiseChanged,
                "Count": _countChanged,
                "height": _height,
                "width": _width,
                "length": _length,
                "pallet_type": _pallet_type
            };
            backend.saveDataModel(JSON.stringify(jsonObject, null, 2));
        } else {
            confirmShow.info_text = qsTr("Please input required fields");
            confirmShow.header_type = 3;
            statusIndicate.open();
        }
    }

    /*

                                   _   _
    ___ ___  _ __  _ __   ___  ___| |_(_) ___  _ __  ___
   / __/ _ \| '_ \| '_ \ / _ \/ __| __| |/ _ \| '_ \/ __|
  | (_| (_) | | | | | | |  __/ (__| |_| | (_) | | | \__ \
   \___\___/|_| |_|_| |_|\___|\___|\__|_|\___/|_| |_|___/


*/
    Connections {
        target: roundButton
        onClicked: {
            console.log("search for model:" + list_model.editText + " <>" + list_count.editText);
            backend.searchModel(list_model.editText, list_count.editText);
        }
    }
    //TODO: connection for updating dataview when cell is pressed
    Connections {
        target: backend
        onModelJsonChanged: {
            var jsonModel = backend.fetchedModelJson;
            console.log("Fetched model json:" + jsonModel);
            updateModelPallet(jsonModel);
        }
        onModelJsonAdded: {
            confirmShow.info_text = qsTr("Added to collection");
            confirmShow.header_type = 4;
            statusIndicate.open();
        }
        onModelJsonAddFailed: {
            confirmShow.info_text = qsTr("Failed to add to collection");
            confirmShow.header_type = 3;
            statusIndicate.open();
        }
        onModelJsonDeleted: {
            confirmShow.info_text = qsTr("Removed from collection");
            confirmShow.header_type = 4;
            statusIndicate.open();
        }
        onModelJsonDeleteFailed: {
            confirmShow.info_text = qsTr("Failed to remove from collection");
            confirmShow.header_type = 3;
            statusIndicate.open();
        }
        onModelJsonEdited: {
            confirmShow.info_text = qsTr("Saved to collection");
            confirmShow.header_type = 4;
            statusIndicate.open();
        }
        onModelJsonEditFailed: {
            confirmShow.info_text = qsTr("Failed to save to collection");
            confirmShow.header_type = 3;
            statusIndicate.open();
        }
        //TODO: update curent popup view when data is changed
    }
    //NOTE: Handle the action when button is pressed
    Connections {
        target: userPopup
        onPopupLoaded: {
            clearTextFields();
            // backend.updateMerchandiseList();
            // backend.updateCountList();
        }
        onAddDataRequest: {
            console.log("model get add request");
            addModelPallet();
        }
        onSaveDataRequest: {
            console.log("model get save request");
            saveModelPallet();
        }
        onDeleteDataRequest: {
            console.log("model get remove request");
            deleteModelPallet();
        }
    }

    Rectangle {
        id: rectangle
        height: 0.15 * parent.height
        color: Constants.secondaryColor
        radius: Constants.borderRadiusMedium
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 0
        anchors.rightMargin: 0

        Text {
            text: qsTr("Pallet Model")
            anchors.fill: parent
            font.pixelSize: parent.height * 0.3
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Ubuntu"
            font.bold: false
            clip: true
            Layout.row: 0
            Layout.fillWidth: false
            Layout.fillHeight: false
            Layout.column: 0
        }
    }

    MouseArea {
        anchors.fill: parent
        z: -1 // Ensure it is above the Flickable
        onClicked: {
            
            console.log("out: ")
            
            list_model.focus = false;
            list_count.focus = false;
            _height__.focus = false;
            _width__.focus = false;
            _length__.focus = false;
            _pallet_type__.focus = false;
        }
        propagateComposedEvents: true
    }

    Flickable {
        id: flickable
        y: 65
        anchors.left: parent.left
        anchors.right: parent.right
        Layout.margins: 5
        Layout.leftMargin: 5
        Layout.fillWidth: true
        Layout.bottomMargin: 5

        anchors.top: rectangle.bottom
        anchors.leftMargin: 11
        anchors.rightMargin: 169
        anchors.topMargin: 20

        height: Qt.inputMethod.visible ? 0.5 * gridLayout.height : gridLayout.heigh

        contentHeight: gridLayout.height
        contentWidth: gridLayout.width
        ScrollBar.vertical: ScrollBar {}

        // Timer {
        //     id: focusTimer
        //     interval: 100 // 100 ms delay
        //     repeat: false
        //     onTriggered: {
        //         if (Qt.inputMethod.visible) {

        //         }
        //     }
        // }

        GridLayout {
            id: gridLayout
            x: 0
            y: 0
            width: 0.7 * model_pallet.width
            height: 0.7 * model_pallet.height
            // x: -528
            // y: -97
            // // Layout.fillWidth: true
            // Layout.margins: 5
            // Layout.leftMargin: 5
            // Layout.fillWidth: true
            // Layout.bottomMargin: 0
            // Layout.maximumHeight: parent.height * 0.8
            // Layout.preferredWidth: parent.width * 0.7
            layoutDirection: Qt.LeftToRight

            ComboBox {
                id: list_count
                editable: true
                font.pixelSize: Math.round(parent.height * 0.07)
                Layout.fillHeight: true
                Layout.fillWidth: true
                flat: false
                Layout.preferredWidth: 300 * grid_queue.width / 1000
                Layout.preferredHeight: 50 * grid_queue.height / 600
                Layout.row: 1
                Layout.column: 1
                currentIndex: 0
                model: backend.pModelCountList
                inputMethodHints: Qt.ImhDigitsOnly

                Component.onCompleted: {
                    backend.updateCountList();
                }

                onFocusChanged: if (focus) {
                    flickable.contentY = Math.max(0, y - 20);
                }

                function resetUI() {
                    _height__.text = "";
                    _width__.text = "";
                    _length__.text = "";
                    _pallet_type__.text = "";
                }

                Timer {
                    id: updateTimer
                    interval: 500 // Debounce interval
                    repeat: false
                    onTriggered: backend.updateComboBox(model_data, count_data)
                }

                onEditTextChanged: {
                    if (editText.trim() === "") {
                        console.log("Empty input ignored.");
                        return;
                    }
                    count_data = editText;
                    resetUI();
                    updateTimer.restart();
                }

                Connections {
                    target: inputPanel
                    onVisibleChanged: {
                        if (!inputPanel.visible) {
                            count_data = editText;
                            resetUI();
                            backend.updateComboBox(model_data, count_data);
                        }
                    }
                }
            }

            ComboBox {
                id: list_model
                editable: true
                font.pixelSize: Math.round(parent.height * 0.07)
                Layout.preferredWidth: 300 * grid_queue.width / 1000
                Layout.preferredHeight: 50 * grid_queue.height / 600
                flat: false
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.row: 0
                Layout.column: 1
                currentIndex: 0
                model: backend.pModelMerchandiseList
                inputMethodHints: Qt.ImhPreferUppercase

                Component.onCompleted: backend.updateMerchandiseList()
                onFocusChanged: if (focus) {
                    flickable.interactive = true;
                    flickable.clip = true;
                    flickable.contentY = Math.max(0, y - 20);
                } else {
                    flickable.interactive = false;
                    flickable.clip = false;
                    flickable.contentY = 0;
                }

                // Reusable function to reset related UI elements
                function resetUI() {
                    _height__.text = "";
                    _width__.text = "";
                    _length__.text = "";
                    _pallet_type__.text = "";
                }

                // Debouncing updates for better performance
                Timer {
                    id: updateTimer2
                    interval: 500 // Adjust debounce time as needed
                    repeat: false
                    onTriggered: backend.updateComboBox(model_data, count_data)
                }

                onEditTextChanged: {
                    if (editText.trim() === "") {
                        console.log("Empty input ignored.");
                        return;
                    }
                    model_data = editText;
                    resetUI();
                    updateTimer.restart();
                    console.log("Selected fruit: " + editText);
                }

                Connections {
                    target: inputPanel
                    onVisibleChanged: {
                        if (!inputPanel.visible) {
                            model_data = editText;
                            resetUI();
                            backend.updateComboBox(model_data, count_data);
                            console.log("Selected box: " + editText);
                        }
                    }
                }
            }

            Text {
                text: qsTr("Merchandise")
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                clip: true
                font.pixelSize: parent.height * 0.07
                font.family: "Ubuntu"
                font.bold: false
                Layout.fillWidth: false
                Layout.fillHeight: true
                Layout.row: 0
                Layout.column: 0
            }

            Text {
                text: qsTr("Count")
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                clip: true
                font.pixelSize: parent.height * 0.07
                font.family: "Ubuntu"
                font.bold: false

                Layout.fillWidth: false
                Layout.fillHeight: true
                Layout.row: 1
                Layout.column: 0
            }

            RoundButton {
                id: roundButton
                radius: Constants.borderRadiusSmall
                text: qsTr("Search")
                font.pointSize: parent.height * 0.05
                icon.source: "asset/search_light.svg"
                Layout.row: 2
                Layout.preferredWidth: 300 * grid_queue.width / 1000
                Layout.preferredHeight: 50 * grid_queue.height / 600
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.column: 1
            }

            TextField {
                id: _height__
                property real radius: 5
                font.pixelSize: parent.height * 0.07
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 300 * grid_queue.width / 1000
                Layout.preferredHeight: 50 * grid_queue.height / 600
                placeholderTextColor: Constants.textColorSecondary
                placeholderText: qsTr("Height")
                objectName: "_height__"
                property bool isBold: false
                focus: true
                Layout.row: 0
                // Layout.fillWidth: true
                // Layout.fillHeight: false
                Layout.column: 2
                inputMethodHints: Qt.ImhDigitsOnly
                onFocusChanged: if (focus) {
                    flickable.interactive = true;
                    flickable.clip = true;
                    flickable.contentY = Math.max(0, y - 20);
                } else {
                    flickable.interactive = false;
                    flickable.clip = false;
                    flickable.contentY = 0;
                }
            }

            TextField {
                id: _width__
                property real radius: 5
                font.pixelSize: parent.height * 0.07
                placeholderTextColor: Constants.textColorSecondary
                placeholderText: qsTr("Width")
                objectName: "_width__"
                property bool isBold: false
                focus: true
                Layout.row: 1
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.column: 2
                inputMethodHints: Qt.ImhDigitsOnly
                onFocusChanged: if (focus) {
                    flickable.interactive = true;
                    flickable.clip = true;
                    flickable.contentY = Math.max(0, y - 20);
                } else {
                    flickable.interactive = false;
                    flickable.clip = false;
                    flickable.contentY = 0;
                }
            }

            TextField {
                id: _length__
                property real radius: 5
                font.pixelSize: parent.height * 0.07
                placeholderTextColor: Constants.textColorSecondary
                Layout.preferredWidth: 300 * grid_queue.width / 1000
                Layout.preferredHeight: 50 * grid_queue.height / 600
                placeholderText: qsTr("Length")
                objectName: "_length__"
                property bool isBold: false
                focus: true
                Layout.row: 2
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.column: 2
                inputMethodHints: Qt.ImhDigitsOnly
                onFocusChanged: if (focus) {
                    flickable.interactive = true;
                    flickable.clip = true;
                    flickable.contentY = Math.max(0, y - 20);
                } else {
                    flickable.interactive = false;
                    flickable.clip = false;
                    flickable.contentY = 0;
                }
            }

            TextField {
                id: _pallet_type__
                property real radius: 5
                font.pixelSize: parent.height * 0.07
                placeholderTextColor: Constants.textColorSecondary
                Layout.preferredWidth: 300 * grid_queue.width / 1000
                Layout.preferredHeight: 50 * grid_queue.height / 600
                placeholderText: qsTr("Pallet Type")
                objectName: "_pallet_type__"
                property bool isBold: false
                focus: true
                Layout.row: 3
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.column: 2
                inputMethodHints: Qt.ImhDigitsOnly
                onFocusChanged: if (focus)
                    flickable.contentY = Math.max(0, y - 20)
            }
        }
    }

    Image {
        id: favpng_boxPalletLogistics
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: flickable.right
        anchors.right: parent.right
        anchors.leftMargin: 6
        anchors.rightMargin: 6
        source: "asset/favpng_box-pallet-logistics.png"
        anchors.verticalCenterOffset: 0
        Layout.margins: 20
        sourceSize.height: 1000
        sourceSize.width: 1000
        fillMode: Image.PreserveAspectFit
    }
}

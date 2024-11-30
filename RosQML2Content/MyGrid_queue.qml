import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.2
import RosQML2

// import QtQuick3D.AssetUtils

Item {
    id: grid_queue
    width: 600
    height: 300
    visible: true

    property alias _id: _Id_.text
    property alias _merchandise: _Merchandise_.text
    property alias _count: _Count_.text
    property alias _height: _height_.text
    property alias _width: _width_.text
    property alias _length: _length_.text
    property alias _palletType: _pallet_type_.text

    property string jsonQueue: ''

    /*

                             _        __          ___                                            _
    ___ _ __ _ __ ___  _ __ (_)_ __  / _| ___    ( _ )     ___ _ __ _ __ ___  _ __  ___ ___   __| | ___
   / _ \ '__| '__/ _ \| '__|| | '_ \| |_ / _ \   / _ \/\  / _ \ '__| '__/ _ \| '__|/ __/ _ \ / _` |/ _ \
  |  __/ |  | | | (_) | |   | | | | |  _| (_) | | (_>  < |  __/ |  | | | (_) | |  | (_| (_) | (_| |  __/
   \___|_|  |_|  \___/|_|___|_|_| |_|_|  \___/   \___/\/  \___|_|  |_|  \___/|_|___\___\___/ \__,_|\___|
                       |_____|                                                |_____|

*/

    // property string errorAdd_code: ""
    // property string errorSave_code: ""
    // property string ErrorDelete_code: ""
    // property string errorAdd_info: ""
    // property string errorSave_info: ""
    // property string errorDelete_info: ""

    /*

/*

       _                   _
   ___(_) __ _ _ __   __ _| |___
  / __| |/ _` | '_ \ / _` | / __|
  \__ \ | (_| | | | | (_| | \__ \
  |___/_|\__, |_| |_|\__,_|_|___/
         |___/

*/

    // signal showConfirm(int type, string info)
    // signal addQueueDB(string jsonPallet)
    // signal removeQueueDB(string jsonFilter)
    // signal saveQueueDB(string jsonPallet)
    signal searchModel(string merchandise, string count)

    /*    __                  _   _
   / _|_   _ _ __   ___| |_(_) ___  _ __
  | |_| | | | '_ \ / __| __| |/ _ \| '_ \
  |  _| |_| | | | | (__| |_| | (_) | | | |
  |_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|


*/

    function clearTextFields() {
        _merchandise = qsTr("");
        _count = qsTr("");
        _height = qsTr("");
        _width = qsTr("");
        _length = qsTr("");
        _palletType = qsTr("");
        _id = qsTr("");
    }
    //TODO:TESTED
    function updateQueuePallet(jsonStr) {
        var jsonObj = JSON.parse(jsonStr); // Parse the JSON string into a JavaScript object

        // Update the text fields with parsed data
        _merchandise = jsonObj.Merchandise || "";
        _count = jsonObj.Count || "";
        _height = jsonObj.height || "";
        _width = jsonObj.width || "";
        _length = jsonObj.length || "";
        _palletType = jsonObj.pallet_type || "";
        _id = jsonObj.queue || "";

        console.log("queue_id: " + jsonObj.queue);
    }

    //TODO: TESTED
    function addQueuePallet() {
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
    //TODO: TESTED
    function deleteQueuePallet(queueId) {
        if (_id !== "") {
            backend.deleteDataQueue(_id);
        } else {
            confirmShow.info_text = qsTr("Position field is empty");
            confirmShow.header_type = 3;
            statusIndicate.open();
        }
    }
    //TODO: TESTED
    function saveQueuePallet(queueId) {
        if (_merchandise !== "" && _count !== "" && _id !== "") {
            var jsonObject = {
                "Merchandise": _merchandise,
                "Count": _count,
                "queue": _id
            };
            backend.saveDataQueue(JSON.stringify(jsonObject, null, 2));
        } else {
            console.log("Error save to queue");
            console.log("Please input required fields");
            confirmShow.info_text = qsTr("Please input required fields");
            confirmShow.header_type = 3;
            // statusIndicate.open();
        }
    }

    /*

                                   _   _
    ___ ___  _ __  _ __   ___  ___| |_(_) ___  _ __  ___
   / __/ _ \| '_ \| '_ \ / _ \/ __| __| |/ _ \| '_ \/ __|
  | (_| (_) | | | | | | |  __/ (__| |_| | (_) | | | \__ \
   \___\___/|_| |_|_| |_|\___|\___|\__|_|\___/|_| |_|___/


*/
    Component.onCompleted: {
        clearTextFields();
    }

    //TODO: connection for updating dataview when cell is pressed
    Connections {
        target: backend
        onQueueJsonChanged: {
            var jsonQueue = backend.fetchedQueueJson;
            console.log("Fetched queue json:" + jsonQueue);
            updateQueuePallet(jsonQueue);
        }
        onQueueJsonAdded: {
            confirmShow.info_text = qsTr("Added to queue");
            confirmShow.header_type = 4;
            statusIndicate.open();
        }
        onQueueJsonDeleted: {
            confirmShow.info_text = qsTr("Remove from queue");
            confirmShow.header_type = 4;
            statusIndicate.open();
        }
    }

    //NOTE: Handle the action when button is pressed
    Connections {
        target: userPopup
        onPopupLoaded: {
            clearTextFields();
        }
        onAddDataRequest: {
            console.log("queue get add request");
            addQueuePallet();
        }
        onSaveDataRequest: {
            console.log("queue get save request");
            saveQueuePallet();
        }
        onDeleteDataRequest: {
            console.log("queue get remove request");
            deleteQueuePallet();
        }
    }

    Connections {
        target: conveyorView
        function onAddNew() {
            console.log("Add newsdsd");
            pop_up_2.open();
            loadPopupType(0);
        // console.log("queueID: " + queueId);
        backend.expandQueue();
        }
    }

    /*

   _____ _     _____ __  __ _____ _   _ _____ ____
  | ____| |   | ____|  \/  | ____| \ | |_   _/ ___|
  |  _| | |   |  _| | |\/| |  _| |  \| | | | \___ \
  | |___| |___| |___| |  | | |___| |\  | | |  ___) |
  |_____|_____|_____|_|  |_|_____|_| \_| |_| |____/


*/
    RowLayout {
        id: rowLayout
        anchors.fill: parent
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        anchors.topMargin: 5
        anchors.bottomMargin: 10
        spacing: 50
        clip: false

        GridLayout {
            id: parent_queue
            Layout.margins: 5
            Layout.leftMargin: 5
            Layout.fillWidth: true
            Layout.bottomMargin: 0
            Layout.maximumHeight: parent.height * 0.8
            layoutDirection: Qt.LeftToRight
            flow: GridLayout.TopToBottom
            rowSpacing: 20
            columnSpacing: 20
            rows: 5
            columns: 2
            TextField {
                id: _Merchandise_
                objectName: "_Merchandise__"
                font.pixelSize: 10 * _Merchandise_.height / 35
                Layout.fillHeight: true
                Layout.fillWidth: true

                placeholderText: qsTr("Merchandise")
                placeholderTextColor: Constants.textColorSecondary
                property bool isBold: false
                property real radius: 5
                Layout.preferredWidth: 300 * grid_queue.width / 1000
                Layout.preferredHeight: 50 * grid_queue.height / 600
                Layout.row: 1
                Layout.column: 0
                /* background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }*/
            }

            TextField {
                id: _Count_
                objectName: "_Count__"
                font.pixelSize: 10 * _Merchandise_.height / 35
                verticalAlignment: Text.AlignVCenter
                Layout.fillWidth: true

                placeholderText: qsTr("Count")
                placeholderTextColor: Constants.textColorSecondary

                text: qsTr("")
                Layout.preferredWidth: 300 * grid_queue.width / 1000
                Layout.preferredHeight: 50 * grid_queue.height / 600

                property bool isBold: false
                property real radius: 5
                Layout.fillHeight: true
                Layout.row: 3
                Layout.column: 0

                /* background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }*/
            }
            TextField {
                id: _height_
                objectName: "_height__"
                font.pixelSize: 10 * _Merchandise_.height / 35
                Layout.fillWidth: true

                placeholderText: qsTr("Height")
                placeholderTextColor: Constants.textColorSecondary
                text: qsTr("")
                Layout.preferredWidth: 300 * grid_queue.width / 1000
                Layout.preferredHeight: 50 * grid_queue.height / 600

                property bool isBold: false
                property real radius: 5
                Layout.fillHeight: true
                Layout.row: 1
                Layout.column: 1

                readOnly: true
                /* background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }*/
            }
            TextField {
                id: _width_
                objectName: "_width__"
                font.pixelSize: 10 * _Merchandise_.height / 35
                Layout.fillWidth: true

                placeholderText: qsTr("Width")
                placeholderTextColor: Constants.textColorSecondary
                text: qsTr("")
                Layout.preferredWidth: 300 * grid_queue.width / 1000
                Layout.preferredHeight: 50 * grid_queue.height / 600

                property bool isBold: false
                property real radius: 5
                Layout.fillHeight: true
                Layout.row: 3
                Layout.column: 1

                readOnly: true
                /* background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }*/
            }
            TextField {
                id: _length_
                objectName: "_length__"
                font.pixelSize: 10 * _Merchandise_.height / 35
                Layout.fillWidth: true

                placeholderText: qsTr("Length")
                placeholderTextColor: Constants.textColorSecondary
                text: qsTr("")
                Layout.preferredWidth: 300 * grid_queue.width / 1000
                Layout.preferredHeight: 50 * grid_queue.height / 600

                readOnly: true
                property bool isBold: false
                property real radius: 5
                Layout.fillHeight: true
                Layout.row: 5
                Layout.column: 1

                /* background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }*/
            }
            TextField {
                id: _pallet_type_
                objectName: "_pallet_type"
                font.pixelSize: 10 * _Merchandise_.height / 35
                Layout.fillWidth: true

                placeholderText: qsTr("Pallet type")
                placeholderTextColor: Constants.textColorSecondary
                text: qsTr("")
                Layout.preferredWidth: 300 * grid_queue.width / 1000
                Layout.preferredHeight: 50 * grid_queue.height / 600

                readOnly: true
                property bool isBold: false
                property real radius: 5
                Layout.fillHeight: true
                Layout.row: 7
                Layout.column: 1

                /* background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }*/
            }

            RoundButton {
                id: roundButton
                radius: Constants.borderRadiusSmall
                text: qsTr("Search")
                icon.source: "asset/search_light.svg"
                Layout.fillWidth: true
                Layout.preferredWidth: 300 * grid_queue.width / 1000
                Layout.preferredHeight: 50 * grid_queue.height / 600
                Layout.fillHeight: true
                Layout.row: 5
                Layout.column: 0
                onClicked: backend.searchModel(_Merchandise_.text, _Count_.text)
            }
        }

        ColumnLayout {
            id: columnLayout
            Layout.margins: 5
            Layout.rightMargin: 5
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            // Layout.fillWidth: true
            Layout.maximumHeight: parent.height * 0.8
            Layout.preferredWidth: parent.width * 0.3

            Image {
                id: conveyorBelt
                visible: true
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source: "asset/conveyor-belt.png"
                Layout.fillWidth: false
                sourceSize.height: 160
                sourceSize.width: 180
                mirror: false
                Layout.preferredWidth: parent.width * 0.8
                Layout.fillHeight: true
                Layout.topMargin: 0
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.bottomMargin: 0
                fillMode: Image.PreserveAspectFit
            }

            TextField {
                id: _Id_
                property real radius: 5
                text: qsTr("")
                font.pixelSize: 10 * _Merchandise_.height / 35
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width * 0.5
                Layout.maximumHeight: _Merchandise_.height

                placeholderTextColor: Constants.textColorSecondary
                placeholderText: qsTr("Position")
                objectName: "_Id__"
                property bool isBold: false
                Layout.row: 1
                // Layout.fillHeight: true
                Layout.column: 0
            }
        }
    }
}

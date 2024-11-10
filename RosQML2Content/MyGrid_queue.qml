import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.2
import RosQML2
import QtQuick3D.AssetUtils

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

    function clearTextFields() {
        _merchandise = qsTr("");
        _count = qsTr("");
        _height = qsTr("");
        _width = qsTr("");
        _length = qsTr("");
        _palletType = qsTr("");
        _id = qsTr("");
    }

    function updateQueuePallet(jsonStr) {
        var jsonObj = JSON.parse(jsonStr); // Parse the JSON string into a JavaScript object

        // Update the text fields with parsed data
        _merchandise = jsonObj.Merchandise || "";
        _count = jsonObj.Count || "";
        _height = jsonObj.Height || "";
        _width = jsonObj.Width || "";
        _length = jsonObj.Length || "";
        _palletType = jsonObj.PalletType || "";
        _id = jsonObj.queue || "";

        console.log("queue_id: " + jsonObj.queue);
    }

    function addQueuePallet() {
        if (uuid_queue.text === "-----") {
            jsonObject = {
                "_id": uuid_queue.text,
                "Id": _Id_.text,
                "PalletInfo": _PalletInfo_.text,
                "Model": _Model_.text,
                "Merchandise": _Merchandise_.text,
                "NameModel": _NameModel_.text,
                "Destination": _Destination_.text,
                "Count": _Count_.text,
                "ZoneId": _ZoneId_.text,
                "ColumnId": _ColumnId_.text,
                "LocationId": _LocationId_.text,
                "Barcode": _Barcode_.text,
                // "Time": _Time_.text,
                "queue": _queue_.text
            };
            // console.log(JSON.stringify(jsonObject, null, 2))

            backend.addDataQueue(JSON.stringify(jsonObject, null, 2));
        } else {
            _headerLayoutText = " Mục đã tồn tại - hãy ấn sửa ";
        }
    }

    function deleteQueuePallet(queueId) {
    // body...
    }

    function saveQueuePallet(queueId) {
    // body...
    }

    Component.onCompleted: {
        clearTextFields();
    }

    Connections {
        target: backend
        onQueueJsonChanged: {
            var jsonQueue = backend.fetchedQueueJson;
            console.log("Fetched queue json:" + jsonQueue);
            updateQueuePallet(jsonQueue);
        }
    }

    Connections {
        target: userPopup
        onPopupLoaded: {
            clearTextFields();
        }
    }

    RowLayout {
        id: rowLayout
        anchors.fill: parent
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        anchors.topMargin: 5
        anchors.bottomMargin: 10
        spacing: 50
        clip: true

        GridLayout {
            id: parent_queue
            Layout.fillWidth: true
            Layout.bottomMargin: 0
            Layout.maximumHeight: parent.height * 0.8
            layoutDirection: Qt.LeftToRight
            flow: GridLayout.TopToBottom
            rowSpacing: 5
            columnSpacing: 5
            rows: 5
            columns: 2

            Text {
                id: mechandise_text
                text: qsTr("Merchandise :")
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignBottom
                clip: true
                font.pointSize: 18 * grid_queue.height / 600
                font.family: "Ubuntu"
                Layout.fillWidth: true
                Layout.fillHeight: true
                font.bold: false
                Layout.row: 0
                Layout.column: 0
            }
            Text {
                text: qsTr("Count :")
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignBottom
                clip: true
                font.pointSize: 18 * grid_queue.height / 600
                font.family: "Ubuntu"
                Layout.fillWidth: true
                Layout.fillHeight: true
                font.bold: false
                Layout.row: 2
                Layout.column: 0
            }
            Text {
                text: qsTr("Height :")
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignBottom
                clip: true
                font.pointSize: 18 * grid_queue.height / 600
                font.family: "Ubuntu"
                Layout.fillWidth: true
                Layout.fillHeight: true
                font.bold: false
                Layout.row: 0
                Layout.column: 1
            }
            Text {
                text: qsTr("Width :")
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignBottom
                clip: true
                font.pointSize: 18 * grid_queue.height / 600
                font.family: "Ubuntu"
                Layout.fillWidth: true
                Layout.fillHeight: true
                font.bold: false
                Layout.row: 2
                Layout.column: 1
            }
            Text {
                text: qsTr("Length :")
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignBottom
                clip: true
                font.pointSize: 18 * grid_queue.height / 600
                font.family: "Ubuntu"
                Layout.fillWidth: true
                Layout.fillHeight: true
                font.bold: false
                Layout.row: 4
                Layout.column: 1
            }
            Text {
                text: qsTr("Type :")
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignBottom
                clip: true
                font.pointSize: 18 * grid_queue.height / 600
                font.family: "Ubuntu"
                Layout.fillWidth: true
                Layout.fillHeight: true
                font.bold: false
                Layout.row: 6
                Layout.column: 1
            }
            TextField {
                id: _Merchandise_
                objectName: "_Merchandise__"
                font.pixelSize: 10 * grid_queue.height / 300
                Layout.fillHeight: true
                Layout.fillWidth: true

                placeholderText: qsTr("Empty")
                placeholderTextColor: Constants.textColorSecondary
                text: qsTr("")
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

                placeholderText: qsTr("Empty")
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

                placeholderText: qsTr("Empty")
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

                placeholderText: qsTr("Empty")
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

                placeholderText: qsTr("Empty")
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

                placeholderText: qsTr("Empty")
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
        }

        ColumnLayout {
            id: columnLayout
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

            ColumnLayout {
                id: columnLayout1
                Layout.fillHeight: false
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                Layout.maximumWidth: parent.width * 0.5
                Layout.preferredHeight: parent.height * 0.3

                Text {
                    text: qsTr("Position :")
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignBottom
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                    Layout.fillHeight: false
                    // Layout.fillHeight: true
                    Layout.fillWidth: true
                    // Layout.fillWidth: true
                    font.pointSize: mechandise_text.font.pointSize
                    font.family: "Ubuntu"
                    font.bold: false
                    clip: true
                    Layout.row: 0
                    Layout.column: 0
                }

                TextField {
                    id: _Id_
                    property real radius: 5
                    text: qsTr("")
                    font.pixelSize: 10 * _Merchandise_.height / 35
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumHeight: _Merchandise_.height

                    placeholderTextColor: Constants.textColorSecondary
                    placeholderText: qsTr("Empty")
                    objectName: "_Id__"
                    property bool isBold: false
                    focus: true
                    background: Rectangle {
                        radius: 5
                        border.color: "#3850ff"
                        anchors.fill: parent
                    }
                    Layout.row: 1

                    // Layout.fillHeight: true
                    Layout.column: 0
                }
            }
        }
    }
}

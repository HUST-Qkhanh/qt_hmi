import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.2
import RosQML2

Item {
    id: grid_queue
    width: 600
    height: 300
    visible: true

    property alias _palletInfo: _PalletInfo_.text
    property alias _merchandise: _Merchandise_.text
    property alias _barcode: _Barcode_.text
    property alias _time: _Time_.text
    property alias _count: _Count_.text
    property alias _height: _height_.text
    property alias _width: _width_.text
    property alias _length: _length_.text
    property alias _palletType: _pallet_type_.text
    property alias _id: _Id_.text

    property string jsonQueue: ''

    function clearTextFields() {
        // _id = qsTr("");
        _palletInfo = qsTr("");
        _merchandise = qsTr("");
        _barcode = qsTr("");
        _time = qsTr("");
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
        _barcode = jsonObj.Barcode || "";
        _time = jsonObj.Time || "";
        _height = jsonObj.Height || "";
        _width = jsonObj.Width || "";
        _length = jsonObj.Length || "";
        _palletType = jsonObj.PalletType || "";
        _id = jsonObj.queue || "";
    }

    Component.onCompleted: {
        clearTextFields();
    }

    Connections {
        target: backend
        onQueueJsonChanged: {
            var jsonQueue = backend.fetchedQueueJson;
            console.log("Fetched json:" + jsonQueue);
            updateQueuePallet(jsonQueue);
        }
    }

    Connections {
        target: userPopup
        onPopupLoaded: {
            clearTextFields();
        }
    }

    GridLayout {
        id: parent_queue
        anchors.fill: parent
        anchors.leftMargin: 5
        anchors.rightMargin: parent.width * 0.05
        anchors.topMargin: 5
        anchors.bottomMargin: 5
        rowSpacing: 15
        columnSpacing: 20
        rows: 5
        columns: 6

        // Text {
        //     text: qsTr("Unique ID")
        //     font.pointSize: 12 * parent.height / 364
        //     font.family: "Ubuntu"
        //     font.bold: true
        //     Layout.preferredWidth: parent.width * 0.1
        //     Layout.fillHeight: true
        //     Layout.row: 0
        //     Layout.column: 0
        // }
        Text {
            text: qsTr("Position :")
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            clip: true
            font.pointSize: 12 * parent.height / 364
            font.family: "Ubuntu"
            font.bold: false
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.row: 0
            Layout.column: 4
        }
        Text {
            text: qsTr("Pallet Info :")
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            clip: true
            font.family: "Ubuntu"
            font.bold: false
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.pointSize: 12 * parent.height / 364
            Layout.row: 2
            Layout.column: 0
        }

        Text {
            text: qsTr("Merchandise :")
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            clip: true
            font.pointSize: 12 * parent.height / 364
            font.family: "Ubuntu"
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.bold: false
            Layout.row: 1
            Layout.column: 0
        }

        Text {
            text: qsTr("Barcode :")
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            clip: true
            font.pointSize: 12 * parent.height / 364
            font.family: "Ubuntu"
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.bold: false
            Layout.row: 3
            Layout.column: 0
        }

        Text {
            text: qsTr("Time :")
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            clip: true
            font.pointSize: 12 * parent.height / 364
            font.family: "Ubuntu"
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.bold: false
            Layout.row: 0
            Layout.column: 0
        }
        Text {
            text: qsTr("Count :")
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            clip: true
            font.pointSize: 12 * parent.height / 364
            font.family: "Ubuntu"
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.bold: false
            Layout.row: 1
            Layout.column: 4
        }
        Text {
            text: qsTr("Height :")
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            clip: true
            font.pointSize: 12 * parent.height / 364
            font.family: "Ubuntu"
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.bold: false
            Layout.row: 2
            Layout.column: 4
        }
        Text {
            text: qsTr("Width :")
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            clip: true
            font.pointSize: 12 * parent.height / 364
            font.family: "Ubuntu"
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.bold: false
            Layout.row: 3
            Layout.column: 4
        }
        Text {
            text: qsTr("Length :")
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            clip: true
            font.pointSize: 12 * parent.height / 364
            font.family: "Ubuntu"
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.bold: false
            Layout.row: 4
            Layout.column: 4
        }
        Text {
            text: qsTr("Type :")
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            clip: true
            font.pointSize: 12 * parent.height / 364
            font.family: "Ubuntu"
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.bold: false
            Layout.row: 5
            Layout.column: 4
        }

        // TextField {
        //     id: uuid_queue
        //     objectName: "uuid_queue"
        //     font.pixelSize: 25 * uuid_queue.height / 45
        //     Layout.fillWidth: true
        //
        //     readOnly: true
        //     property bool isBold: false
        //     property real radius: 5
        //     width: 150
        //     Layout.preferredWidth: parent.width * 0.3
        //     Layout.fillHeight: true
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
            id: _Id_
            objectName: "_Id__"
            font.pixelSize: 10 * _Time_.height / 35

            placeholderText: qsTr("Empty")
            placeholderTextColor: Constants.textColorSecondary
            text: qsTr("")
            focus: true
            property bool isBold: false
            property real radius: 5
            // width: 150
            Layout.preferredWidth: parent.width * 0.3
            Layout.fillHeight: true
            Layout.row: 0
            Layout.column: 5

            background: Rectangle {
                anchors.fill: parent
                radius: 5
                border.color: "#3850ff"
            }
        }
        TextField {
            id: _PalletInfo_
            objectName: "_PalletInfo__"
            font.pixelSize: 10 * _Time_.height / 35

            placeholderText: qsTr("Empty")
            placeholderTextColor: Constants.textColorSecondary
            text: qsTr("")
            focus: true
            property bool isBold: false
            property real radius: 5
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.3
            Layout.row: 2
            Layout.column: 1

            background: Rectangle {
                anchors.fill: parent
                radius: 5
                border.color: "#3850ff"
            }
        }

        TextField {
            id: _Merchandise_
            objectName: "_Merchandise__"
            font.pixelSize: 10 * _Time_.height / 35

            placeholderText: qsTr("Empty")
            placeholderTextColor: Constants.textColorSecondary
            text: qsTr("")
            property bool isBold: false
            property real radius: 5
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.3
            Layout.row: 1
            Layout.column: 1
            background: Rectangle {
                anchors.fill: parent
                radius: 5
                border.color: "#3850ff"
            }
        }

        TextField {
            id: _Barcode_
            objectName: "_Barcode__"
            font.pixelSize: 10 * _Time_.height / 35

            placeholderText: qsTr("Empty")
            placeholderTextColor: Constants.textColorSecondary
            text: qsTr("")
            property bool isBold: false
            property real radius: 5
            Layout.preferredWidth: parent.width * 0.3
            Layout.fillHeight: true
            Layout.row: 3
            Layout.column: 1

            background: Rectangle {
                anchors.fill: parent
                radius: 5
                border.color: "#3850ff"
            }
        }

        TextField {
            id: _Time_
            objectName: "_Time__"
            font.pixelSize: 10 * _Time_.height / 35

            placeholderText: qsTr("Empty")
            placeholderTextColor: Constants.textColorSecondary
            text: qsTr("")

            property bool isBold: false
            property real radius: 5

            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.3
            Layout.row: 0
            Layout.column: 1

            background: Rectangle {
                anchors.fill: parent
                radius: 5
                border.color: "#3850ff"
            }
        }
        TextField {
            id: _Count_
            objectName: "_Count__"
            font.pixelSize: 10 * _Time_.height / 35
            verticalAlignment: Text.AlignVCenter

            placeholderText: qsTr("Empty")
            placeholderTextColor: Constants.textColorSecondary

            text: qsTr("")
            Layout.preferredWidth: parent.width * 0.3

            property bool isBold: false
            property real radius: 5
            Layout.fillHeight: true
            Layout.row: 1
            Layout.column: 5

            background: Rectangle {
                anchors.fill: parent
                radius: 5
                border.color: "#3850ff"
            }
        }
        TextField {
            id: _height_
            objectName: "_height__"
            font.pixelSize: 10 * _Time_.height / 35

            placeholderText: qsTr("Empty")
            placeholderTextColor: Constants.textColorSecondary
            text: qsTr("")
            Layout.preferredWidth: parent.width * 0.3

            property bool isBold: false
            property real radius: 5
            Layout.fillHeight: true
            Layout.row: 2
            Layout.column: 5

            readOnly: true
            background: Rectangle {
                anchors.fill: parent
                radius: 5
                border.color: "#3850ff"
            }
        }
        TextField {
            id: _width_
            objectName: "_width__"
            font.pixelSize: 10 * _Time_.height / 35

            placeholderText: qsTr("Empty")
            placeholderTextColor: Constants.textColorSecondary
            text: qsTr("")
            Layout.preferredWidth: parent.width * 0.3

            property bool isBold: false
            property real radius: 5
            Layout.fillHeight: true
            Layout.row: 3
            Layout.column: 5

            readOnly: true
            background: Rectangle {
                anchors.fill: parent
                radius: 5
                border.color: "#3850ff"
            }
        }
        TextField {
            id: _length_
            objectName: "_length__"
            font.pixelSize: 10 * _Time_.height / 35

            placeholderText: qsTr("Empty")
            placeholderTextColor: Constants.textColorSecondary
            text: qsTr("")
            Layout.preferredWidth: parent.width * 0.3

            readOnly: true
            property bool isBold: false
            property real radius: 5
            Layout.fillHeight: true
            Layout.row: 4
            Layout.column: 5

            background: Rectangle {
                anchors.fill: parent
                radius: 5
                border.color: "#3850ff"
            }
        }
        TextField {
            id: _pallet_type_
            objectName: "_pallet_type"
            font.pixelSize: 10 * _Time_.height / 35

            placeholderText: qsTr("Empty")
            placeholderTextColor: Constants.textColorSecondary
            text: qsTr("")
            Layout.preferredWidth: parent.width * 0.3

            readOnly: true
            property bool isBold: false
            property real radius: 5
            Layout.fillHeight: true
            Layout.row: 5
            Layout.column: 5

            background: Rectangle {
                anchors.fill: parent
                radius: 5
                border.color: "#3850ff"
            }
        }
    }
}

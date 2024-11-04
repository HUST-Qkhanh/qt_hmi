import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.2
import RosQML2

Item {
    id: grid_queue
    height: 300
    visible: true
    width: 600
    GridLayout {
        id: parent_queue
        anchors.fill: parent
        anchors.leftMargin: 5
        anchors.rightMargin: 5
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
            horizontalAlignment: Text.AlignLeft
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
            objectName: "_Id"
            font.pixelSize: 10 * _Time_.height / 35

            placeholderText: qsTr("Empty")
            placeholderTextColor: Constants.textColorSecondary

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
            objectName: "_PalletInfo"
            font.pixelSize: 10 * _Time_.height / 35

            placeholderText: qsTr("Empty")
            placeholderTextColor: Constants.textColorSecondary
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
            objectName: "_Merchandise"
            font.pixelSize: 10 * _Time_.height / 35

            placeholderText: qsTr("Empty")
            placeholderTextColor: Constants.textColorSecondary
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
            objectName: "_Barcode"
            font.pixelSize: 10 * _Time_.height / 35

            placeholderText: qsTr("Empty")
            placeholderTextColor: Constants.textColorSecondary

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
            objectName: "_Time"
            font.pixelSize: 10 * _Time_.height / 35

            placeholderText: qsTr("Empty")
            placeholderTextColor: Constants.textColorSecondary

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
            objectName: "_Count"
            font.pixelSize: 10 * _Time_.height / 35
            verticalAlignment: Text.AlignVCenter

            placeholderText: qsTr("Empty")
            placeholderTextColor: Constants.textColorSecondary
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
            objectName: "_height"
            font.pixelSize: 10 * _Time_.height / 35

            placeholderText: qsTr("Empty")
            placeholderTextColor: Constants.textColorSecondary
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
            objectName: "_width"
            font.pixelSize: 10 * _Time_.height / 35

            placeholderText: qsTr("Empty")
            placeholderTextColor: Constants.textColorSecondary
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
            objectName: "_length"
            font.pixelSize: 10 * _Time_.height / 35

            placeholderText: qsTr("Empty")
            placeholderTextColor: Constants.textColorSecondary
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



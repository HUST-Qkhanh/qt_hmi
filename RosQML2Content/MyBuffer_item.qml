import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.2

Item {
    id: buffer_item

    ColumnLayout {
        id: columnLayout
        x: 0
        y: 0
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        anchors.topMargin: 5
        anchors.bottomMargin: 5
        spacing: 15


        RowLayout {
            id: rowLayout
            width: 433
            height: 42
            Layout.rightMargin: 145
            Layout.fillWidth: true
            layoutDirection: Qt.LeftToRight
            spacing: 5
            Layout.maximumHeight: parent.height * 0.2
            // Layout.maximumWidth: parent.width * 0.45

            Text {
                text: qsTr("Merchandise :")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                clip: true
                Layout.fillWidth: true
                Layout.preferredWidth: parent.width * 0.15
                Layout.fillHeight: true
                font.pointSize: 15 * main_layout.height / 364
                font.bold: false
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.column: 4
                Layout.row: 0
            }

            TextField {
                id: _id_hang
                objectName: "___id_hang"
                font.pixelSize: 25 * _id_hang.height / 45
                Layout.preferredWidth: parent.width * 0.65
                Layout.fillHeight: true
                property bool isBold: false
                property real radius: 5
                Layout.column: 5
                Layout.row: 0
                placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }
            }
        }
        GridLayout {
            id: main_layout
            Layout.rightMargin: 50
            Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
            layoutDirection: Qt.LeftToRight
            Layout.fillWidth: true
            rows: 4
            columns: 6
            // Layout.maximumWidth: parent.width * 0.9
            Layout.maximumHeight: parent.height * 0.8
            Text {
                text: qsTr("Status :")
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                font.pointSize: 15 * main_layout.height / 364
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.bold: false
                Layout.column: 0
                Layout.row: 1
            }
            Text {
                text: qsTr("Position :")
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 15 * main_layout.height / 364
                Layout.preferredWidth: parent.width * 0.15
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.bold: false
                Layout.column: 2
                Layout.row: 1
            }
            Text {
                text: qsTr("Type :")
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 15 * main_layout.height / 364
                Layout.preferredWidth: parent.width * 0.15
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.bold: false
                Layout.column: 4
                Layout.row: 1
            }
            Text {
                text: qsTr("Height :")
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 15 * main_layout.height / 364
                Layout.preferredWidth: parent.width * 0.15
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.bold: false
                Layout.column: 0
                Layout.row: 2
            }
            Text {
                text: qsTr("Width :")
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 15 * main_layout.height / 364
                Layout.preferredWidth: parent.width * 0.15
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.bold: false
                Layout.column: 2
                Layout.row: 2
            }
            Text {
                text: qsTr("Length :")
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 15 * main_layout.height / 364
                Layout.preferredWidth: parent.width * 0.15
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.bold: false
                Layout.column: 4
                Layout.row: 2
            }
            Text {
                text: qsTr("Zone ID :")
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 15 * main_layout.height / 364
                Layout.preferredWidth: parent.width * 0.15
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.bold: false
                Layout.column: 0
                Layout.row: 3
            }
            Text {
                text: qsTr("Column ID :")
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 15 * main_layout.height / 364
                Layout.preferredWidth: parent.width * 0.15
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.bold: false
                Layout.column: 2
                Layout.row: 3
            }
            Text {
                text: qsTr("Location ID :")
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 15 * main_layout.height / 364
                Layout.preferredWidth: parent.width * 0.15
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.bold: false
                Layout.column: 4
                Layout.row: 3
            }
            TextField {
                id: _status
                objectName: "___status"
                font.pixelSize: 25 * _status.height / 45
                Layout.fillWidth: true
                Layout.preferredWidth: parent.width * 0.2
                Layout.fillHeight: true
                property bool isBold: false
                property real radius: 5
                Layout.column: 1
                Layout.row: 1
                placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }
            }
            TextField {
                id: _stt
                objectName: "___stt"
                font.pixelSize: 25 * _stt.height / 45
                Layout.fillWidth: true
                Layout.preferredWidth: parent.width * 0.2
                Layout.fillHeight: true
                property bool isBold: false
                property real radius: 5
                Layout.column: 3
                Layout.row: 1
                placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }
            }
            TextField {
                id: _type
                objectName: "___type"
                font.pixelSize: 25 * _type.height / 45
                Layout.fillWidth: true
                Layout.preferredWidth: parent.width * 0.2
                Layout.fillHeight: true
                property bool isBold: false
                property real radius: 5
                Layout.column: 5
                Layout.row: 1
                placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }
            }

            TextField {
                id: _height
                objectName: "___height"
                font.pixelSize: 25 * _height.height / 45
                Layout.fillWidth: true
                Layout.preferredWidth: parent.width * 0.2
                Layout.fillHeight: true
                property bool isBold: false
                property real radius: 5
                Layout.column: 1
                Layout.row: 2
                placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }
            }

            TextField {
                id: _width
                objectName: "___width"
                font.pixelSize: 25 * _width.height / 45
                Layout.fillWidth: true
                Layout.preferredWidth: parent.width * 0.2
                Layout.fillHeight: true
                property bool isBold: false
                property real radius: 5
                Layout.column: 3
                Layout.row: 2
                placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }
            }

            TextField {
                id: _length
                objectName: "___length"
                font.pixelSize: 25 * _length.height / 45
                Layout.fillWidth: true
                Layout.preferredWidth: parent.width * 0.2
                Layout.fillHeight: true
                property bool isBold: false
                property real radius: 5
                Layout.column: 5
                Layout.row: 2
                placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }
            }

            TextField {
                id: _zone_id
                objectName: "___zone_id"
                font.pixelSize: 25 * _zone_id.height / 45
                Layout.fillWidth: true
                Layout.preferredWidth: parent.width * 0.2
                Layout.fillHeight: true
                property bool isBold: false
                property real radius: 5
                Layout.column: 1
                Layout.row: 3
                placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }
            }

            TextField {
                id: _column_id
                objectName: "___column_id"
                font.pixelSize: 25 * _column_id.height / 45
                Layout.fillWidth: true
                Layout.preferredWidth: parent.width * 0.2
                Layout.fillHeight: true
                property bool isBold: false
                property real radius: 5
                Layout.column: 3
                Layout.row: 3
                placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }
            }

            TextField {
                id: _location_id
                objectName: "___location_id"
                font.pixelSize: 25 * _location_id.height / 45
                Layout.fillWidth: true

                onActiveFocusChanged: {
                    if (activeFocus) {
                        console.log("jomphere");
                        Qt.inputMethod.update(Qt.ImQueryInput);
                    }
                }
                Layout.preferredWidth: parent.width * 0.2
                Layout.fillHeight: true
                property bool isBold: false
                property real radius: 5
                Layout.column: 5
                Layout.row: 3
                placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }
            }
        }
    }
}

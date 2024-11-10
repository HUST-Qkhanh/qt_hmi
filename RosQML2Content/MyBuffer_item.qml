import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.2
import RosQML2

Item {
    id: buffer_item

    property alias _id: _stt.text

    property alias _zone: _zone_id.text
    property alias _column: _column_id.text
    property alias _location: _location_id.text

    property alias _palletStatus: _status.text
    property alias _merchandise: _id_hang.text
    property alias _palletType: _type.text

    property alias _palletHeight: _height.text
    property alias _palletWidth: _width.text
    property alias _palletLength: _length.text

    property string jsonBuffer: ''

    function clearTextFields() {
        _id = qsTr("");

        _zone = qsTr("");
        _column = qsTr("");
        _location = qsTr("");

        _palletStatus = qsTr("");
        _merchandise = qsTr("");
        _palletType = qsTr("");

        _palletHeight = qsTr("");
        _palletWidth = qsTr("");
        _palletLength = qsTr("");
    }

    function updateBufferPallet(jsonStr) {
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

    function addBufferPallet() {
        if (___id.text === "-----") {
            jsonObject = {
                "_id": ___id.text,
                "id": _id.text,
                "id_hang": _id_hang.text,
                "status": _status.text,
                "stt": _stt.text,
                "type": _type.text,
                "height": _height.text,
                "width": _width.text,
                "length": _length.text,
                "zone_id": _zone_id.text,
                "column_id": _column_id.text,
                "location_id": _location_id.text
            };
            backend.addDataBuffer(JSON.stringify(jsonObject, null, 2));
        } else {
            _headerLayoutText = " Mục đã tồn tại - hãy ấn sửa ";
        }
    }

    function deleteBufferPallet(queueId) {
        // body...
    }

    function saveBufferPallet(queueId) {
        // body...
    }

    Component.onCompleted: {
        clearTextFields();
    }

    Connections {
        target: backend
        onBufferJsonChanged: {
            var jsonBuffer = backend.fetchedBufferJson;
            console.log("Fetched buffer json:" + jsonBuffer);
            updateBufferPallet(jsonBuffer);
        }
    }

    Connections {
        target: userPopup
        onPopupLoaded: {
            clearTextFields();
        }
        // on:
    }

    RowLayout {
        id: rowLayout1
        anchors.fill: parent
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        anchors.topMargin: 5
        anchors.bottomMargin: 5
        spacing: 50

        GridLayout {
            id: main_layout
            rowSpacing: 5
            columnSpacing: 20
            Layout.rightMargin: 0
            layoutDirection: Qt.LeftToRight
            Layout.fillWidth: true
            rows: 3
            columns: 3
            Layout.maximumHeight: parent.height * 0.5
            // Text {
            //     visible: false
            //     text: qsTr("Status :")
            //     horizontalAlignment: Text.AlignLeft
            //     verticalAlignment: Text.AlignBottom
            //     font.styleName: "Regular"
            //     Layout.fillHeight: false
            //     Layout.fillWidth: true
            //     font.pointSize: 15 * main_layout.height / 364
            //     Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            //     font.bold: false
            //     Layout.column: 0
            //     Layout.row: 0
            // }
            // Text {
            //     visible: false
            //     text: qsTr("Type :")
            //     horizontalAlignment: Text.AlignLeft
            //     verticalAlignment: Text.AlignBottom
            //     font.styleName: "Regular"
            //     Layout.fillWidth: true
            //     font.pointSize: 15 * main_layout.height / 364
            //     Layout.fillHeight: false
            //     Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            //     font.bold: false
            //     Layout.column: 0
            //     Layout.row: 4
            // }
            // Text {
            //     visible: false
            //     text: qsTr("Height :")
            //     horizontalAlignment: Text.AlignLeft
            //     verticalAlignment: Text.AlignBottom
            //     font.styleName: "Regular"
            //     Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
            //     Layout.fillWidth: true
            //     font.pointSize: 15 * main_layout.height / 364
            //     Layout.fillHeight: false
            //     font.bold: false
            //     Layout.column: 1
            //     Layout.row: 0
            // }
            // Text {
            //     visible: false
            //     text: qsTr("Width :")
            //     horizontalAlignment: Text.AlignLeft
            //     verticalAlignment: Text.AlignBottom
            //     font.styleName: "Regular"
            //     Layout.fillWidth: true
            //     font.pointSize: 15 * main_layout.height / 364
            //     Layout.fillHeight: false
            //     Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            //     font.bold: false
            //     Layout.column: 1
            //     Layout.row: 2
            // }
            // Text {
            //     visible: false
            //     text: qsTr("Length :")
            //     horizontalAlignment: Text.AlignLeft
            //     verticalAlignment: Text.AlignBottom
            //     font.styleName: "Regular"
            //     Layout.fillWidth: true
            //     font.pointSize: 15 * main_layout.height / 364
            //     Layout.fillHeight: false
            //     Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            //     font.bold: false
            //     Layout.column: 1
            //     Layout.row: 4
            // }
            // Text {
            //     visible: false
            //     text: qsTr("Zone ID :")
            //     horizontalAlignment: Text.AlignLeft
            //     verticalAlignment: Text.AlignBottom
            //     font.styleName: "Regular"
            //     Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
            //     Layout.fillWidth: true
            //     font.pointSize: 15 * main_layout.height / 364
            //     Layout.fillHeight: false
            //     font.bold: false
            //     Layout.column: 2
            //     Layout.row: 0
            // }
            // Text {
            //     visible: false
            //     text: qsTr("Column ID :")
            //     horizontalAlignment: Text.AlignLeft
            //     verticalAlignment: Text.AlignBottom
            //     font.styleName: "Regular"
            //     Layout.fillWidth: true
            //     font.pointSize: 15 * main_layout.height / 364
            //     Layout.fillHeight: false
            //     Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            //     font.bold: false
            //     Layout.column: 2
            //     Layout.row: 2
            // }
            // Text {
            //     visible: false
            //     text: qsTr("Location ID :")
            //     horizontalAlignment: Text.AlignLeft
            //     verticalAlignment: Text.AlignBottom
            //     font.styleName: "Regular"
            //     Layout.fillWidth: true
            //     font.pointSize: 15 * main_layout.height / 364
            //     Layout.fillHeight: false
            //     Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            //     font.bold: false
            //     Layout.column: 2
            //     Layout.row: 4
            // }
            TextField {
                id: _status
                objectName: "___status"
                font.pixelSize: 25 * buffer_item.height / 600
                verticalAlignment: Text.AlignVCenter
                activeFocusOnPress: true
                cursorVisible: false
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                Layout.preferredWidth: 300 * parent.width / 1000
                Layout.preferredHeight: 90 * parent.height / 600
                property bool isBold: false
                property real radius: 5
                Layout.column: 0
                Layout.row: 0
                placeholderText: qsTr("Status")
                placeholderTextColor: Constants.textColorSecondary

                // background: Rectangle {
                //     anchors.fill: parent
                //     radius: 5
                //     border.color: "#3850ff"
                // }
            }
            TextField {
                id: _type
                objectName: "___type"
                font.pixelSize: 25 * buffer_item.height / 600
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                Layout.preferredWidth: 300 * parent.width / 1000
                Layout.preferredHeight: 90 * parent.height / 600
                property bool isBold: false
                property real radius: 5
                visible: true
                Layout.column: 0
                Layout.row: 2
                placeholderText: qsTr("Type")
                placeholderTextColor: Constants.textColorSecondary
                /* background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }*/
            }

            TextField {
                id: _height
                objectName: "___height"
                font.pixelSize: 25 * buffer_item.height / 600
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                Layout.preferredWidth: 300 * parent.width / 1000
                Layout.preferredHeight: 90 * parent.height / 600
                property bool isBold: false
                property real radius: 5
                placeholderText: qsTr("Height")
                placeholderTextColor: Constants.textColorSecondary
                visible: true
                Layout.column: 1
                Layout.row: 0

                // background: Rectangle {
                //     anchors.fill: parent
                //     radius: 5
                //     border.color: "#3850ff"
                // }
            }

            TextField {
                id: _width
                objectName: "___width"
                font.pixelSize: 25 * buffer_item.height / 600
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                Layout.preferredWidth: 300 * parent.width / 1000
                Layout.preferredHeight: 90 * parent.height / 600
                property bool isBold: false
                property real radius: 5
                visible: true
                Layout.column: 1
                Layout.row: 1
                placeholderText: qsTr("Width")
                placeholderTextColor: Constants.textColorSecondary
                /* background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }*/
            }

            TextField {
                id: _length
                objectName: "___length"
                font.pixelSize: 25 * buffer_item.height / 600
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                Layout.preferredWidth: 300 * parent.width / 1000
                Layout.preferredHeight: 90 * parent.height / 600
                property bool isBold: false
                property real radius: 5
                visible: true
                Layout.column: 1
                Layout.row: 2
                placeholderText: qsTr("Length")
                placeholderTextColor: Constants.textColorSecondary
                /* background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }*/
            }

            TextField {
                id: _zone_id
                objectName: "___zone_id"
                font.pixelSize: 25 * buffer_item.height / 600
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                Layout.preferredWidth: 300 * parent.width / 1000
                Layout.preferredHeight: 90 * parent.height / 600
                property bool isBold: false
                property real radius: 5
                visible: true
                Layout.column: 2
                Layout.row: 0
                placeholderText: qsTr("Zone ID")
                placeholderTextColor: Constants.textColorSecondary
                /* background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }*/
            }

            TextField {
                id: _column_id
                objectName: "___column_id"
                font.pixelSize: 25 * buffer_item.height / 600
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                Layout.preferredWidth: 300 * parent.width / 1000
                Layout.preferredHeight: 90 * parent.height / 600
                property bool isBold: false
                property real radius: 5
                visible: true
                Layout.column: 2
                Layout.row: 1
                placeholderText: qsTr("Column ID")
                placeholderTextColor: Constants.textColorSecondary
                /* background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }*/
            }

            TextField {
                id: _location_id
                objectName: "___location_id"
                font.pixelSize: 25 * buffer_item.height / 600
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                Layout.preferredWidth: 300 * parent.width / 1000
                Layout.preferredHeight: 90 * parent.height / 600

                onActiveFocusChanged: {
                    if (activeFocus) {
                        console.log("jomphere");
                        Qt.inputMethod.update(Qt.ImQueryInput);
                    }
                }

                property bool isBold: false
                property real radius: 5
                visible: true
                Layout.column: 2
                Layout.row: 2
                placeholderText: qsTr("Location ID")
                placeholderTextColor: Constants.textColorSecondary
                /* background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }*/
            }

            // Text {
            //     visible: false
            //     text: qsTr("Merchandise :")
            //     horizontalAlignment: Text.AlignLeft
            //     verticalAlignment: Text.AlignBottom
            //     font.styleName: "Regular"
            //     clip: true
            //     Layout.fillWidth: true
            //     Layout.preferredWidth: parent.width * 0.15
            //     Layout.fillHeight: false
            //     font.pointSize: 15 * main_layout.height / 364
            //     font.bold: false
            //     Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            //     Layout.column: 0
            //     Layout.row: 2
            // }

            TextField {
                id: _id_hang
                objectName: "___id_hang"
                font.pixelSize: 25 * buffer_item.height / 600
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                Layout.preferredWidth: 300 * parent.width / 1000
                Layout.preferredHeight: 90 * parent.height / 600
                property bool isBold: false
                property real radius: 5
                visible: true
                Layout.column: 0
                Layout.row: 1
                placeholderText: qsTr("Merchandise")
                placeholderTextColor: Constants.textColorSecondary
                /* background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    border.color: "#3850ff"
                }*/
            }
        }

        ColumnLayout {
            id: columnLayout1
            width: 100
            height: 100
            clip: true
            // Layout.fillWidth: true
            Layout.preferredWidth: parent.width * 0.3
            Layout.maximumHeight: parent.height * 0.8
            Image {
                id: pallet1
                source: "asset/pallet (1).png"
                sourceSize.height: 300
                sourceSize.width: 300
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                Layout.fillHeight: true
                Layout.fillWidth: true
                fillMode: Image.PreserveAspectFit
            }

            ColumnLayout {
                id: columnLayout
                Layout.bottomMargin: 5
                // Layout.maximumWidth: parent.width * 0.5
                // Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                Layout.preferredHeight: parent.height * 0.2
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                Layout.maximumWidth: parent.width * 0.5

                // Text {
                //     visible: false
                //     text: qsTr("Position :")
                //     horizontalAlignment: Text.AlignLeft
                //     verticalAlignment: Text.AlignBottom
                //     Layout.fillWidth: true
                //     font.pointSize: 15 * main_layout.height / 364
                //     Layout.fillHeight: false
                //     Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                //     font.bold: false
                //     Layout.column: 0
                //     Layout.row: 2
                // }

                TextField {
                    id: _stt
                    objectName: "___stt"
                    font.pixelSize: 25 * buffer_item.height / 600
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true
                    Layout.preferredWidth: parent.width * 0.2
                    Layout.preferredHeight: _status.height
                    property bool isBold: false
                    property real radius: 5
                    visible: true
                    placeholderText: qsTr("Position")
                    placeholderTextColor: Constants.textColorSecondary
                    // background: Rectangle {
                    //     anchors.fill: parent
                    //     radius: 5
                    //     border.color: "#3850ff"
                    // }
                }
            }
        }
    }
}

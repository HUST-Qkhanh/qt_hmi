import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.2
import RosQML2

Item {
    id: buffer_item

    property alias _id: _stt.text
    property alias _count1: _count.text
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

    function hasEmptyField() {
        return _id === "" || _zone === "" || _column === "" || _location === "" || _palletStatus === "" || _merchandise === "" || _palletType === "" || _palletHeight === "" || _palletWidth === "" || _palletLength === "";
    }

    function updateBufferPallet(jsonStr) {
        var jsonObj = JSON.parse(jsonStr); // Parse the JSON string into a JavaScript object

        // Update the text fields with parsed data
        _id = jsonObj.id.toString() || "";
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
        confirmShow.info_text = qsTr("Can not add new buffer zone");
        confirmShow.header_type = 3;
        statusIndicate.open();
    }

    function deleteBufferPallet() {
        if (_id !== "") {
            backend.deleteDataBuffer(_id);
        } else {
            confirmShow.info_text = qsTr("Position field is empty");
            confirmShow.header_type = 3;
            statusIndicate.open();
        }
    }

    function saveBufferPallet(queueId) {
        if (!hasEmptyField()) {
            var jsonObject = {
                "id": _id,
                "zone_id": _zone,
                "column_id": _column,
                "location_id": _location,
                "status": _palletStatus,
                "id_hang": _merchandise,
                "type": _palletType,
                "height": _palletHeight,
                "width": _palletWidth,
                "length": _palletLength,
                "Count": _count1
            };
            backend.saveDataBuffer(JSON.stringify(jsonObject, null, 2));
        } else {
            console.log("Error save to queue");
            console.log("Please input required fields");
            confirmShow.info_text = qsTr("Please input required fields");
            confirmShow.header_type = 3;
            statusIndicate.open();
        }
    }

    function getBufferPallet() {
        var jsonBuffer = backend.fetchedBufferJson;
        console.log("Fetched buffer json:" + jsonBuffer);
        updateBufferPallet(jsonBuffer);
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
        getBufferPallet();
    }

    Connections {
        target: backend
        onBufferJsonChanged: {
            getBufferPallet();
        }
        onBufferJsonDeleted: {
            confirmShow.info_text = qsTr("Removed from buffer");
            confirmShow.header_type = 4;
            statusIndicate.open();
        }
        onBufferJsonEdited: {
            confirmShow.info_text = qsTr("Saved buffer successfully");
            confirmShow.header_type = 4;
            statusIndicate.open();
        }
    }

    Connections {
        target: userPopup
        onPopupLoaded: {
            clearTextFields();
        }
        onAddDataRequest: {
            console.log("queue get add request");
            addBufferPallet();
        }
        onSaveDataRequest: {
            console.log("buffer get save request");
            saveBufferPallet();
        }
        onDeleteDataRequest: {
            console.log("buffer get remove request");
            deleteBufferPallet();
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        propagateComposedEvents: false
        preventStealing: true
        onClicked: {
            console.log("out: ");

            _status.focus = false;
            _type.focus = false;
            _count.focus = false;
            _height.focus = false;
            _width.focus = false;
            _length.focus = false;
            _zone_id.focus = false;
            _column_id.focus = false;
            _location_id.focus = false;
            _id_hang.focus = false;

            flickable.interactive = false;
            flickable.clip = false;
            flickable.contentY = 0;
            Qt.inputMethod.hide()
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
                text: qsTr("Pallet Buffer")
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

        ColumnLayout {
            id: columnLayout1
            anchors.left: flickable.right
            anchors.right: parent.right
            anchors.top: flickable.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 6
            anchors.rightMargin: 6
            anchors.topMargin: 0
            anchors.bottomMargin: 25
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

            TextField {
                id: _stt
                objectName: "___stt"
                font.pixelSize: 25 * buffer_item.height / 600
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.preferredHeight: _status.height
                Layout.preferredWidth: _status.width
                property bool isBold: false
                property real radius: 5
                visible: true
                placeholderText: qsTr("Position")
                placeholderTextColor: Constants.textColorSecondary
                // onFocusChanged: if (focus) {
                //                     flickable.interactive = true;
                //                     flickable.clip = true;
                //                     flickable.contentY = Math.max(0, y - 20);
                //                 }
            }
        }

        Flickable {
            id: flickable
            x: 6
            y: 187
            anchors.left: parent.left
            anchors.top: rectangle.bottom
            anchors.leftMargin: 6
            anchors.topMargin: 25
            interactive: false
            flickableDirection: Flickable.VerticalFlick
            bottomMargin: 0
            topMargin: 0
            rightMargin: 10
            leftMargin: 10
            width: main_layout.width + 20
            height: Qt.inputMethod.visible ? 0.5 * main_layout.height : main_layout.height
            contentHeight: main_layout.height
            contentWidth: main_layout.width
            ScrollBar.vertical: ScrollBar {}

            GridLayout {
                id: main_layout
                x: flickable.x
                y: 0
                width: 0.6 * buffer_item.width
                height: 0.6 * buffer_item.height
                layoutDirection: Qt.LeftToRight
                TextField {
                    id: _status
                    objectName: "___status"
                    font.pixelSize: 25 * buffer_item.height / 600
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    activeFocusOnPress: true
                    cursorVisible: false
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true
                    Layout.preferredWidth: 300 * grid_queue.width / 1000
                    Layout.preferredHeight: 50 * grid_queue.height / 600
                    property bool isBold: false
                    property real radius: 5
                    Layout.column: 0
                    Layout.row: 0
                    placeholderText: qsTr("Status")
                    placeholderTextColor: Constants.textColorSecondary
                    inputMethodHints: Qt.ImhPreferLowercase

                    onFocusChanged: if (focus) {
                                        flickable.interactive = true;
                                        flickable.clip = true;
                                        flickable.contentY = Math.max(0, y - 20);
                                    }
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
                    Layout.preferredWidth: 300 * grid_queue.width / 1000
                    Layout.preferredHeight: 50 * grid_queue.height / 600
                    property bool isBold: false
                    property real radius: 5
                    visible: true
                    Layout.column: 0
                    Layout.row: 3
                    placeholderText: qsTr("Pallet Type")
                    placeholderTextColor: Constants.textColorSecondary
                    inputMethodHints: Qt.ImhDigitsOnly
                    onFocusChanged: if (focus) {
                                        flickable.interactive = true;
                                        flickable.clip = true;
                                        flickable.contentY = Math.max(0, y - 20);
                                    }
                }

                // TextField {
                //     id: _palletInfo
                //     objectName: "___palletInfo"
                //     font.pixelSize: 25 * buffer_item.height / 600
                //     verticalAlignment: Text.AlignVCenter
                //     activeFocusOnPress: true
                //     cursorVisible: false
                //     Layout.fillHeight: true
                //     Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                //     Layout.fillWidth: true
                //     Layout.preferredWidth: 300 * parent.width / 1000
                //     Layout.preferredHeight: 90 * parent.height / 600
                //     property bool isBold: false
                //     property real radius: 5
                //     Layout.column: 0
                //     Layout.row: 3
                //     placeholderText: qsTr("Pallet info")
                //     placeholderTextColor: Constants.textColorSecondary

                //     // background: Rectangle {
                //     //     anchors.fill: parent
                //     //     radius: 5
                //     //     border.color: "#3850ff"
                //     // }
                // }
                TextField {
                    id: _count
                    objectName: "___Count"
                    font.pixelSize: 25 * buffer_item.height / 600
                    verticalAlignment: Text.AlignVCenter
                    activeFocusOnPress: true
                    cursorVisible: false
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true
                    Layout.preferredWidth: 300 * grid_queue.width / 1000
                    Layout.preferredHeight: 50 * grid_queue.height / 600
                    property bool isBold: false
                    property real radius: 5
                    Layout.column: 0
                    Layout.row: 2
                    placeholderText: qsTr("Count")
                    placeholderTextColor: Constants.textColorSecondary
                    inputMethodHints: Qt.ImhDigitsOnly
                    onFocusChanged: if (focus) {
                                        flickable.interactive = true;
                                        flickable.clip = true;
                                        flickable.contentY = Math.max(0, y - 20);
                                    }
                }

                TextField {
                    id: _height
                    objectName: "___height"
                    font.pixelSize: 25 * buffer_item.height / 600
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true
                    Layout.preferredWidth: 300 * grid_queue.width / 1000
                    Layout.preferredHeight: 50 * grid_queue.height / 600
                    property bool isBold: false
                    property real radius: 5
                    placeholderText: qsTr("Height")
                    placeholderTextColor: Constants.textColorSecondary
                    visible: true
                    Layout.column: 1
                    Layout.row: 1
                    inputMethodHints: Qt.ImhDigitsOnly
                    onFocusChanged: if (focus) {
                                        flickable.interactive = true;
                                        flickable.clip = true;
                                        flickable.contentY = Math.max(0, y - 20);
                                    }
                }

                TextField {
                    id: _width
                    objectName: "___width"
                    font.pixelSize: 25 * buffer_item.height / 600
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true
                    Layout.preferredWidth: 300 * grid_queue.width / 1000
                    Layout.preferredHeight: 50 * grid_queue.height / 600
                    property bool isBold: false
                    property real radius: 5
                    visible: true
                    Layout.column: 1
                    Layout.row: 2
                    placeholderText: qsTr("Width")
                    placeholderTextColor: Constants.textColorSecondary
                    inputMethodHints: Qt.ImhDigitsOnly
                    onFocusChanged: if (focus) {
                                        flickable.interactive = true;
                                        flickable.clip = true;
                                        flickable.contentY = Math.max(0, y - 20);
                                    }
                }

                TextField {
                    id: _length
                    objectName: "___length"
                    font.pixelSize: 25 * buffer_item.height / 600
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true
                    Layout.preferredWidth: 300 * grid_queue.width / 1000
                    Layout.preferredHeight: 50 * grid_queue.height / 600
                    property bool isBold: false
                    property real radius: 5
                    visible: true
                    Layout.column: 1
                    Layout.row: 3
                    placeholderText: qsTr("Length")
                    placeholderTextColor: Constants.textColorSecondary
                    inputMethodHints: Qt.ImhDigitsOnly
                    onFocusChanged: if (focus) {
                                        flickable.interactive = true;
                                        flickable.clip = true;
                                        flickable.contentY = Math.max(0, y - 20);
                                    }
                }

                TextField {
                    id: _zone_id
                    objectName: "___zone_id"
                    font.pixelSize: 25 * buffer_item.height / 600
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true
                    Layout.preferredWidth: 300 * grid_queue.width / 1000
                    Layout.preferredHeight: 50 * grid_queue.height / 600
                    property bool isBold: false
                    property real radius: 5
                    visible: true
                    Layout.column: 2
                    Layout.row: 1
                    placeholderText: qsTr("Zone ID")
                    placeholderTextColor: Constants.textColorSecondary
                    inputMethodHints: Qt.ImhDigitsOnly
                    onFocusChanged: if (focus) {
                                        flickable.interactive = true;
                                        flickable.clip = true;
                                        flickable.contentY = Math.max(0, y - 20);
                                    }
                }

                TextField {
                    id: _column_id
                    objectName: "___column_id"
                    font.pixelSize: 25 * buffer_item.height / 600
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true
                    Layout.preferredWidth: 300 * grid_queue.width / 1000
                    Layout.preferredHeight: 50 * grid_queue.height / 600
                    property bool isBold: false
                    property real radius: 5
                    visible: true
                    Layout.column: 2
                    Layout.row: 2
                    placeholderText: qsTr("Column ID")
                    placeholderTextColor: Constants.textColorSecondary
                    inputMethodHints: Qt.ImhDigitsOnly
                    onFocusChanged: if (focus) {
                                        flickable.interactive = true;
                                        flickable.clip = true;
                                        flickable.contentY = Math.max(0, y - 20);
                                    }
                }

                TextField {
                    id: _location_id
                    objectName: "___location_id"
                    font.pixelSize: 25 * buffer_item.height / 600
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true
                    Layout.preferredWidth: 300 * grid_queue.width / 1000
                    Layout.preferredHeight: 50 * grid_queue.height / 600
                    inputMethodHints: Qt.ImhDigitsOnly
                    onFocusChanged: if (focus) {
                                        flickable.interactive = true;
                                        flickable.clip = true;
                                        flickable.contentY = Math.max(0, y - 20);
                                    }
                    property bool isBold: false
                    property real radius: 5
                    visible: true
                    Layout.column: 2
                    Layout.row: 3
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
                    Layout.preferredWidth: 300 * grid_queue.width / 1000
                    Layout.preferredHeight: 50 * grid_queue.height / 600
                    property bool isBold: false
                    property real radius: 5
                    visible: true
                    Layout.column: 0
                    Layout.row: 1
                    placeholderText: qsTr("Merchandise")
                    placeholderTextColor: Constants.textColorSecondary
                    onFocusChanged: if (focus) {
                                        flickable.interactive = true;
                                        flickable.clip = true;
                                        flickable.contentY = Math.max(0, y - 20);
                                    }
                }
            }
        }
    }
}

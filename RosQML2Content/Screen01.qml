/*
This is a UI file (.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .qml files.
*/
import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.2
import QtQuick.VirtualKeyboard 6.7
import RosQML2

// import QtQuick.VirtualKeyboard.Components 6.7
// import backendqt 1.0
Page {
    id: page1
    visible: true

    // color: "#FAFAFA"
    property double batteryPercentage: 0
    property double batteryVoltage: 0
    property double batteryCurrent: 0
    property int popup_mode: 0
    property string state_system: ""
    property string status_system: ""
    property string reset_mode: "RESET"
    property string homing_mode: "HOMING"
    property string stop_mode: "STOP"
    property string control_mode: "RUNNING"
    property string mode_mode: "MANUAL"
    property string status_mode: "INITIATING"
    property string state_mute: "qrc:/RosQML2Content/asset/sound.svg"
    property double vel_linear: 0
    property double vel_angular: 0
    property int volume_current: 80
    property int volume_: 80
    property string ip_agf: ""
    property string ready_icon_source: "qrc:/RosQML2Content/asset/svg.svg"
    property string color_state: ""
    property bool state_panel_edit: false
    property bool state_panel_queue: false
    property bool popup_confirm_visible: true
    property int state_edit: 0 // 0 -> buffer | 1 -> queue
    property int width_current: 100
    property string header_layout_text: "Trạng thái"
    property string model_data: ""
    property string count_data: ""
    property int item_count: loadConfig()

    signal queuePalletRequest(int queueId)
    signal bufferPalletRequest(int bufferId)
    
    signal loadPopupType(int type)

    // property var model_pallet_: getListModel()
    // property var count_pallet: []
    // Khi cần khôi phục cấu hình
    function loadConfig() {
        var config = configManager.loadConfig("config.json");
        if (config.item_count !== undefined) {
            item_count = config.item_count;
        }
        return item_count;
    }
    function saveConfig(value_) {
        var config = {
            "item_count": value_
        };
        configManager.saveConfig(config, "config.json");
    }

    // function getListCount() {
    //     backend.getDataComboBox2();
    //     var item = backend.getListCount();
    //     return item;
    // }
    // function getListModel() {
    //     backend.getDataComboBox();
    //     var item = backend.getListModel();
    //     return item;
    // }

    function popup_close() {
        header_layout_text = "Trạng thái";
        pop_up_2.close();
        backend.set_color();
    }
    // Component.onCompleted: loadConfig()

    // onClosing: {
    //         saveConfig()
    //     }
    Popup {
        id: popup
        // x: page1.width * 0.15
        // y: page1.height * 0.1
        anchors.centerIn: parent
        width: page1.width * 0.7
        height: page1.height * 0.8
        visible: false
        dim: true
        font.italic: true
        font.pointSize: 50
        font.family: "Ubuntu"
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        background: Rectangle {
            color: "#F0F8FF"
            radius: 20
            border.color: "#F0F8FF"
            border.width: 1
        }
        enter: Transition {
            ParallelAnimation {
                NumberAnimation {
                    properties: "opacity"
                    from: 0
                    to: 1
                    duration: 64
                }
                NumberAnimation {
                    properties: "scale"
                    from: 0.75
                    to: 1
                    duration: 64
                }
            }
        }
        exit: Transition {
            ParallelAnimation {
                NumberAnimation {
                    properties: "opacity"
                    from: 1
                    to: 0
                    duration: 64
                }
                NumberAnimation {
                    properties: "scale"
                    from: 1
                    to: 0.75
                    duration: 64
                }
            }
        }
        Text {
            id: status_popup
            text: qsTr("Loading...")
            height: popup.height * 0.6
            anchors.top: header_popup.bottom
            anchors.left: popup.left
            anchors.right: popup.right
            anchors.rightMargin: 50
            anchors.leftMargin: 50
            anchors.topMargin: 10
            font.pixelSize: 45 * popup.width / 884
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.italic: true
        }
        Text {
            id: header_popup
            text: qsTr("Message")
            height: popup.height * 0.2
            anchors.top: popup.top
            anchors.left: popup.left
            anchors.right: popup.right
            anchors.rightMargin: 20
            font.pixelSize: 45 * popup.width / 884
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.italic: true
        }
        Button {
            id: confirm_button_popup
            text: qsTr("Confirm")
            width: popup.width * 0.25
            anchors.top: status_popup.bottom
            anchors.bottom: parent.bottom
            anchors.right: close_button_popup.left
            anchors.rightMargin: 25
            anchors.leftMargin: 25
            anchors.topMargin: 0
            anchors.bottomMargin: 10
            visible: popup_confirm_visible
            font.pixelSize: 40 * popup.width / 884
            background: Rectangle {
                color: "white"
                radius: 15
                border.color: "blue"
                border.width: 2
            }
            onClicked: {
                if (popup_mode === 1) {
                    if (mode_mode === "MANUAL") {
                        // mode_mode ="AUTO"
                        backend.requestMode("AUTO");
                    } else if (mode_mode === "AUTO") {
                        // mode_mode =  "MANUAL"
                        backend.requestMode("MANUAL");
                    }
                } else if (popup_mode === 0) {
                    confirm_button_popup.text = qsTr("Reset");
                    backend.resetError();
                } else if (popup_mode === 2) {
                    confirm_button_popup.text = qsTr("Reset");
                    backend.requestReset("request_reset");
                }

                popup.close();
            }
        }
        Button {
            id: close_button_popup
            text: qsTr("Close")
            width: popup.width * 0.25
            anchors.top: status_popup.bottom
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: 25
            anchors.leftMargin: 25
            anchors.topMargin: 0
            anchors.bottomMargin: 10

            font.pixelSize: 40 * popup.width / 884
            background: Rectangle {
                color: "white"
                radius: 15
                border.color: "red"
                border.width: 2
            }
            onClicked: popup.close()
        }
    }

    Popup {
        id: pop_up_2
        // x: 0
        // y: -page1.height * 0.08
        anchors.centerIn: parent
        width: page1.width * 0.9
        height: page1.height * 0.65
        opacity: 1
        visible: false
        modal: true
        dim: true
        closePolicy: Popup.NoAutoClose
        // closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        background: Rectangle {
            color: "#ddffffff"
            border.color: "#db000000"
            border.width: 5  // Đặt nền trong suốt
            radius: 5
        }

        MyUserPopup {
            id: myUserPopup
            anchors.fill: parent
            state: page1.state_edit
        }
    }

    Page {
        id: down_panel
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: (parent.height) * 0.45
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0

        Button {
            id: header
            height: page1.height * 0.1
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            anchors.topMargin: 10
            background: Rectangle {

                color: "#90CAF9"
                radius: 25 * header.height / 94
            }

            Text {
                id: status_header
                text: qsTr("Initializing")
                anchors.fill: parent
                font.pixelSize: 30 * parent.height / 48
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.italic: true
            }
        }

        ColumnLayout {
            id: may_cuon_phim
            width: parent.width * 0.075
            Rectangle {
                anchors.fill: parent
                color: "#F9A825"
                radius: 30 * parent.width / 100
                border.width: 1
            }
            anchors.left: parent.left
            anchors.top: header.bottom
            anchors.bottom: parent.bottom
            anchors.leftMargin: 15
            anchors.rightMargin: 15
            anchors.topMargin: 75 * down_panel.height / 445
            anchors.bottomMargin: 75 * down_panel.height / 445
            Text {
                text: qsTr("Máy") + '\n' + qsTr("cuốn") + '\n' + qsTr("phim")
                anchors.fill: parent
                font.pixelSize: 40 * parent.width / 125
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.italic: false
            }
        }

        RowLayout {
            id: bang_tai
            anchors.left: may_cuon_phim.right
            anchors.right: parent.right
            anchors.top: header.bottom
            anchors.bottom: parent.bottom
            anchors.leftMargin: 15
            anchors.rightMargin: 15
            anchors.topMargin: 78 * down_panel.height / 445
            anchors.bottomMargin: 78 * down_panel.height / 445
            spacing: 0
            layoutDirection: Qt.LeftToRight

            Rectangle {
                Layout.preferredWidth: parent.width * 0.4
                Layout.preferredHeight: parent.height
                color: "#64B5F6"
                border.color: "#607D8B"
                border.width: 2
                Layout.fillHeight: false
                Layout.fillWidth: true
                Text {
                    anchors.fill: parent
                    text: "Băng tải chủ động"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignBottom
                    font.pointSize: 20
                }
            }
        }

        RowLayout {
            id: bang_tai_
            anchors.fill: bang_tai
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            spacing: 2

            layoutDirection: Qt.RightToLeft

            // Rectangle {
            //     color: "#ae0808"
            //     anchors.fill: parent

            // }

            Button {
                id: palet_1

                text: qsTr("1")
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                font.bold: true
                font.pointSize: 30 * parent.height / 155

                background: Rectangle {
                    objectName: "zone_1_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    queuePalletRequest(1);
                }
            }
            Button {
                id: palet_2

                text: qsTr("2")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                font.bold: true
                font.pointSize: 30 * parent.height / 155

                background: Rectangle {
                    objectName: "zone_2_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    queuePalletRequest(2);
                }
            }
            Button {
                id: palet_3

                text: qsTr("3")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                font.bold: true
                font.pointSize: 30 * parent.height / 155

                background: Rectangle {
                    objectName: "zone_3_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    queuePalletRequest(3);
                }
            }
            Button {
                id: palet_4
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                text: qsTr("4")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                font.bold: true
                font.pointSize: 30 * parent.height / 155

                background: Rectangle {
                    objectName: "zone_4_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    queuePalletRequest(4);
                }
            }
            Button {
                id: palet_5

                text: qsTr("5")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                font.bold: true
                font.pointSize: 30 * parent.height / 155

                background: Rectangle {
                    objectName: "zone_5_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    queuePalletRequest(5);
                }
            }
            Button {
                id: palet_6

                text: qsTr("6")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                font.bold: true
                font.pointSize: 30 * parent.height / 155
                visible: true
                background: Rectangle {
                    objectName: "zone_6_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    queuePalletRequest(6);
                }
            }
            Button {
                id: palet_7

                text: qsTr("7")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                visible: true

                font.bold: true
                font.pointSize: 30 * parent.height / 155

                background: Rectangle {
                    objectName: "zone_7_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    queuePalletRequest(7);
                }
            }
            Button {
                id: palet_8
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                text: qsTr("8")

                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                font.bold: true
                font.pointSize: 30 * parent.height / 155

                background: Rectangle {
                    objectName: "zone_8_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    queuePalletRequest(8);
                }
            }
            Button {
                id: palet_9
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                text: qsTr("9")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                visible: item_count > 8
                font.bold: true
                font.pointSize: 30 * parent.height / 155

                background: Rectangle {
                    objectName: "zone_9_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    queuePalletRequest(9);
                }
            }

            Button {
                id: palet_10
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                text: qsTr("10")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                font.bold: true
                font.pointSize: 30 * parent.height / 155
                visible: item_count > 9
                background: Rectangle {
                    objectName: "zone_10_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    queuePalletRequest(10);
                }
            }

            Button {
                id: palet_11
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                text: qsTr("11")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.bold: true
                font.pointSize: 30 * parent.height / 155
                visible: item_count > 10
                background: Rectangle {
                    objectName: "zone_11_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    queuePalletRequest(11);
                }
            }

            Button {
                id: palet_12
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                text: qsTr("12")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                visible: item_count > 11

                font.bold: true
                font.pointSize: 30 * parent.height / 155

                background: Rectangle {
                    objectName: "zone_12_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    queuePalletRequest(12);
                }
            }

            Button {
                id: palet_13
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                text: qsTr("13")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.bold: true
                font.pointSize: 30 * parent.height / 155
                visible: item_count > 12
                background: Rectangle {
                    objectName: "zone_13_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    queuePalletRequest(13);
                }
            }
            Button {
                id: palet_14
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                text: qsTr("14")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                visible: item_count > 13
                font.bold: true
                font.pointSize: 30 * parent.height / 155
                background: Rectangle {
                    objectName: "zone_14_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    queuePalletRequest(14);
                }
            }
            Button {
                id: palet_15
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                text: qsTr("15")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                visible: item_count > 14
                font.bold: true
                font.pointSize: 30 * parent.height / 155
                background: Rectangle {
                    objectName: "zone_14_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    queuePalletRequest(15);
                }
            }
        }
        // Image {
        //     id: ready_icon
        //     x: palet_1.x + palet_1.width * 0.25
        //     y: palet_1.y - palet_1.width * 0.75
        //     source: ready_icon_source
        //     rotation: -180
        //     fillMode: Image.PreserveAspectFit
        //     visible: true
        //     height: palet_1.height * 0.5
        //     width: height
        // }
    }

    Page {
        id: up_panel
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: down_panel.bottom
        anchors.bottom: parent.bottom

        RowLayout {
            id: waiting
            height: waiting.width / 6.5
            width: parent.width * 0.45
            anchors.left: parent.left
            anchors.top: parent.top

            anchors.leftMargin: 20
            anchors.topMargin: 25
            // anchors.rightMargin: 230
            spacing: 10

            Rectangle {
                id: none
                anchors.fill: parent
                Text {
                    text: qsTr("Hàng ") + qsTr("chờ")
                    anchors.bottom: parent.top
                    anchors.left: parent.left
                    font.pixelSize: 40 * parent.width / 800
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.italic: false
                }
            }
            Button {

                text: qsTr("1")

                Layout.fillHeight: true
                Layout.preferredWidth: waiting.height
                font.bold: true
                font.pointSize: 40 * parent.height / 150

                background: Rectangle {
                    objectName: "zone_1"
                    color: "#CFD8DC"
                }
                onClicked: {
                    bufferPalletRequest(1);
                }
            }

            Button {

                text: qsTr("2")
                Layout.fillHeight: true
                Layout.preferredWidth: waiting.height
                font.bold: true
                font.pointSize: 40 * parent.height / 150

                background: Rectangle {
                    objectName: "zone_2"
                    color: "#CFD8DC"
                }
                onClicked: {
                    bufferPalletRequest(2);
                }
            }
            Button {

                text: qsTr("3")

                Layout.fillHeight: true
                Layout.preferredWidth: waiting.height
                font.bold: true
                font.pointSize: 40 * parent.height / 150

                background: Rectangle {
                    objectName: "zone_3"
                    color: "#CFD8DC"
                }
                onClicked: {
                    bufferPalletRequest(3);
                }
            }
            Button {

                text: qsTr("4")

                Layout.fillHeight: true
                Layout.preferredWidth: waiting.height
                font.bold: true
                font.pointSize: 40 * parent.height / 150

                background: Rectangle {
                    objectName: "zone_4"
                    color: "#CFD8DC"
                }
                onClicked: {
                    bufferPalletRequest(4);
                }
            }

            Button {

                text: qsTr("5")

                Layout.fillHeight: true
                Layout.preferredWidth: waiting.height
                font.bold: true
                font.pointSize: 40 * parent.height / 150

                background: Rectangle {
                    objectName: "zone_5"
                    color: "#CFD8DC"
                }
                onClicked: {
                    bufferPalletRequest(5);
                }
            }

            Button {

                text: qsTr("6")

                Layout.fillHeight: true
                Layout.preferredWidth: waiting.height
                font.bold: true
                font.pointSize: 40 * parent.height / 150

                background: Rectangle {
                    objectName: "zone_6"
                    color: "#CFD8DC"
                }
                onClicked: {
                    bufferPalletRequest(6);
                }
            }
        }
        GridLayout {
            id: note

            // anchors.right: parent.right
            anchors.left: parent.left
            anchors.right: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            // anchors.bottom: waiting.bottom
            anchors.leftMargin: 20
            anchors.rightMargin: -300
            anchors.topMargin: 100
            anchors.bottomMargin: 20
            // anchors.bottomMargin: 0
            ColumnLayout {
                id: layout_note_1
                Layout.preferredWidth: 50
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                spacing: 5
                Rectangle {
                    color: "#CFD8DC"
                    Layout.preferredWidth: 50
                    Layout.fillHeight: true
                }
                Rectangle {
                    color: "#FFEB3B"
                    Layout.preferredWidth: 50
                    Layout.fillHeight: true
                }
                Rectangle {
                    color: "#FF9800"
                    Layout.preferredWidth: 50
                    Layout.fillHeight: true
                }
                Rectangle {
                    color: "#4CAF50"
                    Layout.preferredWidth: 50
                    Layout.fillHeight: true
                }
                Rectangle {
                    color: "#2196F3"
                    Layout.preferredWidth: 50
                    Layout.fillHeight: true
                }
            }
            ColumnLayout {
                id: layout_note_2
                anchors.left: layout_note_1.right
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 0
                // anchors.rightMargin: -150
                anchors.topMargin: 0
                anchors.bottomMargin: 0
                spacing: 5
                Text {
                    Layout.preferredHeight: 50
                    text: "Trống "
                    font.pixelSize: 35 * up_panel.height / 588
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                Text {

                    Layout.preferredHeight: 50
                    text: "Pallet thấp"
                    font.pixelSize: 35 * up_panel.height / 588
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                Text {

                    Layout.preferredHeight: 50
                    text: "Pallet cao"
                    font.pixelSize: 35 * up_panel.height / 588
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                Text {

                    Layout.preferredHeight: 50
                    text: "Pallet kép"
                    font.pixelSize: 35 * up_panel.height / 588
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                Text {

                    Layout.preferredHeight: 50
                    text: "Pallet đơn"
                    font.pixelSize: 35 * up_panel.height / 588
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
            }
        }

        Slider {
            id: slider

            width: parent.width * 0.2
            height: parent.height * 0.1
            value: item_count
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 20
            anchors.bottomMargin: 10
            live: true
            stepSize: 1
            to: 15
            from: 8
            onValueChanged: {
                item_count = value;
                width_current = 140 - (value - 8) * 7;
                saveConfig(value);
            }
        }
    }

    ColumnLayout {
        width: parent.width * 0.15
        height: parent.height * 0.3
        visible: true
        anchors.right: parent.right
        anchors.top: up_panel.top
        // anchors.bottom: parent.bottom
        anchors.rightMargin: 10
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        spacing: 10

        // rows: 3
        // columns: 2

        Button {
            id: stop_button
            text: stop_mode
            Layout.fillWidth: true
            Layout.fillHeight: true
            highlighted: false
            font.bold: true
            font.pointSize: 45 * parent.height / 420

            background: Rectangle {
                color: "#AB47BC"
                radius: 30 * parent.height / 120
                border.color: stop_button.background.color
                border.width: 1
            }
            onClicked: {
                if (stop_mode === "STOP") {
                    backend.requestStop("STOP");
                } else if (stop_mode === "PAUSED") {
                    backend.requestStop("RUN");
                }
            }
            onPressedChanged: {
                if (pressed) {
                    background.color = "#E1BEE7";
                } else {
                    background.color = "#AB47BC";
                }
            }
        }

        Button {
            id: reset_button
            text: reset_mode

            Layout.fillWidth: true
            Layout.fillHeight: true
            highlighted: false
            font.bold: true
            font.pointSize: 45 * parent.height / 420

            background: Rectangle {
                color: "#4CAF50"
                radius: 30 * parent.height / 120
                border.color: reset_button.background.color
                border.width: 1
            }
            onClicked: {
                popup_mode = 2;
                status_popup.text = state_system;

                popup_confirm_visible = true;

                popup.open();
            }
            onPressedChanged: {
                if (pressed) {
                    background.color = "#A5D6A7";
                } else {
                    background.color = "#4CAF50";
                }
            }
        }

        Button {
            id: homming_button
            text: homing_mode

            Layout.fillWidth: true
            Layout.fillHeight: true
            highlighted: false
            font.bold: true
            font.pointSize: 45 * parent.height / 420

            background: Rectangle {
                color: "#FFFFFF"
                radius: 30 * parent.height / 120
                border.color: "#607D8B"
                border.width: 2
            }
            onPressedChanged: {
                if (pressed) {
                    background.color = "#A5D6A7";
                } else {
                    background.color = "#FFFFFF";
                }
            }
            // onClicked: {
            //     state_edit = 2
            //     pop_up_2.open()
            // }

        }
    }
    RowLayout {
        width: parent.width * 0.5
        height: 25 + 75 * parent.height / 1200
        visible: true
        anchors.left: parent.left
        anchors.bottom: down_panel.top
        // anchors.bottom: parent.bottom
        // anchors.rightMargin: 10
        anchors.leftMargin: parent.width * 0.25
        anchors.bottomMargin: 0
        spacing: 10

        // rows: 3
        // columns: 2

        Button {
            id: control_button
            text: qsTr(control_mode)
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.3
            highlighted: false
            font.bold: true
            font.pointSize: 40 * parent.height / 200

            background: Rectangle {
                color: "#2196F3"
                radius: 30 * parent.height / 104
                border.color: control_button.background.color
                border.width: 1
            }
            onClicked: {
                if (control_mode === "RUNNING") {
                    backend.requestControl("STOP");
                } else if (control_mode === "PAUSED") {
                    backend.requestControl("RUN");
                }
            }
            onPressedChanged: {
                if (pressed) {
                    background.color = "#A5D6A7";
                } else {
                    background.color = "#4CAF50";
                }
            }
        }
        Button {
            id: status_button
            text: status_mode

            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.3
            highlighted: false
            font.bold: true
            font.pointSize: 40 * parent.height / 200
            background: Rectangle {
                color: "white"
                radius: 30 * parent.height / 104
                border.color: status_button.background.color
                border.width: 1
            }
            onClicked: {
                popup_mode = 0;
                if (status_mode === "ERROR") {
                    status_popup.text = backend.robotError;
                    popup_confirm_visible = true;
                } else {
                    status_popup.text = backend.robotDetail;
                    popup_confirm_visible = false;
                }

                popup.open();
            }
        }
        Button {
            id: mode_button
            text: qsTr(mode_mode)

            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.3
            highlighted: false
            font.bold: true
            font.pointSize: 40 * parent.height / 200
            background: Rectangle {
                color: "#4CAF50"
                radius: 30 * parent.height / 104
                border.color: mode_button.background.color
                border.width: 1
            }
            onClicked: {
                popup_mode = 1;
                popup_confirm_visible = true;
                if (mode_mode === "MANUAL") {
                    // mode_mode ="AUTO"
                    status_popup.text = qsTr("Change robot mode to AUTO");
                    mode_button.background.color = "#4CAF50";
                } else if (mode_mode === "AUTO") {
                    // mode_mode =  "MANUAL"
                    status_popup.text = qsTr("Change robot mode to MANUAL");
                    mode_button.background.color = "#03A9F4";
                } else
                    status_popup.text = qsTr("Data false");
                popup.open();
            }
        }
    }

    // Thêm bàn phím ảo
    Keyboard {
        id: inputPanel
        height: parent.height * 0.25
        anchors.bottom: parent.bottom
        anchors.leftMargin: parent.width * 0.15
        anchors.rightMargin: parent.width * 0.15
        visible: Qt.inputMethod.visible
        anchors.left: parent.left
        anchors.right: parent.right
        parent: Overlay.overlay
    }

    // Hiển thị bàn phím khi TextField nhận focus
    // Component.onCompleted: {
    //     inputPanel.active = inputField.hasActiveFocus
    // }
    Connections {
        target: backend
        onBatteryPercentageChanged: {
            batteryPercentage = backend.batteryPercentage;
        }
        onBatteryVoltageChanged: {
            batteryVoltage = backend.batteryVoltage;
        }
        onBatteryCurrentChanged: {
            batteryCurrent = backend.batteryCurrent;
        }
        onRobotDetailChanged: {
            if (status_mode === "ERROR") {
                status_header.text = backend.robotError;
            } else {
                status_header.text = backend.robotDetail;
            }
        }
        onRobotModeChanged: {
            mode_mode = backend.robotMode;
            if (mode_mode === "MANUAL") {
                mode_button.background.color = "#03A9F4";
            } else if (mode_mode === "AUTO") {
                mode_button.background.color = "#4CAF50";
            } else
                mode_button.background.color = "#FF9800";
        }
        onRobotStatusChanged: {
            status_mode = backend.robotStatus;

            if ((status_mode === "ERROR") || (status_mode === "EMG")) {
                status_button.background.color = "#F44336";
            } else if (status_mode === "WAITING_INIT_POSE") {
                status_button.background.color = "#FFFFFF";
            } else if (status_mode === "NORMAL") {
                status_button.background.color = "#4CAF50";
            } else if (status_mode === "WAITING") {
                status_button.background.color = "#FFEB3B";
            } else {
                status_button.background.color = "#FF9800";
            }
        }
        onGetControlChanged: {
            control_mode = backend.getControl;
            if (mode_mode === "AUTO" && control_mode === "RUNNING") {
                if (status_mode === "WAITING") {
                    control_button.background.color = "#2196F3";
                } else {
                    control_button.background.color = "#4CAF50";
                }
            } else if (mode_mode === "MANUAL" && control_mode === "RUNNING") {
                control_button.background.color = "#2196F3";
            } else if (control_mode === "PAUSE") {
                control_button.background.color = "#FFEB3B";
            } else
                control_button.background.color = "#FFEB3B";
        }
        onSystemStatusChanged: {
            state_system = "State AGF: " + backend.getStateSystem();

            status_system = backend.systemStatus;
            reset_mode = backend.systemStatus;
            if (backend.systemStatus === "ERROR") {
                reset_button.background.color = "#F44336";
            } else if (backend.systemStatus === "NORMAL") {
                reset_button.background.color = "#4CAF50";
            }
        }
    }

    Connections {
        target: page1
        onQueuePalletRequest: {
            pop_up_2.open();
            loadPopupType(0);
            console.log("queueID: " + queueId);
            backend.setDataQueue(queueId);
        }
        onBufferPalletRequest: {
            pop_up_2.open();
            loadPopupType(1);
            console.log("bufferID: " + bufferId);
            // var id = bufferId;
            backend.setDataBuffer(bufferId);
        }
    }
}

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
import QtQuick.Studio.DesignEffects
import QtQuick3D 6.7

Rectangle {
    id: page1
    visible: true
    radius: Constants.borderRadiusMedium
    color: "#00000000"
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
    property real scaleFactorWidth: parent.width / 600
    property real scaleFactorHeight: parent.height / 400
    property real scaleFactor: Math.min(scaleFactorWidth, scaleFactorHeight)

    /*

       _                   _
   ___(_) __ _ _ __   __ _| |
  / __| |/ _` | '_ \ / _` | |
  \__ \ | (_| | | | | (_| | |
  |___/_|\__, |_| |_|\__,_|_|
         |___/

*/
    signal queuePalletRequest(int queueId)
    signal bufferPalletRequest(int bufferId)

    signal loadPopupType(int type)

    // property var model_pallet_: getListModel()
    // property var count_pallet: []
    // Khi cần khôi phục cấu hình
    /*

        __                  _   _
       / _|_   _ _ __   ___| |_(_) ___  _ __
      | |_| | | | '_ \ / __| __| |/ _ \| '_ \
      |  _| |_| | | | | (__| |_| | (_) | | | |
      |_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|


*/
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
        id: statusIndicate
        // x: page1.width * 0.15
        // y: page1.height * 0.1
        anchors.centerIn: parent
        width: 400 * scaleFactor
        height: 200 * scaleFactor
        visible: false
        dim: true
        font.italic: true
        font.pointSize: 50
        font.family: "Ubuntu"
        modal: false
        focus: true
        z: 99
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
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
        contentItem: Rectangle {
            anchors.fill: parent
            color: "transparent"  // Ensure there's no background color interfering
        }

        ConfirmShow {
            id: confirmShow
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.fill: parent
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 0
            anchors.bottomMargin: 0
        }
    }

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

        contentItem: Rectangle {
            anchors.fill: parent
            color: "transparent"  // Ensure there's no background color interfering
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
        width: page1.width * 0.8
        height: page1.height * 0.8
        opacity: 1
        visible: false
        modal: true
        dim: true
        closePolicy: Popup.NoAutoClose
        // closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        contentItem: Rectangle {
            anchors.fill: parent
            color: "transparent"  // Ensure there's no background color interfering
        }

        MyUserPopup {
            id: myUserPopup
            anchors.fill: parent
            state: page1.state_edit
        }
    }

    RoundButton {
        id: header
        height: parent.height * 0.07
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 10
        rightInset: 0
        leftInset: 0
        bottomInset: 0
        topInset: 0
        padding: 0
        rightPadding: 0
        leftPadding: 0
        bottomPadding: 0
        topPadding: 0
        Layout.bottomMargin: 0
        Layout.margins: 20
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        Layout.fillWidth: true
        Layout.preferredHeight: parent.height * 0.1
        background: Rectangle {

            color: "#90CAF9"
            radius: Constants.borderRadiusSmall
        }

        Text {
            id: status_header
            text: qsTr("Initializing")
            anchors.fill: parent
            font.pixelSize: 20 * parent.height / 48
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.italic: true
        }
    }

    ColumnLayout {
        id: columnLayout
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: header.bottom
        anchors.leftMargin: 20
        anchors.rightMargin: parent.width * 0.3
        anchors.topMargin: 20
        spacing: 10
        height: parent.height * 0.5

        ConveyorView {
            id: conveyorView
            Layout.fillHeight: true
            Layout.rightMargin: 0
            Layout.leftMargin: 0
            Layout.bottomMargin: 0
            Layout.topMargin: 5
            Layout.margins: 0
            clip: true
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.2
        }

        // Rectangle {
        //     id: rectangle
        //     width: 200
        //     height: 200
        //     color: "#00ffffff"
        //     Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        //     Layout.fillWidth: true
        //     Layout.preferredHeight: parent.height * 0.2
        // }

        BufferView {
            id: bufferView
            Layout.fillHeight: true

            Layout.rightMargin: 0
            Layout.leftMargin: 0
            Layout.bottomMargin: 0
            Layout.topMargin: 0
            Layout.fillWidth: true
            Layout.margins: 0
            Layout.preferredHeight: parent.height * 0.2
            // Layout.preferredWidth: parent.width * 0.7
        }
    }

    MyActionButtonLayout {
        id: actionButtonLayout
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.bottomMargin: 10
        spacing: 10
        visible: true
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height * 0.1
    }

    /*

                                       _   _
        ___ ___  _ __  _ __   ___  ___| |_(_) ___  _ __  ___
       / __/ _ \| '_ \| '_ \ / _ \/ __| __| |/ _ \| '_ \/ __|
      | (_| (_) | | | | | | |  __/ (__| |_| | (_) | | | \__ \
       \___\___/|_| |_|_| |_|\___|\___|\__|_|\___/|_| |_|___/


*/
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
            backend.getDataQueue(queueId);
        }
        onBufferPalletRequest: {
            pop_up_2.open();
            loadPopupType(1);
            console.log("bufferID: " + bufferId);
            // var id = bufferId;
            backend.getDataBuffer(bufferId);
        }
    }
    Connections {
        target: conveyorView
        onAddNew: {
            // console.log("Add newsdsd");
            backend.expandQueue();
            pop_up_2.open();
            loadPopupType(0);
        }
    }

    Image {
        id: pngegg
        anchors.left: columnLayout.right
        anchors.right: parent.right
        anchors.top: columnLayout.top
        anchors.bottom: columnLayout.bottom
        anchors.leftMargin: 5
        anchors.rightMargin: 10
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        source: "asset/pngegg.png"
        mirror: false
        sourceSize.width: 2000
        fillMode: Image.PreserveAspectFit
    }

    GridLayout {
        id: note
        width: parent.width * 0.1
        anchors.left: columnLayout.left
        anchors.top: columnLayout.bottom
        anchors.bottom: actionButtonLayout.top
        anchors.leftMargin: 0
        anchors.topMargin: parent.height * 0.05
        anchors.bottomMargin: parent.height * 0.05
        ColumnLayout {
            id: layout_note_1
            spacing: 5
            Rectangle {
                color: "#cfd8dc"
                Layout.fillWidth: true
                Layout.preferredWidth: height
                Layout.fillHeight: true
            }

            Rectangle {
                color: "#ffeb3b"
                Layout.fillWidth: true
                Layout.preferredWidth: height
                Layout.fillHeight: true
            }

            Rectangle {
                color: "#ff9800"
                Layout.fillWidth: true
                Layout.preferredWidth: height
                Layout.fillHeight: true
            }

            Rectangle {
                color: "#4caf50"
                Layout.fillWidth: true
                Layout.preferredWidth: height
                Layout.fillHeight: true
            }

            Rectangle {
                color: "#2196f3"
                Layout.fillWidth: true
                Layout.preferredWidth: height
                Layout.fillHeight: true
            }
            Layout.maximumWidth: 100
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        ColumnLayout {
            id: layout_note_2
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 5
            Text {
                height: 50
                text: "Trống (type: -1)"
                font.pixelSize: note.height * 0.1
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Text {
                height: 50
                text: "Pallet thấp (type: 0)"
                font.pixelSize: note.height * 0.1
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
            Text {
                height: 50
                text: "Pallet cao (type: 1)"
                font.pixelSize: note.height * 0.1
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Text {
                height: 50
                text: "Pallet kép (type: 2)"
                font.pixelSize: note.height * 0.1
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Text {
                height: 50
                text: "Pallet đơn (type: 3)"
                font.pixelSize: note.height * 0.1
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }

    Item {
        id: __materialLibrary__

        PrincipledMaterial {
            id: principledMaterial
            objectName: "New Material"
        }
    }

    // RowLayout {
    //     id: rowLayout
    //     y: 71
    //     height: parent.height * 0.07
    //     anchors.left: columnLayout.right
    //     anchors.right: pngegg.right
    //     anchors.bottom: columnLayout.bottom
    //     anchors.leftMargin: 5
    //     anchors.rightMargin: 0
    //     anchors.bottomMargin: 0

    //     TextField {
    //         id: textField1
    //         text: "BF1"
    //         horizontalAlignment: Text.AlignHCenter
    //         rightInset: 5
    //         leftInset: 5
    //         font.bold: false
    //         font.pointSize: parent.height * 0.2
    //         Layout.fillHeight: true
    //         Layout.fillWidth: true
    //         placeholderText: qsTr("Departure")
    //     }
    //     Image {
    //         id: transfer_long_right_light
    //         source: "asset/transfer_long_right_light.svg"
    //         sourceSize.height: 50

    //         sourceSize.width: 50
    //         Layout.fillHeight: true
    //         Layout.fillWidth: true
    //         fillMode: Image.PreserveAspectFit
    //     }

    //     TextField {
    //         id: textField
    //         text: "Zone_1"
    //         horizontalAlignment: Text.AlignHCenter
    //         rightInset: 5
    //         leftInset: 5
    //         font.bold: false
    //         font.pointSize: parent.height * 0.2
    //         Layout.fillHeight: true
    //         Layout.fillWidth: true
    //         placeholderText: qsTr("Destination")
    //     }

    // }

    // View3D {
    //     visible: true
    //     anchors.fill: parent
    //     anchors.leftMargin: 160
    //     anchors.rightMargin: 139
    //     anchors.topMargin: 151
    //     anchors.bottomMargin: 73
    //     importScene: perspectiveCamera
    //     camera: perspectiveCamera

    //     // Lighting
    //         // DirectionalLight {
    //         //     worldPosition: Qt.vector3d(0, 200, 200)
    //     //     intensity: 1.0
    //     // }

    //     // 3D Model

    //     PerspectiveCamera {
    //         id: perspectiveCamera
    //         x: -7.6
    //         y: 0
    //         eulerRotation.z: -0.93604
    //         eulerRotation.y: -0.93604
    //         eulerRotation.x: -0.00765
    //         z: 330.52588

    //             Model {
    //                 id: cube
    //                 x: -14.111
    //                 y: 0
    //                 source: "#Cube"
    //                 eulerRotation.z: 18.20031
    //                 eulerRotation.y: 42.55695
    //                 eulerRotation.x: 13.64559
    //                 z: -430.27103
    //                 materials: principledMaterial
    //             }
    //         }

    //         // // Rotation animation for the model
    //         // NumberAnimation on model.rotation.y {
    //         //     from: 0
    //         //     to: 360
    //         //     duration: 10000 // Rotate every 10 seconds
    //         //     loops: Animation.Infinite
    //         //     running: true
    //         // }
    //     }

}

/*##^##
Designer {
    D{i:0;matPrevEnvDoc:"SkyBox";matPrevEnvValueDoc:"preview_studio";matPrevModelDoc:"#Sphere"}
}
##^##*/

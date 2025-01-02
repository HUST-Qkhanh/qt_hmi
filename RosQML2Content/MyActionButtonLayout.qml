import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.2
import RosQML2

RowLayout {
    id: actionButtonLayout
    property real buttonWidth: (width - (spacing * (children.length - 1))) / children.length
    height: parent.height * 0.1
    width: parent.width * 0.8
    // Layout.bottomMargin: 0
    // Layout.topMargin: 0
    spacing: 10
    // Layout.fillWidth: true
    // Layout.margins: 20
    // Layout.fillHeight: true
    // Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
    // Layout.preferredHeight: parent.height * 0.15
    RoundButton {
        id: stop_button
        text: "STOP"
        enabled: true
        checked: false
        flat: false
        layer.samplerName: "source0"
        Layout.preferredWidth: actionButtonLayout.buttonWidth
        Layout.fillHeight: true
        highlighted: true
        font.bold: true
        font.pointSize: 45 * parent.height / 420
        radius: Constants.borderRadiusLarge

        onClicked: {
            if (stop_mode === "STOP") {
                backend.requestStop();
            }
        }
        // onPressedChanged: {
        //     if (pressed) {
        //         background.color = "#E1BEE7";
        //     } else {
        //         background.color = "#AB47BC";
        //     }
        // }
    }

    RoundButton {
        id: reset_button
        text: "RESET"
        Layout.preferredWidth: actionButtonLayout.buttonWidth
        Layout.fillHeight: true
        highlighted: true
        font.bold: true
        font.pointSize: 45 * parent.height / 420
        radius: Constants.borderRadiusLarge
        onClicked: {
            popup_mode = 2;
            status_popup.text = state_system;

            popup_confirm_visible = true;

            popup.open();
        }
    }

    // RoundButton {
    //     id: homming_button
    //     text: homing_mode
    //     Layout.preferredWidth: actionButtonLayout.buttonWidth
    //     Layout.fillHeight: true
    //     highlighted: true
    //     font.bold: true
    //     font.pointSize: 45 * parent.height / 420
    //     Layout.column: 2
    //     Layout.row: 0
    //     radius: Constants.borderRadiusLarge
    // }

    RoundButton {
        id: status_button
        text: "RUNNING"
        highlighted: true
        font.pointSize: 45 * parent.height / 420
        font.bold: true
        radius: Constants.borderRadiusLarge
        Layout.preferredWidth: actionButtonLayout.buttonWidth
        Layout.fillHeight: true
        onClicked: {
            popup_mode = 2;
            status_popup.text = state_system;

            popup_confirm_visible = true;

            popup.open();
        }
    }

    RoundButton {
        id: mode_button
        text: "MANUAL"
        highlighted: true
        font.pointSize: 45 * parent.height / 420
        font.bold: true
        radius: Constants.borderRadiusLarge
        Layout.preferredWidth: actionButtonLayout.buttonWidth
        Layout.fillHeight: true
        onClicked: {
            if (backend.robotMode === "AUTO") {
                backend.requestMode("MANUAL");
                console.log("CHANGE MODE TO MANUAL");
            } else if (backend.robotMode === "MANUAL") {
                backend.requestMode("AUTO");
                console.log("CHANGE MODE TO AUTO");
            }
        }
    }

    Connections {
        target: backend
        onServiceTimeout: {
            confirmShow.header_type = 5;
            confirmShow.info_text = qsTr("Request timeout");
            statusIndicate.open();
        }
        onRobotModeChanged: {
            mode_mode = backend.robotMode;
            control_mode = backend.getControl;
            status_mode = backend.robotStatus;

            // console.log("mode_mode: " + mode_mode);
            // console.log("control_mode: " + control_mode);
            // console.log("status_mode: " + status_mode);
            
            if (mode_mode === "AUTO" && control_mode === "RUNNING") {
                if (status_mode === "WAITING") {
                    mode_button.background.color = "#3498DB";
                    mode_button.text = "AUTO";
                }
                if (status_mode === "RUNNING") {
                    mode_button.background.color = "#4CAF50";
                    mode_button.text = "AUTO";
                }
            } else if (mode_mode === "MANUAL" && control_mode === "RUNNING") {
                mode_button.background.color = "#3498DB";
                mode_button.text = "MANUAL";
            }
        }
        // onRobotStatusChanged: {
        //     status_mode = backend.robotStatus;

        //     if ((status_mode === "ERROR") || (status_mode === "EMG")) {
        //         status_button.background.color = "#F44336";
        //     } else if (status_mode === "WAITING_INIT_POSE") {
        //         status_button.background.color = "#FFFFFF";
        //     } else if (status_mode === "NORMAL") {
        //         status_button.background.color = "#4CAF50";
        //     } else if (status_mode === "WAITING") {
        //         status_button.background.color = "#FFEB3B";
        //     } else {
        //         status_button.background.color = "#FF9800";
        //     }
        // }
        onGetControlChanged: {

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

        onRequestStopSucceeded: {
            stop_button.enabled = false;
            confirmShow.header_type = 6;
            statusIndicate.open();
        }
    }
}

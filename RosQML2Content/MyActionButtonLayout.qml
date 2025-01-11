import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.2
import RosQML2

RowLayout {
    id: actionButtonLayout

    property bool wasResetButtonPressed: false
    property bool wasModeButtonPressed: false
    property bool wasStatusButtonPressed: false
    property bool wasStopButtonPressed: false
    property string stop_mode: "PAUSE"

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
        flat: false
        layer.samplerName: "source0"
        Layout.preferredWidth: actionButtonLayout.buttonWidth
        Layout.fillHeight: true
        highlighted: true
        font.bold: true
        font.pointSize: 45 * parent.height / 420
        radius: Constants.borderRadiusLarge

        onClicked: {
            wasStopButtonPressed = true;
            console.log("mode button: " + wasModeButtonPressed);
            confirmShow.header_type = 5;
            confirmShow.info_text = qsTr("Stop Sequence ?");
            statusIndicate.open();
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
            wasResetButtonPressed = true;

            console.log("reset button: " + wasResetButtonPressed);

            confirmShow.header_type = 5;
            confirmShow.info_text = qsTr("Reset sequence");
            statusIndicate.open();
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
            wasStatusButtonPressed = true;
            confirmShow.header_type = 5;
            confirmShow.info_text = qsTr("Pause robot");
            statusIndicate.open();
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
            wasModeButtonPressed = true;
            console.log("mode button: " + wasModeButtonPressed);
            confirmShow.header_type = 5;
            confirmShow.info_text = qsTr("Change mode ?");
            statusIndicate.open();
        }
    }

    Connections {
        target: confirmShow
        onConfirmPressed: {
            console.log("reset button: " + wasResetButtonPressed);
            console.log("mode button: " + wasModeButtonPressed);
            if (wasResetButtonPressed) {
                backend.requestReset("request_reset");
                wasResetButtonPressed = false;
            }
            if (wasModeButtonPressed) {
                if (backend.robotMode === "AUTO") {
                    backend.requestMode("MANUAL");
                    console.log("CHANGE MODE TO MANUAL");
                } else if (backend.robotMode === "MANUAL") {
                    backend.requestMode("AUTO");
                    console.log("CHANGE MODE TO AUTO");
                }
                wasModeButtonPressed = false;
            }
            if (wasStopButtonPressed) {
                if (backend.robotMode === "AUTO") {
                    backend.requestStop("RUN");
                }
                wasStopButtonPressed = false;
            }
            if (wasStatusButtonPressed) {
                if (backend.robotMode === "AUTO" && backend.robotStatus === "RUNNING") {
                    backend.requestControl("STOP");
                } else if (backend.robotMode === "AUTO" && backend.robotStatus === "PAUSE") {
                    backend.requestControl("RUN");
                }
                wasStatusButtonPressed = false;
            }
        }
    }

    Timer {
        id: delayTimer
        interval: 1000 // Delay in milliseconds (1000ms = 1 second)
        repeat: false // Run only once
        onTriggered: {
            console.log("Performing delayed action");
            confirmShow.header_type = 5;
            confirmShow.info_text = qsTr("Request timeout");
            statusIndicate.open();
        }
    }

    Connections {
        target: backend
        onServiceTimeout: {
            // Start the timer
            delayTimer.start();
        }
        onRobotModeChanged: {
            if (backend.robotMode === "MANUAL") {
                mode_button.text = qsTr("MANUAL");
            } else if (backend.robotMode === "AUTO") {
                mode_button.text = qsTr("AUTO");
            }
        }
        // onRobotStatusChanged: {
        //     if ((backend.robotStatus === "ERROR") || (backend.robotStatus === "EMG")) {
        //         status_button.background.color = "#F44336";

        //     } else if (status_button === "WAITING_INIT_POSE") {
        //         status_button.background.color = "#FFFFFF";
        //     } else if (status_button === "NORMAL") {
        //         status_button.background.color = "#4CAF50";
        //     } else if (status_button === "WAITING") {
        //         status_button.background.color = "#FFEB3B";
        //     } else {
        //         status_button.background.color = "#FF9800";
        //     }
        // }
        onGetControlChanged: {
            console.log("robotStatus: " + backend.robotStatus);
            console.log("robotMode: " + backend.robotMode);
            if (backend.robotMode === "AUTO") {
                if (backend.robotStatus === "WAITING") {
                    status_button.text = qsTr("WAITING");
                    status_button.background.color = "#2196F3";
                    mode_button.background.color = "#2196F3";
                }
                if (backend.robotStatus === "RUNNING") {
                    status_button.text = qsTr("RUNNING");
                    status_button.background.color = "#4CAF50";
                    mode_button.background.color = "#4CAF50";
                }
                if (backend.robotStatus === "PAUSE") {
                    status_button.text = qsTr("PAUSE");
                    status_button.background.color = "#FFEB3B";
                    mode_button.background.color = "#2196F3";
                }
                if (backend.systemStatus === "ERROR" || backend.robotStatus === "ERROR") {
                    status_button.text = qsTr("ERROR");
                    status_button.background.color = "#F44336";
                    mode_button.background.color = "#2196F3";
                }
            } else if (backend.robotMode === "MANUAL") {
                status_button.text = qsTr("RUNNING");
                status_button.background.color = "#2196F3";
                mode_button.background.color = "#2196F3";
            }

            status_button.text = backend.robotStatus;
        }
        // onSystemStatusChanged: {
        //     state_system = "State AGF: " + backend.getStateSystem();

        //     status_system = backend.systemStatus;
        //     reset_mode = backend.systemStatus;
        //     if (backend.systemStatus === "ERROR") {
        //         reset_button.background.color = "#F44336";
        //     } else if (backend.systemStatus === "NORMAL") {
        //         reset_button.background.color = "#4CAF50";
        //     }
        // }
    }
}

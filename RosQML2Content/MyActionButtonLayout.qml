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
                    backend.requestStop("STOP");
                } else if (stop_mode === "PAUSED") {
                    backend.requestStop("RUN");
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
            id: reset_button1
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
            id: homming_button1
            text: "MANUAL"
            highlighted: true
            font.pointSize: 45 * parent.height / 420
            font.bold: true
            radius: Constants.borderRadiusLarge
             Layout.preferredWidth: actionButtonLayout.buttonWidth
            Layout.fillHeight: true
            onClicked: {
                if(backend.robotMode === "AUTO") {
                    backend.requestMode("MANUAL");
                    console.log("CHANGE MODE TO MANUAL");
                }
                else if (backend.robotMode === "MANUAL"){
                    backend.requestMode("AUTO");
                    console.log("CHANGE MODE TO AUTO");
                }


            }
        }

    }

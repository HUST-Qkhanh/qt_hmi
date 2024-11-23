// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick 6.2
// import hmi_agf
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.2
import QtQuick.VirtualKeyboard 6.7
import RosQML2

// import backendqt 1.0
import QtQuick.Studio.DesignEffects

Window {
    id: window
    width: 1920
    height: 1080
    visible: true
    color: Constants.surfaceColor
    // flags: Qt.FramelessWindowHint
    // visibility: Window.FullScreen
    title: "HMI_appication"
    Popup {
        id: keyboardOverlay
        height: parent.height * 0.5
        width: parent.width
        visible: Qt.inputMethod.visible

        // Position the Popup at the bottom of the window
        x: 0
        y: parent.height - height  // Aligns the Popup's bottom edge with the window's bottom edge
        contentItem: Rectangle {
            anchors.fill: parent
            color: "transparent"  // Ensure there's no background color interfering
        }
        Keyboard {
            id: inputPanel
            active: true
            visible: true
            anchors.fill: parent
        }
    }

    PropertyAnimation {
        id: fadeIn
        target: loader
        property: "opacity"
        to: 1
        duration: 500
    }

    Component {
        id: pageComponent
        Page {
            id: change_language

            Button {
                id: eng
                width: change_language.width * 0.45
                height: change_language.width * 0.25
                text: qsTr("ENGLISH")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                font.pointSize: 50

                display: AbstractButton.TextOnly
                background: Rectangle {
                    color: "#F5F5F5"
                    radius: 20
                    border.color: "#FFFFFF"
                    border.width: 5
                }
                onClicked: {
                    backend.change_to_eng();
                }
                onPressedChanged: {
                    if (pressed) {
                        background.color = "#B0BEC5";
                    } else {
                        background.color = "#F5F5F5";
                    }
                }
            }

            Button {
                id: japan

                width: change_language.width * 0.45
                height: change_language.width * 0.25
                text: qsTr("JAPANESE")
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 20
                font.pointSize: 50
                display: AbstractButton.TextOnly
                background: Rectangle {
                    color: "#F5F5F5"
                    radius: 20
                    border.color: "#FFFFFF"
                    border.width: 5
                }
                onClicked: {
                    backend.change_to_japan();
                }
                onPressedChanged: {
                    if (pressed) {
                        background.color = "#B0BEC5";
                    } else {
                        background.color = "#F5F5F5";
                    }
                }
            }
        }
    }

    RowLayout {
        id: rowLayout
        anchors.fill: parent

        Rectangle {
            id: rectangle

            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.1
            color: Constants.backgroundColor

            // ColumnLayout {
            //     id: toolBar
            //     anchors.fill: parent
            //     // contentHeight: 192
            //     // contentWidth: 182
            //     spacing: 10
            //     anchors {
            //         horizontalCenter: window.horizontalCenter
            //     }
            //     Image {
            //         id: meikoLogo
            //         source: "asset/MeikoLogo.svg"
            //         Layout.leftMargin: 35
            //         Layout.margins: 20
            //         Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            //         Layout.fillHeight: true
            //         Layout.fillWidth: true
            //         fillMode: Image.PreserveAspectFit
            //         Layout.maximumHeight: parent.height * 0.1
            //     }
            //     ColumnLayout {
            //         id: columnLayout
            //         Layout.margins: 10

            //         RoundButton {
            //             id: dashboard_button
            //             height: (toolBar.height - 120) * 0.2
            //             radius: Constants.borderRadiusSmall
            //             palette.buttonText: "#448AFF"
            //             font.bold: true
            //             font.family: "ubuntu"
            //             icon.height: 60 * dashboard_button.width / 170
            //             icon.width: 60 * dashboard_button.width / 170
            //             icon.color: Constants.buttonColorSecondary//"#1d1d1d"
            //             // icon.source: "qrc:/RosQML2Content/asset/Vector 48 (Stroke).svg"
            //             icon.source: "asset/Vector 48 (Stroke).svg"
            //             display: AbstractButton.IconOnly
            //             font.pointSize: 25 * dashboard_button.height / 276

            //             text: qsTr("DASHBOARD")
            //             highlighted: false
            //             Layout.fillHeight: true
            //             Layout.fillWidth: true
            //             background: Rectangle {
            //                 color: "#F5F5F5"
            //                 radius: Constants.borderRadiusMedium
            //             }
            //             onClicked: {
            //                 loader.setSource("qrc:/RosQML2Content/Screen01.qml");
            //                 Qt.callLater(function () {
            //                     backend.updateFetchedList();
            //                 });
            //             }

            //             onPressedChanged: {
            //                 if (pressed) {
            //                     background.color = "#B0BEC5";
            //                 } else {
            //                     background.color = "#F5F5F5";
            //                 }
            //             }
            //         }

            //         RoundButton {
            //             id: mission_button
            //             height: (toolBar.height - 120) * 0.2
            //             radius: Constants.borderRadiusSmall
            //             text: qsTr("MONITORING")
            //             Layout.fillHeight: true
            //             Layout.fillWidth: true
            //             palette.buttonText: "#448AFF"
            //             highlighted: false
            //             flat: false
            //             font.family: "ubuntu"
            //             font.bold: true
            //             icon.color: Constants.buttonColorSecondary//"#1d1d1d"
            //             icon.height: 60 * monitoring_button.width / 170
            //             icon.width: 60 * monitoring_button.width / 170
            //             // icon.source: "qrc:/RosQML2Content/asset/dart-mission-goal-success-svgrepo-com.svg"
            //             icon.source: "asset/dart-mission-goal-success-svgrepo-com.svg"
            //             display: AbstractButton.IconOnly
            //             font.pointSize: 25 * dashboard_button.height / 276

            //             background: Rectangle {
            //                 color: "#F5F5F5"
            //                 radius: Constants.borderRadiusMedium
            //             }
            //             onClicked: loader.setSource("qrc:/RosQML2Content/component_test.ui.qml")
            //         }

            //         RoundButton {
            //             id: setup_button
            //             height: (toolBar.height - 120) * 0.2
            //             radius: Constants.borderRadiusSmall
            //             palette.buttonText: "#448AFF"
            //             font.bold: true
            //             font.family: "ubuntu"
            //             icon.height: 60 * setup_button.width / 170
            //             icon.width: 60 * setup_button.width / 170
            //             icon.color: Constants.buttonColorSecondary//"#1d1d1d"
            //             // icon.source: "qrc:/RosQML2Content/asset/setup.svg"
            //             icon.source: "asset/setup.svg"
            //             display: AbstractButton.IconOnly
            //             font.pointSize: 25 * dashboard_button.height / 276
            //             text: qsTr("SETUP")
            //             Layout.fillHeight: true
            //             Layout.fillWidth: true
            //             background: Rectangle {
            //                 color: "#F5F5F5"
            //                 radius: Constants.borderRadiusMedium
            //             }
            //             onClicked: loader.setSource("qrc:/RosQML2Content/Screen02.qml")
            //         }

            //         RoundButton {
            //             id: monitoring_button
            //             height: (toolBar.height - 120) * 0.2
            //             radius: Constants.borderRadiusSmall
            //             text: qsTr("MONITORING")
            //             Layout.fillHeight: true
            //             Layout.fillWidth: true
            //             palette.buttonText: "#448AFF"
            //             font.family: "ubuntu"
            //             font.bold: true
            //             icon.color: Constants.buttonColorSecondary//"#1d1d1d"
            //             icon.height: 60 * monitoring_button.width / 170
            //             icon.width: 60 * monitoring_button.width / 170
            //             // icon.source: "qrc:/RosQML2Content/asset/tv.svg"
            //             icon.source: "asset/tv.svg"
            //             display: AbstractButton.IconOnly
            //             font.pointSize: 25 * dashboard_button.height / 276

            //             background: Rectangle {
            //                 color: "#F5F5F5"
            //                 radius: Constants.borderRadiusMedium
            //             }
            //             onClicked: loader.setSource("qrc:/RosQML2Content/Screen03.qml")
            //         }

            //         RoundButton {
            //             id: system_button
            //             text: qsTr("SYSTEM")
            //             Layout.preferredHeight: monitoring_button.height
            //             Layout.fillWidth: true
            //             palette.buttonText: "#448AFF"
            //             height: (toolBar.height - 120) * 0.2
            //             radius: Constants.borderRadiusSmall
            //             font.family: "ubuntu"
            //             focusPolicy: Qt.NoFocus
            //             font.bold: true
            //             icon.height: 60 * system_button.width / 170
            //             icon.width: 60 * system_button.width / 170
            //             // icon.source: "qrc:/RosQML2Content/asset/Setting.svg"
            //             icon.source: "asset/Setting.svg"
            //             icon.color: Constants.buttonColorSecondary//"#1d1d1d"
            //             display: AbstractButton.IconOnly
            //             font.pointSize: 25 * dashboard_button.height / 276
            //             background: Rectangle {
            //                 color: "#F5F5F5"
            //                 radius: Constants.borderRadiusMedium
            //             }
            //             onClicked: loader.setSource("qrc:/RosQML2Content/component_test_2.ui.qml")
            //         }
            //     }
            // }

            DesignEffect {
                effects: [
                    DesignDropShadow {
                        offsetX: 2
                        offsetY: 0
                        showBehind: true
                    }
                ]
            }
        }

        ColumnLayout {
            id: columnLayout1
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.margins: 10
            spacing: 0

            RowLayout {
                id: rowLayout1
                Layout.bottomMargin: 10
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                Layout.minimumWidth: parent.width
                Layout.maximumHeight: parent.height * 0.08

                RowLayout {
                    id: rowLayout3
                    Layout.alignment: Qt.AlignRight | Qt.AlignTop
                    Layout.maximumHeight: parent.height * 0.7
                    Button {
                        id: minimal_button
                        bottomInset: 0
                        topInset: 0
                        rightPadding: 0
                        leftPadding: 0
                        bottomPadding: 0
                        topPadding: 0
                        Layout.fillHeight: true
                        Layout.preferredWidth: height
                        icon.height: 50
                        icon.width: 50
                        icon.source: "qrc:/RosQML2Content/asset/minimize.svg"
                        display: AbstractButton.IconOnly
                        background: Rectangle {
                            color: "#ECEFF1"
                            radius: Constants.borderRadiusMedium
                            border.color: "#78909C"
                            border.width: 2
                        }
                        onClicked: {
                            window.showNormal();  // Restore to normal size if currently fullscreen
                            window.width = window.screen.width / 1.5;
                            window.height = window.screen.height / 1.5;
                            window.x = (window.screen.width - window.width) / 2;
                            window.y = (window.screen.height - window.height) / 2;
                            window.showMinimized();
                        }
                    }

                    Button {
                        id: close_button
                        bottomInset: 0
                        topInset: 0
                        rightPadding: 0
                        leftPadding: 0
                        bottomPadding: 0
                        topPadding: 0
                        Layout.fillHeight: true
                        Layout.preferredWidth: height
                        icon.height: 50
                        icon.width: 50
                        display: AbstractButton.IconOnly
                        icon.source: "qrc:/RosQML2Content/asset/close.svg"
                        background: Rectangle {
                            color: "#ECEFF1"
                            radius: Constants.borderRadiusMedium
                            border.color: "#78909C"
                            border.width: 2
                        }
                        onClicked: {
                            Qt.quit();
                        }
                    }

                    Button {
                        id: zoom_button
                        bottomInset: 0
                        topInset: 0
                        rightPadding: 0
                        leftPadding: 0
                        bottomPadding: 0
                        topPadding: 0
                        Layout.fillHeight: true
                        Layout.preferredWidth: height
                        icon.height: 50
                        icon.width: 50
                        icon.source: "qrc:/RosQML2Content/asset/zoom.svg"
                        display: AbstractButton.IconOnly
                        background: Rectangle {
                            color: "#ECEFF1"
                            radius: Constants.borderRadiusMedium
                            border.color: "#78909C"
                            border.width: 2
                        }
                        onClicked: {
                            print("Zooming to:", window.screen.width, window.screen.height);

                            if (window.visibility === Window.FullScreen) {
                                window.showNormal();  // Restore to normal size if currently fullscreen
                                window.width = window.screen.width / 1.5;
                                window.height = window.screen.height / 1.5;
                                window.x = (window.screen.width - window.width) / 2;
                                window.y = (window.screen.height - window.height) / 2;
                            } else {
                                window.visibility = Window.FullScreen;
                            }
                        }
                    }
                }
            }
            StackView {
                id: stackView
                Layout.margins: 0
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                Layout.fillHeight: true
                Layout.fillWidth: true
                Loader {
                    id: loader
                    anchors.fill: parent
                    onLoaded: {
                        fadeIn.start(); // Start fade-in animation after content is loaded

                    }

                    // Property to control the opacity for animation
                    opacity: 0
                }

                initialItem: loader.setSource("qrc:/RosQML2Content/Screen01.qml")
            }
        }
    }
}

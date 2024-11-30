// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.2
import QtQuick.VirtualKeyboard 6.7
import RosQML2
import QtQuick.Studio.DesignEffects

Window {
    id: window
    width: 900
    height: 600
    visible: true
    color: Constants.backgroundColor
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
                    color: Constants.buttonColorPrimary
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
                    color: Constants.buttonColorPrimary
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

    Rectangle {
        id: rectangle
        color: Constants.backgroundColor
        anchors.left: parent.left
        anchors.right: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.rightMargin: -parent.width * 0.08
        anchors.topMargin: 0
        anchors.bottomMargin: 0

        Image {
            id: meikoLogo
            source: "asset/MeikoLogo.svg"
            height: parent.height * 0.1
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 10 * parent.height / 1080
            parent: parent.width
            fillMode: Image.PreserveAspectFit
        }
        ColumnLayout {
            id: columnLayout
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: meikoLogo.bottom
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            anchors.topMargin: 50 * parent.height / 1080
            spacing: 20
            Layout.margins: 10

            RoundButton {
                id: dashboard_button
                Layout.preferredHeight: width // (toolBar.height - 120) * 0.2
                radius: Constants.borderRadiusSmall
                font.bold: false
                font.family: "ubuntu"
                // icon.source: "qrc:/RosQML2Content/asset/Vector 48 (Stroke).svg"
                icon.source: "asset/Vector 48 (Stroke).svg"
                display: AbstractButton.TextUnderIcon

                text: qsTr("DASHBOARD")
                flat: true
                font.weight: Font.Normal
                font.pointSize: 6
                spacing: 0
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                bottomInset: 0
                topInset: 0
                rightInset: 0
                leftInset: 0
                icon.color: Constants.buttonTextColor
                icon.height: 500
                icon.width: 500
                padding: 50 * parent.height / 1080
                highlighted: false
                Layout.fillWidth: true

                // background: Rectangle {
                //     color: "#F5F5F5"
                //     radius: Constants.borderRadiusMedium
                // }

                onClicked: {
                    loader.setSource("qrc:/RosQML2Content/Screen01.qml");
                    Qt.callLater(function () {
                        backend.updateFetchedList();
                    });
                }
            }


            RoundButton {
                id: mission_button
                Layout.preferredHeight: width//(toolBar.height - 120) * 0.2
                radius: Constants.borderRadiusSmall
                text: qsTr("MONITORING")
                font.weight: Font.Normal
                font.pointSize: 5
                spacing: 0
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                rightInset: 0
                leftInset: 0
                bottomInset: 0
                topInset: 0
                padding: 50 * parent.height / 1080
                icon.height: 500
                icon.width: 500
                Layout.fillWidth: true
                highlighted: false
                flat: true
                font.family: "ubuntu"
                font.bold: false
                icon.color: Constants.buttonTextColor//"#1d1d1d"
                // icon.source: "qrc:/RosQML2Content/asset/dart-mission-goal-success-svgrepo-com.svg"
                icon.source: "asset/dart-mission-goal-success-svgrepo-com.svg"
                display: AbstractButton.IconOnly
                onClicked: loader.setSource("qrc:/RosQML2Content/component_test.ui.qml")
                onPressedChanged: {
                    if (pressed) {
                        background.color = Constants.buttonPressedColor;
                    } else {
                        background.color = Constants.buttonColorPrimary;
                    }
                }
            }

            RoundButton {
                id: setup_button
                Layout.preferredHeight: width//(toolBar.height - 120) * 0.2
                radius: Constants.borderRadiusSmall
                font.bold: false
                font.family: "ubuntu"
                icon.color: Constants.buttonTextColor
                // icon.source: "qrc:/RosQML2Content/asset/setup.svg"
                icon.source: "asset/setup.svg"
                display: AbstractButton.IconOnly
                text: qsTr("SETUP")
                flat: true
                font.weight: Font.Normal
                font.pointSize: 5
                spacing: 0
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                layer.samplerName: "source0"
                baselineOffset: 0
                rightInset: 0
                leftInset: 0
                bottomInset: 0
                topInset: 0
                padding: 50 * parent.height / 1080
                icon.height: 500
                icon.width: 500
                Layout.fillWidth: true
                onClicked: loader.setSource("qrc:/RosQML2Content/Screen02.qml")
                onPressedChanged: {
                    if (pressed) {
                        background.color = Constants.buttonPressedColor;
                    } else {
                        background.color = Constants.buttonColorPrimary;
                    }
                }
            }

            RoundButton {
                id: monitoring_button
                Layout.preferredHeight: width//(toolBar.height - 120) * 0.2
                radius: Constants.borderRadiusSmall
                text: qsTr("MONITORING")
                flat: true
                font.weight: Font.Normal
                font.pointSize: 5
                spacing: 0
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                baselineOffset: 0
                rightInset: 0
                leftInset: 0
                bottomInset: 0
                topInset: 0
                padding: 50 * parent.height / 1080
                icon.height: 100
                icon.width: 100
                Layout.fillWidth: true
                palette.buttonText: Constants.buttonColorPrimary
                font.family: "ubuntu"
                font.bold: false
                icon.color: Constants.buttonTextColor
                // icon.source: "qrc:/RosQML2Content/asset/tv.svg"
                icon.source: "asset/tv.svg"
                display: AbstractButton.IconOnly
                onClicked: loader.setSource("qrc:/RosQML2Content/Screen03.qml")
                onPressedChanged: {
                    if (pressed) {
                        background.color = Constants.buttonPressedColor;
                    } else {
                        background.color = Constants.buttonColorPrimary;
                    }
                }
            }

            RoundButton {
                id: system_button
                text: qsTr("SYSTEM")
                flat: true
                font.weight: Font.Normal
                font.pointSize: 5
                spacing: 0
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                rightInset: 0
                leftInset: 0
                bottomInset: 0
                topInset: 0
                padding: 50 * parent.height / 1080
                icon.height: 500
                icon.width: 500
                Layout.preferredHeight: width
                Layout.fillWidth: true
                palette.buttonText: Constants.buttonColorPrimary
                height: (toolBar.height - 120) * 0.2
                radius: Constants.borderRadiusSmall
                font.family: "ubuntu"
                focusPolicy: Qt.NoFocus
                font.bold: false
                // icon.source: "qrc:/RosQML2Content/asset/Setting.svg"
                icon.source: "asset/Setting.svg"
                icon.color: Constants.buttonTextColor
                display: AbstractButton.IconOnly
                onClicked: loader.setSource("qrc:/RosQML2Content/component_test_2.ui.qml")
                onPressedChanged: {
                    if (pressed) {
                        background.color = Constants.buttonPressedColor;
                    } else {
                        background.color = Constants.buttonColorPrimary;
                    }
                }
            }
        }


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

    RowLayout {
        id: rowLayout3
        height: 30 * parent.height / 1080
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 5
        anchors.topMargin: 5
        RoundButton {
            id: minimal_button
            radius: Constants.borderRadiusMedium
            flat: true
            rightInset: 0
            leftInset: 0
            padding: 0
            icon.color: Constants.buttonColorPrimary
            bottomInset: 0
            topInset: 0
            rightPadding: 0
            leftPadding: 0
            bottomPadding: 0
            topPadding: 0
            Layout.fillHeight: true
            Layout.preferredWidth: height
            icon.height: 200
            icon.width: 200
            display: AbstractButton.IconOnly
            icon.source: "asset/minimize-8.svg"
            onClicked: {
                window.showNormal();  // Restore to normal size if currently fullscreen
                window.width = window.screen.width / 1.5;
                window.height = window.screen.height / 1.5;
                window.x = (window.screen.width - window.width) / 2;
                window.y = (window.screen.height - window.height) / 2;
                window.showMinimized();
            }
            onPressedChanged: {
                if (pressed) {
                    background.color = Constants.buttonPressedColor;
                } else {
                    background.color = Constants.buttonColorPrimary;
                }
            }
        }

        RoundButton {
            id: close_button
            radius: Constants.borderRadiusMedium
            flat: true
            rightInset: 0
            leftInset: 0
            padding: 0
            icon.color: Constants.buttonColorPrimary
            bottomInset: 0
            topInset: 0
            rightPadding: 0
            leftPadding: 0
            bottomPadding: 0
            topPadding: 0
            Layout.fillHeight: true
            Layout.preferredWidth: height
            icon.height: 200
            icon.width: 200
            display: AbstractButton.IconOnly
            icon.source: "asset/close_round.svg"
            onClicked: {
                Qt.quit();
            }
            onPressedChanged: {
                if (pressed) {
                    background.color = Constants.buttonPressedColor;
                } else {
                    background.color = Constants.buttonColorPrimary;
                }
            }
        }

        RoundButton {
            id: zoom_button
            radius: Constants.borderRadiusMedium
            flat: true
            rightInset: 0
            leftInset: 0
            padding: 0
            icon.color: Constants.buttonColorPrimary
            bottomInset: 0
            topInset: 0
            rightPadding: 0
            leftPadding: 0
            bottomPadding: 0
            topPadding: 0
            Layout.fillHeight: true
            Layout.preferredWidth: height
            icon.height: 200
            icon.width: 200
            display: AbstractButton.IconOnly
            icon.source: "asset/full.svg"
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
            onPressedChanged: {
                if (pressed) {
                    background.color = Constants.buttonPressedColor;
                } else {
                    background.color = Constants.buttonColorPrimary;
                }
            }
        }
    }

    Loader {
        id: loader
        x: 82
        y: 71
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        source: "qrc:/RosQML2Content/Screen01.qml"
        onLoaded: {
            fadeIn.start(); // Start fade-in animation after content is loaded

        }

        // Property to control the opacity for animation
        opacity: 0
        anchors.left: rectangle.right
        anchors.right: parent.right
        anchors.top: rowLayout3.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        anchors.rightMargin: 10
    }





}

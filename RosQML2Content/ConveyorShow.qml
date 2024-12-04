import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.2
import RosQML2
import QtQuick.Studio.DesignEffects

Rectangle {
            id: rectangle5
            color: Constants.surfaceColor
            Layout.margins: 20
            Layout.fillHeight: true
            Layout.fillWidth: true
            radius: Constants.borderRadiusMedium
            Layout.bottomMargin: 20

            ColumnLayout {
                id: columnLayout2
                anchors.fill: parent

                Rectangle {
                    id: rectangle1
                    color: Constants.backgroundColor
                    Layout.margins: 20
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height * 0.3
                    radius: Constants.borderRadiusMedium
                    border.width: 0
                    Layout.bottomMargin: 0
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    RowLayout {
                        id: rowLayout
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        anchors.topMargin: 10
                        anchors.bottomMargin: 10
                        spacing: 20

                        Rectangle {
                            id: rectangle
                            Layout.fillHeight: true
                            Layout.preferredWidth: height
                            color: "#F9A825"
                            radius: Constants.borderRadiusMedium
                            Layout.margins: 0

                            Text {
                                text: qsTr("Máy") + '\n' + qsTr("cuốn") + '\n' + qsTr("phim")
                                anchors.verticalCenter: parent.verticalCenter
                                font.pixelSize: 20 * parent.width / 125
                                horizontalAlignment: Text.AlignRight
                                verticalAlignment: Text.AlignVCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.italic: false
                            }
                        }

                        ColumnLayout {
                            id: columnLayout1
                            width: 100
                            height: 100
                            Layout.fillWidth: true

                            RowLayout {
                                id: bang_tai_
                                Layout.preferredHeight: parent.height * 0.7
                                Layout.fillWidth: true
                                layoutDirection: Qt.RightToLeft

                                // Rectangle {
                                //     color: "#ae0808"
                                //     anchors.fill: parent

                                // }

                                Button {
                                    id: palet_1

                                    text: qsTr("1")
                                    Layout.fillHeight: true
                                    // Layout.fillWidth: true
                                    Layout.preferredHeight: width_current * parent.height / 167
                                    Layout.preferredWidth: height

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
                                    Layout.fillHeight: true
                                    // Layout.fillWidth: true
                                    Layout.preferredHeight: width_current * parent.height / 167
                                    Layout.preferredWidth: height
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
                                    Layout.fillHeight: true
                                    // Layout.fillWidth: true
                                    Layout.preferredHeight: width_current * parent.height / 167
                                    Layout.preferredWidth: height
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
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true

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
                                    Layout.fillHeight: true
                                    // Layout.fillWidth: true
                                    Layout.preferredHeight: width_current * parent.height / 167
                                    Layout.preferredWidth: height
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
                                    Layout.fillHeight: true
                                    // Layout.fillWidth: true
                                    Layout.preferredHeight: width_current * parent.height / 167
                                    Layout.preferredWidth: height
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
                                    Layout.fillHeight: true
                                    // Layout.fillWidth: true
                                    Layout.preferredHeight: width_current * parent.height / 167
                                    Layout.preferredWidth: height
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
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true


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
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
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
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true

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
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
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
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
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
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
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
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
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
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
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

                            Text {
                                text: "Băng tải chủ động"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignBottom
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                                font.pointSize: 20
                            }

                        }


                    }

                    DesignEffect {
                        effects: [
                            DesignDropShadow {
                            }
                        ]
                    }
                }

                Rectangle {
                    id: rectangle3
                    color: Constants.backgroundColor
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height * 0.3
                    radius: Constants.borderRadiusMedium
                    border.width: 0
                    Layout.margins: 20


                    RowLayout {
                        id: row
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        anchors.topMargin: 10
                        anchors.bottomMargin: 10
                        spacing: 20

                        Rectangle {
                            id: rectangle6
                            color: "#256aff"
                            Layout.fillHeight: true
                            Layout.preferredWidth: height
                            radius: Constants.borderRadiusMedium

                            Text {
                                id: _text
                                text: qsTr("Buffer Zone")
                                anchors.verticalCenter: parent.verticalCenter

                                font.pixelSize: 20 * parent.width / 125
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }

                        ColumnLayout {
                            id: columnLayout3

                            RowLayout {
                                id: waiting
                                Layout.preferredHeight: parent.height * 0.7
                                Layout.fillWidth: true
                                spacing: 10
                                Button {

                                    text: qsTr("1")

                                    Layout.fillHeight: true
                                    Layout.preferredWidth: height
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

                            Text {
                                text: "Buffer zone"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignBottom
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                font.pointSize: 20
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                            }
                        }



                    }

                    DesignEffect {
                        effects: [
                            DesignDropShadow {
                            }
                        ]
                    }
                }

                Rectangle {
                    id: rectangle4
                    width: 200
                    height: 200
                    color: "#00ffffff"
                    Layout.margins: 20
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    GridLayout {
                        id: note
                        visible: true
                        anchors.left: parent.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: -parent.width * 0.15
                        anchors.rightMargin: 0
                        anchors.topMargin: 0
                        anchors.bottomMargin: 0

                        // anchors.right: parent.right
                        // anchors.bottom: waiting.bottom
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
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }

                            Text {

                                Layout.preferredHeight: 50
                                text: "Pallet thấp"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }

                            Text {

                                Layout.preferredHeight: 50
                                text: "Pallet cao"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }

                            Text {

                                Layout.preferredHeight: 50
                                text: "Pallet kép"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                            Text {

                                Layout.preferredHeight: 50
                                text: "Pallet đơn"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                        }
                    }

                    Slider {
                        id: slider
                        height: 17

                        value: item_count
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.right: parent.left
                        anchors.leftMargin: 0
                        anchors.rightMargin: -parent.width * 0.15
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

            }

        }



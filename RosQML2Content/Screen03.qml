import QtQuick 6.2
import QtQuick.Controls 6.2

import backendqt 1.0

Page {
    id: page3


    StackView {
        id: stackView
        anchors.left: toolBar.right
        anchors.right: parent.right
        anchors.top: rectangle.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.topMargin: 0
    }

    Rectangle {
        id: rectangle
        height: 72
        color: "#2196F3"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0

        Text {
            id: text1
            color: "#ffffff"
            text: qsTr("MONITORING")
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.italic: true
            font.bold: true
            font.pointSize: 50
        }
    }

    ToolBar {
        id: toolBar
        width: page3.width * 0.25
        anchors.left: parent.left
        anchors.top: rectangle.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0

        Button {
            id: fastech_button
            height: parent.height * 0.2
            text: qsTr("FASTECH")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 0
            font.italic: false
            font.pointSize: 35
            onClicked: {
                stackView.push(fastech_component)
            }
        }

        Button {
            id: arduino_button
            height: parent.height * 0.2
            text: qsTr("ARDUINO")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: fastech_button.bottom
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 0
            font.pointSize: 35
            font.italic: false
        }

        Button {
            id: safety_button
            height: parent.height * 0.2
            text: qsTr("SAFETY")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: arduino_button.bottom
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 0
            font.pointSize: 35
            font.italic: false
        }
    }
    Component {
        id: fastech_component
        Page {
            id: fastech_page

            Column {
                id: name
                width: parent.width * 0.5
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 0
                anchors.topMargin: 0
                anchors.bottomMargin: 0
                topPadding: 10
                leftPadding: 10
                spacing: 10

                Text {
                    id: name_collumn
                    height: parent.height * 0.1
                    text: qsTr("Input")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    font.pointSize: 25
                    font.italic: true
                }

                Text {
                    id: sensor_1
                    height: parent.height * 0.1
                    text: qsTr("Sensor ready")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: name_collumn.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    font.pointSize: 25
                    font.italic: true
                }

                Text {
                    id: sensor_2
                    height: parent.height * 0.1
                    text: qsTr("Allow Entry")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: sensor_1.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    font.pointSize: 25
                    font.italic: true
                }

                Text {
                    id: sensor_3
                    height: parent.height * 0.1
                    text: qsTr("Allow pick/place")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: sensor_2.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    font.pointSize: 25
                    font.italic: true
                }

                Text {
                    id: sensor_4
                    height: parent.height * 0.1
                    text: qsTr("Allow go out")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: sensor_3.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    font.pointSize: 25
                    font.italic: true
                }

                Text {
                    id: sensor_5
                    height: parent.height * 0.1
                    text: qsTr("LD/ULD Emergency")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: sensor_4.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    font.pointSize: 25
                    font.italic: true
                }

                Text {
                    id: sensor_6
                    height: parent.height * 0.1
                    text: qsTr("Finish ACK")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: sensor_5.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    font.pointSize: 25
                    font.italic: true
                }

                Text {
                    id: sensor_7
                    height: parent.height * 0.1
                    text: qsTr("Cell number bit 1 of LD/ULD")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: sensor_6.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    font.pointSize: 25
                    font.italic: true
                }

                Text {
                    id: sensor_8
                    height: parent.height * 0.1
                    text: qsTr("Cell number bit 2 of LD/ULD")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: sensor_7.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    font.pointSize: 25
                    font.italic: true
                }
            }
            Column {
                id: rear
                width: parent.width * 0.25
                anchors.left: name.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 0
                anchors.topMargin: 0
                anchors.bottomMargin: 0

                Text {
                    id: name_collumn_rear
                    height: parent.height * 0.1
                    text: qsTr("Rear")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    font.pointSize: 25
                    font.italic: true
                }

                Text {
                    id: sensor_1_rear
                    height: parent.height * 0.1
                    text: qsTr("No data")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: name_collumn_rear.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 25
                    font.italic: true
                }

                Text {
                    id: sensor_2_rear
                    height: parent.height * 0.1
                    text: qsTr("No data")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: sensor_1_rear.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 25
                    font.italic: true
                }

                Text {
                    id: sensor_3_rear
                    height: parent.height * 0.1
                    text: qsTr("No data")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: sensor_2_rear.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 25
                    font.italic: true
                }

                Text {
                    id: sensor_4_rear
                    height: parent.height * 0.1
                    text: qsTr("No data")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: sensor_3_rear.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 25
                    font.italic: true
                }

                Text {
                    id: sensor_5_rear
                    height: parent.height * 0.1
                    text: qsTr("No data")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: sensor_4_rear.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 25
                    font.italic: true
                }

                Text {
                    id: sensor_6_rear
                    height: parent.height * 0.1
                    text: qsTr("No data")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: sensor_5_rear.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 25
                    font.italic: true
                }

                Text {
                    id: sensor_7_rear
                    height: parent.height * 0.1
                    text: qsTr("No data")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: sensor_6_rear.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 25
                    font.italic: true
                }

                Text {
                    id: sensor_8_rear
                    height: parent.height * 0.1
                    text: qsTr("No data")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: sensor_7_rear.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 25
                    font.italic: true
                }

                
                Connections {
                    target: backend
                    onGetFastechInputChanged: {
                        sensor_1_rear.text = backend.getFastechRear( 1 )
                        sensor_2_rear.text = backend.getFastechRear( 2 )
                        sensor_3_rear.text = backend.getFastechRear( 3 )
                        sensor_4_rear.text = backend.getFastechRear( 4 )
                        sensor_5_rear.text = backend.getFastechRear( 5 )
                        sensor_6_rear.text = backend.getFastechRear( 6 )
                        sensor_7_rear.text = backend.getFastechRear( 7 )
                        sensor_8_rear.text = backend.getFastechRear( 8 )

                    }
                }
                
            }

            Column {
                id: front
                anchors.left: rear.right
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 0
                anchors.rightMargin: 0
                anchors.topMargin: 0
                anchors.bottomMargin: 0
                Text {
                    id: name_collumn_front
                    height: parent.height * 0.1
                    text: qsTr("Front")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 25
                    font.italic: true
                    font.bold: true
                }

                Text {
                    id: sensor_1_front
                    height: parent.height * 0.1
                    text: qsTr("No data")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: name_collumn_front.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 25
                    font.italic: true
                }

                Text {
                    id: sensor_2_front
                    height: parent.height * 0.1
                    text: qsTr("No data")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: sensor_1_front.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 25
                    font.italic: true
                }

                Text {
                    id: sensor_3_front
                    height: parent.height * 0.1
                    text: qsTr("No data")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: sensor_2_front.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 25
                    font.italic: true
                }

                Text {
                    id: sensor_4_front
                    height: parent.height * 0.1
                    text: qsTr("No data")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: sensor_3_front.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 25
                    font.italic: true
                }

                Text {
                    id: sensor_5_front
                    height: parent.height * 0.1
                    text: qsTr("No data")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: sensor_4_front.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 25
                    font.italic: true
                }

                Text {
                    id: sensor_6_front
                    height: parent.height * 0.1
                    text: qsTr("No data")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: sensor_5_front.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 25
                    font.italic: true
                }

                Text {
                    id: sensor_7_front
                    height: parent.height * 0.1
                    text: qsTr("No data")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: sensor_6_front.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 25
                    font.italic: true
                }

                Text {
                    id: sensor_8_front
                    height: parent.height * 0.1
                    text: qsTr("No data")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: sensor_7_front.bottom
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 25
                    font.italic: true
                }

                Connections {
                    target: backend
                    onGetFastechOutputChanged: {
                        sensor_1_front.text = backend.getFastechFront( 1 )
                        sensor_2_front.text = backend.getFastechFront( 2 )
                        sensor_3_front.text = backend.getFastechFront( 3 )
                        sensor_4_front.text = backend.getFastechFront( 4 )
                        sensor_5_front.text = backend.getFastechFront( 5 )
                        sensor_6_front.text = backend.getFastechFront( 6 )
                        sensor_7_front.text = backend.getFastechFront( 7 )
                        sensor_8_front.text = backend.getFastechFront( 8 )

                    }
                }
            }
        }
    }
}

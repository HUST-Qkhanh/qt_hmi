import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    id: page2

    property int volume_current
    property string status_update_info : ""

    StackView {
        id: stackView
        anchors.left: toolBar.right
        anchors.right: parent.right
        anchors.top: rectangle.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.topMargin: 0

        initialItem: Loader {
            source: volume_component
        }
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
            text: qsTr("SETUP")
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
        width: page2.width * 0.25
        anchors.left: parent.left
        anchors.top: rectangle.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0

        Button {
            id: volume_button
            height: parent.height * 0.2
            text: qsTr("Volume")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 0
            font.italic: false
            font.pointSize: 35
            onClicked: {
                stackView.push(volume_component)
                volume_current = backend.getVolume()
            }
        }

        Button {
            id: maintain_button
            height: parent.height * 0.2
            text: qsTr("Update Model")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: volume_button.bottom
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 0
            font.pointSize: 35
            font.italic: false
            onClicked: {
                stackView.push(update_comp)
            }
        }

        // Button {
        //     id: shutdown_button
        //     height: parent.height * 0.2
        //     text: qsTr("Shutdown")
        //     anchors.left: parent.left
        //     anchors.right: parent.right
        //     anchors.top: maintain_button.bottom
        //     anchors.leftMargin: 0
        //     anchors.rightMargin: 0
        //     anchors.topMargin: 0
        //     font.pointSize: 35
        //     font.italic: false
        //     onClicked: {
        //         stackView.push(shutdown_component)
        //     }
        // }

        // Button {
        //     id: screensize_button
        //     height: parent.height * 0.2
        //     text: qsTr("Screen size")
        //     anchors.left: parent.left
        //     anchors.right: parent.right
        //     anchors.top: shutdown_button.bottom
        //     anchors.leftMargin: 0
        //     anchors.rightMargin: 0
        //     anchors.topMargin: 0
        //     font.pointSize: 35
        //     font.italic: false
        //     // onClicked: {
        //     //     stackView.push(shutdown_component)
        //     // }
        // }
    }
    Component {
        id: volume_component
        Page {
            id: volume_page

            Slider {
                id: slider
                height: volume_page.height * 0.5
                value: volume_current
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: mute_button.top
                anchors.leftMargin: 50
                anchors.rightMargin: 50
                anchors.topMargin: 50
                anchors.bottomMargin: 25
                stepSize: 1
                to: 100
                onValueChanged: {
                    volume_current = backend.setVolume(value)
                }
            }

            Button {
                id: mute_button
                width: volume_page.width * 0.25
                height: volume_page.width * 0.25
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: slider.left
                anchors.leftMargin: 0
                icon.height: 50
                icon.width: 50
                display: AbstractButton.IconOnly
                icon.source: "file:asset/mute.svg"
                background: Rectangle {
                    color: "#F5F5F5"
                    radius: 50
                    border.color: "#FFFFFF"
                    border.width: 5
                }

                onPressedChanged: {
                    if (pressed) {
                        background.color = "#B0BEC5"
                    } else {
                        background.color = "#F5F5F5"
                    }
                }
                onClicked: {
                    slider.value = backend.setVolume(0)
                    volume_current = 0
                }
            }

            Button {
                id: sound_button

                width: volume_page.width * 0.25
                height: volume_page.width * 0.25
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: slider.right
                anchors.rightMargin: 0
                icon.width: 50
                icon.source: "file:asset/sound.svg"
                icon.height: 50
                display: AbstractButton.IconOnly
                background: Rectangle {
                    color: "#F5F5F5"
                    radius: 50
                    border.color: "#FFFFFF"
                    border.width: 5
                }

                onPressedChanged: {
                    if (pressed) {
                        background.color = "#B0BEC5"
                    } else {
                        background.color = "#F5F5F5"
                    }
                }
                onClicked: {
                    slider.value = backend.setVolume(100)
                    volume_current = 100
                }
            }
        }
    }
    Component {
        id: update_comp
        Page {
            id: update_model_page

            Button {
                id: update_model_button
                width: update_model_page.width * 0.25
                height: update_model_page.height * 0.25
                text: qsTr("Chọn File")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 50
                font.family: "Times New Roman"
                font.pointSize: 30

                display: AbstractButton.TextOnly
                background: Rectangle {
                    color: "#F5F5F5"
                    radius: 50
                    border.color: "#FFFFFF"
                    border.width: 5
                }
                // onClicked: backend.shutdown(0)
                // onPressedChanged: {
                //     if (pressed) {
                //         background.color = "#B0BEC5"
                //     } else {
                //         background.color = "#F5F5F5"
                //     }
                // }
                onClicked: {
                    var filePath = backend.openFileDialog()
                    if (filePath !== "") {
                        console.log("Đường dẫn file đã chọn: " + filePath)
                    }
                }
            }

            Text {
                id: status_header
                text: qsTr("Trạng thái update")
                anchors.left: update_model_button.right
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.leftMargin: 50
                anchors.rightMargin: 0
                anchors.topMargin: 50
                font.pixelSize: 20
                font.family: "Times New Roman"
            }

            Text {
                id: status
                text: status_update_info
                anchors.left: update_model_button.right
                anchors.right: parent.right
                anchors.top: status_header.bottom
                anchors.bottom: parent.bottom
                anchors.leftMargin: 50
                anchors.rightMargin: 50
                anchors.topMargin: 50
                anchors.bottomMargin: 50
                font.pixelSize: 20
                font.family: "Times New Roman"
            }
        }
    }

    Page {
        id: change_map_page

        Button {
            id: map_2
            width: change_map_page.width * 0.45
            height: change_map_page.width * 0.25
            text: qsTr("AGV1000_2F")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            font.pointSize: 25

            display: AbstractButton.TextOnly
            background: Rectangle {
                color: "#F5F5F5"
                radius: 50
                border.color: "#FFFFFF"
                border.width: 5
            }
        }

        Button {
            id: map_1

            width: change_map_page.width * 0.45
            height: change_map_page.width * 0.25
            text: qsTr("TENDO_1F")
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 20
            font.pointSize: 25
            display: AbstractButton.TextOnly
            background: Rectangle {
                color: "#F5F5F5"
                radius: 50
                border.color: "#FFFFFF"
                border.width: 5
            }
        }
    }
    // onUpdateStatusChanged: {
    //     status_update_info += backend.updateStatus
    // }
}

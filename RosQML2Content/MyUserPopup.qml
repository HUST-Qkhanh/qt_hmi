import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.2
import RosQML2

Rectangle {
    id: userPopup
    width: 600
    height: 400
    visible: true
    color: Constants.surfaceColor
    radius: 5

    /*

   ____  ____   ___  ____  _____ ____ _____ ___ _____ ____
  |  _ \|  _ \ / _ \|  _ \| ____|  _ \_   _|_ _| ____/ ___|
  | |_) | |_) | | | | |_) |  _| | |_) || |  | ||  _| \___ \
  |  __/|  _ <| |_| |  __/| |___|  _ < | |  | || |___ ___) |
  |_|   |_| \_\\___/|_|   |_____|_| \_\|_| |___|_____|____/


*/
    property int state: 0
    property string _headerLayoutText: "Trạng thái"

    // // Calculate scale factors
    // property real scaleFactorWidth: parent.width / 600
    // property real scaleFactorHeight: parent.height / 400

    // // Use the smaller factor to maintain aspect ratio
    // property real scaleFactor: Math.min(scaleFactorWidth, scaleFactorHeight)

    signal popupLoaded
    signal addDataRequest
    signal saveDataRequest
    signal deleteDataRequest

    /*

    ____ ___  _   _ _   _ _____ ____ _____ ___ ___  _   _ ____
   / ___/ _ \| \ | | \ | | ____/ ___|_   _|_ _/ _ \| \ | / ___|
  | |  | | | |  \| |  \| |  _|| |     | |  | | | | |  \| \___ \
  | |__| |_| | |\  | |\  | |__| |___  | |  | | |_| | |\  |___) |
   \____\___/|_| \_|_| \_|_____\____| |_| |___\___/|_| \_|____/


*/
    Connections {
        target: page1
        onLoadPopupType: {
            if (type === 0) {
                console.log("load queue view");

                popupLoader.source = "qrc:/RosQML2Content/MyGrid_queue.qml";
                popupLoaded();
            } else if (type === 1) {
                popupLoader.source = "qrc:/RosQML2Content/MyBuffer_item.qml";
                popupLoaded();
            }
        }
    }

    Connections {
        target: model_button
        onClicked: {
            popupLoader.source = "qrc:/RosQML2Content/MyModel_pallet.qml";
            popupLoaded();
        }
    }

    Connections {
        target: confirmShow
        onConfirmPressed: {
            console.log("confirmed");
            statusIndicate.close();
        }
        onCancelPressed: {
            console.log("cancel");
            statusIndicate.close();
        }
    }

    // Connections {
    //     target: backend
    //     onAddQueueTaskFailed: {}
    // }


    /*

   _____ _     _____ __  __ _____ _   _ _____ ____
  | ____| |   | ____|  \/  | ____| \ | |_   _/ ___|
  |  _| | |   |  _| | |\/| |  _| |  \| | | | \___ \
  | |___| |___| |___| |  | | |___| |\  | | |  ___) |
  |_____|_____|_____|_|  |_|_____|_| \_| |_| |____/


*/

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 10
        anchors.bottomMargin: 10

        Loader {
            id: popupLoader
            Layout.bottomMargin: 10
            Layout.fillHeight: true
            Layout.fillWidth: true
            asynchronous: true
        }

        RowLayout {
            id: footer_layout
            layoutDirection: Qt.RightToLeft
            spacing: 10
            // Layout.fillHeight: true
            Layout.maximumHeight: 0.1 * parent.height
            Layout.fillWidth: true

            RoundButton {
                id: view_button
                radius: Constants.borderRadiusMedium
                // height: parent.height * 0.12
                text: "Trở về"
                rightInset: 0
                leftInset: 0
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.preferredWidth: parent.width * 0.15
                flat: false
                highlighted: false
                rightPadding: 0
                leftPadding: 0
                bottomPadding: 0
                topPadding: 0
                bottomInset: 0
                topInset: 0
                Layout.fillHeight: true

                font.pointSize: 25 * view_button.height / 118
                font.family: "ubuntu"
                font.bold: true
                display: AbstractButton.TextOnly
                onClicked: {
                    popup_close();
                }
                //     animation_goout.start();
                //     animation_forward.start();
            }
            Rectangle {
                id: rectangle
                color: "#00ffffff"
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillHeight: true
            }

            RoundButton {
                id: del_button
                radius: Constants.borderRadiusMedium
                // height: parent.height * 0.12
                text: "Xóa"
                Layout.preferredWidth: parent.width * 0.15
                rightInset: 0
                leftInset: 0
                highlighted: true
                bottomInset: 0
                topInset: 0
                Layout.fillHeight: true

                font.pointSize: 25 * del_button.height / 118
                font.family: "ubuntu"
                font.bold: true
                display: AbstractButton.TextOnly
                onClicked: {
                    userPopup.deleteDataRequest();
                }
            }
            RoundButton {
                id: save_button
                radius: Constants.borderRadiusMedium
                // height: parent.height * 0.12
                text: "Lưu"
                rightInset: 0
                leftInset: 0
                highlighted: true
                Layout.preferredWidth: parent.width * 0.15
                rightPadding: 0
                leftPadding: 0
                bottomPadding: 0
                topPadding: 0
                bottomInset: 0
                topInset: 0
                Layout.fillHeight: true

                font.pointSize: 25 * save_button.height / 118
                font.family: "ubuntu"
                font.bold: true
                display: AbstractButton.TextOnly
                onClicked: {
                    userPopup.saveDataRequest();
                }
            }
            RoundButton {
                id: add_button
                radius: Constants.borderRadiusMedium
                // height: parent.height * 0.12
                text: "Thêm"
                rightInset: 0
                leftInset: 0
                highlighted: true
                flat: false
                Layout.preferredWidth: parent.width * 0.15
                bottomInset: 0
                topInset: 0
                rightPadding: 0
                leftPadding: 0
                bottomPadding: 0
                topPadding: 0
                Layout.fillHeight: true

                font.pointSize: 25 * add_button.height / 118
                font.family: "ubuntu"
                font.bold: true
                display: AbstractButton.TextOnly
                onClicked: {
                    userPopup.addDataRequest();
                }
            }

            RoundButton {
                id: model_button
                visible: true
                radius: Constants.borderRadiusMedium
                // height: parent.height * 0.12
                text: "Model"
                rightInset: 0
                leftInset: 0
                highlighted: true
                // Layout.fillWidth: true
                bottomInset: 0
                topInset: 0
                rightPadding: 0
                bottomPadding: 0
                topPadding: 0
                leftPadding: 0
                Layout.preferredWidth: parent.width * 0.15
                Layout.fillHeight: true

                font.pointSize: 25 * view_button.height / 118
                font.family: "ubuntu"
                font.bold: true
                display: AbstractButton.TextOnly
                onClicked: {
                    backend.updateMerchandiseList();
                    backend.updateCountList();
                }

                // modelViewRequest();
                // statusIndicate.open();
                // onPressedChanged: {
                //     if (pressed) {
                //         background.color = "#607D8B";
                //     } else {
                //         background.color = "#FFFFFF";
                //     }
                // }
            }
        }
    }
}

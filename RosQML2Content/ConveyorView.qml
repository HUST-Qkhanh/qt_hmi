import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import RosQML2

Item {
    id: root
    clip: true

    signal addNew

    Rectangle {
        id: rectangle
        color: "lightblue"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        height: parent.height * 0.3

        Text {
            text: "Pallets on Conveyor "
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 0.3 * height
        }
    }

    RowLayout {
        id: rowLayout
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: rectangle.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 5
        anchors.bottomMargin: 0

        RoundButton {
            id: button
            radius: 5
            rightInset: 0
            leftInset: 0
            bottomInset: 0
            topInset: 0
            padding: 12
            text: qsTr("Add")
            Layout.fillHeight: true
            Layout.preferredWidth: height
            font.pointSize: 0.1 * height
            display: AbstractButton.TextUnderIcon
            icon.height: 0.3 * height
            icon.width: 0.3 * height
            icon.color: Constants.textColorOnSecondary
            icon.source: "asset/add_square_light.svg"
            flat: false
            onClicked: {
                root.addNew();
            }
        }
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ListView {
                id: listView
                boundsMovement: Flickable.StopAtBounds
                clip: true
                spacing: 10
                snapMode: ListView.SnapToItem
                boundsBehavior: Flickable.OvershootBounds
                flickableDirection: Flickable.HorizontalFlick
                model: backend.pQueueListModel
                orientation: ListView.Horizontal // Set to horizontal

                // Adjust ScrollView content width for horizontal scrolling
                contentWidth: contentItem.width
                Layout.fillHeight: true

                delegate: DraggableItem {
                    Rectangle {
                        id: boxItem
                        width: height//textLabel.width * 2 // Adjust width for horizontal layout
                        height: listView.height   // Match ListView height
                        color: "lightGrey"
                        radius: Constants.borderRadiusSmall
                        // border.width: 1
                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            Text {
                                id: textLabel
                                // anchors.centerIn: parent
                                text: modelData["Merchandise"]
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pointSize: 45 * listView.height / 425
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                            }
                            Text {
                                id: textLabel1
                                // anchors.centerIn: parent
                                text: modelData["queue"]
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pointSize: 45 * listView.height / 425
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                            }
                        }

                        Component.onCompleted: {
                            // console.log("pallet_type_view: " + modelData["pallet_type"]);
                            var type = +modelData["pallet_type"];
                            // console.log("paleet type: " + type);
                            switch (type) {
                            case 0:
                                boxItem.color = "#ffeb3b";
                                break;
                            case 1:
                                boxItem.color = "#ff9800";
                                break;
                            case 3:
                                boxItem.color = "#2196f3";
                                break;
                            case 4:
                                boxItem.color = "#4caf50";
                                break;
                            default:
                                boxItem.color = "#4caf50";
                                break;
                            }
                        }
                    }

                    draggedItemParent: root

                    onMoveItemRequested: {
                        backend.switchDocs(from, to);
                    }
                    onItemClicked: {
                        // boxItem.color = "light blue";
                        console.log("request for: ", modelData["queue"]);
                        page1.queuePalletRequest(modelData["queue"]);
                    }
                }
                Component.onCompleted: {
                    console.log("ListView initialized, waiting for model...");
                }
            }
        }
    }
}

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
            id: scrollView
            Layout.fillWidth: true
            Layout.fillHeight: true
            ScrollBar.horizontal.interactive: true

            ListView {
                id: listView
                interactive: true
                pressDelay: 10
                boundsMovement: Flickable.StopAtBounds
                clip: true
                spacing: 10
                snapMode: ListView.SnapToItem
                boundsBehavior: Flickable.OvershootBounds
                flickableDirection: Flickable.HorizontalFlick
                model: backend.pQueueListModel
                orientation: ListView.Horizontal // Set to horizontal

                contentWidth: contentItem.width
                Layout.fillHeight: true

                delegate: DraggableItem {
                    Rectangle {
                        id: boxItem
                        width: height
                        height: listView.height
                        color: "lightGrey"
                        radius: Constants.borderRadiusSmall

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            Text {
                                text: modelData["Merchandise"]
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pointSize: 45 * listView.height / 425
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                            }
                            Text {
                                text: modelData["queue"]
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pointSize: 45 * listView.height / 425
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                            }
                        }

                        Component.onCompleted: {
                            var type = +modelData["pallet_type"];
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

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            onClicked: {
                                console.log("Item clicked: ", modelData["queue"]);
                                page1.queuePalletRequest(modelData["queue"]);
                            }

                            onPressAndHold: {
                                console.log("Item press-and-hold: ", modelData["queue"]);
                                // Handle the press and hold action
                            }
                        }
                    }

                    draggedItemParent: root

                    onMoveItemRequested: {
                        backend.switchDocs(from, to);
                    }
                }

                MultiPointTouchArea {
                    anchors.fill: parent
                    minimumTouchPoints: 2
                    maximumTouchPoints: 2

                    onTouchUpdated: function (touchPoints) {
                        console.log("2 finger");
                        if (touchPoints.length === 2) {
                            var dx = (touchPoints[0].x - touchPoints[0].startX + touchPoints[1].x - touchPoints[1].startX) / 2;
                            listView.contentX -= dx;  // Handle custom horizontal scrolling
                        }
                    }

                    onPressed: function (touchPoints) {
                        if (touchPoints.length === 1) {
                            console.log("1 finger");
                            // Allow single-finger touch events to propagate to MouseArea
                            touchPoints[0].accept();  // This allows MouseArea to process the single touch
                        }
                    }
                }
            }
        }
    }
}

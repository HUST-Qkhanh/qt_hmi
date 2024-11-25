import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: mainContent
    clip: true

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        Rectangle {
            color: "lightblue"
            height: 50
            Layout.fillWidth: true

            Text {
                anchors.centerIn: parent
                text: "Conveyor Pallets"
            }
        }

        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ListView {
                id: listView
                spacing: 10
                snapMode: ListView.SnapToItem
                boundsBehavior: Flickable.StopAtBounds
                flickableDirection: Flickable.HorizontalFlick
                model: backend.isQueueListModelLoaded ? backend.pQueueListModel : null//List1 {}
                orientation: ListView.Horizontal // Set to horizontal

                // Adjust ScrollView content width for horizontal scrolling
                contentWidth: contentItem.width
                Layout.fillHeight: true

                delegate: DraggableItem {
                    Rectangle {
                        id: boxItem
                        width: 120//textLabel.width * 2 // Adjust width for horizontal layout
                        height: listView.height   // Match ListView height
                        color: "lightGrey"/*{
                            var type = modelData["pallet_type"];

                            console.log("paleet type: " + modelData["pallet_type"]);

                            switch (type) {
                            case 0:
                                return "#ffeb3b";
                            case 1:
                                return "#ff9800";
                            case 3:
                                return "#2196f3";
                            case 4:
                                return "#4caf50";
                            default:
                                return "lightgrey";
                            }
                        }*/
                        radius: 10
                        border.width: 1
                        ColumnLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 5
                            anchors.rightMargin: 5
                            anchors.topMargin: 5
                            anchors.bottomMargin: 5
                            Text {
                                id: textLabel
                                // anchors.centerIn: parent
                                text: modelData["Merchandise"]
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pointSize: 10
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                            }
                            Text {
                                id: textLabel1
                                // anchors.centerIn: parent
                                text: modelData["pallet_type"]
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pointSize: 10
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                            }
                        }

                        Component.onCompleted: {
                            console.log("pallet_type_view: " + modelData["pallet_type"]);
                            var type = +modelData["pallet_type"];
                            console.log("paleet type: " + type);
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

                        // Right-side border for horizontal item separation
                        // Rectangle {
                        //     anchors {
                        //         top: parent.top
                        //         bottom: parent.bottom
                        //         right: parent.right
                        //     }
                        //     width: 2
                        //     color: "lightgrey"
                        // }
                    }

                    draggedItemParent: mainContent

                    onMoveItemRequested: {
                        // listView.model.move(from, to, 1);
                        // var updatedList = [];
                        // for (var i = 0; i < listView.model.count; i++) {
                        //     updatedList.push(listView.model.get(i));
                        // }

                        // console.log("updated list", updatedList);
                        backend.switchDocs(from, to)
                    }
                    onItemClicked: {
                        // boxItem.color = "light blue";
                        console.log("request for: ", modelData["queue"]);
                        queuePalletRequest(modelData["queue"]);
                    }
                    // onItemReleased:
                    // // boxItem.color = "light grey";
                    // {}
                    // onDragItemLoaded: {
                    //     console.log("pallet_type_view: " + modelData["pallet_type"]);
                    //     var type = modelData["pallet_type"];
                    //     switch (type) {
                    //     case 0:
                    //         boxItem.color = "#ffeb3b";
                    //         break;
                    //     case 1:
                    //         boxItem.color = "#ff9800";
                    //         break;
                    //     case 3:
                    //         boxItem.color = "#2196f3";
                    //         break;
                    //     case 4:
                    //         boxItem.color = "#4caf50";
                    //         break;
                    //     default:
                    //         boxItem.color = "lightgrey";
                    //         break;
                    //     }
                    // }
                }
                Component.onCompleted: {
                    console.log("ListView initialized, waiting for model...");
                }

                Connections {
                    target: backend
                    onPQueueListModelChanged: {
                        console.log("Model updated, reloading ListView.");
                        listView.model = backend.pQueueListModel;
                    }
                }
            }
        }
    }
}

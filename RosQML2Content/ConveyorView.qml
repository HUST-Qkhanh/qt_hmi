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
                        color: "light grey"
                        radius: 10
                        border.width: 1

                        Text {
                            id: textLabel
                            anchors.centerIn: parent
                            text: modelData["Merchandise"]
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
                        listView.model.move(from, to, 1);
                        var updatedList = [];
                        for (var i = 0; i < listView.model.count; i++) {
                            updatedList.push(listView.model.get(i).name);
                        }

                        console.log("updated list", updatedList);
                    }
                    onItemClicked: {
                        boxItem.color = "light blue";
                        console.log("request for: ", name);
                    }
                    onItemReleased: {
                        boxItem.color = "light grey";
                    }
                }
                Component.onCompleted: {
                    console.log("ListView initialized, waiting for model...");
                }

                Connections {
                    target: backend
                    onPQueueListModelChanged: {
                        console.log("Model updated, reloading ListView.");
                        queueListView.model = backend.pQueueListModel;
                    }
                }
            }
        }
    }
}

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
        height: parent.height * 0.3

        Text {
            text: "Pallets on Conveyor"
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
        anchors.bottom: horizontalScrollBar.top
        anchors.margins: 10

        RoundButton {
            id: button
            radius: 5
            text: qsTr("Add")
            font.pointSize: height * 0.1
            display: AbstractButton.TextUnderIcon
            icon.height: height * 0.5
            icon.width: height * 0.5
            icon.source: "asset/add_square_fill.svg"
            highlighted: false
            rightInset: 0
            leftInset: 0
            bottomInset: 0
            topInset: 0
            padding: 0
            rightPadding: 0
            leftPadding: 0
            bottomPadding: 0
            topPadding: 0
            Layout.preferredWidth: height
            Layout.fillHeight: true
            onClicked: root.addNew()
        }

        ScrollView {
            id: scrollView
            Layout.fillWidth: true
            Layout.fillHeight: true
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            ListView {
                id: listView
                interactive: true
                spacing: 10
                flickableDirection: Flickable.HorizontalFlick
                model: backend.pQueueListModel
                orientation: ListView.Horizontal
                contentWidth: contentItem.width
                Layout.fillHeight: true

                property real savedPosition: 0
                clip: true

                function saveScrollPosition() {
                    savedPosition = contentX;
                }

                function restoreScrollPosition() {
                    contentX = savedPosition;
                }

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
                                font.pointSize: 45 * listView.height / 425
                                Layout.fillWidth: true
                            }
                            Text {
                                text: modelData["queue"]
                                horizontalAlignment: Text.AlignHCenter
                                font.pointSize: 45 * listView.height / 425
                                Layout.fillWidth: true
                            }
                        }

                        Component.onCompleted: {
                            var type = +modelData["pallet_type"];
                            switch (type) {
                            case 0: boxItem.color = "#ffeb3b"; break;
                            case 1: boxItem.color = "#ff9800"; break;
                            case 3: boxItem.color = "#2196f3"; break;
                            case 4: boxItem.color = "#4caf50"; break;
                            default: boxItem.color = "#4caf50"; break;
                            }
                        }
                    }

                    draggedItemParent: root

                    onMoveItemRequested: backend.switchDocs(from, to)
                    onItemClicked: {
                        console.log("request for:", modelData["queue"]);
                        page1.queuePalletRequest(modelData["queue"]);
                    }
                }

                onModelChanged: {
                    restoreScrollPosition();  // Restore scroll position after data changes
                }
            }
        }
    }

    ScrollBar {
        id: horizontalScrollBar
        orientation: Qt.Horizontal
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        policy: ScrollBar.AlwaysOn
        size: listView.width / listView.contentWidth
        position: listView.contentX / listView.contentWidth
        onPositionChanged: listView.contentX = position * listView.contentWidth
    }

    // Automatically reload the view when data changes
    Connections {
        target: backend
        onPQueueListModelChanged: {  // Replace 'onDataUpdated' with your actual signal
            listView.saveScrollPosition();  // Save current position
            listView.model = backend.pQueueListModel;  // Update model data
            listView.restoreScrollPosition();  // Restore saved position
        }
    }
}

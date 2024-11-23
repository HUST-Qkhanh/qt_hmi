import QtQuick
import QtQuick.Controls

Item {
    id: root

    default property Item contentItem
    property Item draggedItemParent

    signal moveItemRequested(int from, int to)
    signal itemClicked(string name)
    signal itemReleased

    property int scrollEdgeSize: 6
    property int _scrollingDirection: 0
    property ListView _listView: ListView.view

    width: leftPlaceholder.width + wrapperParent.width + rigthPlaceholder.width
    height: contentItem.height

    onContentItemChanged: {
        contentItem.parent = contentItemWrapper;
    }

    Rectangle {
        id: leftPlaceholder
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }
        width: 0
        color: "#00ffffff"
    }

    Item {
        id: wrapperParent
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: leftPlaceholder.right
        }
        width: contentItem.width

        Rectangle {
            id: contentItemWrapper
            color: "#00ffffff"
            anchors.fill: parent
            Drag.active: dragArea.drag.active
            Drag.hotSpot {
                x: contentItem.width / 2
                y: contentItem.height / 2
            }

            MouseArea {
                id: dragArea
                anchors.fill: parent
                cursorShape: Qt.SizeHorCursor
                drag.target: parent
                drag.smoothed: false

                onReleased: {
                    if (drag.active) {
                        emitMoveItemRequested();
                    }
                    itemReleased();
                }
                onPressed: {
                    if (!drag.active) {
                        console.log("Item clicked: ", model.name);
                        itemClicked(model.name);
                    }
                }
            }
        }
    }

    Rectangle {
        id: rigthPlaceholder
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: wrapperParent.right
        }
        width: 0
        color: "#00ffffff"
    }

    SmoothedAnimation {
        id: leftAnimation
        target: _listView
        property: "contentX"
        to: 0
        running: _scrollingDirection == -1
    }

    SmoothedAnimation {
        id: rightAnimation
        target: _listView
        property: "contentX"
        to: _listView.contentWidth - _listView.width
        running: _scrollingDirection == 1
    }

    Loader {
        id: leftDropAreaLoader
        active: model.index === 0
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: wrapperParent.horizontalCenter
        }
        width: contentItem.width
        sourceComponent: Component {
            DropArea {
                property int dropIndex: 0
            }
        }
        // Flag to check if the loader is loaded
        property bool isLoaded: false

        onLoaded: {
            // Set the flag to true when the component has finished loading
            isLoaded = true;
            console.log("DropArea is loaded");
        }

        onItemChanged: {
            // Reset the flag when the item is unloaded
            if (!item) {
                isLoaded = false;
            }
        }
    }

    DropArea {
        id: rightDropArea
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: wrapperParent.horizontalCenter
        }
        property bool isLast: model.index === _listView.count - 1
        width: isLast ? _listView.contentWidth - x : contentItem.width
        property int dropIndex: model.index + 1
    }

    states: [
        State {
            when: dragArea.drag.active
            name: "dragging"

            ParentChange {
                target: contentItemWrapper
                parent: draggedItemParent
            }
            PropertyChanges {
                target: contentItemWrapper
                opacity: 0.9
                anchors.fill: undefined
                width: contentItem.width
                height: contentItem.height
            }
            PropertyChanges {
                target: wrapperParent
                width: 0
            }
            PropertyChanges {
                target: root
                _scrollingDirection: {
                    var xCoord = _listView.mapFromItem(dragArea, dragArea.mouseX, 0).x;
                    if (xCoord < scrollEdgeSize) {
                        -1;
                    } else if (xCoord > _listView.width - scrollEdgeSize) {
                        1;
                    } else {
                        0;
                    }
                }
            }
        },
        State {
            when: rightDropArea.containsDrag
            name: "droppingRight"
            PropertyChanges {
                target: rigthPlaceholder
                width: contentItem.width
            }
            PropertyChanges {
                target: rightDropArea
                width: contentItem.width * 2
            }
        },
        State {
            when: leftDropAreaLoader.isLoaded && leftDropAreaLoader.item.containsDrag
            name: "droppingLeft"
            PropertyChanges {
                target: leftPlaceholder
                width: contentItem.width
            }
            PropertyChanges {
                target: leftDropAreaLoader
                width: contentItem.width * 2
            }
        }
    ]

    function emitMoveItemRequested() {
        var dropArea = contentItemWrapper.Drag.target;
        if (!dropArea) {
            return;
        }
        var dropIndex = dropArea.dropIndex;

        if (model.index < dropIndex) {
            dropIndex--;
        }
        if (model.index === dropIndex) {
            return;
        }
        root.moveItemRequested(model.index, dropIndex);

        makeDroppedItemVisibleTimer.start();
    }

    Timer {
        id: makeDroppedItemVisibleTimer
        interval: 0
        onTriggered: {
            _listView.positionViewAtIndex(model.index, ListView.Contain);
        }
    }
}

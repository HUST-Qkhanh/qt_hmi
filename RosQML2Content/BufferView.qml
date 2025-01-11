import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import RosQML2

Item {
    id: root
    clip: true

    signal addNew
    signal itemClicked
    signal onReleased

    Rectangle {
        id: rectangle
        color: Constants.secondaryLightColor
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        height: parent.height * 0.3

        Text {
            text: "Pallets on Buffer "
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 0.3 * height
            fontSizeMode: Text.VerticalFit
        }
    }

    RowLayout {
        id: rowLayout
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: rectangle.bottom
        anchors.bottom: horizontalScrollBar.top
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 5
        anchors.bottomMargin: 10
        ScrollView {
            hoverEnabled: false
            enabled: true
            Layout.fillWidth: true
            Layout.fillHeight: true
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            ListView {
                id: listView
                boundsMovement: Flickable.StopAtBounds
                pixelAligned: true
                // highlightRangeMode: ListView.ApplyRange
                interactive: true
                clip: true
                spacing: 10
                snapMode: ListView.SnapToItem
                boundsBehavior: Flickable.StopAtBounds
                flickableDirection: Flickable.HorizontalFlick
                // model: backend.isQueueListModelLoaded ? backend.pQueueListModel : null//List1 {}
                model: backend.pBufferListModel
                orientation: ListView.Horizontal // Set to horizontal

                // Adjust ScrollView content width for horizontal scrolling
                contentWidth: contentItem.width
                Layout.fillHeight: true

                delegate: Rectangle {
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
                            text: modelData["id_hang"]
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: 45 * listView.height / 425
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                        }
                        Text {
                            id: textLabel1
                            // anchors.centerIn: parent
                            text: modelData["status"]
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: 45 * listView.height / 425
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                        }
                    }
                    MouseArea {
                        id: dragArea
                        anchors.fill: parent
                        // cursorShape: Qt.SizeHorCursor
                        drag.target: parent
                        drag.smoothed: false

                        onPressAndHold: {
                            // boxItem.color = "light blue";
                            console.log("request for: ", modelData["stt"]);
                            bufferPalletRequest(modelData["stt"]);
                        }
                    }

                    Component.onCompleted: {
                        // console.log("pallet_type_view: " + modelData["pallet_type"]);
                        var type = +modelData["type"];
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
                        case 2:
                            boxItem.color = "#4caf50";
                            break;
                        default:
                            boxItem.color = "lightGrey";
                            break;
                        }
                    }
                }
                Component.onCompleted: {
                    console.log("ListView initialized, waiting for model...");
                }
            }
        }
    }
    ScrollBar {
        id: horizontalScrollBar
        orientation: Qt.Horizontal
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        // Bind to the ListView's horizontal position
        policy: ScrollBar.AlwaysOn
        size: listView.width / listView.contentWidth
        position: listView.contentX / listView.contentWidth
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        onPositionChanged: listView.contentX = position * listView.contentWidth
    }
}

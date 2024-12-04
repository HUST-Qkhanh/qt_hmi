import QtQuick
import QtQuick.Controls

DropArea {
    id: root
    property int dropIndex
    property alias dropAreaWidth: dropIndicator.width

    Rectangle {
        id: dropIndicator
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: dropIndex === 0 ? parent.horizontalCenter : undefined
            right: dropIndex === 0 ? undefined : parent.horizontalCenter
        }
        width: 0
        opacity: root.containsDrag ? 0.8 : 0.0
        color: "red"
    }

    onDropAreaWidthChanged: {
        // console.log("dropIndicator.width", dropIndicator.width);
        // console.log("dropAreaWidth", dropAreaWidth)
    }
}

import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Window 2.3

Item {
    id: root
    width: 300
    height: 300
    visible: true

    property bool attached: true
    property int previousX
    property int previousY

    property int attachedX
    property int attachedY

    signal detach
    signal attach

    Rectangle {
        id: topBar

        height: 30
        color: "gray"
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        Button {
            id: detachButton
            width: 20
            height: 20

            anchors {
                right: parent.right
                top: parent.top
                margins: 5
            }

            text: "D"

            onClicked: attached = !attached
        }
    }

    Rectangle {
        id: bodyFiller
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            top: topBar.bottom
        }

        color: "red"
    }

    Component.onCompleted: {
        attachedX = root.x
        attachedY = root.y
    }

    onAttachedChanged: {
        if (attached) {
            root.x = attachedX
            root.y = attachedY
        } else {
            root.x = 0
            root.y = 0;
        }
    }
}

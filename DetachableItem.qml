import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Window 2.3

Item {
    id: root
    width: 300
    height: 300
    visible: true

    // Holds the state of the item: attached/detached
    property bool attached: true
    // Holds coordinates of the item when it is attached
    property int attachedX
    property int attachedY

    // Just top gray line
    Rectangle {
        id: topBar

        height: 30
        color: "gray"
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        // Button which negates property 'attached' on click
        Button {
            id: detachButton
            height: 20

            anchors {
                right: parent.right
                top: parent.top
                margins: 5
            }

            text: attached ? "Detach" : "Attach"

            onClicked: attached = !attached
        }
    }

    // Just a body filler to see the item borders when it is attached
    Rectangle {
        id: bodyFiller
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            top: topBar.bottom
        }

        color: "green"
    }

    // filling attached coordinates after item was created
    Component.onCompleted: {
        attachedX = root.x
        attachedY = root.y
    }

    // adjusting position according to state
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

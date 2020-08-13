import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: rootWindow
    visible: true
    width: 400
    height: 400
    title: qsTr("DetachableItemExample")

    // Variable which will contain the Item you want to detach.
    // It is helpful to have an item to not search for proper one in 'data' of the rootWindow
    property var detachableItem

    Component.onCompleted: {
        // Dynamically creating the item we want to detach
        // How to create components dynamically: https://doc.qt.io/qt-5/qtqml-javascript-dynamicobjectcreation.html
        detachableItem = Qt.createQmlObject('import QtQuick 2.0; DetachableItem { x: 50; y: 50 }',
                                            rootWindow,
                                            "test")
        // Dynamically create connection for our  detachable item
        var connection = Qt.createQmlObject('import QtQuick 2.0; Connections { target: detachableItem
                                            onAttachedChanged: detachableItem.attached ? pullItem() : wrap.pushItem(detachableItem) }',
                                            rootWindow,
                                            "test")
    }

    // Window, which will pop up after you detach the item from rootWindow.
    Window {
        id: wrap

        visible: false
        title: "WoooHooo! It is detached!"

        property var detachableItem

        // To make item a child of this window, you need to push it into 'data' property of the window,
        // which is just a list of all children.
        function pushItem(item) {
            detachableItem = item
            wrap.data.push(detachableItem)
            // Adjust window's geometry to item's parameters
            wrap.setGeometry(item.x, item.y, item.width, item.height)
            wrap.visible = true
        }
    }

    // Pull item back to main window. Same way as pushing to detached window
    function pullItem() {
        detachableItem = wrap.detachableItem
        data.push(detachableItem)
        wrap.close()
    }
}

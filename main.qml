import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: rootWindow
    visible: true
    width: 400
    height: 400
    title: qsTr("DetachableItemExample")

    // Item you want to detach.
    DetachableItem {
        id: detachableItem

        objectName: "DetachableItem"

        x: 50
        y: 50

        // ractic on property change
        onAttachedChanged: {
            if (attached) {     // state changed from detached to attached
                // pushing item back to main window and closing auxillary window
                pushItem(objectName, auxiliaryWindow, rootWindow)
                auxiliaryWindow.close()
            } else {            // state changed from attached to detached
                // pushing item from main window to auxillary window
                pushItem(objectName, rootWindow, auxiliaryWindow)
                // adjusting auzillary window's geometry and showing it
                auxiliaryWindow.setGeometry(x, y, width, height)
                auxiliaryWindow.show()
            }
        }
    }

    // Window, which will pop up after you detach the item from rootWindow.
    Window {
        id: auxiliaryWindow

        visible: false
        title: "WoooHooo! It is detached!"
    }

    // Searches for object with objectName inside parent's property 'data'.
    // If object found it is pushed to new parent's 'data' and becomes it's child
    // @param objName name of object to search for.
    // Every object has property 'objectName', but it is empty by default
    // @param parent object where to seach
    // @param newParent object to push child into
    function pushItem(objName, parent, newParent) {
        var index = indexOfObject(objName, parent)
        if (index === -1) {
            console.debug("Cound't find object with name \"" + objName + "\"")
            return
        } else {
            newParent.data.push(parent.data[index])
        }
    }

    // Searches for object with objectName inside parent's property 'data'
    // @param objName object name to search for
    // @param parant object where to search
    // @return -1 if not found, index if found
    function indexOfObject(objName, parent) {
        for (var i = 0 ; i < parent.data.length; i++) {
            if (parent.data[i].objectName === objName)
                return i
        }
        return -1
    }
}

import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: rootWindow
    visible: true
    width: 400
    height: 400
    title: qsTr("DetachableItemExample")

    property var detachableItem

    Component.onCompleted: {
        detachableItem = Qt.createQmlObject('import QtQuick 2.0; WindowItem { x: 50; y: 50 }',
                                            rootWindow,
                                            "test")
        var connection = Qt.createQmlObject('import QtQuick 2.0; Connections { target: detachableItem
                         onAttachedChanged: detachableItem.attached ? pullItem() : wrap.pushItem(detachableItem) }',
                           rootWindow,
                           "test")
    }

    Window {
        id: wrap

        visible: false
        title: "WoooHooo! It is detached!"

        function pushItem(item) {
            wrap.data.push(item)
            wrap.setGeometry(item.x, item.y, item.width, item.height)
            wrap.visible = true
        }
    }

    function pullItem() {
        detachableItem = wrap.data[0]
        data.push(detachableItem)
        wrap.close()
    }
}

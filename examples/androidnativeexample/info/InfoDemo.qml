import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "../theme"

Page {
    id: page
    actionBar: ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("Information")
        showTitle: true

        onActionButtonClicked: back();
        z: 10
    }

    VisualItemModel {
        id: itemModel

        ListItem {
            title: "Environment.DIRECTORY_DCIM"
            subtitle: Environment.DIRECTORY_DCIM
            interactive: false
            width: page.width
        }

        ListItem {
            title: "Debug.getNativeHeapSize"
            subtitle: (Debug.getNativeHeapSize() / 1024 / 1024).toFixed(2) + "MB";
            interactive: false
            width: page.width
        }

        ListItem {
            title: "Debug.getNativeHeapAllocatedSize"
            subtitle: (Debug.getNativeHeapAllocatedSize() / 1024 / 1024).toFixed(2) + "MB";
            interactive: false
            width: page.width
        }
    }


    ListView {
        anchors.fill: parent
        model: itemModel
    }
}

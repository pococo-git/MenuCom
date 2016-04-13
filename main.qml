import QtQuick 2.6
import QtQuick.Controls 1.5
import QtQuick.Dialogs 1.2

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("MenuCom")

    menuBar: MenuBar {
        Menu {
            title: qsTr("Sync")
            MenuItem {
                text: qsTr("Download")
                onTriggered: console.log("Open action triggered");
            }
            MenuItem {
                text: qsTr("Upload")
                onTriggered: console.log("Settingn action triggered");
            }
        }
        Menu {
            title: qsTr("Setting")
            MenuItem {
                text: qsTr("Account")
                onTriggered: console.log("Pass action triggered");
            }
            MenuItem {
                text: qsTr("Pass")
                onTriggered: console.log("Pass action triggered");
            }
        }
    }

    MainForm {
        anchors.fill: parent
    }

    MessageDialog {
        id: messageDialog
        title: qsTr("May I have your attention, please?")

        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }
}

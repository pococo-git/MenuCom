import QtQuick 2.6
import QtQuick.Controls 1.5
import QtQuick.Dialogs 1.2

import WeeklyMenuModel 1.0

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

    WeeklyMenuModel {
        id: wModel
    }

    MainForm {
        id: mainForm
        anchors.fill: parent
        wmModel: wModel
        uploadButton.onClicked: dataUpload()
        importButton.onClicked: dataImport()
        settingButton.onClicked: fileDialog.visible = true
        fileName: wModel.filePath
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        selectMultiple: false
        selectFolder: false
        nameFilters: ["CSV files (*.csv)"]
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)
            visible = false
            wmFileUpdate(fileDialog.fileUrl)
        }
        onRejected: {
            console.log("Canceled")
            visible = false
        }
        Component.onCompleted: visible = false
    }

    function wmFileUpdate(file) {
        console.debug("Weekly Menu File Update : " + file)
        wModel.filePath = file
    }

    function dataUpload() {
        if (mainForm.tabView.currentIndex == 0) {
            wModel.uploadFlag = true
            wModel.sync()
        }
    }

    function dataImport() {
        if (mainForm.tabView.currentIndex == 0) {
            wModel.importFlag = true
            wModel.sync()
        }
    }
}

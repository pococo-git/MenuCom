import QtQuick 2.6
import QtQuick.Controls 1.5
import QtQuick.Layouts 1.3

Item {
    width: 640
    height: 480

    property var wmModel
    property alias uploadButton: uploadButton
    property alias importButton: importButton
    property alias settingButton: settingButton
    property alias tabView: tabView
    property string fileName

    RowLayout {
        id: syncLayout
        height: 50
        Button {
            id: uploadButton
            text: "Upload"
        }
        Button {
            id: importButton
            text: "Import"
        }
        Button {
            id: settingButton
            text: "Setting"
        }
        Label {
            id: wmfileName
            text: "File : " + fileName
        }
    }

    TabView {
        id: tabView
        anchors.top: syncLayout.bottom
        anchors.topMargin: 5
        anchors.bottom: parent.bottom
        width: parent.width

        Tab {
            id: wTab
            anchors.fill: parent
            title: qsTr("Weekly")
            WeeklyMenuForm {
                id: wmForm
                anchors.fill: parent
                weeklyMenuMoel: wmModel
            }
        }
        Tab {
            id: mTab
            anchors.fill: parent
            title: qsTr("Monthly")

            RowLayout {
                anchors.centerIn: parent
                Button {
                    id: button1
                    text: qsTr("Press Me 1")
                }

                Button {
                    id: button2
                    text: qsTr("Press Me 2")
                }
            }
        }
        Tab {
            id: lTab
            anchors.fill: parent
            title: qsTr("List")
            ShoppingListForm {
                anchors.fill: parent
            }
        }
    }
}

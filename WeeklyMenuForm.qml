import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

Item {

    property string filledText
    Dialog {
        id: filledDialog

        contentItem: Rectangle {
            color: "lightskyblue"
            implicitWidth: 400
            implicitHeight: 400

            TextEdit {
                id: edit
                text: filledText
                color: "navy"
                anchors.centerIn: parent
                enabled: false
//                visible: false
            }
            Row {
                spacing: 5
                Button {
                    text: edit.enabled ? "確定" : "編集"
                    onClicked: {
                        edit.enabled = !edit.enabled
                    }
                }
                Button {
                    text: "キャンセル"
                    onClicked: {
                        edit.enabled = false
                        edit.text = filledText
                        filledDialog.reject()
                    }
                }
                Button {
                    text: "OK"
                    enabled: !edit.enabled
                    onClicked: {
                        edit.enabled = false
                        filledDialog.accept()
                    }
                }
            }
        }
    }

    ListModel {
        id: wModel
        ListElement {
            breakfast: "バナナ"
            lunch: "パン"
            dinner: "ご飯"
            date: "4/11 (月)"
        }
        ListElement {
            breakfast: "バナナ"
            lunch: "パン"
            dinner: "ご飯"
            date: "4/12 (火)"
        }
        ListElement {
            breakfast: "バナナ"
            lunch: "パン"
            dinner: "ご飯"
            date: "4/13 (水)"
        }
        ListElement {
            breakfast: "鶏肉"
            lunch: "パン"
            dinner: "ご飯"
            date: "4/14 (木)"
        }
        ListElement {
            breakfast: "鶏肉"
            lunch: "パン"
            dinner: "ご飯"
            date: "4/15 (金)"
        }
        ListElement {
            breakfast: "魚"
            lunch: "パン"
            dinner: "ご飯"
            date: "4/16 (土)"
        }
        ListElement {
            breakfast: "魚"
            lunch: "パン"
            dinner: "ご飯"
            date: "4/17 (日)"
        }
        ListElement {
            breakfast: "魚"
            lunch: "パン"
            dinner: "ご飯"
            date: "4/18 (月)"
        }
        ListElement {
            breakfast: "魚"
            lunch: "パン"
            dinner: "ご飯"
            date: "4/19 (火)"
        }
        ListElement {
            breakfast: "魚"
            lunch: "パン"
            dinner: "ご飯"
            date: "4/20 (水)"
        }
        ListElement {
            breakfast: "魚"
            lunch: "パン"
            dinner: "ご飯"
            date: "4/21 (木)"
        }
    }

    Component {
        id: wDelegate
        Item {
            height: listview.height/7 - 5
            width: listview.width
            clip: true
            RowLayout {
                anchors.fill: parent
                spacing: 5
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: date
                }

                Rectangle {
                     Layout.fillWidth: true
                     Layout.minimumWidth: 50
                     Layout.preferredWidth: 100
                     Layout.maximumWidth: 300
                     Layout.minimumHeight: 100
                     color: "red"
                     Text {
                        text: "朝食" + "\n" + breakfast
                     }
                     MouseArea {
                         anchors.fill: parent
                         onClicked: {
                            filledText = breakfast
                            filledDialog.open()
                         }
                     }
                 }
                 Rectangle {
                     Layout.fillWidth: true
                     Layout.minimumWidth: 50
                     Layout.preferredWidth: 100
                     Layout.maximumWidth: 300
                     Layout.minimumHeight: 100
                     Text {
                         text: "昼食" + "\n" + lunch
                     }
                     MouseArea {
                         anchors.fill: parent
                         onClicked: {
                            filledText = lunch
                            filledDialog.open()
                         }
                     }
                 }
                 Rectangle {
                     Layout.fillWidth: true
                     Layout.minimumWidth: 50
                     Layout.preferredWidth: 100
                     Layout.maximumWidth: 300
                     Layout.minimumHeight: 100
                     Text {
                         text: "夕食" + "\n" + dinner
                     }
                     MouseArea {
                         anchors.fill: parent
                         onClicked: {
                            filledText = dinner
                            filledDialog.open()
                         }
                     }
                 }
            }
        }
    }

    ListView {
        id: listview
        anchors.centerIn: parent
        height: parent.height -20
        width: parent.width -10
        model: wModel
        delegate: wDelegate
        spacing: 5
        clip: true
    }
}

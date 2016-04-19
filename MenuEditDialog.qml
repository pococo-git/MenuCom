import QtQuick 2.6
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.4

Dialog {
    id: _dialog
    property int columnValue: 0
    property bool dataUpdate: false
    property bool editEnable: false
    property alias breakfastValue: _breakfastEdit.text
    property alias lunchValue: _lunchEdit.text
    property alias dinnerValue: _dinnerEdit.text

    contentItem: Rectangle {
        color: "lightskyblue"
        implicitWidth: 400
        implicitHeight: 400

        TextEdit {
            id: _breakfastEdit
            color: "navy"
            anchors.centerIn: parent
            enabled: editEnable
            visible: columnValue == 1 ? true : false
        }
        TextEdit {
            id: _lunchEdit
            color: "navy"
            anchors.centerIn: parent
            enabled: editEnable
            visible: columnValue == 2 ? true : false
        }
        TextEdit {
            id: _dinnerEdit
            color: "navy"
            anchors.centerIn: parent
            enabled: editEnable
            visible: columnValue == 3 ? true : false
        }
        Row {
            spacing: 5
            Button {
                text: editEnable ? "確定" : "編集"
                onClicked: {
                    if (editEnable) {
                        dataUpdate = true
                    }

                    editEnable = !editEnable
                }
            }
            Button {
                text: "キャンセル"
                onClicked: {
                    editEnable = false
                    _dialog.reject()
                }
            }
            Button {
                text: "OK"
                enabled: !editEnable
                onClicked: {
                    editEnable = false
                    _dialog.accept()
                }
            }
        }
    }
}

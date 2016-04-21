import QtQuick 2.6
import QtQuick.Layouts 1.3

Item {
    id: wDelegate
//    height: parent.height/7 - 5
    height: 50
    width: parent.width
    clip: true

    signal clicked(int index, int column)

    RowLayout {
        anchors.fill: parent
        spacing: 5
        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: date.getMonth()+1 + "/" + date.getDate()
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.minimumWidth: 50
            Layout.preferredWidth: 100
            Layout.maximumWidth: 300
            Layout.minimumHeight: 100
//            color: "red"
            Text {
                text: "朝食" + "\n" + breakfast
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    wDelegate.clicked(index, 1)
//                    filledDialog.open()
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
//                    filledDialog.open()
                    wDelegate.clicked(index, 2)
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
                    wDelegate.clicked(index, 3)
//                    filledDialog.open()
                }
            }
        }
    }

}

import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

Item {
    ListModel {
        id: slModel
        ListElement {
            name: "バナナ"
            number: "1本"
        }
        ListElement {
            name: "バナナ"
            number: "1本"
        }
        ListElement {
            name: "バナナ"
            number: "1本"
        }
        ListElement {
            name: "鶏肉"
            number: "200g"
        }
        ListElement {
            name: "鶏肉"
            number: "200g"
        }
        ListElement {
            name: "魚"
            number: "1切れ"
        }
        ListElement {
            name: "魚"
            number: "2切れ"
        }
        ListElement {
            name: "魚"
            number: "3切れ"
        }
        ListElement {
            name: "魚"
            number: "4切れ"
        }
        ListElement {
            name: "魚"
            number: "5切れ"
        }
        ListElement {
            name: "魚"
            number: "6切れ"
        }
    }

    Component {
        id: slDelegate
        Item {
            width: 180; height: 40
            Row {
                CheckBox {
                    checked: false
                }
                Text {
                    text: name
                }
                Text {
                    text: number
                }
                Button {
                    text: qsTr("Edit")
                }
            }
        }
    }

    ListView {
        anchors.fill: parent
        model: slModel
        delegate:  slDelegate
    }
}

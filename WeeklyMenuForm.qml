import QtQuick 2.0

Item {
    id: _wmForm
    property var weeklyMenuMoel

    ListView {
        id: listview
        anchors.centerIn: parent
        height: parent.height -20
        width: parent.width -10
        model: weeklyMenuMoel
        delegate: WeeklyMenuDelegate {
            onClicked: {
                console.debug("On Clicked : " + index + ", " + column)
                if (index !== -1) {
                    listview.currentIndex = index
                    var data = listview.model.get(index)
                    filledDialog.columnValue = column
                    filledDialog.dateData = data.date
                    filledDialog.breakfastValue = data.breakfast
                    filledDialog.lunchValue = data.lunch
                    filledDialog.dinnerValue = data.dinner

                    filledDialog.open()
                }
            }
        }
        spacing: 5
        clip: true
    }

    MenuEditDialog {
        id: filledDialog
        property int rowData: listview.currentIndex
        property date dateData
        onAccepted: {
            console.debug("Dialog Accept" + rowData)
            if (dataUpdate) {
                console.debug("Update ...")
                listview.model.updateRow(rowData, dateData, breakfastValue, lunchValue, dinnerValue)
                dataUpdate = false
            }
        }
        onRejected: {
            console.debug("Dialog Reject" + rowData)
        }
    }
}

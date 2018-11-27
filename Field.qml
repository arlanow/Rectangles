import QtQuick 2.0
import QtQuick.Layouts 1.3
Item {
    id: obj
    property int rows
    property int columns
    function calculateBorder(highlighted, fieldModel) {
        if (highlighted) {
            return game.highlightedColor
        }
        else {
            if (fieldModel==='1') return "Blue"
            if (fieldModel==='2') return "Orange"
            return "Grey"
        }
    }
    function calculateColor(highlighted, fieldModel) {
        if (highlighted) {
            return game.highlightedColor
        }
        else {
            if (fieldModel==='1') return "Blue"
            if (fieldModel==='2') return "Orange"
            return "White"
        }
    }
    GridLayout {
        id: fieldGrid
        anchors.fill: parent
        focus: true
        Keys.forwardTo: this
        Keys.onPressed: {
            if (event.key === Qt.Key_S) skip()
            if (event.key === Qt.Key_E) end(2)
        }
        Keys.enabled: true
        columnSpacing: 0
        rows: obj.rows
        columns: obj.columns
        rowSpacing: 0
        Repeater {
            model: columns*rows
            Rectangle {
                id: row
                opacity: 0.5
                Layout.fillWidth: true
                Layout.fillHeight: true
                border.width: 1
                border.color: obj.calculateBorder(game.fieldModel[index]==='highlighted', game.fieldModel[index])
                color: obj.calculateColor(game.fieldModel[index]==='highlighted', game.fieldModel[index])
            }
        }
    }
}




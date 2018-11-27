import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0

Item {
    id: obj
    property real rowSize: 30
    property alias fieldHeight: field.width
    property alias fieldWidth: field.height
    property alias fieldRows: field.rows
    property alias fieldColumns: field.columns
    function fieldFocus() {
        field.forceActiveFocus()
    }
    ColumnLayout {
        id: gameLayout
        anchors.fill: parent
        anchors.margins: 0
        RowLayout {
            Layout.preferredHeight: 40
            Layout.fillWidth: true
            id: header
            RoundButton {
                Image {
                    source: 'qrc:/icons/menu.svg'
                    anchors.centerIn: parent
                }
                Layout.leftMargin: 10
                onClicked: screen.currentIndex = 0
            }
            Item {
                Layout.fillWidth: true
            }
            RoundButton {
                Image {
                    source: 'qrc:/icons/skip.svg'
                    anchors.centerIn: parent
                }
                onClicked: game.skip()
            }
            Item {
                Layout.preferredWidth: 20
            }
            Item {
                Layout.preferredHeight: 50
                Layout.preferredWidth: 50
                Image {
                    id: dice1
                    source: 'qrc:/icons/dice'+game.turnWidth+'.svg'
                    sourceSize.width: width
                    sourceSize.height: height
                    anchors.fill: parent
                    visible: false
                }
                ColorOverlay {
                    id: dice1Overlay
                    anchors.fill: parent
                    source: dice1
                    antialiasing: true
                    color: 'Grey'
                }
            }
            Item {
                Layout.preferredWidth: 10
            }
            Item {
                Layout.preferredHeight: 50
                Layout.preferredWidth: 50
                Image {
                    id: dice2
                    source: 'qrc:/icons/dice'+game.turnHeight+'.svg'
                    sourceSize.width: width
                    sourceSize.height: height
                    anchors.fill: parent
                    visible: false
                }

                ColorOverlay {
                    id: dice2Overlay
                    anchors.fill: parent
                    source: dice2
                    antialiasing: true
                    color: 'Grey'
                }
            }
            Item {
                Layout.preferredWidth: 20
            }
            RoundButton {
                Image {
                    source: 'qrc:/icons/end.svg'
                    anchors.centerIn: parent
                }
                onClicked: game.end(2)
            }
            Item {
                Layout.fillWidth: true
            }
            RoundButton {
                text: 'A'
            }
        }
        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
            id: fieldItem
            Field {
                id: field
                height: rows*rowSize
                width: columns*rowSize
                anchors.centerIn: parent
                rows: Math.floor((parent.height-20)/rowSize)
                columns: Math.floor((parent.width-20)/rowSize)
                Layout.alignment: Qt.AlignHCenter || Qt.AlignVCenter
                MouseArea {
                    id: gameFieldMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: {
                        console.log('test')
                        lastX = mouseX
                        lastY = mouseY
                        helper.visible = true
                    }
                    property real lastX
                    property real lastY
                    onReleased: {
                        helper.visible = false
                        game.cleanHighLited()
                        var oldX = Math.floor(lastX/rowSize)
                        var oldY = Math.floor(lastY/rowSize)
                        var newX = Math.floor(mouseX/rowSize)
                        var newY = Math.floor(mouseY/rowSize)
                        console.log(oldX, oldY, newX, newY)
                        if ((Math.abs(newX-oldX)+1===game.turnWidth&&Math.abs(newY-oldY)+1===game.turnHeight)||(Math.abs(newX-oldX)+1===game.turnHeight&&Math.abs(newY-oldY)+1===game.turnWidth)) {
                            console.log(oldX, oldY, Math.abs(newY-oldY+1), Math.abs(newX-oldX+1))
                            if (game.tryStep(Math.min(newX,oldX), Math.min(newY, oldY), Math.abs(newY-oldY)+1, Math.abs(newX-oldX)+1)) game.nextStep()
                        }
                    }
                    onMouseXChanged: {
                        if (containsPress) {
                            var oldX = Math.floor(lastX/rowSize)
                            var oldY = Math.floor(lastY/rowSize)
                            var newX = Math.floor(mouseX/rowSize)
                            var newY = Math.floor(mouseY/rowSize)
                            helper.x = Math.min(lastX, mouseX)+field.x+fieldItem.x+gameLayout.y
                            helper.y = Math.min(lastY, mouseY)+field.y+fieldItem.y+gameLayout.y+header.height+gameLayout.spacing
                            helper.width = Math.abs(mouseX-lastX)
                            helper.height = Math.abs(mouseY-lastY)
                            helper.text = (Math.abs(newY-oldY)+1)+':'+(Math.abs(newX-oldX)+1)
                            game.highLight(Math.min(oldX, newX), Math.min(oldY, newY), Math.abs(newY-oldY)+1, Math.abs(newX-oldX)+1)
                        }
                    }
                    onMouseYChanged: {
                        if (containsPress) {
                            var oldX = Math.floor(lastX/rowSize)
                            var oldY = Math.floor(lastY/rowSize)
                            var newX = Math.floor(mouseX/rowSize)
                            var newY = Math.floor(mouseY/rowSize)
                            helper.x = Math.min(lastX, mouseX)+field.x
                            helper.y = Math.min(lastY, mouseY)+field.y
                            helper.width = Math.abs(mouseX-lastX)
                            helper.height = Math.abs(mouseY-lastY)
                            helper.text = (Math.abs(newY-oldY)+1)+':'+(Math.abs(newX-oldX)+1)
                            game.highLight(Math.min(oldX, newX), Math.min(oldY, newY), Math.abs(newY-oldY)+1, Math.abs(newX-oldX)+1)
                        }
                    }
                }
            }
        }
        RowLayout {
            id: footer
            Layout.preferredHeight: 30
            Layout.fillWidth: true
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            Label {
                text: (main.botActive)?'Игрок':'Игрок 1'
                font.bold: true
                font.family: 'roboto'
                font.pointSize: 14
            }
            Item {
                Layout.preferredWidth: 20
            }
            Label {
                property int score2: (game.mode==='score')?game.score2:game.skipped2
                text: (game.mode==='score')?game.score1:game.skipped1
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                font.family: 'roboto'
                font.pointSize: 14
            }
            Item {
                Layout.fillWidth: true
            }
            Label {
                text: (game.mode==='score')?game.score2:game.skipped2
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                font.family: 'roboto'
                font.pointSize: 14
            }
            Item {
                Layout.preferredWidth: 20
            }
            Label {
                text: (main.botActive)?'Бот':'Игрок 2'
                font.bold: true
                font.family: 'roboto'
                font.pointSize: 14
            }
        }
    }
    Item {
        id: helper
        property string text
        visible: false
        Text {
            anchors.centerIn: parent
            text: parent.text
        }
    }
}

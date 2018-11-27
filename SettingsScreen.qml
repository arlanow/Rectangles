import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.0

Item {
    ColumnLayout {
        anchors.centerIn: parent
        width: 350
        height: 250
        Label {
            text: 'Настройки'
            Layout.alignment: Qt.AlignHCenter
        }
        Item {
            Layout.fillHeight: true
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            RowLayout {
                Layout.fillWidth: true
                Label {
                    text: 'Бот'
                    Layout.preferredWidth: 100
                }
                Item {
                    width: 20
                }
                Switch {
                    checked: main.botActive
                    onCheckedChanged: main.botActive = checked
                }
            }
            RowLayout {
                Layout.fillWidth: true
                Label {
                    text: 'Режим игры'
                    Layout.preferredWidth: 100
                }
                Item {
                    width: 20
                }

                ComboBox {
                    Layout.fillWidth: true
                    model: ['До трёх побед', 'Превосходство']
                    currentIndex: (game.mode==='passes')?0:1
                    onCurrentIndexChanged: if (currentIndex===0) game.mode = 'passes'; else game.mode = 'score'
                }
            }
        }
        Item {
            Layout.fillHeight: true
        }
        Button {
            text: 'Продолжить'
            Layout.alignment: Qt.AlignHCenter
            onClicked: {
                game.newGame()
                screen.currentIndex++
            }
        }


    }
}

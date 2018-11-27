import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

Window {
    id: main
    visible: true
    width: Screen.width
    height: Screen.height
    title: qsTr("Rectangles")
    property bool botActive: true
    Material.theme: Material.Light
    Material.accent: Material.Blue

    GameMechanics {
        id: game
    }

    Bot {
        id: bot
    }
    Settings {
        id: settings
        property alias botActive: main.botActive
        property alias mode: game.mode
    }

    SwipeView {
        id: screen
        interactive: false
        anchors.fill: parent
        currentIndex: 0
        MenuScreen {

        }
        CampaignScreen {

        }
        SettingsScreen {

        }
        GameScreen {
            id: gameScreen
        }
    }

//    Drawer {
//        id: leftMenu
//        dragMargin: 10
//        width: parent.width
//        height: parent.height
//        RoundButton {
//            id: closeDrawer
//            Image {
//                source: 'qrc:/icons/close.svg'
//                anchors.centerIn: parent
//            }
//            anchors.right: parent.right
//            anchors.top: parent.top
//            anchors.margins: 10
//            onClicked: leftMenu.close()
//        }
//        ColumnLayout {
//            anchors.top: closeDrawer.bottom
//            anchors.margins: 10
//            anchors.left: parent.left
//            anchors.right: parent.right
//            RowLayout {
//                height: 50
//                Layout.leftMargin: 20
//                Label {
//                    text: 'Бот'
//                }
//                Item {
//                    width: 20
//                }

//                Switch {
//                    checked: botActive
//                    onCheckedChanged: botActive = checked
//                }
//            }
//            RowLayout {
//                height: 50
//                Layout.preferredWidth: 400
//                Layout.leftMargin: 20
//                Label {
//                    text: 'Режим игры'
//                }
//                Item {
//                    width: 20
//                }

//                ComboBox {
//                    Layout.preferredWidth: 200
//                    model: ['До трёх побед', 'Превосходство']
//                    currentIndex: (game.mode==='passes')?0:1
//                    onCurrentIndexChanged: if (currentIndex===0) game.mode = 'passes'; else game.mode = 'score'
//                }
//            }
//            RowLayout {
//                height: 50
//                Layout.fillWidth: true
//                Layout.leftMargin: 20
//                Label {
//                    text: '-Отладочная информация-'
//                    Layout.fillWidth: true
//                }
//            }
//            RowLayout {
//                height: 50
//                Layout.preferredWidth: 300
//                Layout.leftMargin: 20
//                Label {
//                    text: 'Высота экрана: '
//                }
//                Label {
//                    text: main.height
//                }
//            }
//            RowLayout {
//                height: 50
//                Layout.preferredWidth: 300
//                Layout.leftMargin: 20
//                Label {
//                    text: 'Ширина экрана: '
//                }
//                Label {
//                    text: main.width
//                }
//            }
//            RowLayout {
//                height: 50
//                Layout.preferredWidth: 300
//                Layout.leftMargin: 20
//                Label {
//                    text: 'Размер ячейки: '
//                }
//                Label {
//                    text: game.rowWidth
//                }
//            }
//            RowLayout {
//                height: 50
//                Layout.preferredWidth: 300
//                Layout.leftMargin: 20
//                Label {
//                    text: 'Поддержка настроек: Бот: '
//                }
//                Label {
//                    text: settings.botActive
//                }
//            }
//        }
//    }
    Dialog {
        id: endDialog
        x: parent.width/2-width/2
        y: parent.height/2-height/2
        width: 300
        height: 150
        standardButtons: Dialog.Yes | Dialog.No
        onAccepted: {
            game.newGame()
            gameScreen.fieldFocus()
        }
        onRejected: screen.currentIndex = 0
        Label {
            anchors.centerIn: parent
            text: game.endText
            horizontalAlignment: Text.AlignHCenter
        }
    }
}

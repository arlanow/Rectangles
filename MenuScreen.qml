import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.0
Item {
    ColumnLayout {
        anchors.centerIn: parent
        width: 200
        height: 250
        Label {
            id: title
            text: 'Прямоугольники'
            Layout.alignment: Qt.AlignHCenter
        }
        Item {
            id: spacer
            Layout.fillHeight: true
        }
        ColumnLayout {
            id: buttons
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            Button {
                Layout.fillWidth: true
                text: 'Компания (не работает!)'
                onClicked: screen.currentIndex++
            }
            Button {
                Layout.fillWidth: true
                text: 'Одиночная игра'
                onClicked: screen.currentIndex+=2
            }
            Button {
                Layout.fillWidth: true
                text: 'Сетевая игра'
                onClicked: screen.currentIndex++
            }
            Button {
                Layout.fillWidth: true
                text: 'Выход'
                onClicked: main.close()
            }
        }
    }


}

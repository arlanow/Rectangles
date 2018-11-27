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
            text: 'Обучение'
        }
        RowLayout {
            Layout.fillWidth: true
            Button {
                text: '0'
            }
            Button {
                text: '1'
            }
            Button {
                text: '2'
            }
        }
    }
}

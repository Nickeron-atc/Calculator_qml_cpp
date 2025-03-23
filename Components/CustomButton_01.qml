import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import Fonts 1.0

RoundButton {
    id: root

    property string iconSource: "<svg width=\""+ 30 +"\" height=\""+ 30 +"\" viewBox=\"0 0 30 30\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M24.5 19L5.5 19\" stroke=\"white\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/> <path d=\"M24.5 11L5.5 11\" stroke=\"white\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/> </svg>"
    property int displayType: DisplayType.TextOnly  // 0 - Text, 1 - Icon, 2 - Both
    property string buttonColor: ""

    enum DisplayType {
        TextOnly,
        IconOnly,
        IconAndText
    }

    contentItem: RowLayout {
        id: layout
        spacing: root.spacing

        Image {
            id: btnImage
            width: 30
            height: 30
            sourceSize.width: 30
            sourceSize.height: 30
            fillMode: Image.Pad
            smooth: false
            source:  "data:image/svg+xml;utf8," + root.iconSource;
            visible: root.displayType !== CustomButton.DisplayType.TextOnly
            Layout.alignment: Qt.AlignCenter
        }

        Text {
            id: btnText
            text: root.text
            visible: root.displayType !== CustomButton.DisplayType.IconOnly
            color: root.buttonColor
            font: root.font
            Layout.alignment: Qt.AlignCenter
        }


    }
}

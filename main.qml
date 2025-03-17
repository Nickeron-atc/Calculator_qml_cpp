import QtQuick
import QtQuick.Controls
import QtQuick.Shapes

import backend

Window {
    Backend {
        id: backend
    }

    visible: true
    title: qsTr("Calculator 3000")
    id: main_window
    color: "#024873"

    property int buttonWidth: 58
    property int buttonHeight: 58
    property int buttonSpacing: 26

    property int windowWidth: 360
    property int windowHeight: 640
    property bool operationInserted: false

    width: windowWidth
    height: windowHeight

    maximumWidth: width
    minimumWidth: width
    maximumHeight: height
    minimumHeight: height

    function onClickButtonAction(controlName, modelData) {
        switch (modelData[0]) {
            case '0':
                backend.push_button_0();
                break;
            case '1':
                backend.push_button_1();
                break;
            case '2':
                backend.push_button_2();
                break;
            case '3':
                backend.push_button_3();
                break;
            case '4':
                backend.push_button_4();
                break;
            case '5':
                backend.push_button_5();
                break;
            case '6':
                backend.push_button_6();
                break;
            case '7':
                backend.push_button_7();
                break;
            case '8':
                backend.push_button_8();
                break;
            case '9':
                backend.push_button_9();
                break;
            case "BRACKETS":
                backend.push_button_brackets();
                break;
            case "PLUS_MINUS":
                backend.push_button_plus_minus();
                break;
            case "PERCENT":
                backend.push_button_percent();
                break;
            case "DIVIDE":
                backend.push_button_div();
                break;
            case "MULTIPLY":
                backend.push_button_mult();
                break;
            case "SUBTRACT":
                backend.push_button_sub();
                break;
            case "ADD":
                backend.push_button_add();
                break;
            case "CLEAR":
                backend.push_button_clear();
                label_input_id.text = ""
                label_result_id.text = "0"
                operationInserted = false;
                break;
            case "DOT":
                backend.push_button_dot();
                break;
            case "EQUALS":
                pushButtonEqualsTimer.start()
                backend.push_button_equals();
                operationInserted = false;
                break;
            default:
                break;
        }
        if ((modelData[0] < "0" || modelData[0] > "9") && modelData[0] != "." && modelData[0] != "EQUALS")
            operationInserted = true;

        if (modelData[0] == "EQUALS") {
            label_input_id.text = ""
            label_result_id.text = backend.expression
        }
        else if (operationInserted) {
            label_input_id.text = backend.expression
        }
        else {
            label_result_id.text = backend.expression;
        }
    }

    function onReleaseButtonAction(controlName, modelData) {
        if (pushButtonEqualsTimer.running) {
            pushButtonEqualsTimer.stop();
            console.log("Button Equals Timer Stoped");
        }
    }

    function getButtonBackgroundColor(modelData) {
        if (modelData[0] >= '0' && modelData[0] <= '9' || modelData[0] == "DOT") {
            return "#b0d1d8";
        }
        else if (modelData[0] == "CLEAR") {
            return "#f9afaf";
        }
        return "#0889a6";
    }

    function getButtonFontColor(modelData) {
        if (modelData[0] >= '0' && modelData[0] <= '9' || modelData[0] == "DOT") {
            return "#024873";
        }
        return "white";
    }

    function getButtonLineHeight(modelData) {
        if (modelData[0] == "DIVIDE") {
            return 35
        }
        return 30
    }

    function getObjectName(modelData) {
        return "Button_" + String(modelData[0]) + "_objectName";
    }

    Rectangle {
        id: labelWrapper
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: 100
        color: "#04BFAD"

        Label {
            anchors {
                top: parent.top
                topMargin: 66
                right: parent.right
                rightMargin: 42
                margins: buttonSpacing

            }
            id: label_input_id
            objectName: "label_input_objectName"
            text: ""
            font.pixelSize: 20
            textFormat: Text.RichText
            color: "white"
            font.family: "Open Sans"
            font.weight: Font.DemiBold  // 600 соответствует Font.DemiBold
            font.letterSpacing: 0.5
            lineHeight: 30
            lineHeightMode: Text.FixedHeight

        }
    }

    Rectangle {
        id: labelWrapper2
        z: -1
        anchors {
            top: parent.top
            topMargin: 75
            left: parent.left
            right: parent.right
        }
        height: 105
        color: "#04BFAD"
        radius: 30

        Label {
            id: label_result_id
            objectName: "label_result_objectName"

            anchors {
                bottom: parent.bottom
                bottomMargin: 6
                right: parent.right
                rightMargin: 39
                margins: buttonSpacing
            }

            text: backend.expression
            font.pixelSize: 50
            textFormat: Text.RichText
            color: "white"
            font.family: "Open Sans"
            font.weight: Font.DemiBold  // 600 соответствует Font.DemiBold
            font.letterSpacing: 0.5
            lineHeight: 60
            lineHeightMode: Text.FixedHeight

        }
    }

    Timer {
            id: secretTimer
            interval: 5000
            onTriggered: () => {
                if (backend.expression == "123") {
                    console.log("Secret option activated!");
                    secretWindow.visible = true;
                }
            }
    }

    Timer {
        id: pushButtonEqualsTimer
        interval: 4000
        onTriggered: {
            secretTimer.start()
        }
    }

    Window {
        id: secretWindow
        width: 300
        height: 200
        title: "Секретное окно"
        visible: false

        Column {
            Text {
                text: "Вы нашли секретное окно!"
                font.pixelSize: 20
            }

            Button {
                text: "Назад"
                font.pixelSize: 20
                onClicked: () => {
                    secretWindow.visible = false;
                }
            }
        }
    }

    Grid {
        id: grid
        anchors {
            bottom: parent.bottom
            bottomMargin: 41
            horizontalCenter: parent.horizontalCenter
            margins: buttonSpacing
        }
        columns: 4
        spacing: buttonSpacing

        Repeater {

            model: [
                ["BRACKETS", "()"],
                ["PLUS_MINUS", "<span style='letter-spacing: -3px;'><span>+</span>/<span>\u208B</span></span>"],
                ["PERCENT", "%"],
                ["DIVIDE", "<span style='font-size:35px; margin-bottom: -5px'>\u00F7</span>"],
                ["7", "7"], ["8", "8"], ["9", "9"], ["MULTIPLY", "\u2715"],
                ["4", "4"], ["5", "5"], ["6", "6"], ["SUBTRACT", "\uFF0D"],
                ["1", "1"], ["2", "2"], ["3", "3"], ["ADD", "\uFF0B"],
                ["CLEAR", "C"], ["0", "0"], ["DOT", "."], ["EQUALS", "\uFF1D"]
            ]
            RoundButton {
                objectName: getObjectName(modelData)

                width: buttonWidth
                height: buttonHeight
                radius: 30

                contentItem: Text {
                    text: modelData[1]
                    anchors.centerIn: parent
                    font.pixelSize: 24
                    textFormat: Text.RichText
                    color: getButtonFontColor(modelData)
                    font.family: "Open Sans"
                    font.weight: Font.DemiBold  // 600 соответствует Font.DemiBold
                    font.letterSpacing: 1
                    lineHeight: getButtonLineHeight(modelData)
                    lineHeightMode: Text.FixedHeight
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle {
                    id: buttonBackground
                    anchors.fill: parent
                    anchors.margins: -1
                    radius: 30
                    color: getButtonBackgroundColor(modelData)

                    Behavior on color {
                            ColorAnimation { duration: 250 }
                    }
                }

                Timer {
                    id: colorTimer
                    interval: 550
                    onTriggered: {
                        buttonBackground.color = getButtonBackgroundColor(modelData);
                    }
                }

                onClicked: {
                    buttonBackground.color = "#F7E425";
                    colorTimer.start();
                    onClickButtonAction(this, modelData);
                }

                onReleased: () => {
                    onReleaseButtonAction(this, modelData)
                }
            }
        }
    }
}

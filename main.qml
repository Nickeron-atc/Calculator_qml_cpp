import QtQuick
import QtQuick.Controls
import QtQuick.Shapes

import backend

import Fonts 1.0
import Components 1.0

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

    property var equalsButtonID: null

    width: windowWidth
    height: windowHeight

    maximumWidth: width
    minimumWidth: width
    maximumHeight: height
    minimumHeight: height

    function onClickButtonAction(controlName, modelData) {
        switch (modelData[1]) {
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
                backend.push_button_equals();
                operationInserted = false;
                break;
            default:
                break;
        }
        if ((modelData[1] < "0" || modelData[1] > "9") && modelData[1] != "." && modelData[1] != "EQUALS" && modelData[1] != "CLEAR" && modelData[1] != "DOT")
            operationInserted = true;

        if (modelData[1] == "EQUALS") {
            label_input_id.text = ""
            label_result_id.text = backend.expression
        }
        else if (operationInserted) {
            label_input_id.text = backend.expression
            label_result_id.text = backend.precomputed
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

    function onPressAndHoldButtonAction(controlName, modelData) {
        if (modelData[1] == "EQUALS")
            pushButtonEqualsTimer.start()
    }

    function getButtonBackgroundColor(modelData) {
        if (modelData[1] >= '0' && modelData[1] <= '9' || modelData[1] == "DOT") {
            return "#b0d1d8";
        }
        else if (modelData[1] == "CLEAR") {
            return "#f9afaf";
        }
        return "#0889a6";
    }

    function getButtonFontColor(modelData) {
        if (modelData[1] >= '0' && modelData[1] <= '9' || modelData[1] == "DOT") {
            return "#024873";
        }
        return "white";
    }

    function getButtonLineHeight(modelData) {
        if (modelData[1] == "DIVIDE") {
            return 35
        }
        return 30
    }

    function getObjectName(modelData) {
        return "Button_" + String(modelData[1]) + "_objectName";
    }

    function svgElementWidth(index) {
        return 30;
        /*
        var elem_width = [14,24,20,22,12,12,12,16,14,12,12,22,8,12,12,22,14,12,4,22];
        return elem_width[index]
        */
    }

    function svgElementHeight(index) {
        return 30;
        /*
        var elem_heihgt = [22,18,20,18,18,19,19,16,18,19,19,2,18,18,19,22,19,19,5,10];
        return elem_heihgt[index]
        */
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
            font.family: OpenSans.bold//"Open Sans"
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
            font.family: OpenSans.bold
            font.weight: Font.DemiBold  // 600 соответствует Font.DemiBold
            font.letterSpacing: 0.5
            lineHeight: 60
            lineHeightMode: Text.FixedHeight

        }//"Open Sans"
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
                    (function(){main_window.equalsButtonID.background.color = "#0889a6"})()
                }
            }
        }

        onClosing: (function(){main_window.equalsButtonID.background.color = "#0889a6"})()
    }

    Grid {
        id: grid
        anchors {
            bottom: parent.bottom
            bottomMargin: 41
            horizontalCenter: parent.horizontalCenter
            margins: main_window.buttonSpacing
        }
        columns: 4
        spacing: buttonSpacing

        Repeater {

            model: [
                [0, "BRACKETS",     "<svg width=\""+ svgElementWidth(0)  +"\" height=\""+ svgElementHeight(0)  +"\" viewBox=\"0 0 30 30\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M12 5C12 5 9 9 9 15C9 21 12 25 12 25\" stroke=\"white\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/> <path d=\"M18 25C18 25 21 21 21 15C21 9 18 5 18 5\" stroke=\"white\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/> </svg> "],
                [1, "PLUS_MINUS",   "<svg width=\""+ svgElementWidth(1)  +"\" height=\""+ svgElementHeight(1)  +"\" viewBox=\"0 0 30 30\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M18 7L12 23\" stroke=\"white\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/> <path d=\"M8 7V15\" stroke=\"white\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/> <path d=\"M12 11L4 11\" stroke=\"white\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/> <path d=\"M26 19L18 19\" stroke=\"white\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/> </svg> "],
                [2, "PERCENT",      "<svg width=\""+ svgElementWidth(2)  +"\" height=\""+ svgElementHeight(2)  +"\" viewBox=\"0 0 30 30\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M20 7L10 23\" stroke=\"white\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/> <ellipse cx=\"21\" cy=\"20\" rx=\"3\" ry=\"4\" stroke=\"white\" stroke-width=\"2\"/> <ellipse cx=\"9\" cy=\"10\" rx=\"3\" ry=\"4\" stroke=\"white\" stroke-width=\"2\"/> </svg> "],
                [3, "DIVIDE",       "<svg width=\""+ svgElementWidth(3)  +"\" height=\""+ svgElementHeight(3)  +"\" viewBox=\"0 0 30 30\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M24.5 15L5.5 15\" stroke=\"white\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/> <circle cx=\"15\" cy=\"8\" r=\"2\" fill=\"white\"/> <circle cx=\"15\" cy=\"22\" r=\"2\" fill=\"white\"/> </svg> "],
                [4, "7",            "<svg width=\""+ svgElementWidth(4)  +"\" height=\""+ svgElementHeight(4)  +"\" viewBox=\"0 0 12 18\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M2.14453 18L8.91797 3.31641H0.0117188V0.890625H11.8594V2.8125L5.12109 18H2.14453Z\" fill=\"#024873\"/> </svg> "],
                [5, "8",            "<svg width=\""+ svgElementWidth(5)  +"\" height=\""+ svgElementHeight(5)  +"\" viewBox=\"0 0 12 19\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M5.98828 0.644531C7.61328 0.644531 8.89844 1.01953 9.84375 1.76953C10.7891 2.51172 11.2617 3.50781 11.2617 4.75781C11.2617 6.51562 10.207 7.91406 8.09766 8.95312C9.44141 9.625 10.3945 10.332 10.957 11.0742C11.5273 11.8164 11.8125 12.6445 11.8125 13.5586C11.8125 14.9727 11.293 16.1055 10.2539 16.957C9.21484 17.8086 7.80859 18.2344 6.03516 18.2344C4.17578 18.2344 2.73438 17.8359 1.71094 17.0391C0.6875 16.2422 0.175781 15.1133 0.175781 13.6523C0.175781 12.6992 0.441406 11.8438 0.972656 11.0859C1.51172 10.3203 2.39062 9.64062 3.60938 9.04688C2.5625 8.42188 1.81641 7.76172 1.37109 7.06641C0.925781 6.37109 0.703125 5.58984 0.703125 4.72266C0.703125 3.48047 1.19141 2.49219 2.16797 1.75781C3.14453 1.01563 4.41797 0.644531 5.98828 0.644531ZM2.8125 13.5586C2.8125 14.3711 3.09766 15.0039 3.66797 15.457C4.23828 15.9023 5.01172 16.125 5.98828 16.125C6.99609 16.125 7.77734 15.8945 8.33203 15.4336C8.89453 14.9648 9.17578 14.332 9.17578 13.5352C9.17578 12.9023 8.91797 12.3242 8.40234 11.8008C7.88672 11.2773 7.10547 10.793 6.05859 10.3477L5.71875 10.1953C4.6875 10.6484 3.94531 11.1484 3.49219 11.6953C3.03906 12.2344 2.8125 12.8555 2.8125 13.5586ZM5.96484 2.76562C5.18359 2.76562 4.55469 2.96094 4.07812 3.35156C3.60156 3.73438 3.36328 4.25781 3.36328 4.92188C3.36328 5.32812 3.44922 5.69141 3.62109 6.01172C3.79297 6.33203 4.04297 6.625 4.37109 6.89062C4.69922 7.14844 5.25391 7.46094 6.03516 7.82812C6.97266 7.41406 7.63281 6.98047 8.01562 6.52734C8.40625 6.06641 8.60156 5.53125 8.60156 4.92188C8.60156 4.25781 8.35938 3.73438 7.875 3.35156C7.39844 2.96094 6.76172 2.76562 5.96484 2.76562Z\" fill=\"#024873\"/> </svg> "],
                [6, "9",            "<svg width=\""+ svgElementWidth(6)  +"\" height=\""+ svgElementHeight(6)  +"\" viewBox=\"0 0 12 19\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M11.7891 8.17969C11.7891 11.5547 11.1094 14.0742 9.75 15.7383C8.39062 17.4023 6.34375 18.2344 3.60938 18.2344C2.57031 18.2344 1.82422 18.1719 1.37109 18.0469V15.7383C2.06641 15.9336 2.76562 16.0312 3.46875 16.0312C5.32812 16.0312 6.71484 15.5312 7.62891 14.5312C8.54297 13.5312 9.04297 11.9609 9.12891 9.82031H8.98828C8.52734 10.5234 7.96875 11.0312 7.3125 11.3438C6.66406 11.6562 5.90234 11.8125 5.02734 11.8125C3.51172 11.8125 2.32031 11.3398 1.45312 10.3945C0.585938 9.44922 0.152344 8.15234 0.152344 6.50391C0.152344 4.71484 0.652344 3.29297 1.65234 2.23828C2.66016 1.17578 4.03125 0.644531 5.76562 0.644531C6.98438 0.644531 8.04688 0.941406 8.95312 1.53516C9.85938 2.12891 10.5586 2.99219 11.0508 4.125C11.543 5.25 11.7891 6.60156 11.7891 8.17969ZM5.8125 2.92969C4.85938 2.92969 4.12891 3.24219 3.62109 3.86719C3.11328 4.48438 2.85938 5.35547 2.85938 6.48047C2.85938 7.45703 3.09375 8.22656 3.5625 8.78906C4.03906 9.34375 4.75781 9.62109 5.71875 9.62109C6.64844 9.62109 7.42969 9.34375 8.0625 8.78906C8.69531 8.23438 9.01172 7.58594 9.01172 6.84375C9.01172 6.14844 8.875 5.5 8.60156 4.89844C8.33594 4.28906 7.96094 3.80859 7.47656 3.45703C6.99219 3.10547 6.4375 2.92969 5.8125 2.92969Z\" fill=\"#024873\"/> </svg> "],
                [7, "MULTIPLY",     "<svg width=\""+ svgElementWidth(7)  +"\" height=\""+ svgElementHeight(7)  +"\" viewBox=\"0 0 30 30\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M21.7175 8.2825L8.2825 21.7175\" stroke=\"white\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/> <path d=\"M21.7175 21.7175L8.2825 8.2825\" stroke=\"white\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/> </svg> "],
                [8, "4",            "<svg width=\""+ svgElementWidth(8)  +"\" height=\""+ svgElementHeight(8)  +"\" viewBox=\"0 0 14 18\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M13.4219 14.2617H11.1133V18H8.42969V14.2617H0.601562V12.1406L8.42969 0.820312H11.1133V11.9766H13.4219V14.2617ZM8.42969 11.9766V7.67578C8.42969 6.14453 8.46875 4.89062 8.54688 3.91406H8.45312C8.23438 4.42969 7.89062 5.05469 7.42188 5.78906L3.16797 11.9766H8.42969Z\" fill=\"#024873\"/> </svg> "],
                [9, "5",            "<svg width=\""+ svgElementWidth(9)  +"\" height=\""+ svgElementHeight(9)  +"\" viewBox=\"0 0 12 19\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M6.01172 7.30078C7.73828 7.30078 9.10547 7.75781 10.1133 8.67188C11.1211 9.58594 11.625 10.832 11.625 12.4102C11.625 14.2383 11.0508 15.668 9.90234 16.6992C8.76172 17.7227 7.13672 18.2344 5.02734 18.2344C3.11328 18.2344 1.60938 17.9258 0.515625 17.3086V14.8125C1.14844 15.1719 1.875 15.4492 2.69531 15.6445C3.51562 15.8398 4.27734 15.9375 4.98047 15.9375C6.22266 15.9375 7.16797 15.6602 7.81641 15.1055C8.46484 14.5508 8.78906 13.7383 8.78906 12.668C8.78906 10.6211 7.48438 9.59766 4.875 9.59766C4.50781 9.59766 4.05469 9.63672 3.51562 9.71484C2.97656 9.78516 2.50391 9.86719 2.09766 9.96094L0.867188 9.23438L1.52344 0.867188H10.4297V3.31641H3.94922L3.5625 7.55859C3.83594 7.51172 4.16797 7.45703 4.55859 7.39453C4.95703 7.33203 5.44141 7.30078 6.01172 7.30078Z\" fill=\"#024873\"/> </svg> "],
                [10, "6",           "<svg width=\""+ svgElementWidth(10) +"\" height=\""+ svgElementHeight(10) +"\" viewBox=\"0 0 12 19\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M0.246094 10.6992C0.246094 3.99609 2.97656 0.644531 8.4375 0.644531C9.29688 0.644531 10.0234 0.710938 10.6172 0.84375V3.14062C10.0234 2.96875 9.33594 2.88281 8.55469 2.88281C6.71875 2.88281 5.33984 3.375 4.41797 4.35938C3.49609 5.34375 2.99609 6.92188 2.91797 9.09375H3.05859C3.42578 8.46094 3.94141 7.97266 4.60547 7.62891C5.26953 7.27734 6.05078 7.10156 6.94922 7.10156C8.50391 7.10156 9.71484 7.57812 10.582 8.53125C11.4492 9.48438 11.8828 10.7773 11.8828 12.4102C11.8828 14.207 11.3789 15.6289 10.3711 16.6758C9.37109 17.7148 8.00391 18.2344 6.26953 18.2344C5.04297 18.2344 3.97656 17.9414 3.07031 17.3555C2.16406 16.7617 1.46484 15.9023 0.972656 14.7773C0.488281 13.6445 0.246094 12.2852 0.246094 10.6992ZM6.22266 15.9609C7.16797 15.9609 7.89453 15.6562 8.40234 15.0469C8.91797 14.4375 9.17578 13.5664 9.17578 12.4336C9.17578 11.4492 8.93359 10.6758 8.44922 10.1133C7.97266 9.55078 7.25391 9.26953 6.29297 9.26953C5.69922 9.26953 5.15234 9.39844 4.65234 9.65625C4.15234 9.90625 3.75781 10.2539 3.46875 10.6992C3.17969 11.1367 3.03516 11.5859 3.03516 12.0469C3.03516 13.1484 3.33203 14.0781 3.92578 14.8359C4.52734 15.5859 5.29297 15.9609 6.22266 15.9609Z\" fill=\"#024873\"/> </svg> "],
                [11, "SUBTRACT",    "<svg width=\""+ svgElementWidth(11) +"\" height=\""+ svgElementHeight(11) +"\" viewBox=\"0 0 30 30\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M24.5 15L5.5 15\" stroke=\"white\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/> </svg> "],
                [12, "1",           "<svg width=\""+ svgElementWidth(12) +"\" height=\""+ svgElementHeight(12) +"\" viewBox=\"0 0 9 18\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M8.28516 18H5.53125V6.9375C5.53125 5.61719 5.5625 4.57031 5.625 3.79688C5.44531 3.98438 5.22266 4.19141 4.95703 4.41797C4.69922 4.64453 3.82422 5.36328 2.33203 6.57422L0.949219 4.82812L5.98828 0.867188H8.28516V18Z\" fill=\"#024873\"/> </svg> "],
                [13, "2",           "<svg width=\""+ svgElementWidth(13) +"\" height=\""+ svgElementHeight(13) +"\" viewBox=\"0 0 12 18\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M11.8125 18H0.199219V15.9141L4.61719 11.4727C5.92188 10.1367 6.78516 9.19141 7.20703 8.63672C7.63672 8.07422 7.94922 7.54688 8.14453 7.05469C8.33984 6.5625 8.4375 6.03516 8.4375 5.47266C8.4375 4.69922 8.20312 4.08984 7.73438 3.64453C7.27344 3.19922 6.63281 2.97656 5.8125 2.97656C5.15625 2.97656 4.51953 3.09766 3.90234 3.33984C3.29297 3.58203 2.58594 4.01953 1.78125 4.65234L0.292969 2.83594C1.24609 2.03125 2.17188 1.46094 3.07031 1.125C3.96875 0.789062 4.92578 0.621094 5.94141 0.621094C7.53516 0.621094 8.8125 1.03906 9.77344 1.875C10.7344 2.70312 11.2148 3.82031 11.2148 5.22656C11.2148 6 11.0742 6.73438 10.793 7.42969C10.5195 8.125 10.0938 8.84375 9.51562 9.58594C8.94531 10.3203 7.99219 11.3164 6.65625 12.5742L3.67969 15.457V15.5742H11.8125V18Z\" fill=\"#024873\"/> </svg> "],
                [14, "3",           "<svg width=\""+ svgElementWidth(14) +"\" height=\""+ svgElementHeight(14) +"\" viewBox=\"0 0 12 19\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M11.168 4.80469C11.168 5.89062 10.8516 6.79688 10.2188 7.52344C9.58594 8.24219 8.69531 8.72656 7.54688 8.97656V9.07031C8.92188 9.24219 9.95312 9.67188 10.6406 10.3594C11.3281 11.0391 11.6719 11.9453 11.6719 13.0781C11.6719 14.7266 11.0898 16 9.92578 16.8984C8.76172 17.7891 7.10547 18.2344 4.95703 18.2344C3.05859 18.2344 1.45703 17.9258 0.152344 17.3086V14.8594C0.878906 15.2188 1.64844 15.4961 2.46094 15.6914C3.27344 15.8867 4.05469 15.9844 4.80469 15.9844C6.13281 15.9844 7.125 15.7383 7.78125 15.2461C8.4375 14.7539 8.76562 13.9922 8.76562 12.9609C8.76562 12.0469 8.40234 11.375 7.67578 10.9453C6.94922 10.5156 5.80859 10.3008 4.25391 10.3008H2.76562V8.0625H4.27734C7.01172 8.0625 8.37891 7.11719 8.37891 5.22656C8.37891 4.49219 8.14062 3.92578 7.66406 3.52734C7.1875 3.12891 6.48438 2.92969 5.55469 2.92969C4.90625 2.92969 4.28125 3.02344 3.67969 3.21094C3.07812 3.39062 2.36719 3.74609 1.54688 4.27734L0.199219 2.35547C1.76953 1.19922 3.59375 0.621094 5.67188 0.621094C7.39844 0.621094 8.74609 0.992188 9.71484 1.73438C10.6836 2.47656 11.168 3.5 11.168 4.80469Z\" fill=\"#024873\"/> </svg> "],
                [15, "ADD",         "<svg width=\""+ svgElementWidth(15) +"\" height=\""+ svgElementHeight(15) +"\" viewBox=\"0 0 30 30\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M15 5.5V24.5\" stroke=\"white\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/> <path d=\"M24.5 15L5.5 15\" stroke=\"white\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/> </svg> "],
                [16, "CLEAR",       "<svg width=\""+ svgElementWidth(16) +"\" height=\""+ svgElementHeight(16) +"\" viewBox=\"0 0 14 19\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M8.94531 3.02344C7.33594 3.02344 6.07031 3.59375 5.14844 4.73438C4.22656 5.875 3.76562 7.44922 3.76562 9.45703C3.76562 11.5586 4.20703 13.1484 5.08984 14.2266C5.98047 15.3047 7.26562 15.8438 8.94531 15.8438C9.67188 15.8438 10.375 15.7734 11.0547 15.6328C11.7344 15.4844 12.4414 15.2969 13.1758 15.0703V17.4727C11.832 17.9805 10.3086 18.2344 8.60547 18.2344C6.09766 18.2344 4.17188 17.4766 2.82812 15.9609C1.48438 14.4375 0.8125 12.2617 0.8125 9.43359C0.8125 7.65234 1.13672 6.09375 1.78516 4.75781C2.44141 3.42188 3.38672 2.39844 4.62109 1.6875C5.85547 0.976562 7.30469 0.621094 8.96875 0.621094C10.7188 0.621094 12.3359 0.988281 13.8203 1.72266L12.8125 4.05469C12.2344 3.78125 11.6211 3.54297 10.9727 3.33984C10.332 3.12891 9.65625 3.02344 8.94531 3.02344Z\" fill=\"white\"/> </svg> "],
                [17, "0",           "<svg width=\""+ svgElementWidth(17) +"\" height=\""+ svgElementHeight(17) +"\" viewBox=\"0 0 12 19\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M11.8125 9.43359C11.8125 12.4102 11.332 14.6211 10.3711 16.0664C9.41797 17.5117 7.95703 18.2344 5.98828 18.2344C4.08203 18.2344 2.63672 17.4883 1.65234 15.9961C0.667969 14.5039 0.175781 12.3164 0.175781 9.43359C0.175781 6.41016 0.652344 4.18359 1.60547 2.75391C2.56641 1.31641 4.02734 0.597656 5.98828 0.597656C7.90234 0.597656 9.35156 1.34766 10.3359 2.84766C11.3203 4.34766 11.8125 6.54297 11.8125 9.43359ZM2.96484 9.43359C2.96484 11.7695 3.20312 13.4375 3.67969 14.4375C4.16406 15.4375 4.93359 15.9375 5.98828 15.9375C7.04297 15.9375 7.8125 15.4297 8.29688 14.4141C8.78906 13.3984 9.03516 11.7383 9.03516 9.43359C9.03516 7.13672 8.78906 5.47656 8.29688 4.45312C7.8125 3.42188 7.04297 2.90625 5.98828 2.90625C4.93359 2.90625 4.16406 3.41016 3.67969 4.41797C3.20312 5.42578 2.96484 7.09766 2.96484 9.43359Z\" fill=\"#024873\"/> </svg> "],
                [18, "DOT",         "<svg width=\""+ svgElementWidth(18) +"\" height=\""+ svgElementHeight(18) +"\" viewBox=\"0 0 4 5\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M0.253906 2.53516C0.253906 1.96484 0.402344 1.52734 0.699219 1.22266C0.996094 0.917969 1.42578 0.765625 1.98828 0.765625C2.55859 0.765625 2.99219 0.925781 3.28906 1.24609C3.58594 1.55859 3.73438 1.98828 3.73438 2.53516C3.73438 3.08984 3.58203 3.53125 3.27734 3.85938C2.98047 4.17969 2.55078 4.33984 1.98828 4.33984C1.42578 4.33984 0.996094 4.17969 0.699219 3.85938C0.402344 3.53906 0.253906 3.09766 0.253906 2.53516Z\" fill=\"#024873\"/> </svg> "],
                [19, "EQUALS",      "<svg width=\""+ svgElementWidth(19) +"\" height=\""+ svgElementHeight(19) +"\" viewBox=\"0 0 30 30\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M24.5 19L5.5 19\" stroke=\"white\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/> <path d=\"M24.5 11L5.5 11\" stroke=\"white\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/> </svg> "]
            ]

            CustomButton {
                id: button
                objectName: getObjectName(modelData)

                width: buttonWidth
                height: buttonHeight
                radius: 30

                iconSource: modelData[2]

                font.pixelSize: 24
                font.family: OpenSans.bold
                font.weight: Font.DemiBold

                font.letterSpacing: 1
                buttonColor: getButtonFontColor(modelData)

                text: (function(){
                    if (modelData[1][0] >= '0' && modelData[1][0] <= '9')
                        return modelData[1];
                    else if (modelData[1] == "CLEAR")
                        return "C";
                    else if (modelData[1] == "DOT")
                        return ".";
                    else
                        return "";
                })()

                displayType: (function() {
                    if ((modelData[1][0] >= '0' && modelData[1][0] <= '9') || modelData[1] == "DOT" || modelData[1] == "CLEAR")
                        return CustomButton.DisplayType.TextOnly;
                    return CustomButton.DisplayType.IconOnly;
                })()

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

                Timer {
                    id: colorHoldTimer
                }

                onClicked: {
                    buttonBackground.color = "#F7E425";
                    colorTimer.start();
                    onClickButtonAction(this, modelData);
                }

                onReleased: () => {
                    onReleaseButtonAction(this, modelData)
                    buttonBackground.color = getButtonBackgroundColor(modelData);
                }

                onPressAndHold: {
                    buttonBackground.color = "#25e4f7" //"#F7E425";
                    onPressAndHoldButtonAction(this, modelData);
                }

                Component.onCompleted: {
                    if (modelData[1] === "EQUALS") {
                        main_window.equalsButtonID = button;
                    }
                }
            }
        }
    }
}

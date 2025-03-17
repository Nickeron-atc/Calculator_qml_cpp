#include "backend.h"

QString Backend::getValue() const
{
    return m_expression;
}
void Backend::setValue(QString newValue)
{
    m_expression = newValue;
    emit valueChanged(m_expression);
}

void Backend::push_button_brackets() {
    if (this->divisionByZero) return;

    if (this->brackets_counter > 0) {
        if (this->lastTag & TAGS::NUMBER
            || this->lastTag & TAGS::CLOSING_BRACKET
            || this->lastTag & TAGS::PERCENT) {
            this->m_expression += ")";
            this->brackets_counter--;
            this->lastTag & TAGS::CLOSING_BRACKET;
        }
    } else {
        if (this->lastTag & TAGS::NUMBER
            || this->lastTag & TAGS::CLOSING_BRACKET
            || this->lastTag & TAGS::EQUALS
            || this->lastTag & TAGS::NONE
            || this->lastTag & TAGS::PERCENT
            || this->lastTag & TAGS::CLEAR) {
            this->m_expression += " * (";
        } else {
            this->m_expression += " (";
        }
        this->brackets_counter++;
        this->lastTag = TAGS::OPENNING_BRACKET;
    }
    this->operationInserted = true;
}

void Backend::push_button_plus_minus() {
    if (this->lastTag & TAGS::DOT
        || this->divisionByZero) { return;}

    if (this->lastTag & TAGS::BINARY_OPERATION
        ||  this->lastTag & TAGS::SIGN)
    {
        this->m_expression += " (-";
        this->brackets_counter++;
    }
    else {
        this->m_expression += " * (-";
        this->brackets_counter++;
    }

    this->operationInserted = true;
    this->floatingNumber = false;
    this->lastTag = TAGS::SIGN;
}

void Backend::push_button_dot() {
    if (!this->lastTag | !TAGS::NUMBER
        && !this->lastTag | !TAGS::EQUALS
        && !this->lastTag | !TAGS::CLEAR
        || this->divisionByZero
        || this->floatingNumber
        || this->m_expression.length() == 0) { return;}

    this->m_expression += ".";
    this->floatingNumber = true;
    this->valueIsZero = false;

    this->lastTag = TAGS::DOT;
}

void Backend::push_button_percent() {
    if (this->divisionByZero
        || !this->lastTag | !TAGS::NUMBER)
        return;
    this->m_expression += " % ";
    this->operationInserted = true;

    this->lastTag = TAGS::PERCENT;
}

void Backend::push_button_clear() {
    this->m_expression = "0";

    this->divisionByZero = false;

    this->valueIsZero = true;

    this->operationInserted = false;
    this->floatingNumber = false;

    this->brackets_counter = 0;

    this->lastTag = TAGS::CLEAR;
    this->m_expression = "0";
}

void Backend::push_button_0() {
    if (this->divisionByZero || this->valueIsZero) { return; }

    if (this->lastTag & TAGS::CLOSING_BRACKET
        || this->lastTag & TAGS::PERCENT) {
        this->m_expression += " * 0";
    }
    else if(this->lastTag & TAGS::BINARY_OPERATION){
        this->m_expression += " 0";
    }
    else {
        this->m_expression += "0";
    }

    this->lastTag = TAGS::ZERO;
}

void Backend::push_button_1() {
    if (this->divisionByZero) { return; }

    if (this->valueIsZero && !this->operationInserted) {
        this->m_expression = "";
        this->valueIsZero = false;
    }

    if (this->lastTag & TAGS::CLOSING_BRACKET
        || this->lastTag & TAGS::PERCENT) {
        this->m_expression += " * 1";
    }
    else if(this->lastTag & TAGS::BINARY_OPERATION){
        this->m_expression += " 1";
    }
    else {
        this->m_expression += "1";
    }

    this->lastTag = TAGS::NUMBER;
}

void Backend::push_button_2() {
    if (this->divisionByZero) { return; }

    if (this->valueIsZero && !this->operationInserted) {
        this->m_expression = "";
        this->valueIsZero = false;
    }

    if (this->lastTag & TAGS::CLOSING_BRACKET
        || this->lastTag & TAGS::PERCENT) {
        this->m_expression += " * 2";
    }
    else if(this->lastTag & TAGS::BINARY_OPERATION){
        this->m_expression += " 2";
    }
    else {
        this->m_expression += "2";
    }

    this->lastTag = TAGS::NUMBER;
}

void Backend::push_button_3() {
    if (this->divisionByZero) { return; }

    if (this->valueIsZero && !this->operationInserted) {
        this->m_expression = "";
        this->valueIsZero = false;
    }

    if (this->lastTag & TAGS::CLOSING_BRACKET
        || this->lastTag & TAGS::PERCENT) {
        this->m_expression += " * 3";
    }
    else if(this->lastTag & TAGS::BINARY_OPERATION){
        this->m_expression += " 3";
    }
    else {
        this->m_expression += "3";
    }

    this->lastTag = TAGS::NUMBER;
}

void Backend::push_button_4() {
    if (this->divisionByZero) { return; }

    if (this->valueIsZero && !this->operationInserted) {
        this->m_expression = "";
        this->valueIsZero = false;
    }

    if (this->lastTag & TAGS::CLOSING_BRACKET
        || this->lastTag & TAGS::PERCENT) {
        this->m_expression += " * 4";
    }
    else if(this->lastTag & TAGS::BINARY_OPERATION){
        this->m_expression += " 4";
    }
    else {
        this->m_expression += "4";
    }

    this->lastTag = TAGS::NUMBER;
}

void Backend::push_button_5() {
    if (this->divisionByZero) { return; }

    if (this->valueIsZero && !this->operationInserted) {
        this->m_expression = "";
        this->valueIsZero = false;
    }

    if (this->lastTag & TAGS::CLOSING_BRACKET
        || this->lastTag & TAGS::PERCENT) {
        this->m_expression += " * 5";
    }
    else if(this->lastTag & TAGS::BINARY_OPERATION){
        this->m_expression += " 5";
    }
    else {
        this->m_expression += "5";
    }

    this->lastTag = TAGS::NUMBER;
}

void Backend::push_button_6() {
    if (this->divisionByZero) { return; }

    if (this->valueIsZero && !this->operationInserted) {
        this->m_expression = "";
        this->valueIsZero = false;
    }

    if (this->lastTag & TAGS::CLOSING_BRACKET
        || this->lastTag & TAGS::PERCENT) {
        this->m_expression += " * 6";
    }
    else if(this->lastTag & TAGS::BINARY_OPERATION){
        this->m_expression += " 6";
    }
    else {
        this->m_expression += "6";
    }

    this->lastTag = TAGS::NUMBER;
}

void Backend::push_button_7() {
    if (this->divisionByZero) { return; }

    if (this->valueIsZero && !this->operationInserted) {
        this->m_expression = "";
        this->valueIsZero = false;
    }

    if (this->lastTag & TAGS::CLOSING_BRACKET
        || this->lastTag & TAGS::PERCENT) {
        this->m_expression += " * 7";
    }
    else if(this->lastTag & TAGS::BINARY_OPERATION){
        this->m_expression += " 7";
    }
    else {
        this->m_expression += "7";
    }

    this->lastTag = TAGS::NUMBER;
}

void Backend::push_button_8() {
    if (this->divisionByZero) { return; }

    if (this->valueIsZero && !this->operationInserted) {
        this->m_expression = "";
        this->valueIsZero = false;
    }

    if (this->lastTag & TAGS::CLOSING_BRACKET
        || this->lastTag & TAGS::PERCENT) {
        this->m_expression += " * 8";
    }
    else if(this->lastTag & TAGS::BINARY_OPERATION){
        this->m_expression += " 8";
    }
    else {
        this->m_expression += "8";
    }

    this->lastTag = TAGS::NUMBER;
}

void Backend::push_button_9() {
    if (this->divisionByZero) { return; }

    if (this->valueIsZero && !this->operationInserted) {
        this->m_expression = "";
        this->valueIsZero = false;
    }

    if (this->lastTag & TAGS::CLOSING_BRACKET
        || this->lastTag & TAGS::PERCENT) {
        this->m_expression += " * 9";
    }
    else if(this->lastTag & TAGS::BINARY_OPERATION){
        this->m_expression += " 9";
    }
    else {
        this->m_expression += "9";
    }

    this->lastTag = TAGS::NUMBER;
}

void Backend::push_button_add() {
    if (this->divisionByZero) { return; }

    if (this->valueIsZero) {
        this->valueIsZero = false;
    }

    if (this->lastTag & TAGS::BINARY_OPERATION) {
        this->m_expression.chop(2);
    }

    this->m_expression += " +";

    this->operationInserted = true;
    this->lastTag = TAGS::PLUS;
}

void Backend::push_button_sub() {
    if (this->divisionByZero) { return; }

    if (this->valueIsZero) {
        this->valueIsZero = false;
    }

    if (this->lastTag & TAGS::BINARY_OPERATION) {
        this->m_expression.chop(2);
    }

    this->m_expression += " -";

    this->operationInserted = true;
    this->lastTag = TAGS::MINUS;
}

void Backend::push_button_div() {
    if (this->divisionByZero) { return; }

    if (this->valueIsZero) {
        this->valueIsZero = false;
    }

    if (this->lastTag & TAGS::BINARY_OPERATION) {
        this->m_expression.chop(2);
    }

    this->m_expression += " /";

    this->operationInserted = true;
    this->lastTag = TAGS::DIVIDE;
}

void Backend::push_button_mult() {
    if (this->divisionByZero) { return; }

    if (this->lastTag & TAGS::BINARY_OPERATION) {
        this->m_expression.chop(2);
    }

    if (this->valueIsZero) {
        this->valueIsZero = false;
    }

    this->m_expression += " *";

    this->operationInserted = true;
    this->lastTag = TAGS::MULTIPLY;
}

void Backend::push_button_equals() {
    if (this->m_expression.length() == 0
        || this->divisionByZero
        || this->lastTag & TAGS::BINARY_OPERATION
        || this->lastTag & TAGS::DOT
        || this->lastTag & TAGS::OPENNING_BRACKET
        || this->lastTag & TAGS::SIGN) { return;}

    this->equalsButtonPressed = true;

    auto remove_spaces = [](std::string str) {
        str.erase(std::remove_if(str.begin(), str.end(), [](char c) {
                      return std::isspace(static_cast<unsigned char>(c));
                  }), str.end());
        return str;
    };

    this->calculator.set_input(remove_spaces(this->m_expression.toStdString()));
    double res = this->calculator.calculate();

    auto cut_the_zeros = [](std::string res_str) {
        auto it = std::find(res_str.begin(), res_str.end(), '.');
        if (it != res_str.end()) {
            int pos = it - res_str.begin();
            int last_non_zero = res_str.length() - 1;
            while (last_non_zero > pos && res_str[last_non_zero] == '0') {
                last_non_zero--;
            }
            if (last_non_zero == pos) {
                res_str = res_str.substr(0, pos);
            }
            else {
                res_str = res_str.substr(0, last_non_zero + 1);
            }
        }
        return res_str;
    };

    this->m_expression = cut_the_zeros(std::to_string(res)).c_str();
    if (this->m_expression == "inf") {
        this->divisionByZero = true;
        this->m_expression = "DIVISION BY ZERO";
    }
    else if (this->m_expression == "nan") {
        this->divisionByZero = true;
        this->m_expression = "NOT A NUMBER";
    }
    this->floatingNumber = this->m_expression.indexOf('.') != -1;
    this->operationInserted = false;

    if (this->m_expression == "0") { this->valueIsZero = true; this->lastTag = TAGS::ZERO; }
    else if (this->m_expression == "0.0") { this->valueIsZero = true; this->lastTag = TAGS::ZERO; }
    else this->lastTag = TAGS::EQUALS;
}

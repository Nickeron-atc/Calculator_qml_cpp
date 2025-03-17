#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QString>

#include <string>
#include <algorithm>

#include "calculator.h"

class Backend: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString expression READ getValue WRITE setValue
                   NOTIFY valueChanged)
public:
    Backend(QObject *parent = nullptr) : m_expression{"0"}, calculator{} {
        divisionByZero = false;
        valueIsZero = true;
        operationInserted = false;
        floatingNumber = false;
        equalsButtonPressed = false;
        brackets_counter = 0;
        lastTag = TAGS::NUMBER;
    }

    QString getValue() const;
    void setValue(QString newValue);

    Q_INVOKABLE void push_button_brackets();
    Q_INVOKABLE void push_button_plus_minus();
    Q_INVOKABLE void push_button_dot();
    Q_INVOKABLE void push_button_percent();
    Q_INVOKABLE void push_button_clear();

    Q_INVOKABLE void push_button_0();
    Q_INVOKABLE void push_button_1();
    Q_INVOKABLE void push_button_2();
    Q_INVOKABLE void push_button_3();
    Q_INVOKABLE void push_button_4();
    Q_INVOKABLE void push_button_5();
    Q_INVOKABLE void push_button_6();
    Q_INVOKABLE void push_button_7();
    Q_INVOKABLE void push_button_8();
    Q_INVOKABLE void push_button_9();

    Q_INVOKABLE void push_button_add();
    Q_INVOKABLE void push_button_sub();
    Q_INVOKABLE void push_button_div();
    Q_INVOKABLE void push_button_mult();

    Q_INVOKABLE void push_button_equals();
signals:
    void valueChanged(QString);
private:
    enum TAGS {
        NONE                = 0,

        PLUS                = 1 << 1,
        MINUS               = 1 << 2,
        MULTIPLY            = 1 << 3,
        DIVIDE              = 1 << 4,

        PERCENT             = 1 << 5,
        SIGN                = 1 << 6,

        EQUALS              = 1 << 7,
        DOT                 = 1 << 8,
        CLEAR               = 1 << 9,

        ZERO                = 1 << 10,
        FLOATING_NUMBER     = (1 << 11) | ZERO,
        INTEGER_NUMBER      = (1 << 12) | ZERO,

        OPENNING_BRACKET    = 1 << 13,
        CLOSING_BRACKET     = 1 << 14,

        BINARY_OPERATION    = TAGS::PLUS | TAGS::MINUS | TAGS::MULTIPLY | TAGS::DIVIDE,
        UNARY_OPERATION     = PERCENT | SIGN,
        NUMBER              = FLOATING_NUMBER | INTEGER_NUMBER,
        BRACKET             = OPENNING_BRACKET | CLOSING_BRACKET
    };

    QString m_expression;

    bool divisionByZero;
    bool valueIsZero;
    bool operationInserted;
    bool floatingNumber;
    bool equalsButtonPressed;

    int brackets_counter;

    TAGS lastTag;

    Calculator calculator;
};

#endif // BACKEND_H

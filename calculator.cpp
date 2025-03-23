#include "calculator.h"

#include <iostream>
#include <sstream>
#include <string>
#include <algorithm>
#include <stack>
#include <cctype> // isdigit

int Calculator::operation_priority(char operation) {
    switch (operation) {
    case '(': return 0;
    case '+': case '-': return 1;
    case '*': case '/': return 2;
    case '~': case '%': return 3; // unary minus and percent
    default: return -1;
    }
}

std::string Calculator::get_string_number(const std::string& str, int& pos) {
    std::string strNumber;
    bool has_decimal_point = false;

    while (pos < str.length()) {
        char c = str[pos];
        if (isdigit(c) || (c == '.' && !has_decimal_point)) {
            if (c == '.') has_decimal_point = true;
            strNumber += c;
            pos++;
        } else {
            break;
        }
    }
    pos--;

    return strNumber;
}

std::string Calculator::precompute(const std::string& infix, int index1, int index2) {
    std::string str = infix.substr(index1+1, index2 - index1-1);
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
    auto remove_spaces = [](std::string str) {
        str.erase(std::remove_if(str.begin(), str.end(), [](char c) {
                      return std::isspace(static_cast<unsigned char>(c));
                  }), str.end());
        return str;
    };
    this->set_input(remove_spaces(str));
    str = cut_the_zeros(std::to_string(this->calculate()));
    return str;
}

std::string Calculator::evaluatePercent(std::string infix) {
    std::string orig = infix, eval = infix;
    for (int i = 0; i < orig.size(); i++) {
        if (orig[i] == '%') {
            int index = i - 1;
            while(index >= 0 && (orig[index] >= '0' && orig[index] <= '9'))
                index--;
            if (index > 0) {
                if (orig[index] == '+') {
                    eval = orig.substr(0, index) + "*(1+" + orig.substr(index+1, i - (index+1)) + "/100)";
                    if (i == orig.size() - 1)
                        eval += orig.substr(i + 1, orig.length() - 1);
                }
                else if (orig[index] == '-') {
                    eval = orig.substr(0, index) + "*(1-" + orig.substr(index+1, i - (index+1)) + "/100)";
                    if (i == orig.size() - 1)
                        eval += orig.substr(i + 1, orig.length() - 1);
                }
            }
        }
        orig = eval;
    }
    return eval;
}

std::string Calculator::toPostfix(const std::string& infix) {
    std::string postfix;
    std::stack<char> operator_stack;

    for (int i = 0; i < infix.length(); i++) {
        char c = infix[i];

        if (isdigit(c) || c == '.') {
            int start = i;
            postfix += get_string_number(infix, i) + " ";
        }
        else if (c == '(') {
            operator_stack.push(c);
        }
        else if (c == ')') {
            while (!operator_stack.empty() && operator_stack.top() != '(') {
                postfix += operator_stack.top();
                operator_stack.pop();
            }
            operator_stack.pop();
        }
        else if (operation_priority(c) >= 0) {
            char op = c;
            if (op == '-' && (i == 0 || (!isdigit(infix[i-1]) && infix[i-1] != ')'))) {
                op = '~';
            }

            while (!operator_stack.empty() && (operation_priority(operator_stack.top()) >= operation_priority(op))) {
                postfix += operator_stack.top();
                operator_stack.pop();
            }
            operator_stack.push(op);
        }
    }

    while (!operator_stack.empty()) {
        postfix += operator_stack.top();
        operator_stack.pop();
    }

    return postfix;
}

double Calculator::execute(char op, double first, double second = 0) {
    switch (op) {
    case '+': return first + second;
    case '-': return first - second;
    case '*': return first * second;
    case '/': return first / second;
    case '~': return -first; // unary minus
    case '%': return first / 100;
    default: return 0;
    }
}

Calculator::Calculator(const std::string& infix_notation) : infixNotation(infix_notation) {
    postfixNotation = toPostfix(infix_notation);
}

void Calculator::set_input(const std::string& param) {
    infixNotation = param;
    postfixNotation = toPostfix(infixNotation);
}

double Calculator::calculate() {
    return this->calculate(this->postfixNotation);
}

double Calculator::calculate(std::string postfixNotation) {
    std::stack<double> locals;
    for (int i = 0; i < postfixNotation.length(); i++) {
        char c = postfixNotation[i];

        if (isdigit(c) || c == '.') {
            std::string number;
            while (i < postfixNotation.length() && (isdigit(postfixNotation[i]) || postfixNotation[i] == '.')) {
                number += postfixNotation[i++];
            }
            locals.push(std::stod(number));
            i--;
        }
        else if (c == '~') {
            double last = locals.top();
            locals.pop();
            if (last == 0)
                locals.push(execute('+', 0, 0));
            else
                locals.push(execute('~', last));
        }
        else if (c == '%') {
            double last = locals.top();
            locals.pop();
            locals.push(execute('%', last));
        }
        else if (operation_priority(c) > 0) {
            double second = locals.top(); locals.pop();
            double first = locals.top(); locals.pop();
            locals.push(execute(c, first, second));
        }
    }
    return locals.top();
}

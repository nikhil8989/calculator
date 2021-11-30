import 'package:stack/stack.dart';

class CalculatorController {
  static CalculatorController instance = CalculatorController();
  int precedence(String op) {
    if (op == '+' || op == '-') return 1;
    if (op == '*' || op == '/' || op == '%') return 2;
    return 0;
  }

  int applyOp(int a, int b, String op) {
    switch (op) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '*':
        return a * b;
      case '/':
        return (a / b).floor();
      case '%':
        return a % b;
    }
    return a;
  }

  int evaluate(String tokens) {
    if (tokens.isEmpty) {
      return 0;
    }

    int i;

    Stack<int> values = Stack<int>();

    Stack<String> ops = Stack<String>();

    for (i = 0; i < tokens.length; i++) {
      if (tokens[i] == ' ') {
        continue;
      } else if (tokens[i] == '(') {
        ops.push(tokens[i]);
      } else if (int.tryParse(tokens[i]) != null) {
        int val = 0;
        while (i < tokens.length && int.tryParse(tokens[i]) != null) {
          val = (val * 10) + int.parse(tokens[i]);
          i++;
        }

        values.push(val);
        i--;
      } else if (tokens[i] == ')') {
        while (ops.isNotEmpty && ops.top() != '(') {
          int val2 = values.top();
          values.pop();

          int val1 = values.top();
          values.pop();

          String op = ops.top();
          ops.pop();

          values.push(applyOp(val1, val2, op));
        }
        if (ops.isNotEmpty) ops.pop();
      } else {
        while (ops.isNotEmpty && precedence(ops.top()) >= precedence(tokens[i])) {
          int val2 = values.top();
          values.pop();

          int val1 = values.top();
          values.pop();

          String op = ops.top();
          ops.pop();

          values.push(applyOp(val1, val2, op));
        }

        ops.push(tokens[i]);
      }
    }

    while (ops.isNotEmpty) {
      int val2 = values.top();
      values.pop();

      int val1 = values.top();
      values.pop();

      String op = ops.top();
      ops.pop();

      values.push(applyOp(val1, val2, op));
    }
    return values.top();
  }
}

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math' as math;

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  State<KalkulatorPage> createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  String _expression = '';
  String _result = '0';

  // Tombol ditekan
  void _buttonPressed(String buttonText) {
    setState(() {
      switch (buttonText) {
        case 'C':
          _expression = '';
          _result = '0';
          break;

        case '⌫':
          if (_expression.isNotEmpty) {
            _expression = _expression.substring(0, _expression.length - 1);
          }
          if (_expression.isEmpty) _result = '0';
          break;

        case '=':
          _evaluate();
          break;

        case 'x²':
          _square();
          break;

        case '√':
          _sqrt();
          break;

        default:
          // Hindari double operator seperti "++" atau "+×"
          if (_expression.isNotEmpty &&
              _isOperator(_expression[_expression.length - 1]) &&
              _isOperator(buttonText)) {
            _expression =
                _expression.substring(0, _expression.length - 1) + buttonText;
          } else {
            _expression += buttonText;
          }
          break;
      }
    });
  }

  // Cek apakah tombol operator
  bool _isOperator(String s) {
    return ['+', '-', '×', '÷', '*', '/'].contains(s);
  }

  // Fungsi menghitung ekspresi
  void _evaluate() {
    try {
      if (_expression.isEmpty) return;

      String finalExpression = _expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('√', 'sqrt');

      Parser p = Parser();
      Expression exp = p.parse(finalExpression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      _result = eval.toStringAsFixed(eval.truncateToDouble() == eval ? 0 : 2);
      _expression = _result;
    } catch (e) {
      _result = 'Error';
    }
  }

  // Kuadrat
  void _square() {
    try {
      double val = double.parse(_expression.isEmpty ? '0' : _expression);
      double squared = val * val;
      _result = squared.toStringAsFixed(
        squared.truncateToDouble() == squared ? 0 : 2,
      );
      _expression = _result;
    } catch (e) {
      _result = 'Error';
    }
  }

  // Akar
  void _sqrt() {
    try {
      double val = double.parse(_expression.isEmpty ? '0' : _expression);
      if (val < 0) {
        _result = 'Invalid';
      } else {
        double sq = math.sqrt(val);
        _result = sq.toStringAsFixed(sq.truncateToDouble() == sq ? 0 : 2);
        _expression = _result;
      }
    } catch (e) {
      _result = 'Error';
    }
  }

  // Widget tombol
  Widget _buildButton(String buttonText, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color ?? Colors.grey[200],
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _buttonPressed(buttonText),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color != null ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Bagian atas diperpendek (dari flex: 2 jadi flex: 1)
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _expression,
                      style: const TextStyle(
                        fontSize: 24, // 🔽 dari 32 → 24 agar muat
                        color: Colors.black54,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _result,
                      style: const TextStyle(
                        fontSize: 40, // 🔽 dari 52 → 40 agar lebih ramping
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 🔹 Bagian tombol tetap proporsional
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _buildButton('C', color: Colors.red[400]),
                        _buildButton('√', color: Colors.grey[600]),
                        _buildButton('x²', color: Colors.grey[600]),
                        _buildButton('÷', color: Colors.deepPurple),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton('7'),
                        _buildButton('8'),
                        _buildButton('9'),
                        _buildButton('×', color: Colors.deepPurple),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton('4'),
                        _buildButton('5'),
                        _buildButton('6'),
                        _buildButton('-', color: Colors.deepPurple),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton('1'),
                        _buildButton('2'),
                        _buildButton('3'),
                        _buildButton('+', color: Colors.deepPurple),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton('⌫', color: Colors.grey[700]),
                        _buildButton('0'),
                        _buildButton('.'),
                        _buildButton('=', color: Colors.deepPurple),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

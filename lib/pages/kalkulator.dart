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

  bool _isOperator(String s) {
    return ['+', '-', '×', '÷', '*', '/'].contains(s);
  }

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

  Widget _buildButton(String buttonText, {Color? color, Color? textColor}) {
    bool isSpecial = ['C', '⌫', '÷', '×', '-', '+', '='].contains(buttonText);

    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () => _buttonPressed(buttonText),
            child: Container(
              decoration: BoxDecoration(
                color: color ?? (isSpecial ? Colors.grey[100] : Colors.white),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
                gradient: color != null
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          color,
                          Color.alphaBlend(
                              Colors.black.withOpacity(0.1), color),
                        ],
                      )
                    : null,
              ),
              child: Center(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: textColor ??
                        (isSpecial ? Colors.blue[700] : Colors.black87),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- PERBAIKAN ADA DI SINI ---
  // Hapus 'Scaffold', 'body', dan 'backgroundColor'
  // Langsung return 'SafeArea'
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Display Area
          Expanded(
            flex: 1, // Anda bisa ubah rasio flex ini jika mau
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(
                      _expression,
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Saya tambahkan FittedBox di sini agar angka tidak overflow
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      _result,
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Buttons Area
          Expanded(
            flex: 3, // Rasio flex (bisa diubah, misal jadi 2)
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // --- Agar tombolnya pas ---
                  // Bungkus tiap Row dengan Expanded
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('C',
                            color: Colors.red[400], textColor: Colors.white),
                        _buildButton('√',
                            color: Colors.blue[700], textColor: Colors.white),
                        _buildButton('x²',
                            color: Colors.blue[700], textColor: Colors.white),
                        _buildButton('÷',
                            color: Colors.blue[700], textColor: Colors.white),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('7'),
                        _buildButton('8'),
                        _buildButton('9'),
                        _buildButton('×',
                            color: Colors.blue[700], textColor: Colors.white),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('4'),
                        _buildButton('5'),
                        _buildButton('6'),
                        _buildButton('-',
                            color: Colors.blue[700], textColor: Colors.white),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('1'),
                        _buildButton('2'),
                        _buildButton('3'),
                        _buildButton('+',
                            color: Colors.blue[700], textColor: Colors.white),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('⌫',
                            color: Colors.orange[400],
                            textColor: Colors.white),
                        _buildButton('0'),
                        _buildButton('.'),
                        _buildButton('=',
                            color: Colors.green[500],
                            textColor: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
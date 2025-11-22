import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  double? _firstOperand;
  String? _operator;
  bool _shouldReset = false;

  void _onNumberPress(String value) {
    setState(() {
      if (_shouldReset) {
        _display = '0';
        _shouldReset = false;
      }

      if (_display == '0' && value != '.') {
        _display = value;
      } else if (value == '.' && _display.contains('.')) {
        // ignore duplicate decimal
      } else {
        _display += value;
      }
    });
  }

  void _onOperatorPress(String op) {
    setState(() {
      try {
        _firstOperand = double.parse(_display);
      } catch (_) {
        _firstOperand = 0.0;
      }
      _operator = op;
      _shouldReset = true;
    });
  }

  void _onClear() {
    setState(() {
      _display = '0';
      _firstOperand = null;
      _operator = null;
      _shouldReset = false;
    });
  }

  void _onPlusMinus() {
    setState(() {
      if (_display.startsWith('-')) {
        _display = _display.substring(1);
      } else if (_display != '0') {
        _display = '-$_display';
      }
    });
  }

  void _onPercent() {
    setState(() {
      try {
        final val = double.parse(_display) / 100.0;
        _display = _formatResult(val);
      } catch (_) {}
    });
  }

  String _formatResult(double v) {
    if (v == v.roundToDouble()) return v.toInt().toString();
    return v.toString();
  }

  void _onEquals() {
    if (_operator == null || _firstOperand == null) return;

    double second;
    try {
      second = double.parse(_display);
    } catch (_) {
      second = 0.0;
    }

    double result;
    try {
      switch (_operator) {
        case '+':
          result = _firstOperand! + second;
          break;
        case '-':
          result = _firstOperand! - second;
          break;
        case '×':
        case '*':
          result = _firstOperand! * second;
          break;
        case '÷':
        case '/':
          if (second == 0) throw Exception('Division by zero');
          result = _firstOperand! / second;
          break;
        default:
          result = second;
      }
      setState(() {
        _display = _formatResult(result);
        _operator = null;
        _firstOperand = null;
        _shouldReset = true;
      });
    } catch (e) {
      setState(() {
        _display = 'Error';
        _operator = null;
        _firstOperand = null;
        _shouldReset = true;
      });
    }
  }

  Widget _buildButton(String label,
      {Color? color, void Function()? onTap, double flex = 1}) {
    return Expanded(
      flex: flex.toInt(),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? const Color(0xFF2E2E2E),
            padding: const EdgeInsets.symmetric(vertical: 22),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onTap,
          child: Text(
            label,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                alignment: Alignment.bottomRight,
                child: SingleChildScrollView(
                  reverse: true,
                  child: Text(
                    _display,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 56, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _buildButton('C', color: const Color(0xFF9E9E9E), onTap: _onClear),
                        _buildButton('+/-', color: const Color(0xFF9E9E9E), onTap: _onPlusMinus),
                        _buildButton('%', color: const Color(0xFF9E9E9E), onTap: _onPercent),
                        _buildButton('÷', color: const Color(0xFFFFA000), onTap: () => _onOperatorPress('/')),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton('7', onTap: () => _onNumberPress('7')),
                        _buildButton('8', onTap: () => _onNumberPress('8')),
                        _buildButton('9', onTap: () => _onNumberPress('9')),
                        _buildButton('×', color: const Color(0xFFFFA000), onTap: () => _onOperatorPress('*')),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton('4', onTap: () => _onNumberPress('4')),
                        _buildButton('5', onTap: () => _onNumberPress('5')),
                        _buildButton('6', onTap: () => _onNumberPress('6')),
                        _buildButton('-', color: const Color(0xFFFFA000), onTap: () => _onOperatorPress('-')),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton('1', onTap: () => _onNumberPress('1')),
                        _buildButton('2', onTap: () => _onNumberPress('2')),
                        _buildButton('3', onTap: () => _onNumberPress('3')),
                        _buildButton('+', color: const Color(0xFFFFA000), onTap: () => _onOperatorPress('+')),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton('0', onTap: () => _onNumberPress('0'), flex: 2),
                        _buildButton('.', onTap: () => _onNumberPress('.')),
                        _buildButton('=', color: const Color(0xFFFFA000), onTap: _onEquals),
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

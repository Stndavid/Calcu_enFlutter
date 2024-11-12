import 'package:flutter/material.dart';

void main() {
  runApp(const CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: const CalculadoraPage(),
    );
  }
}

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  CalculadoraPageState createState() => CalculadoraPageState();
}

class CalculadoraPageState extends State<CalculadoraPage> {
  String _output = '0';
  String _currentValue = '';
  String _operator = '';
  double _firstOperand = 0;

  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _output = '0';
        _currentValue = '';
        _operator = '';
        _firstOperand = 0;
      } else if (value == '+' || value == '-' || value == '×' || value == '÷' || value == '=') {
        if (value == '=') {
          double secondOperand = double.parse(_output.split(' ').last);
          double result = 0;
          switch (_operator) {
            case '+':
              result = _firstOperand + secondOperand;
              break;
            case '-':
              result = _firstOperand - secondOperand;
              break;
            case '×':
              result = _firstOperand * secondOperand;
              break;
            case '÷':
              result = _firstOperand / secondOperand;
              break;
          }
          _output = result.toString();
          _currentValue = _output;
          _operator = '';
        } else {
          _firstOperand = double.parse(_output);
          _operator = value;
          _currentValue += ' $value ';
          _output = _currentValue;
        }
      } else {
        _currentValue += value;
        _output = _currentValue;
      }
    });
  }

  Widget _buildButton(String label, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(label),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: color,
            shadowColor: Colors.black,
            elevation: 5,
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'), // Imagen de fondo
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Título de la calculadora
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'MI CALCULADORA EN FLUTTER',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: 480,  // Ancho del contenedor aumentado
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: const Color.fromARGB(255, 255, 255, 255), width: 3), // Agregar borde alrededor de la calculadora
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Pantalla de la calculadora con borde
                    Container(
                      width: double.infinity, // Hace que el contenedor ocupe todo el ancho
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color.fromARGB(255, 255, 255, 255), width: 2), // Borde solo para la pantalla
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        _output,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                    // Se agrega un espacio de 2px entre la pantalla y los botones
                    const SizedBox(height: 7),
                    // Marco alrededor de los botones de los operadores y números
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color.fromARGB(255, 255, 255, 255), width: 2), // Borde alrededor de los botones
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        children: [
                          // Fila con todos los operadores, incluyendo "="
                          Row(
                            children: [
                              _buildButton('C', Colors.redAccent),
                              _buildButton('÷', Colors.deepPurpleAccent),
                              _buildButton('×', Colors.deepPurpleAccent),
                              _buildButton('-', Colors.deepPurpleAccent),
                              _buildButton('+', Colors.deepPurpleAccent),
                              _buildButton('=', Colors.greenAccent), // Botón igual
                            ],
                          ),
                          Row(
                            children: [
                              _buildButton('7', Colors.grey.shade800),
                              _buildButton('8', Colors.grey.shade800),
                              _buildButton('9', Colors.grey.shade800),
                            ],
                          ),
                          Row(
                            children: [
                              _buildButton('4', Colors.grey.shade800),
                              _buildButton('5', Colors.grey.shade800),
                              _buildButton('6', Colors.grey.shade800),
                            ],
                          ),
                          Row(
                            children: [
                              _buildButton('1', Colors.grey.shade800),
                              _buildButton('2', Colors.grey.shade800),
                              _buildButton('3', Colors.grey.shade800),
                            ],
                          ),
                          // Fila con el 0 ocupando todo el ancho
                          Row(
                            children: [
                              _buildButton('0', Colors.grey.shade800),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

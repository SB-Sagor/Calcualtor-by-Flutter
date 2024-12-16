import 'package:calculator_app/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> buttons = [
    'AC',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    'Ans',
    '0',
    '.',
    '='
  ];
  String userInput = '';
  String answer = '';

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'AC') {
        userInput = '';
        answer = '';
      } else if (buttonText == 'DEL') {
        if (userInput.isNotEmpty) {
          userInput = userInput.substring(0, userInput.length - 1);
        }
      } else if (buttonText == '=') {
        try {
          String finalInput = userInput.replaceAll('x', '*');
          finalInput = finalInput.replaceAll('%', '/100');
          Parser p = Parser();
          Expression exp = p.parse(finalInput);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          answer = eval.toString();
        } catch (e) {
          answer = 'Error';
        }
      } else {
        userInput += buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Calculator',
          style: TextStyle(
            color: Colors.orange,
          ),
        ),
        centerTitle: true,
        leading: Icon(
          Icons.calculate,
          size: 50,
          color: Colors.lightBlueAccent,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(20.0),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      userInput,
                      style: TextStyle(color: Colors.white54, fontSize: 30),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      answer,
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {
                      return Mybutton(
                        buttonText: buttons[index],
                        color: Operator(buttons[index])
                            ? Colors.deepPurple
                            : Colors.lightBlueAccent,
                        textColor: Colors.white,
                        buttonTapped: () {
                          buttonPressed(buttons[index]);
                        },
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool Operator(String x) {
  if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
    return true;
  }
  return false;
}

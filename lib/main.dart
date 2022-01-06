import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38;
  double resultFontSize = 48;


  buttonPressed(String buttonText){
    setState(() {
      if (buttonText == "C"){
        equation = "0";
            result = "0";
         equationFontSize = 38;
         resultFontSize = 48;
       }

      else if(buttonText == "Del") {
         equationFontSize = 38;
         resultFontSize = 48;
        equation = equation.substring(0, equation.length - 1);
        if (equation == ""){
          equation = "0";
        }
      }

      else if(buttonText == "=") {
         equationFontSize = 38;
         resultFontSize = 48;

         expression = equation;
         expression = expression.replaceAll('X', '*');
         expression = expression.replaceAll('/', '/');

         try{
           Parser p = new Parser();
           Expression exp =p.parse(expression);

           ContextModel cm = ContextModel();
           result = '${exp.evaluate(EvaluationType.REAL, cm)}';
         }
         catch(e){
           result = "Error";
         }


      }

      else {
        equationFontSize = 38;
       resultFontSize = 48;
        if(equation == "0"){
          equation = buttonText;
        }

        else
        equation = equation + buttonText;
      }
    });
  }
  Widget Buildbutton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.1),
            side: BorderSide(
                color: Colors.white, width: 1, style: BorderStyle.solid)),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Calculator")),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 20, 0),
              child: Text(
                equation,
                style: TextStyle(
                  fontSize: equationFontSize,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 20, 0),
              child: Text(
                result,
                style: TextStyle(
                  fontSize: resultFontSize,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(children: [
                      Buildbutton("C", 1, Colors.redAccent),
                      Buildbutton("Del", 1, Colors.blue),
                      Buildbutton("/", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      Buildbutton("7", 1, Colors.black54),
                      Buildbutton("8", 1, Colors.black54),
                      Buildbutton("9", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      Buildbutton("4", 1, Colors.black54),
                      Buildbutton("5", 1, Colors.black54),
                      Buildbutton("6", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      Buildbutton("1", 1, Colors.black54),
                      Buildbutton("2", 1, Colors.black54),
                      Buildbutton("3", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      Buildbutton(".", 1, Colors.black54),
                      Buildbutton("0", 1, Colors.black54),
                      Buildbutton("00", 1, Colors.black54),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      Buildbutton("X", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      Buildbutton("-", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      Buildbutton("+", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      Buildbutton("=", 2, Colors.redAccent),
                    ]),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

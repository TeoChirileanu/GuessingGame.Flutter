import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GuessingGame",
      debugShowCheckedModeBanner: false,
      home: GuessedNumberForm(),
    );
  }
}

class GuessedNumberForm extends StatefulWidget {
  @override
  _GuessedNumberFormState createState() => _GuessedNumberFormState();
}

class _GuessedNumberFormState extends State<GuessedNumberForm> {
  int _correctNumber = 13;
  String _guessResult = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wanna play a game?"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          TextField(
            decoration: new InputDecoration(labelText: "Enter your guess:"),
            onSubmitted: checkGuess,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          Text(_guessResult),
        ],
      ),
    );
  }

  void checkGuess(String rawGuess) {
    /*
    This would have been much easier with C# 9 switch expressions:
    var guessResult = guess switch {
      < _correctNumber => "too low",
      > _correctNumber => "too high",
      _ => "correct!"
    };
    */
    setState(() {
      try {
        int guess = int.parse(rawGuess);
        if (guess == _correctNumber) {
          _guessResult = "Correct!";
          return;
        }
        _guessResult = guess > _correctNumber ? "too high!" : "too low!";
      } catch (e) {
        _guessResult = e.toString();
      }
    });
  }
}

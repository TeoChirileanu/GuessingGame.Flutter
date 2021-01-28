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
  bool _gameOver = false;
  int _correctNumber = 13;
  String _guessResult = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wanna play a game?"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: new InputDecoration(labelText: "Enter your guess:"),
                textAlignVertical: TextAlignVertical.center,
                onSubmitted: checkGuess,
                enabled: !_gameOver,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              Text(_guessResult),
              Visibility(
                child: OutlinedButton(
                  onPressed: resetGameState,
                  child: Text("Play again"),
                ),
                visible: _gameOver,
              )
            ],
          ),
        ),
        margin: EdgeInsets.all(30.0),
        padding: EdgeInsets.all(25.0),
      ),
    );
  }

  void checkGuess(String guessAsString) => setState(() {
        _guessResult = getGuess(guessAsString);
        if (_guessResult.contains("Correct")) _gameOver = true;
      });

  String getGuess(String guessAsString) {
    if (guessAsString.isEmpty) return "Empty input";

    int guessAsInteger = int.tryParse(guessAsString);
    if (guessAsInteger == null) return "Invalid number $guessAsString";

    if (guessAsInteger == _correctNumber) return "Correct!";

    return guessAsInteger > _correctNumber ? "too high!" : "too low!";
  }

  void resetGameState() {
    setState(() {
      _gameOver = false;
      _guessResult = "";
    });
  }
}

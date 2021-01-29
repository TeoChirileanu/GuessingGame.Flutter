import 'package:flutter/material.dart';

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
  num _correctNumber = 13;
  String _guessResult = "";
  var _guessController = TextEditingController();
  List<String> _guessAttempts = [];

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
              Text("Enter your guess:"),
              TextField(
                controller: _guessController,
                textAlign: TextAlign.center,
                enabled: !_gameOver,
              ),
              Visibility(
                visible: !_gameOver,
                child: TextButton(
                  onPressed: checkGuess,
                  child: Text("Check"),
                ),
              ),
              Text(_guessResult),
              Visibility(visible: _gameOver, child: Text("History: ${guessAttemptsAsString()}")),
              Visibility(
                visible: _gameOver,
                child: OutlinedButton(
                  onPressed: resetGameState,
                  child: Text("Play again"),
                ),
              )
            ],
          ),
        ),
        margin: EdgeInsets.all(30.0),
        padding: EdgeInsets.all(25.0),
      ),
    );
  }

  void checkGuess() {
    var guessAsString = _guessController.text;
    setState(() => _guessResult = getGuess(guessAsString));
    if (_guessResult.contains("Correct")) setState(() => _gameOver = true);
    setState(() => _guessController.text = "");
    _guessAttempts.add(guessAsString);
  }

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
      _guessAttempts.clear();
    });
  }

  String guessAttemptsAsString() => _guessAttempts.join(", ");
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'questionBank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuestionBank questionBank =
    QuestionBank(); // Helps in abstraction of question and answer list

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Center(
            child: Text("Quizzler App"),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

//  List<String> questionList = [
//    'You can lead a cow down stairs but not up stairs.',
//    'Approximately one quarter of human bones are in the feet.',
//    'A slug\'s blood is green.'
//  ];
//
//  List<bool> answers = [false, true, true];

  nextQuest() {
    bool val = questionBank.endOfQuestionList();
    setState(() {
      if (val == true) {
        _onBasicAlertPressed(context);
        scoreKeeper.clear();
      } else {
        setState(() {
          questionBank.nextQuestion();
        });
      }
    });
  }

  answerChecking(bool buttonPressed) {
    setState(() {
      if (buttonPressed == questionBank.getAnswer()) {
        scoreKeeper.add(Icon(Icons.check, color: Colors.green));
      } else {
        scoreKeeper.add(Icon(Icons.close, color: Colors.red));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBank.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ), // Questions
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text(
                "True",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () {
                answerChecking(true);
                nextQuest();
              },
            ),
          ),
        ), //True
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              child: Text(
                "False",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () {
                answerChecking(false);
                nextQuest();
              },
            ),
          ),
        ), //False
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

void _onBasicAlertPressed(BuildContext context) {
  Alert(
          context: context,
          title: "Questions Ended",
          desc: "Thank You for taking the quiz")
      .show();
}

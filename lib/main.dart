import 'package:flutter/material.dart';
import 'package:quizzer_flutter/question_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(
    Quizzler(),
  );
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
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
  QuestionBrain questionBrain = QuestionBrain();

  void handleAddResult(Icon icon) {
    setState(() {
      questionBrain.getNextQuestion();
      if (questionBrain.hasNextQuestion()) {
        scoreKeeper.add(icon);
      } else {
        Alert(
            context: context,
            title: "Finish",
            desc: "press under button to reset",
            buttons: [
              DialogButton(
                child: Text(
                  'Reset',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                onPressed: () {
                  setState(() {
                    questionBrain.resetQuestionCount();
                    scoreKeeper.clear();
                    Navigator.pop(context);
                  });
                },
              )
            ]).show();
      }
    });
  }

  void handleAnswer(bool selectAnswer) {
    questionBrain.checkingAnswer(selectAnswer)
        ? handleAddResult(Icon(
            Icons.check,
            color: Colors.green,
          ))
        : handleAddResult(Icon(
            Icons.close,
            color: Colors.red,
          ));
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
                questionBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                handleAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                handleAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/

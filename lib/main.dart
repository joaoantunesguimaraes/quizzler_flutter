//import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizzler',
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

  void checkAnswer(bool userPickedAnswer)  {
    bool correctedAnswer = quizBrain.getCorrectAnswer();
    Icon newIcon;

    setState(() {
      if (userPickedAnswer == correctedAnswer) {
        quizBrain.incCorrectAnswers();
        // scoreKeeper.add(Icon(
        //   Icons.check,
        //   color: Colors.green,
        // ));
        newIcon = Icon(
          Icons.check,
          color: Colors.green,
        );
      } else {
        // scoreKeeper.add(Icon(
        //   Icons.close,
        //   color: Colors.red,
        // ));
        newIcon = Icon(
          Icons.close,
          color: Colors.red,
        );
      }

      scoreKeeper.add(newIcon);

      if (quizBrain.isFinished()) {
        //sleep(const Duration(seconds: 1));
        //Future.delayed(Duration(seconds: 16));
        Alert(
          //onWillPopActive: true,
          //closeFunction: (_) => quizBrain.reset(),
          context: context,
          type: AlertType.success,
          title: "End of the Quiz!",
          content: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: scoreKeeper,
              ),
            ],
          ),
          desc: 'Correct answers: ${quizBrain.getCorrectAnswers()}/${scoreKeeper.length}',
          buttons: [
            DialogButton(
              child: Text(
                "RESTART",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                quizBrain.reset();

                setState(() {
                  scoreKeeper.clear();
                });
                // exp
                //quizBrain.reset();

                Navigator.pop(context);
              },
              width: 150,
            )
          ],
        ).show();
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
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                bool corectAnswer = quizBrain.getCorrectAnswer();
                checkAnswer(true);
                setState(() {
                  quizBrain.nextQuestion();
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                bool corectAnswer = quizBrain.getCorrectAnswer();
                checkAnswer(false);

                setState(() {
                  quizBrain.nextQuestion();
                });
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

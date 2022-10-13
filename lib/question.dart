
import 'package:quizzler/quiz_brain.dart';
class Question {
  String questionText;
  bool questionAnswer;
  // novo
  int correctAnswers;

  // Construtor Nomeado
  // Question({String q = '', bool a = true}) {
  //   questionText = q;
  //   questionAnswer = a;
  // }

  // Constructor
  // Question(String q, bool a) {
  //   questionText = q;
  //   questionAnswer = a;
  // }


  // Constructor with Syntactic sugar
  Question(this.questionText, this.questionAnswer, [this.correctAnswers = 0]);


}

class Question {
  final String questionText;
  final List<Answer> answerLists;

  Question(this.questionText, this.answerLists);
  //creating a constructor for the question class to be used later on the application
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

List<Question> getQuestion() {
  List<Question> lists = [];
  lists.add(Question('Who is the owner of flutter', [
    Answer('Google', true),
    Answer('facebook', false),
    Answer('amazon', false),
    Answer('you', false),
  ]));
  lists.add(Question('What is the next generation of web ', [
    Answer('Web1.0', false),
    Answer('Web2.0', false),
    Answer('Web3.0', true),
    Answer('Web4.0', false),
  ]));
  lists.add(Question('Flutter uses ______ programming language', [
    Answer('Pascal', false),
    Answer('Java', false),
    Answer('Rust', false),
    Answer('Dart', true),
  ]));
  lists.add(Question('what is the new name for the facebook', [
    Answer('Google', false),
    Answer('facebook', false),
    Answer('amazon', false),
    Answer('meta', true),
  ]));
  lists.add(Question('Which one is version control system', [
    Answer('Git', true),
    Answer('Drive', false),
    Answer('Java', false),
    Answer('Flutter', false),
  ]));
  return lists;
}

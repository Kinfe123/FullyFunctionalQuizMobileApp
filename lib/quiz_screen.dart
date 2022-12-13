import 'package:flutter/material.dart';
import 'package:quizapp/quiz_model.dart';

class QuizScreen extends StatefulWidget {
  String name = '';
  QuizScreen({required this.name});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questionList = getQuestion();
  int currentIndex = 0;
  int highscore = 0;
  int trail = 0;
  int score = 0;
  Answer? selectedAnswer = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 32, 83),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  'Welcome ${widget.name} to Quiz App',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Po'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.white,
                height: 1,
              ),
              _questionWidget(),
              _answerList(),
              SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  !(currentIndex == 0 ||
                          currentIndex + 1 == questionList.length)
                      ? _prevButton()
                      : Text(''),
                  _nextButton()
                ],
              ),
              SizedBox(height: 80),
              Divider(color: Colors.white, height: 10)
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: IconButton(
          color: Colors.amber,
          icon: Icon(Icons.info),
          onPressed: () {
            showDialog(context: context, builder: (_) => _scoreAnalysis());
          },
          //  style: IconButton.styleFrom(

          //  ),
        ),
      ),
    );
  }

  _questionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
        ),
        Center(
          child: Text(
            ' list of question - ${currentIndex + 1} / ${questionList.length.toString()}',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Po',
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: Text(
              '${currentIndex + 1}. ${questionList[currentIndex].questionText} ?',
              style: TextStyle(fontFamily: 'Po'),
            ))
      ],
    );
  }

  _answerList() {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: questionList[currentIndex]
          .answerLists
          .map((e) => _answerButton(e))
          .toList(),
    );
  }

  Widget _answerButton(Answer answer) {
    bool isSelected = answer == selectedAnswer;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      // margin: EdgeInsets.only(top: 10),
      // padding: EdgeInsets.all(30),
      width: double.infinity,
      height: 40,

      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(2.0),
      //   color: Colors.blue,
      // ),

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            // backgroundColor: Colors.white,
            primary: isSelected ? Colors.amber : Colors.white,
            onPrimary: isSelected ? Colors.black : Colors.white),
        // icon: Icon(Icons.church_outlined),
        onPressed: () {
          if (answer.isCorrect) {
            setState(() {
              score++;
            });
          }

          setState(() {
            selectedAnswer = answer;
          });
        },
        child: Text(
          answer.answerText,
          style: TextStyle(color: Colors.black, fontFamily: 'Po'),
        ),
      ),
    );
  }

  Widget _nextButton() {
    bool isLast = questionList.length == currentIndex + 1;

    // bool isSelected = answer == selectedAnswer;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      // margin: EdgeInsets.only(top: 10),
      // padding: EdgeInsets.all(30),
      width: MediaQuery.of(context).size.width * 0.3,
      height: 40,

      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(2.0),
      //   color: Colors.blue,
      // ),

      child: ElevatedButton.icon(
        icon: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
        style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            // backgroundColor: Colors.white,
            primary: Colors.blueAccent,
            onPrimary: Colors.black),
        // icon: Icon(Icons.church_outlined),
        onPressed: () {
          if (isLast) {
            showDialog(context: context, builder: (_) => _showScoreDialogue());
            setState(() {
              trail++;
              if (score > highscore) {
                setState(() {
                  highscore = score;
                });
              }
            });
          } else {
            setState(() {
              selectedAnswer = null;
              currentIndex++;
            });
          }
        },
        label: Text(
          isLast ? "Submit" : "Next",
          style: TextStyle(color: Colors.white, fontFamily: 'Po'),
        ),
      ),
    );
  }

  Widget _prevButton() {
    bool isLast = questionList.length == currentIndex + 1;

    // bool isSelected = answer == selectedAnswer;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      // margin: EdgeInsets.only(top: 10),
      // padding: EdgeInsets.all(30),
      width: MediaQuery.of(context).size.width * 0.3,
      height: 40,

      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(2.0),
      //   color: Colors.blue,
      // ),

      child: ElevatedButton.icon(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            // backgroundColor: Colors.white,
            primary: Colors.blueAccent,
            onPrimary: Colors.black),
        // icon: Icon(Icons.church_outlined),
        onPressed: () {
          setState(() {
            currentIndex--;
            score--;
          });
        },
        label: Text(
          'Previous',
          style: TextStyle(color: Colors.white, fontFamily: 'Po'),
        ),
      ),
    );
  }

  _showScoreDialogue() {
    return AlertDialog(
      title: Text(
        'Your score: ${score.toString()}',
        style: TextStyle(fontFamily: 'Po'),
      ),
      icon: Icon(Icons.announcement),
      backgroundColor: Colors.amber,
      elevation: 4.0,
      iconColor: Colors.black,
      content: ElevatedButton.icon(
        onPressed: () {
          setState(() {
            Navigator.of(context).pop();
            currentIndex = 0;
            score = 0;
          });
        },
        icon: Icon(Icons.restart_alt_rounded),
        label: Text(
          'Restart',
          style: TextStyle(fontFamily: 'Po'),
        ),
      ),
    );
  }

  _scoreAnalysis() {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hey ${widget.name} , ',
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Your score analysis',
            style: TextStyle(fontFamily: 'Po'),
          ),
          Divider(
            color: Colors.black,
            height: 1,
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Highscore: ${highscore}',
                  style: TextStyle(fontFamily: 'Po')),
              Text('Trail : ${trail}', style: TextStyle(fontFamily: 'Po')),
            ],
          )
        ],
      ),
      backgroundColor: Colors.amber,
      elevation: 8.0,
      iconColor: Colors.black,
      icon: Icon(Icons.announcement),
      content: ElevatedButton.icon(
        onPressed: () {
          setState(() {
            Navigator.of(context).pop();
            currentIndex = 0;
            score = 0;
          });
        },
        icon: Icon(Icons.arrow_back),
        label: Text(
          'Back',
          style: TextStyle(fontFamily: 'Po'),
        ),
      ),
    );
  }
}

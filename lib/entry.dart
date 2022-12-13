import 'package:flutter/material.dart';
import 'package:quizapp/quiz_screen.dart';

class EntryHome extends StatefulWidget {
  const EntryHome({super.key});

  @override
   _EntryHomeState createState() => _EntryHomeState();
}

class _EntryHomeState extends State<EntryHome> {
  String name = '';
  final _nameController = TextEditingController();
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 32, 83),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 10 ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height:20),
            Text('Welcome to QUIZ APP' , style: TextStyle(
              color: Colors.amber,
              fontFamily: 'Po',
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),),
       

            Container(
              margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 10 ),
              width: double.infinity,
              height: 90,
              decoration: BoxDecoration(
                
                borderRadius: BorderRadius.circular(20),
               
              ),
              child: TextField(
                controller: _nameController,
                
                decoration: InputDecoration(
                   fillColor: Colors.white,
                   
                   filled: true,
                  hintText: 'Enter your name' ,
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)), 
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Po',
                    fontWeight: FontWeight.w100,
                  
                    

                  )
                ),
                
              ),
              
            ),
            SizedBox(height: 10,),
            ElevatedButton.icon(
              icon: Icon(Icons.login_sharp, color: Colors.black,  ),
              onPressed: () {
                setState(() {
                  name = _nameController.text;
                });
                Navigator.push(context, MaterialPageRoute(builder:(context) => QuizScreen(name: name), ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 16),

              ),
              label: Text('Get started' , style: TextStyle(
                color: Colors.black , fontFamily: 'Po'
              ),),
            )
            
          ],

        ),
      ),
    );
  }
}
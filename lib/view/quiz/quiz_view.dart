import 'package:flutter/material.dart';
import 'package:quiz_app/view/quiz/quiz_screen.dart';

class ScienceQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Science Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Science Quiz'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back navigation here
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pop(context);
                // Handle search functionality here
              },
            ),
          ],
        ),
        body: ListView.separated(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) =>  QuizScreen()));


              },
              child: QuizCard(
                image: 'assets/logo.jpg',
                title: 'How do Plants convert...',
                author: 'Titus kitamura',
                time: '2 months ago',
                plays: '5.6k plays',
                questions: 16,
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 10,
            );
          },
        ));
  }
}

class QuizCard extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final String time;
  final String plays;
  final int questions;

  QuizCard({
    required this.image,
    required this.title,
    required this.author,
    required this.time,
    required this.plays,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            image,
            height: 140,
            width: 150,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/logo.jpg'),
                      radius: 16,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '• ${time} • ${plays}\n${author}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$questions Qs',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

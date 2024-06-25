import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dashboard.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestion = 0;
  List<String> _questions = [
    'How do plants convert light into energy?',
    'How do Rubber convert elastic into energy?',
    'How do Laptop convert electric into energy?',
    'How do Plastic convert silicon into energy?',
  ];
  List<List<String>> _answers = [
    ['Illumination', 'Transpiration', 'Photosynthesis'],
    ['dell', 'hp', 'apple'],
    ['silicon', 'rubber', 'polyester'],
    ['natural', 'handmade', 'Photosynthesis'],
  ];
  List<bool> _selectedAnswers = [];
  int _countdown = 10;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _selectedAnswers = List.filled(_questions.length, false);
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _countdown = 10;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _nextQuestion();
        }
      });
    });
  }

  void _nextQuestion() {
    _timer?.cancel();
    if (_currentQuestion < _questions.length - 1) {
      setState(() {
        _currentQuestion++;
        _startTimer();
      });
    } else {
      // Quiz finished, navigate to the dashboard
      Navigator.pop(
        context,
      );
    }
  }

  void _selectAnswer(int answerIndex) {
    setState(() {
      _selectedAnswers[_currentQuestion] = answerIndex == 2;
      _nextQuestion();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 300,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage('assets/logo.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              _questions[_currentQuestion],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            for (int i = 0; i < _answers[_currentQuestion].length; i++)
              ElevatedButton(
                onPressed: () => _selectAnswer(i),
                child: Text('${i + 1}. ${_answers[_currentQuestion][i]}'),
              ),
            SizedBox(height: 20),
            if (_selectedAnswers[_currentQuestion])
              Text(
                'Correct!',
                style: TextStyle(color: Colors.green),
              ),
            if (!_selectedAnswers[_currentQuestion] &&
                _currentQuestion == _questions.length - 1)
              Text(
                'Incorrect. The correct answer is Photosynthesis.',
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 20),
            Text(
              'Next question in $_countdown seconds',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

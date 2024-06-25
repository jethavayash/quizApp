import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dashboard.dart';
import '../helper/user_model_class.dart';


class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestion = 0;
  int _score = 0;
  bool _showNextButton = false;
  final List<String> _questions = [
    'How do plants convert light into energy?',
    'How do Rubber convert elastic into energy?',
    'How do Laptop convert electric into energy?',
    'How do Plastic convert silicon into energy?',
  ];
  final List<List<String>> _answers = [
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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
        _showNextButton = false;
        _startTimer();
      });
    } else {
      Navigator.pop(context);
      _showScoreScreen();
    }
  }

  void _selectAnswer(int answerIndex) {
    setState(() {
      _selectedAnswers[_currentQuestion] = answerIndex == 2;
      if (_selectedAnswers[_currentQuestion]) {
        _score++;
      }
      _showNextButton = true;
      _timer?.cancel();
    });
  }

  void _showScoreScreen() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Quiz Finished!'),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: Text('Your score: $_score/${_questions.length}'),
        );
      },
    );
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
        title: const Text('Plant Quiz'),
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
                image: const DecorationImage(
                  image: AssetImage('assets/logo.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _questions[_currentQuestion],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            for (int i = 0; i < _answers[_currentQuestion].length; i++)
              ElevatedButton(
                onPressed: () => _selectAnswer(i),
                child: Text('${i + 1}. ${_answers[_currentQuestion][i]}'),
              ),
            const SizedBox(height: 20),
            if (_showNextButton)
              ElevatedButton(
                onPressed: _nextQuestion,
                child: const Text('Next'),
              ),
            const SizedBox(height: 20),
            Text(
              'Next question in $_countdown seconds',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

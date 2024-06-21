import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_app/view/dashboard.dart';
import 'package:quiz_app/view/helper/user_model_class.dart';
import 'package:quiz_app/view/register/sign_up_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  bool visible = true;
  AnimationController? animationController;
  Animation<double>? animation;

  startTime() async {
    try {
      var _duration = const Duration(seconds: 3);
      return Timer(_duration, navigationPage);
    } catch(error){
      print('startTime Exception :- $error');
    }
  }

  Future<void> navigationPage() async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      var name = preferences.getString('DisplayName');
      var userId = preferences.getString('userId');
      var userEmail = preferences.getString('email');

      print('USERID=== ${userId}');
      print('USER EMAIL=== ${userEmail}');
      print('USER NAME=== ${name}');

      if (userId == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SignUpPage()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => DashBoardPage(
              user: Users(
                id: int.tryParse(userId)!,
                name: name ?? '',
                email: userEmail ?? '',
                isAdmin: false, // You can set admin status based on your logic
              ),
            ),
          ),
        );
      }
    } catch (error) {
      print('navigationPage Exception :- $error');
    }
  }


  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animation =
        CurvedAnimation(parent: animationController!, curve: Curves.easeInOut);
    animation!.addListener(() => setState(() {
      visible = !visible;
    }));
    animationController!.forward();
    setState(() {
      visible = !visible;
    });
    startTime();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Center(
          child: Text(
            'Ellena ToDo App',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFFFFF),
                letterSpacing: 10.0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
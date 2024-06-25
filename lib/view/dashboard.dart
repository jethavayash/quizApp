import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/view/quiz/quiz_view.dart';
import 'package:quiz_app/view/register/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'create_quiz.dart';
import 'helper/user_model_class.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key, required this.user});
  final Users user;
  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          GestureDetector(
              onTap: () {
                _showUserDetailsDialog(context);
              },
              child: const Icon(
                Icons.person,
                size: 30,
              )),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const CreateQuiz()));
                 },
              child: const Icon(
                Icons.add_circle,
                color: Colors.blue,
                size: 30,
              )),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            commonTile(
              icon: Icons.cast_for_education_outlined,
              color: Colors.blue,
              title: 'Education',
              ontTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) =>  ScienceQuizApp()));

              },
            ),
            commonTile(
              icon: Icons.science_outlined,
              color: Colors.deepPurple,
              title: 'Science',
              ontTap: () {},
            ),
            commonTile(
              icon: Icons.generating_tokens,
              color: Colors.orange,
              title: 'General Knowledge',
              ontTap: () {},
            ),
            commonTile(
              icon: Icons.games_outlined,
              color: Colors.deepPurpleAccent,
              title: 'Games',
              ontTap: () {},
            ),
            commonTile(
              icon: Icons.business_center,
              color: Colors.cyan,
              title: 'Business',
              ontTap: () {},
            ),
            commonTile(
              icon: Icons.movie_creation_outlined,
              color: Colors.redAccent,
              title: 'Entertainment',
              ontTap: () {},
            ),
            commonTile(
              icon: Icons.account_tree_outlined,
              color: Colors.green,
              title: 'Plants',
              ontTap: () {},
            ),
            commonTile(
              icon: Icons.format_paint,
              color: CupertinoColors.systemRed,
              title: 'Art',
              ontTap: () {},
            ),
            commonTile(
              icon: Icons.currency_rupee,
              color: Colors.brown,
              title: 'Finance',
              ontTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget commonTile(
      {required String title,
      required GestureTapCallback ontTap,
      required IconData icon,
      required Color color}) {
    return GestureDetector(
      onTap: ontTap,
      child: Column(
        children: [
          Card(
            elevation: 0.4,
            color: Colors.white,
            child: ListTile(
              horizontalTitleGap: 5,
              leading: Icon(
                icon,
                color: color,
              ),
              title: Text(
                title,
                style: TextStyle(
                  color: color,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  void _showUserDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: ListTile(
            leading: const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150'), // Replace with user's avatar URL
            ),
            title: Text(
              widget.user.email.toString(), // Replace with user's name
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                          ),
                          TextButton(
                            child: const Text('Logout'),
                            onPressed: () async {
                              final SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              preferences.remove('DisplayName');
                              preferences.remove('email');
                              preferences.remove('password');
                              preferences.remove('userId');

                              FirebaseAuth.instance.signOut();
                              Navigator.of(context).pop(); // Close the dialog
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Icon(Icons.logout)),
          ),
        );
      },
    );
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({Key? key}) : super(key: key);

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  List<String> _options = ['', '', ''];
  int? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Create Quiz'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText:
                    'Type your question here and option below with check mark..',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a question';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Center(
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.image,size: 100,),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showTime();
                  },
                  child: const Text('10 sec'),
                ),
                ElevatedButton(
                  onPressed: () {
                    showCategory();
                  },
                  child: const Text('Select Category'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.pink,
                      child: Text('${index + 1}',
                          style: const TextStyle(color: Colors.white)),
                    ),
                    title: TextFormField(
                      initialValue: _options[index],
                      onChanged: (value) {
                        setState(() {
                          _options[index] = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Type Option',
                      ),
                    ),
                    trailing: Checkbox(
                      value: _selectedOption == index,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value! ? index : null;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();

                    if (_formKey.currentState!.validate()) {
                      // Process the form data
                      // ...
                    }
                  },
                  child: const Text('Next +'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Finish'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future showCategory() {
    return showModalBottomSheet(
        context: context,backgroundColor: Colors.white,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Select Category',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 20),
                  commonTile(
                    icon: Icons.cast_for_education_outlined,
                    color: Colors.blue,
                    title: 'Education',
                    ontTap: () {},
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
        });
  }

  Future showTime() {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 400, // adjust the height to fit your content
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Time Limit',style: TextStyle(fontSize: 20),),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TimeLimitButton(
                      time: 5,
                      onPressed: () {
                        // handle time limit selection
                      },
                    ),
                    TimeLimitButton(
                      time: 10,
                      onPressed: () {
                        // handle time limit selection
                      },
                    ),

                  ],
                ),SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    TimeLimitButton(
                      time: 20,
                      onPressed: () {
                        // handle time limit selection
                      },
                    ),
                    TimeLimitButton(
                      time: 30,
                      onPressed: () {
                        // handle time limit selection
                      },
                    ),
                  ],
                ),SizedBox(height: 10,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    TimeLimitButton(
                      time: 45,
                      onPressed: () {
                        // handle time limit selection
                      },
                    ),
                    TimeLimitButton(
                      time: 60,
                      onPressed: () {
                        // handle time limit selection
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10,),Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    TimeLimitButton(
                      time: 90,
                      onPressed: () {
                        // handle time limit selection
                      },
                    ),
                    TimeLimitButton(
                      time: 120,
                      onPressed: () {
                        // handle time limit selection
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white10,minimumSize: Size(double.infinity, 50),
                    // side: BorderSide(width: 1, color: Colors.white),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    // handle form submission
                  },
                  child: Text('Ok',style: TextStyle(color: Colors.white,fontSize: 30),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget commonTile({
    required IconData icon,
    required Color color,
    required String title,
    required Function() ontTap,
  }) {
    return GestureDetector(
      onTap: ontTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeLimitButton extends StatelessWidget {
  final int time;
  final VoidCallback onPressed;

  TimeLimitButton({required this.time, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('$time sec'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,minimumSize: Size(150, 50),
        // side: BorderSide(width: 1, color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

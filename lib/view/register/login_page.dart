import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/view/dashboard.dart';
import 'package:quiz_app/view/helper/user_model_class.dart';
import 'package:quiz_app/view/register/sign_up_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordHidden = true;
  bool _rememberMe = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  addUser(String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  // Function to convert String UID to int
  int uidToInt(String uid) {
    var bytes = utf8.encode(uid); // Convert string to UTF-8 bytes
    var hash = bytes.fold(
        0,
        (sum, byte) =>
            sum + byte); // Sum all byte values to get a consistent int
    return hash;
  }

  // Your sign-in method using Firebase Authentication
  Future<void> signInWithEmailPassword(
      BuildContext context, String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        print("User is successfully signed in");

        // Retrieve user information from Firebase Authentication
        String uid = user.uid;
        int userId = uidToInt(uid); // Convert UID to int
        print("======${userId}");
        String name = user.displayName ??
            ''; // If display name is not set, use empty string
        String userEmail =
            user.email ?? ''; // If email is not set, use empty string

        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        preferences.setString('DisplayName', name);
        preferences.setString('password', password);
        preferences.setString('email', userEmail);
        preferences.setString('userId', userId.toString());

        print('USER ID -- ${userId}');
        print('USER NAME -- ${name}');
        print('USER EMAIL -- ${userEmail}');

        // Pass the user information to the TaskListScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DashBoardPage(
              user: Users(
                id: userId,
                name: name,
                email: userEmail,
                isAdmin: false, // You can set admin status based on your logic
              ),
            ),
          ),
        );

        // Optionally, retrieve the values to verify they are set correctly
        print('Retrieved USER ID -- ${preferences.getString('userId')}');
        print('Retrieved USER NAME -- ${preferences.getString('DisplayName')}');
        print('Retrieved USER EMAIL -- ${preferences.getString('email')}');
      }
    } catch (e) {
      print("Error signing in: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid Email or Password"),
          duration: Duration(seconds: 2), // Adjust the duration as needed
        ),
      );
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text(
                  'Sign Up Here',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              'Sign In',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            controller: _emailController,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 93, 84, 7),
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              hintText: "abc@xyz.com",
                              hintStyle: const TextStyle(fontSize: 18),
                              label: const Text(
                                "Email",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Password',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _passwordHidden,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 93, 84, 7),
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: IconButton(
                                  icon: _passwordHidden
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _passwordHidden = !_passwordHidden;
                                    });
                                  },
                                  color: Colors.black87,
                                ),
                              ),
                              hintText: "Test123",
                              hintStyle: const TextStyle(fontSize: 18),
                              label: const Text(
                                "Password",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CheckboxListTile(
                            title: const Text("Remember Me"),
                            value: _rememberMe,
                            onChanged: (newValue) {
                              setState(() {
                                _rememberMe = newValue!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          Divider(),
                          const SizedBox(
                            height: 30,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                // Handle forgot password action
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Colors.deepPurple, fontSize: 25),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                signInWithEmailPassword(
                                    context,
                                    _emailController.text,
                                    _passwordController.text);
                              }
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      color: Colors.deepPurple,
                                      style: BorderStyle.solid,
                                      width: 1)),
                              child: const Center(
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ]),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

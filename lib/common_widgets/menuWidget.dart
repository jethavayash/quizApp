import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/view/register/login_page.dart';


class customWidget extends StatelessWidget {
  const customWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(color: Colors.grey),
              child: Column(
                children: [
                  CircleAvatar(
                    // child: Text("ksdkjf"),
                    backgroundColor: Colors.grey.withOpacity(0.1),

                    backgroundImage: const NetworkImage(
                        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
                    maxRadius: 50,
                  ),
                  const Spacer(),
                  const Text(
                    "User",
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              )),

          ListTile(
            tileColor: Colors.red[200],

            leading: const Icon(Icons.logout),
            title: const Text("Sign Out"),
            trailing: const Icon(Icons.arrow_right),
            //autofocus: true,
            onTap: (() {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            }),
            dense: true,
          ),
          const Divider(
            thickness: 1,
            endIndent: 10,
            indent: 10,
          ),
        ],
      ),
    );
  }
}

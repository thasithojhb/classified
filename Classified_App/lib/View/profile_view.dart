import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/View/login_view.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
      child: ElevatedButton(
        child: const Text('Log Out'),
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove('token');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
        },

      ),
    );
  }
}

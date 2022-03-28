import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Controller/signup_controller.dart';
import 'package:untitled/View/home.dart';
import 'package:untitled/main_home.dart';
import 'package:untitled/models/Login.dart';

import '../Controller/login_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _StartPageState();
}

class _StartPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold (
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 100),
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Welcome',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                          fontSize: 30
                      ),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: userNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    margin: const EdgeInsets.only(top: 20.0),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Sign Up'),
                      onPressed: () async {
                        if (nameController.text.isEmpty || passwordController.text.isEmpty ||
                            emailController.text.isEmpty || userNameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Input Missing'))
                          );
                        } else if (await Signup().validate(nameController.text, userNameController.text, emailController.text, passwordController.text)) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
                                  (Route<dynamic> route) => false
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Email Already Exist'))
                          );
                        }
                      },
                    )
                ),
              ],
            )));
  }

}
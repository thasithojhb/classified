import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/View/signup_view.dart';
import 'package:untitled/main_home.dart';


import '../Controller/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _StartPageState();
}

class _StartPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold (
        body:Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
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
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Email',
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
                TextButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  child: const Text('Forgot Password',),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: _isLoading ?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator( color: Colors.white,),
                          SizedBox(width: 24,),
                          Text('Please Wait')
                        ],): const Text('Login'),
                      onPressed: () async {
                        if (_isLoading) {
                          return;
                        }
                        print(nameController.text.isNotEmpty);
                        print(passwordController.text);
                        setState(() {
                          _isLoading = true;
                        });
                        if (nameController.text.isEmpty || passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('No Password or User Name Added'))
                          );
                        } else if ( await Login().validate(nameController.text, passwordController.text)) {
                          await Login().getProducts(context);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
                                  (Route<dynamic> route) => false
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Invalid Password or Email'))
                          );
                        }
                        setState(() {
                          _isLoading = false;
                        });
                      },
                    )
                ),
                Row(
                  children: <Widget>[
                    const Text('Does not have account?'),
                    TextButton(
                      child: const Text(
                        'Sign up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //signup screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpPage()),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            )));
  }

  Future<bool> _onLoading(String username, String password) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
              Text("Loading"),
            ],
          ),
        );
      },
    );
    var _bool = await Login().validate(nameController.text, passwordController.text);
    if (!_bool) {
      Future.delayed(const Duration(seconds: 3), () {//pop dialog
        _StartPageState();
        setState(() {
        });
      });
    }
    return  _bool;
  }
}

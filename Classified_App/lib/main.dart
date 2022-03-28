
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/View/login_view.dart';
import 'package:untitled/main_home.dart';
import 'package:untitled/View/Add_Advert_view.dart';
import 'package:untitled/View/product_view.dart';
import 'package:untitled/View/classified_for_sale_view.dart';
import 'package:untitled/models/product.dart';


void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'QuteQuotes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loggedIn = false;
  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        ChangeNotifierProvider(create: (context) => Product())
      ],

      child: MaterialApp(
        title: 'quteQuotes',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blueGrey,
        ),
        home: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder:
                (BuildContext context, AsyncSnapshot<SharedPreferences> prefs) {
              var x = prefs.data;
              if (prefs.hasData) {
                  if( x?.getString('token') != null) {
                    return const HomePage();
                  }

              } else {
                return Container(
                    alignment: Alignment.center,
                    color: Colors.blueGrey,
                    margin: const EdgeInsets.only(top: 20),
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      value: 0.8,
                    )
                );
              }
              return const LoginPage();
            })
        ));

    // return Scaffold(
    //   appBar: AppBar(
    //     centerTitle: true,
    //     // Here we take the value from the MyHomePage object that was created by
    //     // the App.build method, and use it to set our appbar title.
    //     title: Text(widget.title,),
    //   ),
    //   body: _buildQuotes(),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (context) => _addNewQuote()),
    //       );
    //     },
    //     tooltip: 'Increment',
    //     child: Icon(Icons.add),
    //   ), // This trailing comma makes auto-formatting nicer for build methods.
    // );
  }



  void isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token'));
    if (prefs.getString('token') != null) {
      loggedIn = true;
    }
  }







}


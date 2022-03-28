import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:untitled/Controller/controller.dart';
import 'package:untitled/View/form_page.dart';
import 'package:untitled/View/quote_view.dart';
import 'package:untitled/models/product.dart';

class QuoteListView extends StatelessWidget {

  QuoteListView({Key? key}) : super(key: key);
  // late Future<List<Map>> futureQuotes = Controller().getData();
  final _biggerFont = const TextStyle(fontSize: 20.0);

  Iterable<ListTile> tile (BuildContext context, Product quotes) {
    final tiles = quotes.getQuoteList.map((pair) { // from controller
      return ListTile(
        title: Text(
          pair['text'].toString(),
          style: _biggerFont,
        ),
        onTap: () {
          // NEW lines from here...
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                QuoteView(pair)),
          );
        }, // ... to here.
      );
    });
    return tiles;
  }

  List<Widget> divided (BuildContext context, quotes) {
    Iterable<ListTile> tiles = tile(context, quotes);
    final divided = tiles.isNotEmpty
        ? ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList()
        : <Widget>[
      Center(
        child: Text(
          "No Quotes",
          textAlign: TextAlign.center,
          style: _biggerFont,
        ),
      )
    ];
    return divided;
  }

  @override
  Widget build(BuildContext context) {
    

    // Controller().update(context, this.futureQuotes);

    // final tiles = quotes.getQuoteList.map((pair) { // from controller
    //   return ListTile(
    //       title: Text(
    //         pair['text'].toString(),
    //         style: _biggerFont,
    //       ),
    //       onTap: () {
    //         // NEW lines from here...
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(builder: (context) =>
    //               QuoteView(
    //                   pair['text'].toString(), pair['name'].toString())),
    //         );
    //       }, // ... to here.
    //     );
    // });
    //
    // final divided = tiles.isNotEmpty
    //     ? ListTile.divideTiles(
    //   context: context,
    //   tiles: tiles,
    // ).toList()
    //     : <Widget>[
    //   Center(
    //     child: Text(
    //       "No Quotes",
    //       textAlign: TextAlign.center,
    //       style: _biggerFont,
    //     ),
    //   )
    // ];
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: const Text('Classified - For Sale',),
      // ),
      body: Consumer<Product>(
              builder: (context, quotes, child) =>
                  // ListView(
                  //     padding: const EdgeInsets.all(18.0),
                  //     children: this.divided(context, quotes)
                  // ),
              ListView.builder(
                                  itemCount: quotes.getQuoteList.length *2 ,
                                  padding: const EdgeInsets.all(18.0),
                                  itemBuilder: /*1*/ (context, i) {
                                    print('$i ${quotes.getQuoteList.length}');
                                    if (i.isOdd) return const Divider(); /*2*/

                                    final index = i ~/ 2; /*3*/
                                    print(quotes.getQuoteList);
                                    return _buildRow(context, quotes.getQuoteList[index]);
                                  }
                              )
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormPage()),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.post_add),
      ),
    );


    // return  Scaffold(
    //     appBar: AppBar(
    //           centerTitle: true,
    //           // Here we take the value from the MyHomePage object that was created by
    //           // the App.build method, and use it to set our appbar title.
    //           title: Text('QuteQuotes',),
    //         ),
    //   body: Container(
    //     child: Consumer<QuoteList>(
    //           builder: (context, quote, child) =>
    //               ListView.builder(
    //                   itemCount: quote.getQuoteList.length,
    //                   padding: const EdgeInsets.all(18.0),
    //                   itemBuilder: /*1*/ (context, i) {
    //                     print('$i ${quote.getQuoteList.length}');
    //                     // if (i.isOdd) return const Divider(); /*2*/
    //
    //                     final index = i ~/ 2; /*3*/
    //                     print(quote.getQuoteList);
    //                     return _buildRow(context, quote.getQuoteList[index]);
    //                   }
    //               )
    //       ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //       onPressed: () {
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(builder: (context) => QuoteForm()),
    //         );
    //       },
    //       tooltip: 'Increment',
    //       child: Icon(Icons.add),
    //     ),
    // );
  }
  
  List<Widget> _text(Map pair) {
    
    return  [
      Text(
        pair['description'].toString(),
        style: const TextStyle(fontSize: 15.0,
        color: Colors.black),
        overflow: TextOverflow.ellipsis,
        // textAlign: TextAlign.left,
      ),
      Text("Condition: " + pair['condition'].toString() + " "
            + "Packaging: " + pair['packaging'].toString() + " " 
            + "Warranty: "  +pair['warranty'].toString()+ " " 
            + "Bid Amount: R" + pair['minimumBid'].toString(),
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 12.0,
            color: Colors.black),

      ),
    ];
  }

  Widget _buildRow(BuildContext context, Map pair) {

    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.account_circle_rounded),
        backgroundColor: Colors.purple,

      ),
      title: Text(
        pair['userName'].toString(),
        style: _biggerFont,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _text(pair),
      ),
        onTap: () {
            // NEW lines from here...
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  QuoteView(pair)),
            );
          },
                    // ... to here.
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}


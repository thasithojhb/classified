import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:untitled/View/Add_Advert_view.dart';
import 'package:untitled/View/product_view.dart';
import 'package:untitled/models/product.dart';

class ClassifiedWantedView extends StatelessWidget {

  const ClassifiedWantedView({Key? key}) : super(key: key);
  final _biggerFont = const TextStyle(fontSize: 20.0);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Consumer<Product>(
              builder: (context, product, child) =>
                  ListView.builder(
                      itemCount: product.getProductWantedList.length *2 ,
                      padding: const EdgeInsets.all(18.0),
                      itemBuilder: /*1*/ (context, i) {
                        print('$i ${product.getProductWantedList.length}');
                        if (i.isOdd) return const Divider(); /*2*/

                        final index = i ~/ 2; /*3*/
                        print(product.getProductWantedList);
                        return _buildRow(context, product.getProductWantedList[index]);
                      }
                  )

            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddAdvert()),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.post_add),
      ),
    );
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
                  ProductView(pair)),
            );
          },
                    // ... to here.
    );
  }
}



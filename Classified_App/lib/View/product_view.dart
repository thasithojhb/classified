import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductView extends StatelessWidget {
  final Map product;
  const ProductView( this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text(product['description']),
      ),
      body: FittedBox(
        fit: BoxFit.fill,
        child: Container(
          margin: const EdgeInsets.only(top: 20, left: 5, right: 5),
          child: PhysicalModel(
              color: Colors.blueGrey,
              elevation: 8,
              shadowColor: Colors.blue,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                  margin: const EdgeInsets.only( top: 10.0,),
                  padding: const EdgeInsets.only(left: 15, top: 25, right: 5, bottom: 30),
                  width: MediaQuery.of(context).size.width,
                  // decoration: const BoxDecoration(
                  //   // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
                  //   color: Colors.blueGrey,
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: Colors.black,
                  //       blurRadius: 2.0,
                  //       spreadRadius: 0.0,
                  //       offset: Offset(2.0, 2.0), // shadow direction: bottom right
                  //     )
                  //   ],
                  // ),
                  // Center is a layout widget. It takes a single child and positions it
                  // in the middle of the parent.
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: const CircleAvatar(
                          child: Icon(Icons.account_circle_rounded),
                          backgroundColor: Colors.purple,

                        ),
                        title: Text(
                          product['userName'].toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(color: Colors.greenAccent,),
                        ),
                        subtitle: Text(timeAgoSinceDate(product['created'].toString().replaceAll('T', " "),),
                      )),
                      const SizedBox(height: 5,),
                      RichText(
                          text: TextSpan(
                            text: 'Item name: ',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15,),
                            children:  <TextSpan>[
                              TextSpan(text: product['description'] + "\n",  style: const TextStyle(fontWeight: FontWeight.normal,),),
                              const TextSpan(text: 'Age and Condition: ',  style: TextStyle(fontWeight: FontWeight.bold,),),
                              TextSpan(text: product['condition'] + "\n", style: const TextStyle(fontWeight: FontWeight.normal,),),
                              const TextSpan(text: 'Packaging: ', style: TextStyle(fontWeight: FontWeight.bold,),),
                              TextSpan(text: product['packaging'] + "\n", style: const TextStyle(fontWeight: FontWeight.normal,),),
                              const TextSpan(text: 'Warranty: ', style: TextStyle(fontWeight: FontWeight.bold,),),
                              TextSpan(text: product['warranty'] + "\n", style: const TextStyle(fontWeight: FontWeight.normal,),),
                              const TextSpan(text: 'Shipping: ', style: TextStyle(fontWeight: FontWeight.bold,),),
                              TextSpan(text: product['shipping'], style: const TextStyle(fontWeight: FontWeight.normal,),),
                            ],
                          )
                      ),
                    ],
                  )
              )),
        )
        ),



    );
  }

  String timeAgoSinceDate(String dateString, {bool numericDates = true}) {
    DateTime notificationDate = DateTime.parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);

    if (difference.inDays > 8) {
      return DateFormat.yMMMd().format(notificationDate);
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}

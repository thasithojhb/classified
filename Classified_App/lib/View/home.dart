import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:untitled/Controller/controller.dart';
import 'package:untitled/View/form_page.dart';
import 'package:untitled/View/quote_view.dart';
import 'package:untitled/View/quotes_list_view.dart';
import 'package:untitled/models/product.dart';

class Home extends StatelessWidget {

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: 2,
        child : Scaffold(
          appBar: AppBar(
            // automaticallyImplyLeading: false,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                TabBar(
                  tabs: [
                    Tab(
                      text: 'Classified - For Sale',
                    ),
                    Tab(
                      text: 'Classified - Wanted',
                    ),
                  ],
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              QuoteListView(),
              QuoteListView(),
            ],
          ),
        )
    );
  }
}


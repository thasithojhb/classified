import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:untitled/View/Add_Advert_view.dart';
import 'package:untitled/View/product_view.dart';
import 'package:untitled/View/classified_for_sale_view.dart';
import 'package:untitled/models/product.dart';

import 'classified_wanted_view.dart';

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
          body: const TabBarView(
            children: [
              ClassifiedForSaleView (),
              ClassifiedWantedView(),
            ],
          ),
        )
    );
  }
}


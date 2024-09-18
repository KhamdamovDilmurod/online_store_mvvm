import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_store_mvvm/screens/detail/detail_screen.dart';
import 'package:online_store_mvvm/viewModel/view_model.dart';
import 'package:stacked/stacked.dart';

import '../model/product_model.dart';
import '../view/product_item_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fake api store'),
      ),
      body: ViewModelBuilder<MainViewModel>.reactive(
        viewModelBuilder: () {
          return MainViewModel();
        },
        builder:
            (BuildContext context, MainViewModel viewModel, Widget? child) {
          return Stack(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ListView.builder(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        shrinkWrap: true,
                        primary: false,
                        scrollDirection: Axis.vertical,
                        itemCount: viewModel.products.length,
                        itemBuilder: (_, position) {
                          var item = viewModel.products[position];
                          return ProductItemView(
                            product: item,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => DetailScreen(id: item.id,)));
                            },
                          );
                        }),
                  ],
                ),
              ),
              // if (viewModel.progressData) showAsProgress(),
            ],
          );
        },
        onViewModelReady: (viewModel) {
          viewModel.getProducts();
          viewModel.errorData.listen((event) {
            // showError(context, event);
            print(event);
          });
        },
      ),
    );
  }
}

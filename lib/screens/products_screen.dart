import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_store_mvvm/view/product_item_view.dart';
import 'package:online_store_mvvm/view/shimmer_product_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

import '../viewModel/view_model.dart';
import 'detail/product_detail.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF6E0FFFF),
      appBar: AppBar(
        title: Text("online store"),
      ),
      body: ViewModelBuilder<MainViewModel>.reactive(
        viewModelBuilder: () {
          return MainViewModel();
        },
        builder:
            (BuildContext context, MainViewModel viewModel, Widget? child) {
          if (viewModel.products == null) {
            return CircularProgressIndicator();
          }
          return Stack(
            children: [
              GridView.builder(
                padding: EdgeInsets.all(10),
                itemCount: viewModel.products.length,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .7,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                ),
                itemBuilder: (context, index) {
                  var item = viewModel.products[index];
                  return ProductItemView(product: item);
                },
              ),
              if (viewModel.progressData) Center(child: ShimmerProductView()),
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

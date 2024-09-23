import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Fake API Store'),
      ),
      body: ViewModelBuilder<MainViewModel>.reactive(
        viewModelBuilder: () {
          return MainViewModel();
        },
        builder: (BuildContext context, MainViewModel viewModel, Widget? child) {
          if (viewModel.products == null) {
            return CircularProgressIndicator();
          }
          return Stack(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Wrapping GridView in a SizedBox with a defined height
                    SafeArea(
                        child: Container(
                          padding: EdgeInsets.only(bottom: 100),
                          height: MediaQuery.of(context).size.height * 0.88, // Adjust height as needed
                          child: GridView.builder(
                            padding: EdgeInsets.all(10),
                            itemCount: viewModel.products.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: .7,
                              mainAxisSpacing: 1,
                              crossAxisSpacing: 1,
                            ),
                            itemBuilder: (context, index) {
                              var item = viewModel.products[index];
                              return GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(18),
                                          child: Image.network(
                                            item.image,
                                            fit: BoxFit.contain,
                                            height: 130,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        item.title,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        item.title,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${item.price}",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                // Handle add to cart
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Color(0xff8e00c5),
                                                ),
                                                child: Icon(
                                                  Icons.add_rounded,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          ProductDetailScreen(id: item.id,),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                    ),
                    SizedBox(height: 100,)
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
      bottomNavigationBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "Home"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "Cart"
            )
          ]
      ),
    );
  }
}

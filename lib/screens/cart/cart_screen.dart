import 'package:flutter/material.dart';
import 'package:online_store_mvvm/provider/providers.dart';
import 'package:online_store_mvvm/view/cart_item_view.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sdfads"),
      ),
      body: Consumer<CartProvider>(builder: (context, provider, child){
        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: provider.getCartItems().length,
            itemBuilder: (context, index){
              final item = provider.getCartItems()[index];
              return CartItemView(item: item);
            });
      })
    );
  }
}

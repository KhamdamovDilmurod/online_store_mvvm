import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:online_store_mvvm/model/cart_model.dart';
import 'package:online_store_mvvm/model/product_model.dart';
import 'package:online_store_mvvm/utils/pref_utils.dart';

class CartProvider with ChangeNotifier{
  List<CartModel> _cartProducts = [];

  List<CartModel> get cartProducts  => _cartProducts;

  void add2Cart( ProductModel item) {
    final CartModel cartItem = CartModel(product: item, cart_count: 1, price: item.price);
    PrefUtils.addToCart(cartItem);
    notifyListeners();
  }

  List<CartModel> getCartItems(){
    _cartProducts = PrefUtils.getCartList();
    notifyListeners();
    return _cartProducts;
  }
}
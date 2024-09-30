import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:online_store_mvvm/model/cart_model.dart';
import 'package:online_store_mvvm/model/product_model.dart';
import 'package:online_store_mvvm/utils/pref_utils.dart';

class CartProvider with ChangeNotifier{
  List<CartModel> _cartProducts = [];

  List<CartModel> get cartProducts  => _cartProducts;

  void add2Cart( CartModel item) {
    PrefUtils.addToCart(item);
    notifyListeners();
  }

  List<CartModel> getCartItems(){
    _cartProducts = PrefUtils.getCartList();
    notifyListeners();
    return _cartProducts;
  }

  int getCartCount(int productId){
    int cartCount = PrefUtils.getCartCount(productId);
    notifyListeners();
    return cartCount;
  }
}
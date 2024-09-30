
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/cart_model.dart';

class PrefUtils {
  static SharedPreferences? _singleton;

  static const PREF_CART = "pref_cart";

  static SharedPreferences? getInstance() {
    return _singleton;
  }

  static initInstance() async {
    _singleton = await SharedPreferences.getInstance();
  }
  //
  // static BdmItemsModel? getBdmItems() {
  //   var json = _singleton?.getString(PREF_BDM_ITEMS);
  //   return json == null ? null : BdmItemsModel.fromJson(jsonDecode(json));
  // }
  //
  // static Future<bool> setBdmItems(BdmItemsModel items) async {
  //   return _singleton!.setString(PREF_BDM_ITEMS, jsonEncode(items.toJson()));
  // }
  //
  // static String getBaseUrl() {
  //   return _singleton?.getString(PREF_BASE_URL) ?? "";
  // }
  //
  // static Future<bool> setBaseUrl(String value) async {
  //   return _singleton!.setString(PREF_BASE_URL, value);
  // }
  //
  // static List<String> getFavoriteList() {
  //   return _singleton!.getStringList(PREF_FAVORITES) ?? [];
  // }
  //
  // static Future<bool> setFavoriteProduct(ProductModel item) async {
  //   var items = getFavoriteList();
  //   if (items.where((element) => item.id == element).isNotEmpty) {
  //     items = items.where((element) => element != item.id).toList();
  //   } else {
  //     items.add(item.id);
  //   }
  //   return _singleton!.setStringList(PREF_FAVORITES, items);
  // }


// Clearing the cart
  static Future<bool> clearCart() async {
    var result = await _singleton!.setString(PREF_CART, jsonEncode([]));
    return result;
  }

// Retrieving the cart list
  static List<CartModel> getCartList() {
    var json = _singleton?.getString(PREF_CART);
    if (json == null) {
      return [];
    }
    var items = (jsonDecode(json) as List<dynamic>)
        .map((js) => CartModel.fromJson(js as Map<String, dynamic>));
    return items.toList();
  }

// Getting cart count based on product ID
  static int getCartCount(int productId) {
    final items = PrefUtils.getCartList().where((element) => element.product.id == productId).toList();
    return items.isNotEmpty ? items.first.cart_count : 0;
  }

// Adding items to the cart
  static Future<bool> addToCart(CartModel item) async {
    var items = getCartList();

    if (item.cart_count == 0) {
      // If the cart count is 0, remove the item from the cart
      var indexToRemove = -1;
      for (var i = 0; i < items.length; i++) {
        if (items[i].product.id == item.product.id) {
          indexToRemove = i;
          break;
        }
      }
      if (indexToRemove > -1) {
        items.removeAt(indexToRemove);
      }
    } else {
      var found = false;
      // Update existing item if found
      for (var element in items) {
        if (element.product.id == item.product.id) {
          element.cart_count = item.cart_count;
          element.price = item.price;
          found = true;
          break;
        }
      }
      // Add new item if not found
      if (!found) {
        items.add(item);
      }
    }

    var result = await _singleton!.setString(PREF_CART, jsonEncode(items.map((item) => item.toJson()).toList()));
    return result;
  }


  static void clearAll() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

}
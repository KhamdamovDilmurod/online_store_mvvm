import 'package:online_store_mvvm/model/product_model.dart';

class CartModel {
   ProductModel product;
   int cart_count;
   double price;

  CartModel(
      {required this.product, required this.cart_count, required this.price,});

  // From JSON
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
        product: ProductModel.fromJson(json['product']),
        cart_count: json['cart_count'],
        price: json['price']

    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'cart_count': cart_count,
      'price': price,
    };
  }
}


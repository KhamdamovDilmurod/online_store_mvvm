import 'package:flutter/material.dart';
import 'package:online_store_mvvm/model/product_model.dart';

class ProductItemView extends StatefulWidget {
  ProductModel product;
  VoidCallback onPressed;
  ProductItemView({Key? key, required this.product, required this.onPressed,}) : super(key: key);

  @override
  _ProductItemViewState createState() => _ProductItemViewState();
}

class _ProductItemViewState extends State<ProductItemView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blueAccent, width: 1),
        ),
        child: Column(
          children: [
            Image.network(
              widget.product.image,
              width: 100,
              height: 200,
            ),

            Text(
              widget.product.title,
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
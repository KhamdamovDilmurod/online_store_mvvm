import 'package:flutter/material.dart';

import '../model/cart_model.dart';

class CartItemView extends StatefulWidget {
  final CartModel item;
  const CartItemView({Key? key, required this.item}) : super(key: key);

  @override
  _CartItemViewState createState() => _CartItemViewState();
}

class _CartItemViewState extends State<CartItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width * .9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.4),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            child: Icon(
              Icons.production_quantity_limits,
              size: 48,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.item.product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      style: ButtonStyle(
                      ),
                      onPressed: () {},
                      child: Text(
                        "-",
                        style: TextStyle(color: Colors.black, fontSize: 32),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(widget.item.cart_count.toString(), style: TextStyle(fontSize: 32, color: Colors.black),),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: Text("+",
                          style:
                          TextStyle(color: Colors.black, fontSize: 32)),
                    ),
                  ],
                )
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete, size: 32,), onPressed: () {  },
          ),
        ],
      ),
    );
  }
}

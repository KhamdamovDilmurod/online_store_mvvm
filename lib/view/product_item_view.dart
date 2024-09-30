import 'package:flutter/material.dart';
import 'package:online_store_mvvm/model/cart_model.dart';
import 'package:online_store_mvvm/model/product_model.dart';
import 'package:online_store_mvvm/provider/providers.dart';
import 'package:provider/provider.dart';

class ProductItemView extends StatefulWidget {
  final ProductModel product;

  const ProductItemView({Key? key, required this.product}) : super(key: key);

  @override
  _ProductItemViewState createState() => _ProductItemViewState();
}

class _ProductItemViewState extends State<ProductItemView> {
  int cartCount = 0;

  @override
  void initState() {
    cartCount = context.read<CartProvider>().getCartCount(widget.product.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  widget.product.image,
                  fit: BoxFit.contain,
                  height: 130,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              widget.product.title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              widget.product.title,
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
                    "${widget.product.price}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  context.read<CartProvider>().getCartCount(widget.product.id) >
                          0
                      ? Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                cartCount--;
                                context.read<CartProvider>().add2Cart(CartModel(
                                    product: widget.product,
                                    price: widget.product.price,
                                    cart_count: cartCount));
                              },
                              child: Container(
                                width: 28,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: Colors.blueAccent, width: 1)),
                                child: Icon(Icons.remove),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Text(
                                context
                                    .read<CartProvider>()
                                    .getCartCount(widget.product.id)
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                cartCount++;
                                context.read<CartProvider>().add2Cart(CartModel(
                                    product: widget.product,
                                    price: widget.product.price,
                                    cart_count: cartCount));
                              },
                              child: Container(
                                width: 28,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: Colors.blueAccent, width: 1)),
                                child: Icon(Icons.add),
                              ),
                            ),
                          ],
                        )
                      : GestureDetector(
                          onTap: () {
                            // Handle add to cart
                            context
                                .read<CartProvider>()
                                .add2Cart(CartModel(
                                product: widget.product,
                                price: widget.product.price,
                                cart_count: 1));
                            print("JW-ERROR: $cartCount");
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
      onTap: () {},
    );
  }
}

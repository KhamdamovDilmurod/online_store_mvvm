import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ProductZoom extends StatefulWidget {
  final String image;
  const ProductZoom({Key? key, required this.image}) : super(key: key);

  @override
  _ProductZoomState createState() => _ProductZoomState();
}

class _ProductZoomState extends State<ProductZoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PhotoView(
            imageProvider: NetworkImage(widget.image),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.close, size: 30, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);  // Close the screen
              },
            ),
          ),
        ],
      ),
    );
  }
}
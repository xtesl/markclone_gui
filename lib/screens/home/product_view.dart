import 'package:flutter/material.dart';
import 'package:markclone/Functionalities/special_functions.dart';

class ProductView extends StatefulWidget {
  final String productName;
  const ProductView({super.key, required this.productName});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  String formatProductName(String productName) {
    if (productName.length > 15) {
      return '${productName.substring(0, 15)}...';
    }
    return productName;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> screenDimensions = getScreenDimensions(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            formatProductName(widget.productName),
            style: TextStyle(fontSize: screenDimensions['width']! * 0.04),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Container(
                      constraints: BoxConstraints(
                        maxWidth: screenDimensions['width']! * 0.99,
                      ),
                      child: const Product()))
            ],
          ),
        ));
  }
}

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      shadowColor: Colors.white,
      child: Image.asset(
        'assets/images/iphone_15_pro_max.png',
        fit: BoxFit.cover,
      ),
    );
  }
}

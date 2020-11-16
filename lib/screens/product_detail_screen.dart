import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {

  // final String title;
  // final double price;
  // ProductDetailScreen(this.title, this.price);

  static const routeName = '/product_detail';

  @override
  Widget build(BuildContext context) {
    //product_itemからのidを取得
    final productId = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shop_app/providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {

  // final String title;
  // final double price;
  // ProductDetailScreen(this.title, this.price);

  static const routeName = '/product_detail';

  @override
  Widget build(BuildContext context) {
    //product_itemからのidを取得
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadProduct = Provider.of<Products>(
        context,
        listen: false).findById(productId);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loadProduct.title),
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                title: Text(loadProduct.title),
                background: Hero(
                  tag: loadProduct.id,
                  child: Image.network(
                    loadProduct.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
               [
                SizedBox(height: 10),
                Text(
                  '\$${loadProduct.price}',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                    loadProduct.description,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
                 SizedBox(
                   height: 800,
                 )
              ])
          )
        ],
      ),
    );
  }
}

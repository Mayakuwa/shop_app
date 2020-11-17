import 'package:flutter/material.dart';
import 'product_item.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class ProductsGrid extends StatelessWidget {

  final bool showFavorites;
  ProductsGrid(this.showFavorites);

  @override
  Widget build(BuildContext context) {
    //Productsインスタンスとコミュニケーション
    final productsDate = Provider.of<Products>(context);
    final products = showFavorites ? productsDate.favoriteItems : productsDate.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      //itemをrenderする
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl
        ),
      ) ,
      //itemの表示の仕方を定義
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio:  3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}

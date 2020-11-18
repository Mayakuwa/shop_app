import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/widgets/product_grid.dart';

enum FilterOptions {
  Favorite,
  All
}

class ProductOverViewScreen extends StatefulWidget {
  @override
  _ProductOverViewScreenState createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {

  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('My shop'),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if(selectedValue == FilterOptions.Favorite) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites =  false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                    child: Text('Only Favorites'),
                    value: FilterOptions.Favorite),
                PopupMenuItem(
                    child: Text('Show All'),
                    value: FilterOptions.All),
              ],
            ),
            Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                child: ch,
                value: cart.itemCount.toString(),
              ),
                child: IconButton(
                    icon: Icon(
                    Icons.shopping_cart
                  ),
                  onPressed: () {},
              ),
            )
          ],
      ),
      //GridView.builderはListView同様、表示する要素が事前にわからない場合に利用する書き方です。
      // itemBuilderは画面表示時に実行されるため、無限にグリッドを作成することが可能です。
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/providers/product.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  //
  // ProductItem(this.id, this.title, this.imageUrl);
  //
  // final String id;
  // final String title;
  // final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    //GridTileをClipRRectでLappingすることで、radiusを表現している
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: GridTile(
          //ImageをGestureDetectorでLapすることでTapできるようになる
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                    ProductDetailScreen.routeName,
                    arguments: product.id
                );
              },
              child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover
              )
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              builder: (ctx, product, _) => IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border
              ),
              onPressed: () {
                product.toggleFavoriteStatus();
              },
              color: Theme.of(context).accentColor,
            ),
            ),
            title: Text(
                product.title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white)),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
              },
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
    );
  }
}

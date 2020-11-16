import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {

  ProductItem(this.id, this.title, this.imageUrl);

  final String id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    //GridTileをClipRRectでLappingすることで、radiusを表現している
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
          child: Image.network(
              imageUrl,
              fit: BoxFit.cover
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
              leading: IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () => null,
                  color: Theme.of(context).accentColor,
              ),
              title: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white)),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {

              },
              color: Theme.of(context).accentColor,
            ),
          ),
      ),
    );
  }
}

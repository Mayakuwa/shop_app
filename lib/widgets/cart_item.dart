import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {

  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(
     this.id,
     this.productId,
     this.price,
     this.quantity,
     this.title
  );

  @override
  Widget build(BuildContext context) {
    //Dismissibleで要素をスワイプして削除することができる
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              //TextをFittedBoxで囲むことで、テキストが枠内に収まって表示される
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(child: Text('\$$price'))
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${(price * quantity)}'),
            trailing: Text('$quantity x '),
          ),
        ),
      ),
    );
  }
}
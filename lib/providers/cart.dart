import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    // containsKeyメソッドは、指定したキーが存在するか確認を行い、キーが存在する場合はtrueを返します
    if(_items.containsKey(productId)) {
      //change quantity
      _items.update(productId,
              (existingCartItem) =>
                  CartItem(
                      id: existingCartItem.id,
                      title: existingCartItem.title,
                      quantity: existingCartItem.quantity + 1,
                      price: existingCartItem.price
                  ));
    } else {
      //productIdにマッチする_itemがnullの場合、CartItemを新しく生成する。
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1
          ),
      );
    }
    notifyListeners();
  }
}
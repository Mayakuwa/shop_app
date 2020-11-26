import 'package:flutter/foundation.dart';
import 'cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amout;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amout,
    @required this.products,
    @required this.dateTime
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders =[];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cardProducts, double  total) async {
    const url = 'https://my-shop-388ad.firebaseio.com/orders.json';
    final timeStamp = DateTime.now();
    final response = await http.post(
        url,
        body: json.encode({
      'amout' : total,
      'dateTime': timeStamp.toIso8601String(),
      'products' : cardProducts.map((cp) => {
        'id' : cp.id,
        'title':cp.title,
        'quantity':cp.quantity,
        'price':cp.price
      }).toList()
    }));
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amout: total,
            dateTime: timeStamp,
            products: cardProducts
        ),
    );
    notifyListeners();
  }

}
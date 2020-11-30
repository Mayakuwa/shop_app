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
  final String authToken;
  final String userId;

  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrder() async {
    final url = 'https://my-shop-388ad.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    //dynamicで宣言すると、動的な型宣言が可能となる
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    //エラーハンドリング
    if(extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
          OrderItem(
              id: orderId,
              amout: orderData['amout'],
              dateTime: DateTime.parse(orderData['dateTime']),
              products: (orderData['products'] as List<dynamic>)
                    .map((item) => CartItem(
                    id: item['id'],
                    title: item['title'],
                    quantity: item['quantity'],
                    price: item['price'])).toList(),
              ),
          );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cardProducts, double  total) async {
    final url = 'https://my-shop-388ad.firebaseio.com/orders/$userId.json?auth=$authToken';
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
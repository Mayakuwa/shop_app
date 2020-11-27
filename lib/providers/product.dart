import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {

  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  //this is changeble method
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    //初期値はいいねがされていない
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token)async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = 'https://my-shop-388ad.firebaseio.com/products/$id.json?auth=$token';
    try {
      final response = await http.patch(
          url,
          body: json.encode({
            'isFavorite' : isFavorite
          }),
      );
      if(response.statusCode >= 400) {
        // if adding to date is fail, rollback.
        _setFavValue(oldStatus);
      }
    } catch(error) {
      // if adding to date is fail, rollback.
      _setFavValue(oldStatus);
    }
  }

}
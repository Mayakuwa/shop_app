import 'package:flutter/material.dart';
import 'package:shop_app/widgets/product_grid.dart';

class ProductOverViewScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('My shop')
      ),
      //GridView.builderはListView同様、表示する要素が事前にわからない場合に利用する書き方です。
      // itemBuilderは画面表示時に実行されるため、無限にグリッドを作成することが可能です。
      body: ProductsGrid(),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'screens/products_overview_screen.dart';
import 'screens/product_detail_screen.dart';
import 'providers/products.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Provider追加
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders()
        ),
      ],
      // productに関するWidgetだけ監視（not to Material App）
      child: MaterialApp(
        title: 'My Shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductOverViewScreen(),
        routes: {
          //ルート設定
          ProductDetailScreen.routeName:  (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My shop'),
      ),
      body: Center(
        child: Text('hello'),
      ),
    );
  }
}

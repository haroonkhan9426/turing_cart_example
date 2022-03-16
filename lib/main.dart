import 'package:cart_example/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProductsCatalog(),
      ),
    );
  }
}

class Product {
  String? name;
  double price;

  Product({this.name, required this.price});
}

class ProductsCatalog extends StatefulWidget {
  @override
  _ProductsCatalogState createState() => _ProductsCatalogState();
}

class _ProductsCatalogState extends State<ProductsCatalog> {

  List<Product> products = [
    Product(name: 'cheese burger', price: 3),
    Product(name: 'bacon burger', price: 5),
    Product(name: 'beef burger', price: 4),
    Product(name: 'simple burger', price: 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, provider, child) => 
      Scaffold(
          appBar: AppBar(
            title: Text('Product Catalog'),
            actions: [
              Stack(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartScreen()));
                      },
                      icon: Icon(Icons.car_rental)),
                  Text(
                    '${provider.cartProducts.length}',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: products.length, 
            itemBuilder: (context, index) => ListTile(
              title: Text(products[index].name!),
              subtitle: Text(products[index].price.toString()),
              trailing: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                 provider.addItemInCart(products[index]);
                },
              ),
            ),
          )),
    );
  }
}

class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, provider, child) => 
       Scaffold(
          appBar: AppBar(
            title: Text('Cart Screen'),
          ),
          body: ListView.builder(
            itemCount: provider.cartProducts.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(provider.cartProducts[index].name!),
              subtitle: Text(provider.cartProducts[index].price.toString()),
              trailing: IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
                  provider.removeCartItem(index);
                },
              ),
            ),
          )),
    );
  }
}

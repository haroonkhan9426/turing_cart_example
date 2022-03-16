import 'package:cart_example/main.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier{
  List<Product> cartProducts = [];
  int cartItemCount = 0;


  addItemInCart(Product newProduct){
    cartProducts.add(newProduct);
    cartItemCount++;
    notifyListeners();
  }

  removeCartItem(index){
    cartProducts.removeAt(index);
    cartItemCount--;
    notifyListeners();
  }

}
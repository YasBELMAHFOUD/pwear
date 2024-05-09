import 'package:flutter/material.dart';
import 'package:pwear_store2/databaseObjects/design.dart';

class CartLine {
  int id;
  Design article;
  Color color;
  String size;
  int quantity;
  double price;
  bool dismissed;

  CartLine({
    required this.id,
    required this.article,
    required this.quantity,
    required this.price,
    required this.color,
    required this.size,
    this.dismissed = false,
  });

  static List<CartLine> cartlines = [];

  // static int getQuantitySum() {
  //   return cartlines.fold<int>(0, (sum, cartLine) => sum + cartLine.quantity);
  // }

  static int getQuantitySum() {
    int sum = 0;

    for (var cartLine in cartlines) {
      sum = sum + cartLine.quantity;
    }

    return sum;
  }

  static double getTotalPrice() {
    double totalPrice = 0.0;

    for (var cartLine in cartlines) {
      totalPrice = totalPrice + cartLine.price;
    }

    return totalPrice;
  }
}

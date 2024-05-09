import 'package:pwear_store2/databaseObjects/cart_line.dart';

class Cart {
  int idcart;
  double totalprice;
  int paymentMethod;
  List<CartLine> cartlines;
  String date;
  Cart(
      {required this.idcart,
      required this.totalprice,
      required this.cartlines,
      required this.paymentMethod,
      required this.date});

  static List<Cart> carts = [];
}

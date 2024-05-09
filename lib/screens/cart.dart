import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pwear_store2/components/cart_item_card.dart';
import 'package:pwear_store2/constants.dart';
import 'package:pwear_store2/databaseObjects/cart_line.dart';
import 'package:pwear_store2/pwear.dart';
import 'package:pwear_store2/screens/chekout.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  CartScreenState createState() => CartScreenState();
}

double getProportionateScreenWidth(double width, BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  return width * screenWidth / 375;
}

class CartScreenState extends State<CartScreen> {
  int? cartItemCount;
  double? totalAmount;

  @override
  void initState() {
    super.initState();
    cartItemCount = CartLine.getQuantitySum();
    totalAmount = CartLine.getTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Your Cart',
            style: TextStyle(color: Colors.black, fontSize: 20)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Text(
            "$cartItemCount items", //Use the separate variable for count
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: CartLine.cartlines.length,
              itemBuilder: (context, index) {
                final cart = CartLine.cartlines[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(9, 140, 210, 0.25),
                          offset: Offset(0, 8), //(x,y)
                          blurRadius: 16,
                          spreadRadius: 3,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Dismissible(
                      key: Key(cart.id.toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          CartLine.cartlines.removeAt(index);

                          cartItemCount = CartLine.getQuantitySum();
                          totalAmount = CartLine.getTotalPrice();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Item removed from cart."),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      background: Container(
                        clipBehavior: Clip.hardEdge,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 243, 217, 142),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            const Spacer(),
                            SvgPicture.asset("assets/icons/Trash.svg"),
                          ],
                        ),
                      ),
                      child: CartItemRow(
                        cartline: cart,
                        onAmountChanged: (value) {
                          setState(() {
                            totalAmount = value;
                          });
                        },
                        oncartItemCountChanged: (value) {
                          setState(() {
                            cartItemCount = value;
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(20, context),
          horizontal: getProportionateScreenWidth(20, context),
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 243, 217, 142),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -10),
              blurRadius: 10,
              color: const Color(0xFFDADADA).withOpacity(0.15),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total :",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "$totalAmount DH",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (CartLine.cartlines.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        scrollable: true,
                        title: const Text('cart empty'),
                        content: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                const Text('your cart is empty'),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const Pwear(),
                                          ),
                                        );
                                      },
                                      child: const Text("Store"),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      );
                    },
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Checkout(),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Checkout ($cartItemCount)',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

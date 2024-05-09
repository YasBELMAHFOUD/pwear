import 'package:flutter/material.dart';
import 'package:pwear_store2/components/quantity.dart';
import 'package:pwear_store2/constants.dart';
import 'package:pwear_store2/databaseObjects/cart_line.dart';
import 'package:pwear_store2/screens/cart.dart';

class CartItemRow extends StatefulWidget {
  const CartItemRow(
      {Key? key,
      required this.cartline,
      required this.onAmountChanged,
      required this.oncartItemCountChanged})
      : super(key: key);

  final CartLine cartline;
  final ValueChanged<double> onAmountChanged;
  final ValueChanged<int> oncartItemCountChanged;

  @override
  CartItemRowState createState() => CartItemRowState();
}

class CartItemRowState extends State<CartItemRow> {
  double totalPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kPrimaryLightColor.withOpacity(0.35),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                child: SizedBox(
                    height: 70,
                    width: getProportionateScreenWidth(50, context),
                    child: Image.asset(
                      widget.cartline.article.path,
                      fit: BoxFit.fitHeight,
                    )),
              ),
              SizedBox(width: getProportionateScreenWidth(20, context)),
              SizedBox(
                height: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          child: Text.rich(
                            TextSpan(
                              text: widget.cartline.article.designName.length >
                                      30
                                  ? '${widget.cartline.article.designName.substring(0, 30)}...' // Adjust the number as needed
                                  : widget.cartline.article.designName,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${widget.cartline.price.toStringAsFixed(2)} Dh",
                      style: const TextStyle(color: kPrimaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: QuantitySelector(
              initialValue: widget.cartline.quantity,
              onChanged: (p0) {
                setState(() {
                  widget.cartline.quantity = p0;
                  widget.cartline.price =
                      widget.cartline.quantity * widget.cartline.article.prix;
                });
                double totalAmount = CartLine.getTotalPrice();
                widget.onAmountChanged(totalAmount);

                int cartItemCount = CartLine.getQuantitySum();
                widget.oncartItemCountChanged(cartItemCount);
              },
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                width: 100,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: kPrimaryLightColor.withOpacity(0.2),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(widget.cartline.size),
                    CircleAvatar(
                      radius: 8,
                      backgroundColor: widget.cartline.color,
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

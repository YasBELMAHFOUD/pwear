// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pwear_store2/components/master_card.dart';
import 'package:pwear_store2/constants.dart';

class CashOnDeliv extends StatefulWidget {
  static bool isSelected = false;
  final ValueChanged<bool?> onValueChanged;

  const CashOnDeliv({super.key, required this.onValueChanged});
  @override
  State<CashOnDeliv> createState() => _CashOnDelivState();
}

class _CashOnDelivState extends State<CashOnDeliv> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: CashOnDeliv.isSelected
                  ? [
                      const Color.fromARGB(255, 223, 200, 74),
                      const Color(0xFFFF84BB),
                      const Color(0xFFFDB2E8),
                    ]
                  : [
                      Colors.grey.withOpacity(0.5),
                      Colors.blueGrey.withOpacity(0.5),
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          Positioned(
            top: 16,
            left: 24,
            child: SvgPicture.asset(
              "assets/Payment_images/cash-on-delivery.svg",
              height: 100,
            ),
          ),
          Positioned(
            top: 16,
            right: 24,
            child: Transform.scale(
              scale: 2,
              child: Checkbox(
                checkColor: Colors.black,
                activeColor: kPrimaryLightColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                value: CashOnDeliv.isSelected,
                onChanged: (value) {
                  setState(() {
                    CashOnDeliv.isSelected = true;
                    Mastercard.isSelected = false;
                    widget.onValueChanged(CashOnDeliv.isSelected);
                  });
                },
              ),
            ),
          ),
          const Positioned(
            bottom: 47,
            left: 24,
            child: Text(
              "Cash",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const Positioned(
            bottom: 22,
            left: 24,
            child: Text(
              "On Delivery",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pwear_store2/components/cash_on_deliv.dart';
import 'package:pwear_store2/constants.dart';

class Mastercard extends StatefulWidget {
  static bool isSelected = false;
  final ValueChanged<bool?> onValueChanged;
  const Mastercard({super.key, required this.onValueChanged});

  @override
  State<Mastercard> createState() => _MastercardState();
}

class _MastercardState extends State<Mastercard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: Mastercard.isSelected
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
            child: SvgPicture.asset("assets/Payment_images/Mastercard-logo.svg",
                width: 100),
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
                value: Mastercard.isSelected,
                onChanged: (value) {
                  setState(() {
                    Mastercard.isSelected = true;
                    CashOnDeliv.isSelected = false;
                    widget.onValueChanged(Mastercard.isSelected);
                  });
                },
              ),
            ),
          ),
          const Positioned(
            bottom: 47,
            left: 24,
            child: Text(
              "8977 5468 2554 8786",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const Positioned(
            bottom: 22,
            left: 24,
            child: Text(
              "MyNameIs Jeff",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pwear_store2/constants.dart';

class Upside extends StatelessWidget {
  const Upside({Key? key, required this.imgUrl, required this.logoUrl})
      : super(key: key);
  final String logoUrl;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height / 2,
          color: kPrimaryColor,
          child: Image.asset(
            imgUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Image.asset(
            logoUrl,
            width: 50,
            height: 50,
          ),
        ),
      ],
    );
  }
}

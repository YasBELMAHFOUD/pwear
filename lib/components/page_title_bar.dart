import 'package:flutter/material.dart';

class PageTitleBar extends StatefulWidget {
  const PageTitleBar(
      {Key? key, required this.title, required MaterialColor backgroundColor})
      : super(key: key);
  final String title;

  @override
  State<PageTitleBar> createState() => _PageTitleBarState();
}

class _PageTitleBarState extends State<PageTitleBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 260.0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 4,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 228, 229, 230),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                color: Color(0xFF575861)),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class RememberMeSwitch extends StatefulWidget {
  const RememberMeSwitch({Key? key}) : super(key: key);

  @override
  RememberMeSwitchState createState() => RememberMeSwitchState();
}

class RememberMeSwitchState extends State<RememberMeSwitch> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 40),
      child: SwitchListTile(
        dense: true,
        title: const Text(
          'Remember Me',
          style: TextStyle(fontSize: 16, fontFamily: 'OpenSans'),
        ),
        value: rememberMe,
        activeColor: Colors.blue,
        onChanged: (val) {
          setState(() {
            rememberMe = val;
          });
        },
        secondary: rememberMe
            ? const Icon(Icons.check, color: Colors.blue)
            : const Icon(Icons.close, color: Colors.grey),
      ),
    );
  }
}

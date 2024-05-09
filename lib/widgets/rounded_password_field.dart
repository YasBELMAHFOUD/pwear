import 'package:flutter/material.dart';
import 'package:pwear_store2/constants.dart';
import 'package:pwear_store2/widgets/text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  const RoundedPasswordField({Key? key}) : super(key: key);

  @override
  RoundedPasswordFieldState createState() => RoundedPasswordFieldState();
}

class RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: !isPasswordVisible,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: const Icon(
            Icons.lock,
            color: Colors.grey,
          ),
          hintText: "Password",
          hintStyle: const TextStyle(fontFamily: 'OpenSans'),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
            child: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

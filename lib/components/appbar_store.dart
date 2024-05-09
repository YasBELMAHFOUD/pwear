import 'package:flutter/material.dart';
import 'package:pwear_store2/constants.dart';
import 'package:pwear_store2/databaseObjects/cart_line.dart';
import 'package:pwear_store2/main.dart';

import 'package:pwear_store2/screens/cart.dart';
import 'package:pwear_store2/screens/login_screen.dart';
import 'package:pwear_store2/screens/signup_screen.dart';

class StoreAppBar extends SliverAppBar {
  const StoreAppBar({super.key, required this.logged});
  final bool? logged;
  @override
  State<StoreAppBar> createState() => _StoreAppBarState();
}

class _StoreAppBarState extends State<StoreAppBar> {
  int cartItems = 0;
  @override
  void initState() {
    cartItems = CartLine.getQuantitySum();
    super.initState();
  }

  @override
  SliverAppBar build(BuildContext context) {
    bool isLabelVisible;
    if (cartItems != 0) {
      isLabelVisible = true;
    } else {
      isLabelVisible = false;
    }
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: false,
      floating: true,

      toolbarHeight: 113,
      elevation: 8,
      backgroundColor: kPrimaryLightColor,
      shadowColor: kPrimaryColor,

      //-----------------------------title : middle-----------------------------
      title: Image.asset(
        "assets/logo/pwearlogo.png",
        width: 100,
      ),
      //------------------------------------------------------------------------

      //------------------------------------------------------------------------actions : right
      actions: [
        Row(
          children: [
            Visibility(
              visible: (widget.logged == null),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Log in",
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.w900),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1, color: kPrimaryColor)),
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: (widget.logged == true),
              child: (MyApp.clentImage != null)
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(
                        'http://10.0.2.2/Pwear/${MyApp.clentImage!}',
                      ),
                    )
                  : const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/Profile_image/defaultAvatar.jpg'),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Badge(
                label: Text(cartItems.toString()),
                isLabelVisible: isLabelVisible,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
      //----------------------------------------------------------------------------

      //leading : left--------------------------------------------------------------
      //leading:
      //----------------------------------------------------------------------------

      //-----------------------------bottom : bottom-------------------------------

      //---------------------------------------------------------------------------

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
    );
  }
}

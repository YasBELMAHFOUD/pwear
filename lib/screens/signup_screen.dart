import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pwear_store2/components/page_title_bar.dart';
import 'package:pwear_store2/components/under_part.dart';
import 'package:pwear_store2/components/upside.dart';
import 'package:pwear_store2/constants.dart';
import 'package:pwear_store2/pwear.dart';
import 'package:pwear_store2/screens/login_screen.dart';
import 'package:pwear_store2/widgets/text_field_container.dart';
import '../widgets/rounded_button.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isPasswordVisible = false;
  bool isRememberMeChecked = false;

  TextEditingController useremailController = TextEditingController();
  FocusNode useremailFocusNode = FocusNode();

  TextEditingController userBirthdayController = TextEditingController();
  FocusNode userBirhdayFocusNode = FocusNode();

  TextEditingController userPhoneNumberController = TextEditingController();
  FocusNode userPhoneNumberFocusNode = FocusNode();

  TextEditingController usernameController = TextEditingController();
  FocusNode usernameFocusNode = FocusNode();

  TextEditingController passwordController = TextEditingController();
  FocusNode userpasswordFocusNode = FocusNode();

  DateTime? dateTime = DateTime.now();

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime(2020),
            firstDate: DateTime(DateTime.now().year - 150),
            lastDate: DateTime(DateTime.now().year))
        .then((date) {
      setState(() {
        dateTime = date;
        userBirthdayController.text =
            '${dateTime!.year}-${dateTime!.month}-${dateTime!.day}';
      });
    });
  }

  Future<void> registerClient(String clientName, String email, String birthday,
      String password, String phoneNumber) async {
    // API endpoint for the PHP script

    final url = Uri.parse('http://10.0.2.2/Pwear/signup.php');

    // Create the request body

    final body = {
      'clientName': clientName,
      'email': email,
      'birthday': birthday,
      'phoneNumber': phoneNumber,
      'password': password,
    };

    // Send the POST request
    final response = await http.post(url, body: body);
    final data = json.decode(response.body);
    if (data["status"] == "Success") {
      if (context.mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
      }
    } else if (data["status"] == "Error") {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              scrollable: true,
              title: const Text('Account already exist'),
              content: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const Text(
                          'ther is already an email associated with this email'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("try again"),
                          ),
                          const Text('or'),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            child: const Text("log in"),
                          ),
                        ],
                      ),
                    ],
                  )),
            );
          },
        );
      }
    } else if (data["status"] == "Error2") {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              scrollable: true,
              title: const Text('error'),
              content: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    const Text('an error has occured try again later'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("try again"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    }
  }

  String emailRegex = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)*[a-zA-Z]{2,7}$';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String email;
    String clientname;
    String password;
    String birthday;
    String phone;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Pwear.currentpage = 1;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Pwear(),
                  ));
            },
            icon: const Icon(CupertinoIcons.home),
          ),
          title: const Text('Sign Up',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: const Color(0xFFEBD298),
        ),
        body: Container(
          width: size.width,
          height: size.height,
          color: const Color(0xFFEBD298),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                const Upside(
                  logoUrl: "assets/images/Splash.png",
                  imgUrl: "assets/images/loginImage.jpg",
                ),
                const PageTitleBar(
                  title: 'Create your account',
                  backgroundColor: Colors.blue,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 320.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEBD298),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Form(
                          child: Column(
                            children: [
                              TextFieldContainer(
                                child: TextField(
                                  onSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(usernameFocusNode);
                                  },
                                  focusNode: useremailFocusNode,
                                  controller: useremailController,
                                  cursorColor: kPrimaryColor,
                                  decoration: const InputDecoration(
                                      icon: Icon(
                                        Icons.email,
                                        color: Colors.grey,
                                      ),
                                      hintText: "Email",
                                      hintStyle:
                                          TextStyle(fontFamily: 'OpenSans'),
                                      border: InputBorder.none),
                                ),
                              ),
                              TextFieldContainer(
                                child: TextField(
                                  controller: usernameController,
                                  cursorColor: kPrimaryColor,
                                  onSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(userBirhdayFocusNode);
                                  },
                                  focusNode: usernameFocusNode,
                                  decoration: const InputDecoration(
                                      icon: Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                      ),
                                      hintText: "UserName",
                                      hintStyle:
                                          TextStyle(fontFamily: 'OpenSans'),
                                      border: InputBorder.none),
                                ),
                              ),
                              TextFieldContainer(
                                child: TextField(
                                  controller: userBirthdayController,
                                  cursorColor: kPrimaryColor,
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .digitsOnly, // Only allow digits
                                    LengthLimitingTextInputFormatter(
                                        10), // Limit the length to 10 digits
                                  ],
                                  onTap: () {
                                    _showDatePicker();
                                    FocusScope.of(context)
                                        .requestFocus(userPhoneNumberFocusNode);
                                  },
                                  onSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(userPhoneNumberFocusNode);
                                  },
                                  focusNode: userBirhdayFocusNode,
                                  decoration: const InputDecoration(
                                      icon: Icon(
                                        Icons.date_range,
                                        color: Colors.grey,
                                      ),
                                      hintText: "Birth Day YYYY-MM-DD",
                                      hintStyle:
                                          TextStyle(fontFamily: 'OpenSans'),
                                      border: InputBorder.none),
                                ),
                              ),
                              TextFieldContainer(
                                child: TextField(
                                  controller: userPhoneNumberController,
                                  cursorColor: kPrimaryColor,
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .digitsOnly, // Only allow digits
                                    LengthLimitingTextInputFormatter(
                                        10), // Limit the length to 10 digits
                                  ],
                                  onSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(userpasswordFocusNode);
                                  },
                                  focusNode: userPhoneNumberFocusNode,
                                  decoration: const InputDecoration(
                                      icon: Icon(
                                        Icons.phone_android,
                                        color: Colors.grey,
                                      ),
                                      hintText: "Phone number",
                                      hintStyle:
                                          TextStyle(fontFamily: 'OpenSans'),
                                      border: InputBorder.none),
                                ),
                              ),
                              TextFieldContainer(
                                child: TextField(
                                  controller: passwordController,
                                  obscureText: !isPasswordVisible,
                                  cursorColor: kPrimaryColor,
                                  focusNode: userpasswordFocusNode,
                                  decoration: InputDecoration(
                                    icon: const Icon(
                                      Icons.lock,
                                      color: Colors.grey,
                                    ),
                                    hintText: "Password",
                                    hintStyle:
                                        const TextStyle(fontFamily: 'OpenSans'),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isPasswordVisible =
                                              !isPasswordVisible;
                                        });
                                      },
                                      child: Icon(
                                        isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              RoundedButton(
                                text: 'REGISTER',
                                press: () {
                                  if (useremailController.text != '') {
                                    if (RegExp(emailRegex)
                                        .hasMatch(useremailController.text)) {
                                      if (userBirthdayController.text != '') {
                                        if (userPhoneNumberController.text !=
                                            '') {
                                          if (passwordController.text != '') {
                                            if (usernameController.text != '') {
                                              clientname =
                                                  usernameController.text;
                                              email = useremailController.text;
                                              phone = userPhoneNumberController
                                                  .text;
                                              birthday =
                                                  userBirthdayController.text;
                                              password =
                                                  passwordController.text;

                                              registerClient(clientname, email,
                                                  birthday, password, phone);
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    scrollable: true,
                                                    title: const Text(
                                                        'Username required'),
                                                    content: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        child: Column(
                                                          children: [
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  "ok"),
                                                            ),
                                                          ],
                                                        )),
                                                  );
                                                },
                                              );
                                            }
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  scrollable: true,
                                                  title: const Text(
                                                      'Password required'),
                                                  content: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Column(
                                                        children: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                "ok"),
                                                          ),
                                                        ],
                                                      )),
                                                );
                                              },
                                            );
                                          }
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                scrollable: true,
                                                title: const Text(
                                                    'Phone number required'),
                                                content: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Column(
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const Text("ok"),
                                                        ),
                                                      ],
                                                    )),
                                              );
                                            },
                                          );
                                        }
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              scrollable: true,
                                              title: const Text(
                                                  'Birthday required'),
                                              content: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Column(
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text("ok"),
                                                      ),
                                                    ],
                                                  )),
                                            );
                                          },
                                        );
                                      }
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            scrollable: true,
                                            title: const Text(
                                                'incorrect email format'),
                                            content: Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Column(
                                                  children: [
                                                    const Text(
                                                        'the email format you entered is invalide'),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("ok"),
                                                    ),
                                                  ],
                                                )),
                                          );
                                        },
                                      );
                                    }
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          scrollable: true,
                                          title: const Text('email required'),
                                          content: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Column(
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("ok"),
                                                  ),
                                                ],
                                              )),
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                              UnderPart(
                                title: "Already have an account?",
                                navigatorText: "Login here",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

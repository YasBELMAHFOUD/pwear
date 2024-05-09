import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pwear_store2/components/page_title_bar.dart';
import 'package:pwear_store2/components/under_part.dart';
import 'package:pwear_store2/components/upside.dart';
import 'package:pwear_store2/constants.dart';
import 'package:pwear_store2/main.dart';
import 'package:pwear_store2/pwear.dart';
import 'package:pwear_store2/screens/signup_screen.dart';
import 'package:pwear_store2/widgets/rounded_button.dart';
import 'package:pwear_store2/widgets/rounded_icon.dart';
import 'package:pwear_store2/widgets/text_field_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'forgot_pass.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = false;
  TextEditingController useremailController = TextEditingController();
  FocusNode useremailFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  FocusNode userpasswordFocusNode = FocusNode();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    String email;
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)*[a-zA-Z]{2,7}$';
    String password;

//----------------------------------------login function with error handling---------------------------------------

    Future<void> loginClient(String email, String password) async {
      final url = Uri.parse('http://10.0.2.2/Pwear/login.php');

      // Create the request body
      final body = {
        'email': email,
        'password': password,
      };

      // Send the POST request
      final response = await http.post(url, body: body);

      var data = json.decode(response.body);

      if (data["status"] == "Success") {
        if (rememberMe == true) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('idClient', data['idClient']);
          await prefs.setString('clientname', data['ClientName']);
          await prefs.setString('clientimage', data['ClientImage']);
          await prefs.setString('emailaddress', data['EmailAddress']);
          await prefs.setString('city', data['City']);
          await prefs.setString('address', data['Address']);
          await prefs.setString('secondadress', data['SecondAdress']);
          await prefs.setString('zipcode', data['ZipCode']);
          await prefs.setString('phonenumber', data['PhoneNumber']);
          await prefs.setString('birthday', data['BirthDay']);
          await prefs.setBool('loggedin', true);
          MyApp.loggedin = true;
          setState(() {
            MyApp.loggedin = true;
            MyApp.clientid = data['idClient'];
            MyApp.clientname = data['ClientName'];
            MyApp.clentImage = data['ClientImage'];
            MyApp.clientemail = data['EmailAddress'];
            MyApp.clientCity = data['City'];
            MyApp.clientAdress = data['Address'];
            MyApp.clientSecAdress = data['SecondAdress'];
            MyApp.clientZipcode = data['ZipCode'];
            MyApp.clientPhoneNumber = data['PhoneNumber'];
            MyApp.clientBirthDay = data['BirthDay'];
          });
        } else {
          setState(() {
            MyApp.loggedin = true;
            MyApp.clientid = data['idClient'];
            MyApp.clientname = data['ClientName'];
            MyApp.clentImage = data['ClientImage'];
            MyApp.clientemail = data['EmailAddress'];
            MyApp.clientCity = data['City'];
            MyApp.clientAdress = data['Address'];
            MyApp.clientSecAdress = data['SecondAdress'];
            MyApp.clientZipcode = data['ZipCode'];
            MyApp.clientPhoneNumber = data['PhoneNumber'];
            MyApp.clientBirthDay = data['BirthDay'];
          });
        }

        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Pwear(),
            ),
          );
        }
      } else if (data['status'] == 'Error') {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                scrollable: true,
                title: const Text('no account found'),
                content: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        const Text(
                            'there is no account with this Email and password'),
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
                                    builder: (context) => const SignUpScreen(),
                                  ),
                                );
                              },
                              child: const Text("SignUp"),
                            ),
                          ],
                        ),
                      ],
                    )),
              );
            },
          );
        }
      } else {
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
                        const Text('an error has occured'),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("try again"),
                        ),
                      ],
                    )),
              );
            },
          );
        }
      }
    }

//--------------------------------------------------------end of function-----------------------

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Pwear.currentpage = 1;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Pwear(),
                    ));
              },
              icon: const Icon(CupertinoIcons.home)),
          title: const Text('Log In',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: const Color(0xFFEBD298),
          elevation: 0,
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
                  title: 'Login to your account',
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
                                        .requestFocus(userpasswordFocusNode);
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
                              switchListTile(),
                              RoundedButton(
                                text: 'LOGIN',
                                press: () {
                                  if (RegExp(emailRegex)
                                      .hasMatch(useremailController.text)) {
                                    email = useremailController.text;
                                    password = passwordController.text;
                                    loginClient(email, password);
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          scrollable: true,
                                          title: const Text(
                                              'incorrect email format'),
                                          content: Padding(
                                            padding: const EdgeInsets.all(8),
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
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                              UnderPart(
                                title: "Don't have an account?",
                                navigatorText: "Register here",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen(),
                                    ),
                                  );
                                },
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPasswordScreen(), // Remplacez "ForgotPasswordScreen" par le nom de votre classe pour la page "Forgot Password"
                                    ),
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                    top: 5,
                                    bottom: 20,
                                  ),
                                  child: Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
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

  Widget switchListTile() {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 40),
      child: SwitchListTile(
        dense: true,
        title: const Text(
          'Remember Me',
          style: TextStyle(fontSize: 16, fontFamily: 'OpenSans'),
        ),
        value: rememberMe,
        activeColor: kPrimaryColor,
        onChanged: (val) {
          setState(() {
            rememberMe = !rememberMe;
          });
        },
      ),
    );
  }
}

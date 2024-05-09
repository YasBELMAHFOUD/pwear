import 'package:flutter/material.dart';
import 'package:pwear_store2/pwear.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyApp.checkLogin();
  await MyApp.checkClientId();
  await MyApp.checkClientName();
  await MyApp.checkClientImage();
  await MyApp.checkEmailAddress();
  await MyApp.checkCity();
  await MyApp.checkAddress();
  await MyApp.checkSecondAdress();
  await MyApp.checkZipCode();
  await MyApp.checkPhoneNumber();
  await MyApp.checkClientBirthday();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  static bool? loggedin;
  static String? clientid;
  static String? clientname;
  static String? clentImage;
  static String? clientemail;
  static String? clientCity;
  static String? clientAdress;
  static String? clientSecAdress;
  static String? clientZipcode;
  static String? clientPhoneNumber;
  static String? clientBirthDay;
  //static int? likedDesignsCount;
  //static int? cartItemCount;
  //static int? orderHistoryCount;

  @override
  State<MyApp> createState() => _MyAppState();

  static Future<void> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MyApp.loggedin = prefs.getBool("loggedin");
  }

  static Future<void> checkClientId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MyApp.clientid = prefs.getString("idClient");
  }

  static Future<void> checkClientName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MyApp.clientname = prefs.getString("clientname");
  }

  static Future<void> checkClientImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MyApp.clentImage = prefs.getString("clientimage");
  }

  static Future<void> checkEmailAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MyApp.clientemail = prefs.getString("emailaddress");
  }

  static Future<void> checkCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MyApp.clientCity = prefs.getString("city");
  }

  static Future<void> checkAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MyApp.clientAdress = prefs.getString("address");
  }

  static Future<void> checkSecondAdress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MyApp.clientSecAdress = prefs.getString("secondadress");
  }

  static Future<void> checkZipCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MyApp.clientZipcode = prefs.getString("zipcode");
  }

  static Future<void> checkPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MyApp.clientPhoneNumber = prefs.getString("phonenumber");
  }

  static Future<void> checkClientBirthday() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MyApp.clientBirthDay = prefs.getString("birthday");
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Pwear(),
    );
  }
}

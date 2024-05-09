import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pwear_store2/components/product_card.dart';
import 'package:pwear_store2/databaseObjects/cart.dart';
import 'package:pwear_store2/databaseObjects/cart_line.dart';
import 'package:pwear_store2/databaseObjects/design.dart';

import 'package:pwear_store2/main.dart';
import 'package:pwear_store2/pwear.dart';
import 'package:pwear_store2/screens/cart.dart';
import 'package:pwear_store2/screens/login_screen.dart';
import 'package:pwear_store2/screens/order_tracking.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Profile> {
  TextEditingController clientnameController = TextEditingController();
  TextEditingController clientemailController = TextEditingController();
  TextEditingController clientcityController = TextEditingController();
  TextEditingController clientadressController = TextEditingController();
  TextEditingController clientsecondadressController = TextEditingController();
  TextEditingController clientzipcodeController = TextEditingController();
  TextEditingController clientphonenumberController = TextEditingController();
  TextEditingController clientBirthdayController = TextEditingController();

  void selectDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime(2020),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year),
    ).then((date) {
      setState(() {
        DateTime? dateTime = date;
        (dateTime != null)
            ? clientBirthdayController.text =
                '${dateTime.year}-${dateTime.month}-${dateTime.day}'
            : MyApp.clientBirthDay;
      });
    });
  }

  Future<void> updateClientinfo(
      String clientName,
      String email,
      String birthday,
      String phoneNumber,
      String adress,
      String city,
      String secondadress,
      String zipcode) async {
    final url =
        Uri.parse('http://10.0.2.2/Pwear/update_client_informations.php');

    // Create the request body

    final body = {
      'clientName': clientName,
      'email': email,
      'birthday': birthday,
      'phoneNumber': phoneNumber,
      'address': adress,
      'city': city,
      'secondAdress': secondadress,
      'zipCode': zipcode,
      'clientId': MyApp.clientid,
    };

    // Send the POST request

    final response = await http.post(url, body: body);
    final data = json.decode(response.body);

    if (data["status"] == "Success") {
      MyApp.clientAdress = adress;
      MyApp.clientname = clientName;
      MyApp.clientPhoneNumber = phoneNumber;
      MyApp.clientSecAdress = secondadress;
      MyApp.clientZipcode = zipcode;
      MyApp.clientemail = email;
      MyApp.clientBirthDay = birthday;
      MyApp.clientCity = city;

      if (context.mounted) {
        Navigator.pop(context);
      }
    } else if (data["status"] == "Error") {
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

  var current = 0;

  // todo: get iphone permitions to use camera

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) {
        return;
      } else {
        File tempimage = File(image.path);
        String base64 = base64Encode(tempimage.readAsBytesSync());

        final url = Uri.parse('http://10.0.2.2/Pwear/update_profile_image.php');

        final body = {
          'profileimage': base64,
          'idclient': MyApp.clientid,
          'extention': p.extension(tempimage.path)
        };

        final response = await http.post(url, body: body);

        var data = json.decode(response.body);

        if (data['status'] == 'Success') {
          setState(() {
            MyApp.clentImage = data['image'];
          });
        } else if (data['status'] == 'Error') {
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
        } else {
          print('OTHER ERROR');
        }
      }
    } on PlatformException catch (ex) {
      if (kDebugMode) {
        print('failed to pick image: $ex');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String? clientName;
    String? email;
    String? birthday;
    String? phoneNumber;
    String? adress;
    String? city;
    String? secondadress;
    String? zipcode;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.bars,
                color: Colors.black,
              ),
            ),
          ],
          pinned: false,
          floating: true,
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    child: IconButton(
                      onPressed: () async {
                        if (context.mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        }
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.remove('idClient');
                        await prefs.remove('loggedin');
                        await prefs.remove('clientname');
                        await prefs.remove('clientimage');
                        await prefs.remove('emailaddress');
                        await prefs.remove('city');
                        await prefs.remove('address');
                        await prefs.remove('secondadress');
                        await prefs.remove('zipcode');
                        await prefs.remove('phonenumber');
                        await prefs.remove('birthday');

                        setState(() {
                          MyApp.loggedin = null;
                        });
                      },
                      icon: const Icon(CupertinoIcons.square_arrow_left),
                    ),
                  ),
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFFFB508),
                                ),
                                BoxShadow(
                                  spreadRadius: -1.0,
                                  blurRadius: 16.0,
                                  offset: Offset(0, 8),
                                  color: Colors.white,
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              width: 156,
                              height: 156,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                              ),
                              child: MyApp.clentImage != null
                                  ? Image.network(
                                      'http://10.0.2.2/Pwear/${MyApp.clentImage!}',
                                      fit: BoxFit.cover,
                                    )
                                  : const Image(
                                      image: AssetImage(
                                          'assets/Profile_image/defaultAvatar.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            pickImage();
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFEBD21),
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            child: const Icon(
                              CupertinoIcons.photo_camera,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    MyApp.clientname!, //--------------------------------Name
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                ),
              ),

              Center(
                child: Text(
                  MyApp.clientemail!, //---------------------------------E-mail
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),

              // --order/cart/favourits-- Start
              Padding(
                padding: const EdgeInsets.only(
                  top: 21,
                  bottom: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        if (Cart.carts.isNotEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderTrack(
                                  cart: Cart.carts.last,
                                ),
                              ));
                        } else {
                          AlertDialog(
                            title: const Text("No Orders Yet"),
                            actions: [
                              CupertinoDialogAction(
                                  child: const Text("Ok"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                            ],
                          );
                        }
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(9, 140, 210, 0.25),
                                offset: Offset(0, 8), //(x,y)
                                blurRadius: 8,
                                spreadRadius: 4,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Text('${Cart.carts.length}'),
                            ),
                            Column(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromRGBO(
                                                  9, 140, 210, 0.25),
                                            ),
                                            BoxShadow(
                                              spreadRadius: 0,
                                              blurRadius: 8.0,
                                              offset: Offset(0, 8),
                                              color: Colors.white,
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(200)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Icon(
                                          CupertinoIcons.time_solid,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Center(
                                    child: Text(
                                      'Order History',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(9, 140, 210, 0.25),
                                offset: Offset(0, 8), //(x,y)
                                blurRadius: 8,
                                spreadRadius: 4,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Text('${CartLine.cartlines.length}'),
                            ),
                            Column(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromRGBO(
                                                9, 140, 210, 0.25),
                                          ),
                                          BoxShadow(
                                            spreadRadius: 0,
                                            blurRadius: 8.0,
                                            offset: Offset(0, 8),
                                            color: Colors.white,
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(200),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Icon(
                                          CupertinoIcons.cart_fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Center(
                                    child: Text(
                                      'Cart',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black.withOpacity(0.7)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Pwear.pageController!.hasClients;
                        Pwear.pageController!.animateToPage(0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOutCubicEmphasized);
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(9, 140, 210, 0.25),
                                offset: Offset(0, 8), //(x,y)
                                blurRadius: 8,
                                spreadRadius: 4,
                              )
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Text((Design.articles
                                      .where((article) => article.liked)
                                      .length)
                                  .toString()),
                            ),
                            Column(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromRGBO(
                                                  9, 140, 210, 0.25),
                                            ),
                                            BoxShadow(
                                              spreadRadius: 0,
                                              blurRadius: 8.0,
                                              offset: Offset(0, 8),
                                              color: Colors.white,
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(200)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Icon(CupertinoIcons.heart_fill),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Center(
                                    child: Text(
                                      'Favourits',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black.withOpacity(0.7)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // --order/cart/favourits-- Ends
              const Divider(),
              // --Personal Starts here
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Personal Informations',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              scrollable: true,
                              title: const Text('Editing informations'),
                              content: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: clientnameController,
                                      decoration: InputDecoration(
                                        labelText: MyApp.clientname,
                                        hintText: "Name",
                                        icon: const Icon(Icons.account_box),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: clientBirthdayController,
                                      onTap: () {
                                        selectDate();
                                      },
                                      decoration: InputDecoration(
                                        labelText: MyApp.clientBirthDay,
                                        hintText: "Birth day",
                                        icon: const Icon(Icons.date_range),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: clientemailController,
                                      decoration: InputDecoration(
                                        labelText: MyApp.clientemail,
                                        hintText: "Email",
                                        icon: const Icon(Icons.email),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: clientcityController,
                                      decoration: InputDecoration(
                                        labelText: MyApp.clientCity,
                                        hintText: "City",
                                        icon: const Icon(Icons.location_city),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: clientadressController,
                                      decoration: InputDecoration(
                                        labelText: MyApp.clientAdress,
                                        hintText: "Adress",
                                        icon: const Icon(Icons.location_on),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: clientsecondadressController,
                                      decoration: InputDecoration(
                                        labelText: MyApp.clientSecAdress,
                                        hintText: "SecondAddress",
                                        icon: const Icon(
                                            Icons.location_on_outlined),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: clientzipcodeController,
                                      decoration: InputDecoration(
                                        labelText: MyApp.clientZipcode,
                                        hintText: "Zip code",
                                        icon: const Icon(
                                            Icons.location_on_outlined),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: clientphonenumberController,
                                      decoration: InputDecoration(
                                        labelText: MyApp.clientPhoneNumber,
                                        hintText: "Phone number",
                                        icon: const Icon(Icons.phone_android),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        clientName =
                                            (clientnameController.text == '')
                                                ? MyApp.clientname
                                                : clientnameController.text;
                                        print(clientName);

                                        email =
                                            (clientemailController.text == '')
                                                ? MyApp.clientemail
                                                : clientemailController.text;
                                        print(email);
                                        birthday =
                                            (clientBirthdayController.text ==
                                                    '')
                                                ? MyApp.clientBirthDay
                                                : clientBirthdayController.text;
                                        print(clientBirthdayController.text);
                                        phoneNumber =
                                            (clientphonenumberController.text ==
                                                    '')
                                                ? MyApp.clientPhoneNumber
                                                : clientphonenumberController
                                                    .text;
                                        adress =
                                            (clientadressController.text == '')
                                                ? MyApp.clientAdress
                                                : clientadressController.text;
                                        city = (clientcityController.text == '')
                                            ? MyApp.clientCity
                                            : clientcityController.text;
                                        secondadress =
                                            (clientsecondadressController
                                                        .text ==
                                                    '')
                                                ? MyApp.clientSecAdress
                                                : clientsecondadressController
                                                    .text;
                                        zipcode =
                                            (clientzipcodeController.text == '')
                                                ? MyApp.clientZipcode
                                                : clientzipcodeController.text;

                                        updateClientinfo(
                                            clientName!,
                                            email!,
                                            birthday!,
                                            phoneNumber!,
                                            adress!,
                                            city!,
                                            secondadress!,
                                            zipcode!);

                                        //save client data in database
                                      },
                                      child: const Text("Confirm informations"),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Icon(
                        Icons.edit,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(9, 140, 210, 0.25),
                      offset: Offset(0, 8), //(x,y)
                      blurRadius: 8,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                //height: 223,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Name :',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.5),
                              )),
                          Text(
                            MyApp.clientname!,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.25)),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Email :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.5))),
                          Text(MyApp.clientemail!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.25)))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('City :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.5))),
                          Text(MyApp.clientCity!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.25)))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Address :',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              MyApp.clientAdress!,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.25),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Second Address :',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          Text(
                            MyApp.clientSecAdress!,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(0.25),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Zip code :',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          Text(
                            MyApp.clientZipcode!,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(0.25),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Phone number :',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          Text(
                            MyApp.clientPhoneNumber!,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(0.25),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // --Personal Ends here
              const Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      'More to Love',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 235,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: Design.articles.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProductCard(
                            path: Design.articles[index].path,
                            nom: Design.articles[index].type,
                            rating: Design.articles[index].rating,
                            prix: Design.articles[index].prix,
                            numOfRev: Design.articles[index].numOfRev,
                            index: index,
                            liked: Design.articles[index].liked,
                            onLikedChanged: (liked) {
                              setState(() {
                                Design.articles[index].liked = liked;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

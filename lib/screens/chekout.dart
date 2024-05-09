import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pwear_store2/components/async_slyde_to_act.dart';
import 'package:pwear_store2/components/master_card.dart';
import 'package:pwear_store2/constants.dart';
import 'package:pwear_store2/databaseObjects/cart.dart';
import 'package:pwear_store2/databaseObjects/cart_line.dart';
import 'package:pwear_store2/main.dart';
import 'package:pwear_store2/screens/add_new_card.dart';
import 'package:pwear_store2/screens/order_tracking.dart';
import '../components/cash_on_deliv.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  TextEditingController clientnameController = TextEditingController();
  TextEditingController clientemailController = TextEditingController();
  TextEditingController clientcityController = TextEditingController();
  TextEditingController clientadressController = TextEditingController();
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

  String clientname = '--';
  String clientadress = '--';
  int clientpaiyementmethod = 0;
  double total = 0.0;

  @override
  void initState() {
    setState(() {
      clientname = (MyApp.clientname == null ? '--' : MyApp.clientname!);
      clientadress = (MyApp.clientAdress == null ? '--' : MyApp.clientAdress!);
      total = CartLine.getTotalPrice();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late Cart cart;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<Widget> cards = [
      Mastercard(onValueChanged: (value) {
        setState(() {
          Mastercard.isSelected = value!;
          if (Mastercard.isSelected == true) {
            clientpaiyementmethod = 1;
          }
        });
      }),
      CashOnDeliv(onValueChanged: (value) {
        setState(() {
          CashOnDeliv.isSelected = value!;
          if (CashOnDeliv.isSelected == true) {
            clientpaiyementmethod = 2;
          }
        });
      }),
    ];

    return clientname == '--'
        ? Scaffold(
            body: SizedBox(
              height: height,
              width: width,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: height * 0.6,
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            controller: clientcityController,
                            decoration: InputDecoration(
                              labelText: MyApp.clientCity,
                              hintText: "City",
                              icon: const Icon(Icons.location_city),
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
                            controller: clientadressController,
                            decoration: InputDecoration(
                              labelText: MyApp.clientAdress,
                              hintText: "Adress",
                              icon: const Icon(Icons.location_on),
                            ),
                          ),
                          TextFormField(
                            controller: clientzipcodeController,
                            decoration: InputDecoration(
                              labelText: MyApp.clientZipcode,
                              hintText: "Zip code",
                              icon: const Icon(Icons.location_on_outlined),
                            ),
                          ),
                          TextFormField(
                            controller: clientphonenumberController,
                            inputFormatters: [
                              FilteringTextInputFormatter
                                  .digitsOnly, // Only allow digits
                              LengthLimitingTextInputFormatter(
                                  10), // Limit the length to 10 digits
                            ],
                            decoration: InputDecoration(
                              labelText: MyApp.clientPhoneNumber,
                              hintText: "Phone number",
                              icon: const Icon(Icons.phone_android),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (clientnameController.text == '' ||
                                  clientadressController.text == '' ||
                                  clientemailController.text == '' ||
                                  clientBirthdayController.text == '' ||
                                  clientphonenumberController.text == '' ||
                                  clientcityController.text == '' ||
                                  clientzipcodeController.text == '') {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                        scrollable: true,
                                        title: const Text(
                                            'Please fill all the informations'),
                                        content: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text('Ok'),
                                                )
                                              ],
                                            )));
                                  },
                                );
                              } else {
                                setState(() {
                                  clientname = clientnameController.text;
                                  clientadress = clientadressController.text;
                                  MyApp.clientname = clientnameController.text;
                                  MyApp.clientemail =
                                      clientemailController.text;
                                  MyApp.clientBirthDay =
                                      clientBirthdayController.text;
                                  MyApp.clientPhoneNumber =
                                      clientphonenumberController.text;
                                  MyApp.clientAdress =
                                      clientadressController.text;
                                  MyApp.clientCity = clientcityController.text;
                                  MyApp.clientZipcode =
                                      clientzipcodeController.text;
                                });
                              }
                            },
                            child: const Text("Confirm informations"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Checkout',
                  style: TextStyle(color: Colors.black, fontSize: 20)),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                ),
              ),
            ),

            // --BODY--
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: Container(
                      height: 144,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 223, 216, 253),
                      ),
                      child: Column(
                        children: [
                          // -- First Card Starts here --
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Shipping Information',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Icon(Icons.person_pin_circle_outlined),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                clientname,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 35),
                            child: Row(
                              children: [
                                const Icon(Icons.location_history),
                                Flexible(
                                  child: Text(
                                    clientadress,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.7),
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
                  // -- First Card Ends here --

                  const Divider(),
                  // -- Second Card Starts here --
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Container(
                      height: 105,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 209, 209, 209)),
                      child: Column(
                        children: [
                          // -- First Card Starts here --
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Courier  Service',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                Icon(Icons.arrow_back),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Amana Express',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 35),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    'Delivery in 48h Maximum',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(0.7)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Divider(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text('Select payement Method',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NewCard(),
                            ),
                          );
                        },
                        child: const Text(
                          'Add new card',
                          style: TextStyle(
                              color: Color(0xFF4D2DCE),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      height: 177,
                      width: double.infinity,
                      child: Swiper(
                        scale: 0.8,
                        fade: 0.3,
                        layout: SwiperLayout.DEFAULT,
                        viewportFraction: 0.80,
                        itemHeight: 177,
                        itemWidth: 311,
                        allowImplicitScrolling: false,
                        duration: 500,
                        autoplayDelay: 5000,
                        itemCount: cards.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return cards.elementAt(index);
                        },
                      ),
                    ),
                  ),

                  const Divider(),

                  const Text(
                    'Summary',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total: ',
                              style: TextStyle(
                                  color: Color(0xFF989898),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '$total DH',
                              style: const TextStyle(
                                color: Color(0xFF989898),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delivery: ',
                                style: TextStyle(
                                    color: Color(0xFF989898),
                                    fontWeight: FontWeight.bold)),
                            Text('0.00 DH',
                                style: TextStyle(color: Color(0xFF989898)))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total: ',
                              style: TextStyle(
                                  color: Color(0xFF989898),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '$total DH',
                              style: const TextStyle(
                                color: Color(0xFF989898),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AsyncExample(
                    callback: () async {
                      await Future.delayed(const Duration(milliseconds: 500));
                      // ignore: use_build_context_synchronously
                      await showCupertinoDialog(
                          context: context,
                          builder: (context) => clientpaiyementmethod == 0
                              ? AlertDialog(
                                  title: const Text(
                                      "Please select a payment method"),
                                  actions: [
                                    CupertinoDialogAction(
                                        child: const Text("Ok"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ],
                                )
                              : AlertDialog(
                                  title: const Text("Greetings"),
                                  content: const Text("Order hasbeen placed"),
                                  actions: [
                                    CupertinoDialogAction(
                                        child: const Text("Track Order"),
                                        onPressed: () {
                                          setState(() {
                                            int generateRandomNumber() {
                                              Random random = Random();
                                              int min =
                                                  10000; // Minimum value of 5-digit number (10,000)
                                              int max =
                                                  99999; // Maximum value of 5-digit number (99,999)
                                              return min +
                                                  random.nextInt(max - min);
                                            }

                                            String getCurrentDate() {
                                              DateTime now = DateTime.now();
                                              String day = now.day
                                                  .toString()
                                                  .padLeft(2, '0');
                                              String month = now.month
                                                  .toString()
                                                  .padLeft(2, '0');
                                              String year = now.year.toString();
                                              return '$day/$month/$year';
                                            }

                                            cart = Cart(
                                                date: getCurrentDate(),
                                                idcart: generateRandomNumber(),
                                                totalprice:
                                                    CartLine.getTotalPrice(),
                                                cartlines: CartLine.cartlines,
                                                paymentMethod:
                                                    clientpaiyementmethod);
                                            Cart.carts.add(cart);
                                          });
                                          Navigator.of(context).maybePop();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrderTrack(cart: cart)));
                                        }),
                                  ],
                                ));
                    },
                  ),
                ],
              ),
            ),
            // --BODY--
            //bottomNavigationBar: ,
          );
  }
}

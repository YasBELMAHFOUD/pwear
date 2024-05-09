import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:pwear_store2/databaseObjects/cart.dart';
import 'package:pwear_store2/databaseObjects/cart_line.dart';
import 'package:pwear_store2/main.dart';
import 'package:pwear_store2/pwear.dart';

class OrderTrack extends StatefulWidget {
  const OrderTrack({super.key, required this.cart});
  final Cart cart;

  @override
  State<OrderTrack> createState() => _MyWidgetState();
}

int activeStep = 0;
bool cod = true;
bool mastercard = false;

class _MyWidgetState extends State<OrderTrack> {
  @override
  Widget build(BuildContext context) {
    DateTime incrementDateByTwoDays() {
      DateTime currentDate = DateTime.now();
      return currentDate.add(
        const Duration(days: 2),
      );
    }

    DateTime incrementedDate = incrementDateByTwoDays();

    String formattedDate =
        '${incrementedDate.day.toString().padLeft(2, '0')}/${incrementedDate.month.toString().padLeft(2, '0')}/${incrementedDate.year}';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // --AppBar Starts Here--
        appBar: AppBar(
          title: const Text(
            'Order Tracking',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          leading: GestureDetector(
            onTap: () {
              setState(() {
                CartLine.cartlines = [];
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Pwear(),
                ),
              );
            },
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
        // --AppBar Ends Here--

        // --Body Starts Here--
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  'Order ID:${widget.cart.idcart}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ),

              // Stepper

              EasyStepper(
                  activeStep: activeStep,
                  padding: const EdgeInsetsDirectional.only(top: 36),
                  internalPadding: 10,
                  lineLength: 100,
                  lineSpace: 0,
                  stepRadius: 10,
                  showLoadingAnimation: false,
                  finishedLineColor: Colors.green,
                  defaultLineColor: const Color(0xFFD0D5DD),
                  activeLineColor: const Color(0xFFD0D5DD),
                  borderThickness: 2,
                  defaultStepBorderType: BorderType.normal,
                  activeStepBorderColor: Colors.green[500],
                  activeStepTextColor: Colors.green[900],
                  lineThickness: 2,
                  steppingEnabled: true,
                  enableStepTapping: false,
                  lineType: LineType.dotted,
                  onStepReached: (index) => setState(() => activeStep = index),
                  steps: [
                    EasyStep(
                      customStep: CircleAvatar(
                        backgroundColor: activeStep >= 0
                            ? Colors.green[500]
                            : const Color(0xFFD0D5DD),
                      ),
                      title: 'Confirmed',
                      topTitle: true,
                      lineText: widget.cart.date,
                    ),
                    EasyStep(
                        customStep: CircleAvatar(
                          backgroundColor: activeStep >= 1
                              ? Colors.green[500]
                              : const Color(0xFFD0D5DD),
                        ),
                        title: 'Courier',
                        topTitle: true,
                        lineText: formattedDate),
                    EasyStep(
                      customStep: CircleAvatar(
                        backgroundColor: activeStep >= 2
                            ? Colors.green[500]
                            : const Color(0xFFD0D5DD),
                      ),
                      title: 'Delivered',
                      topTitle: true,
                    ),
                  ]),
              // Stepper Ends here

              const Divider(
                indent: 25,
                endIndent: 25,
                color: Color(0xFFD0D5DD),
              ),

              //dakchi li tchra

              const Divider(
                indent: 25,
                endIndent: 25,
                color: Color(0xFFD0D5DD),
              ),

              // --Payement And Delivery--

              SizedBox(
                height: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Payement
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Payement',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(widget.cart.paymentMethod == 1
                            ? 'credit card'
                            : 'Cash On Delivery'),
                      ],
                    ),

                    // Delivery
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Delivery',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          MyApp.clientPhoneNumber!,
                          style: const TextStyle(
                            color: Color(0xFF667085),
                          ),
                        ),
                        Text(
                          MyApp.clientAdress!,
                          style: const TextStyle(
                            color: Color(0xFF667085),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Divider(
                indent: 25,
                endIndent: 25,
                color: Color(0xFFD0D5DD),
              ),

              const Text(
                'Order summary',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),

              SizedBox(
                height: 178,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal:',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Color(0xFF475467))),
                          Text('${widget.cart.totalprice} DH',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Color(0xFF475467)))
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Delivery:',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Color(0xFF475467))),
                          Text('0.00 DH',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Color(0xFF475467)))
                        ],
                      ),
                    ),
                    const Divider(
                        indent: 50,
                        endIndent: 50,
                        color: Color(0xFFD0D5DD),
                        thickness: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total:',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Color(0xFF475467))),
                        Text('${widget.cart.totalprice}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Color(0xFF475467)))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        // --Body Ends Here--
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pwear_store2/components/color_picker.dart';
import 'package:pwear_store2/components/comment_line.dart';
import 'package:pwear_store2/components/product_card.dart';
import 'package:pwear_store2/components/product_counter.dart';
import 'package:pwear_store2/components/productshowcasecard.dart';
import 'package:pwear_store2/components/size_picker.dart';
import 'package:pwear_store2/databaseObjects/cart_line.dart';
import 'package:pwear_store2/databaseObjects/design.dart';
import 'package:pwear_store2/databaseObjects/comment.dart';
import 'package:pwear_store2/main.dart';
import 'package:pwear_store2/pwear.dart';
import 'package:pwear_store2/screens/cart.dart';
import 'package:pwear_store2/screens/login_screen.dart';
import 'package:pwear_store2/screens/signup_screen.dart';

class ProductPage extends StatefulWidget {
  final int productindex;
  const ProductPage({super.key, required this.productindex});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int qtt = 1;
  Color productSelectedColor = Colors.black;

  String productSelectedSize = '';

  String getCurrentDate() {
    DateTime now = DateTime.now();
    String day = now.day.toString().padLeft(2, '0');
    String month = now.month.toString().padLeft(2, '0');
    String year = now.year.toString();
    return '$day/$month/$year';
  }

  @override
  void initState() {
    qtt = 1;
    productSelectedColor = Design.articles[widget.productindex].colorOptions[0];

    productSelectedSize = Design.articles[widget.productindex].sizes[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //--------------------------------------------------------------------------
    double width = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    double height = MediaQuery.of(context).size.height;
    //--------------------------------------------------------------------------
    List<Color> productColorList =
        Design.articles[widget.productindex].colorOptions;
    List<String> productSizeList = Design.articles[widget.productindex].sizes;

    TextEditingController clientcommentController = TextEditingController();

    late String comment;
    double clientrating = 5;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Pwear(),
                    ));
                setState(() {
                  Pwear.currentpage = 2;
                });
              },
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ProductShowcaseCard(
                  onLikedChanged: (liked) {
                    Design.articles[widget.productindex].liked = liked;
                  },
                  productindex: widget.productindex,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          ProductCounter(
                            onQuantityChanged: (value) {
                              setState(() {
                                qtt = value;
                                print(qtt);
                              });
                            },
                            size: 85,
                            actionscolor: Colors.amber,
                            qttboxcolor: Colors.blueAccent,
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Color :",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: 200,
                                height: 35,
                                margin: const EdgeInsets.only(left: 10),
                                clipBehavior: Clip.hardEdge,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(9, 140, 210, 0.25),
                                    ),
                                    BoxShadow(
                                      spreadRadius: -1.0,
                                      blurRadius: 8.0,
                                      offset: Offset(0, 8),
                                      color: Colors.white,
                                    ),
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: ColorListPicker(
                                  colors: productColorList,
                                  itemSize: 30,
                                  selectedColor: productSelectedColor,
                                  onColorChanged: (Color? color) {
                                    setState(() {
                                      productSelectedColor = color!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Size :",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: 200,
                                height: 35,
                                margin: const EdgeInsets.only(left: 10),
                                clipBehavior: Clip.hardEdge,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(9, 140, 210, 0.25),
                                    ),
                                    BoxShadow(
                                      spreadRadius: -1.0,
                                      blurRadius: 8.0,
                                      offset: Offset(0, 8),
                                      color: Colors.white,
                                    )
                                  ],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                child: SizeListPicker(
                                  sizes: productSizeList,
                                  itemSize: 30,
                                  selectedSize: productSelectedSize,
                                  onSizeChanged: (String? size) {
                                    setState(() {
                                      productSelectedSize = size!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width / 2 - 24, 40),
                      ),
                      onPressed: () {
                        //create a orderlistobject

                        var cartline = CartLine(
                            id: widget.productindex,
                            article: Design.articles[widget.productindex],
                            color: productSelectedColor,
                            size: productSelectedSize,
                            dismissed: false,
                            quantity: qtt,
                            price: Design.articles[widget.productindex].prix *
                                qtt);

                        setState(() {
                          CartLine.cartlines.add(cartline);
                        });
                        Navigator.push(
                          context,
                          CupertinoModalPopupRoute(
                            builder: (context) => const Pwear(),
                          ),
                        );
                      },
                      child: const Text('Add to card'),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(width / 2 - 24, 40),
                        ),
                        onPressed: () {
                          //create a orderlistobject

                          var cartline = CartLine(
                              id: widget.productindex,
                              article: Design.articles[widget.productindex],
                              color: productSelectedColor,
                              size: productSelectedSize,
                              dismissed: false,
                              quantity: qtt,
                              price: Design.articles[widget.productindex].prix *
                                  qtt);
                          setState(() {
                            CartLine.cartlines.add(cartline);
                          });

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartScreen(),
                            ),
                          );
                        },
                        child: const Text('Order Now')),
                  ],
                ),
                SizedBox(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 30),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: InkWell(
                                onTap: () {
                                  MyApp.loggedin == true
                                      ? showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              scrollable: true,
                                              title: const Text('Review'),
                                              content: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        child:
                                                            RatingBar.builder(
                                                          initialRating: 5,
                                                          minRating: 1,
                                                          maxRating: 5,
                                                          direction:
                                                              Axis.horizontal,
                                                          allowHalfRating: true,
                                                          glow: false,
                                                          itemCount: 5,
                                                          itemSize: 30,
                                                          updateOnDrag: false,
                                                          ignoreGestures: false,
                                                          unratedColor:
                                                              Colors.black,
                                                          itemBuilder:
                                                              (context, _) =>
                                                                  const Icon(
                                                            Icons.star_rounded,
                                                            color: Colors.amber,
                                                          ),
                                                          onRatingUpdate:
                                                              (rating) {
                                                            setState(() {
                                                              clientrating =
                                                                  rating;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      TextFormField(
                                                        controller:
                                                            clientcommentController,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              "your comment",
                                                          // hintText: "your comment",
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  comment =
                                                                      clientcommentController
                                                                          .text;
                                                                  Comment
                                                                      .comments
                                                                      .add(
                                                                    Comment(
                                                                        profileimage:
                                                                            'http://10.0.2.2/Pwear/${MyApp.clentImage!}',
                                                                        name: MyApp
                                                                            .clientname!,
                                                                        comment:
                                                                            comment,
                                                                        rating:
                                                                            clientrating,
                                                                        date:
                                                                            getCurrentDate(),
                                                                        designid:
                                                                            widget.productindex),
                                                                  );

                                                                  print(Comment
                                                                      .comments
                                                                      .last
                                                                      .comment);
                                                                  print(Comment
                                                                      .comments
                                                                      .last
                                                                      .rating);
                                                                  print(Comment
                                                                      .comments
                                                                      .last
                                                                      .date);
                                                                });
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  'Submit')),
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  'Cancel'))
                                                        ],
                                                      )
                                                    ],
                                                  )),
                                            );
                                          },
                                        )
                                      : showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  "You need to log in or sign up"),
                                              actions: [
                                                CupertinoDialogAction(
                                                    child: const Text("Log in"),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const LoginScreen(),
                                                          ));
                                                    }),
                                                CupertinoDialogAction(
                                                    child:
                                                        const Text("Sign up"),
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const SignUpScreen(),
                                                        ),
                                                      );
                                                    }),
                                              ],
                                            );
                                          },
                                        );
                                  ;
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromRGBO(9, 140, 210, 0.25),
                                        offset: Offset(0, 8), //(x,y)
                                        blurRadius: 16,
                                        spreadRadius: 3,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(CupertinoIcons.add),
                                            Text(
                                              "Add a review",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          child: RatingBar.builder(
                                            initialRating: 5,
                                            minRating: 1,
                                            maxRating: 5,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 30,
                                            ignoreGestures: true,
                                            unratedColor: Colors.black,
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star_rounded,
                                              color: Color(0xFFFFC107),
                                            ),
                                            onRatingUpdate: (rating) {
                                              if (kDebugMode) {
                                                print(rating);
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 250,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(9, 140, 210, 0.25),
                                      offset: Offset(0, 8), //(x,y)
                                      blurRadius: 16,
                                      spreadRadius: 3,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(15)),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: Comment.getCommentsForDesign(
                                        widget.productindex)
                                    .length,
                                itemBuilder: (context, index) {
                                  return CommentLine(
                                    comment: Comment.getCommentsForDesign(
                                        widget.productindex)[index],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Text('Related Wear',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19))),
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
        ),
      ),
    );
  }
}

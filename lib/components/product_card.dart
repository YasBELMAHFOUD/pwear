import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pwear_store2/databaseObjects/design.dart';
import 'package:pwear_store2/screens/product_page.dart';

class ProductCard extends StatefulWidget {
  final int index;
  final bool liked;
  final String path;
  final String nom;
  final double rating;
  final double prix;
  final int numOfRev;

  final Function(bool liked) onLikedChanged;

  const ProductCard({
    super.key,
    required this.index,
    required this.liked,
    required this.path,
    required this.nom,
    required this.rating,
    required this.prix,
    required this.numOfRev,
    required this.onLikedChanged,
  });

  @override
  State<ProductCard> createState() => ProductCardState();
}

class ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 135,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(9, 140, 210, 0.25),
            offset: Offset(0, 8), //(x,y)
            blurRadius: 16,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 5,
              top: 5,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    widget.onLikedChanged(!widget.liked);
                  },
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    child: Icon(
                      widget.liked
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      color: widget.liked ? Colors.red : null,
                      key: ValueKey<bool>(widget.liked),
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(productindex: widget.index),
                ),
              );
            },
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 130,
                  child: Image(
                    image: AssetImage(widget.path),
                    width: 100,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child:
                            Text(widget.nom, overflow: TextOverflow.ellipsis)),
                    Text("${widget.prix} Dh"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          initialRating:
                              Design.getAverageRatingForDesign(widget.index),
                          minRating: 1,
                          maxRating: 5,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 15,
                          ignoreGestures: true,
                          unratedColor: Colors.black,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            if (kDebugMode) {
                              print(rating);
                            }
                          },
                        ),
                        Text(
                          '(${Design.getNumberOfCommentsForDesign(widget.index)})',
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'OpenSans'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

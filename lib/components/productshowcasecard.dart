import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:pwear_store2/components/image_with_reflection.dart';

import 'package:pwear_store2/databaseObjects/design.dart';

class ProductShowcaseCard extends StatefulWidget {
  final int productindex;
  final Function(bool liked) onLikedChanged;
  const ProductShowcaseCard(
      {super.key, required this.productindex, required this.onLikedChanged});

  @override
  State<ProductShowcaseCard> createState() => _ProductShowcaseCardState();
}

class _ProductShowcaseCardState extends State<ProductShowcaseCard> {
  //double valeur = 0;

  @override
  Widget build(BuildContext context) {
    bool liked = Design.articles[widget.productindex].liked;
    String productImageURL = Design.articles[widget.productindex].path;

    String articleName = Design.articles[widget.productindex].designName;
    String designName = Design.articles[widget.productindex].type;
    double productPrice = Design.articles[widget.productindex].prix;

    return Center(
      child: Column(
        children: [
          Container(
            width: double.infinity,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                  child: Container(
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
                    height: 400,
                    width: 305,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 12,
                          left: 12,
                          child: RatingBar.builder(
                            initialRating: Design.getAverageRatingForDesign(
                                widget.productindex),
                            minRating: 1,
                            maxRating: 5,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20,
                            glowColor: Colors.black,
                            ignoreGestures: true,
                            unratedColor: Colors.black,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                        ),
                        Positioned(
                          right: 15,
                          top: 30,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                articleName,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                designName,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.4),
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 30,
                          child: SizedBox(
                            width: 500,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  child: ImageWithReflection(
                                    imageURL: productImageURL,
                                    cardHeight: 550,
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            liked = !liked;
                            widget.onLikedChanged(
                                !Design.articles[widget.productindex].liked);
                          });
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
                            liked
                                ? CupertinoIcons.heart_fill
                                : CupertinoIcons.heart,
                            color: liked ? Colors.red : null,
                            key: ValueKey<bool>(liked),
                          ),
                        ),
                      ),
                      Text(
                        "${productPrice}dh",
                        style: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 24),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

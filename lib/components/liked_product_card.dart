import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pwear_store2/constants.dart';
import 'package:pwear_store2/databaseObjects/design.dart';

class LikedProductCard extends StatefulWidget {
  final int indexoflikedproduct;
  final bool liked;
  final Function(bool liked) onLikedChanged;

  const LikedProductCard({
    super.key,
    required this.indexoflikedproduct,
    required this.liked,
    required this.onLikedChanged,
  });

  @override
  State<LikedProductCard> createState() => _LikedProductCardState();
}

class _LikedProductCardState extends State<LikedProductCard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 16,
            color: const Color(0xFF098CD2).withOpacity(0.25),
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Container(
                  width: 90,
                  height: 80,
                  decoration: BoxDecoration(
                      color: kPrimaryLightColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Image(
                      height: 70,
                      fit: BoxFit.fitHeight,
                      image: AssetImage(Design.articles
                          .where((article) => article.liked)
                          .toList()[widget.indexoflikedproduct]
                          .path),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SizedBox(
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: Design.articles
                                      .where((article) => article.liked)
                                      .toList()[widget.indexoflikedproduct]
                                      .designName
                                      .length >
                                  30
                              ? '${Design.articles.where((article) => article.liked).toList()[widget.indexoflikedproduct].designName.substring(0, 30)}...' // Adjust the number as needed
                              : Design.articles
                                  .where((article) => article.liked)
                                  .toList()[widget.indexoflikedproduct]
                                  .designName,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        maxLines: 2,
                      ),
                      Text(
                        '${Design.articles.where((article) => article.liked).toList()[widget.indexoflikedproduct].prix} dh',
                        style: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            bottom: 12,
            right: 22,
            child: InkWell(
              onTap: () {
                widget.onLikedChanged(!widget.liked);
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
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
          ),
        ],
      ),
    );
  }
}

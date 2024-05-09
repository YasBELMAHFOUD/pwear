import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pwear_store2/components/appbar_store.dart';
import 'package:pwear_store2/components/product_card.dart';
import 'package:pwear_store2/databaseObjects/design.dart';

import 'package:pwear_store2/main.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key, required this.filteredDesigns});
  final List<Design> filteredDesigns;

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return CustomScrollView(
      slivers: [
        StoreAppBar(logged: MyApp.loggedin),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEB508),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Filters",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          ),
                          Icon(
                            CupertinoIcons.slider_horizontal_3,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GridView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.filteredDesigns.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 220,
                    maxCrossAxisExtent: 190,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                  ),
                  itemBuilder: (BuildContext ctx, artind) {
                    //--------------------------------------------------------------Product card
                    return ProductCard(
                      path: widget.filteredDesigns[artind].path,
                      nom: widget.filteredDesigns[artind].designName,
                      rating: widget.filteredDesigns[artind].rating,
                      prix: widget.filteredDesigns[artind].prix,
                      numOfRev: widget.filteredDesigns[artind].numOfRev,
                      index: artind,
                      liked: widget.filteredDesigns[artind].liked,
                      onLikedChanged: (liked) {
                        setState(
                          () {
                            widget.filteredDesigns[artind].liked = liked;
                          },
                        );
                      },
                    );
                    //--------------------------------------------------------------Product card
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

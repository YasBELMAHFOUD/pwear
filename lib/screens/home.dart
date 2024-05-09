import 'package:pwear_store2/components/appbar_home.dart';
import 'package:pwear_store2/components/categorie_card.dart';
import 'package:pwear_store2/components/product_card.dart';
import 'package:pwear_store2/constants.dart';
import 'package:pwear_store2/databaseObjects/design.dart';
import 'package:pwear_store2/databaseObjects/categorie.dart';
import 'package:flutter/material.dart';
import 'package:pwear_store2/main.dart';
import 'package:pwear_store2/pwear.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var current = 0;
  List<Design> getDesignsByApparelTitle(String title) {
    return Design.articles.where((design) => design.typeS == title).toList();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          HomeAppBar(logged: MyApp.loggedin),
          SliverToBoxAdapter(
            child: Column(
              children: [
                //---------------------Categories builder-----------
                Column(
                  children: [
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 16, left: 25),
                          child: Text(
                            'Categories',
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 26),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 25, left: 14, right: 14),
                      child: GridView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: Categorie.categories.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 150,
                          childAspectRatio: 2 / 3,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                        ),
                        itemBuilder: (BuildContext ctx, ind) {
                          //------------------------------------------------------Categories card
                          return CategorieCard(
                              index: ind,
                              path: Categorie.categories[ind].path,
                              titre: Categorie.categories[ind].titre);
                          //------------------------------------------------------Categories card
                        },
                      ),
                    ),
                  ],
                ),
                //----------------------------------------------------------------Categories builder

                ElevatedButton(
                  onPressed: () {
                    Pwear.pageController!.hasClients;
                    Pwear.pageController!.animateToPage(2,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOutCubicEmphasized);
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(kPrimaryLightColor)),
                  child: const Text('Visit Store'),
                ),

                Column(
                  children: [
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 0, left: 25),
                          child: Text(
                            'Best selling products',
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 26),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 25, left: 14, right: 14),
                      child: GridView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: Design.articles.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisExtent: 220,
                          maxCrossAxisExtent: 190,
                          childAspectRatio: 2 / 3,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                        ),
                        itemBuilder: (BuildContext ctx, artind) {
                          //------------------------------------------------------Product card
                          return ProductCard(
                            path: Design.articles[artind].path,
                            nom: Design.articles[artind].designName,
                            rating: Design.articles[artind].rating,
                            prix: Design.articles[artind].prix,
                            numOfRev: Design.articles[artind].numOfRev,
                            index: artind,
                            liked: Design.articles[artind].liked,
                            onLikedChanged: (liked) {
                              setState(() {
                                Design.articles[artind].liked = liked;
                              });
                            },
                          );
                          //------------------------------------------------------Product card
                        },
                      ),
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

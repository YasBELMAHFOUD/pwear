import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pwear_store2/databaseObjects/apparel.dart';
import 'package:pwear_store2/databaseObjects/categorie.dart';
import 'package:pwear_store2/databaseObjects/design.dart';
import 'package:pwear_store2/screens/favourits.dart';
import 'package:pwear_store2/screens/home.dart';
import 'package:pwear_store2/screens/login_screen.dart';
import 'package:pwear_store2/screens/profile.dart';
import 'package:pwear_store2/screens/store_page.dart';
import 'main.dart';

class Pwear extends StatefulWidget {
  const Pwear({Key? key}) : super(key: key);
  static int currentpage = 1;
  static PageController? pageController;

  @override
  State<Pwear> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Pwear> {
  List<Design>? filteredDesigns;
  bool _isLoading = true;

  late List<bool?> isCategorieChecked;
  late List<bool?> isApparelChecked;

  double minValue = 0;
  double maxValue = 1000;
  RangeValues currentRangeValues = const RangeValues(0, 1000);

  Widget? profOrSign;
  List<Design> filterDesigns(List<Design> designs) {
    // Filtering logic based on categories, price range, and apparels

    // Check if any category is selected
    bool anyCategorySelected =
        isCategorieChecked.any((isSelected) => isSelected == true);

    // Check if any apparel is selected
    bool anyApparelSelected =
        isApparelChecked.any((isSelected) => isSelected == true);

    // Check if the price range is the default (0 to 1000)
    bool defaultPriceRangeSelected = currentRangeValues.start == minValue &&
        currentRangeValues.end == maxValue;

    // If no category, no apparel, and the default price range is selected,
    // return the original designs list to show all designs
    if (!anyCategorySelected &&
        !anyApparelSelected &&
        defaultPriceRangeSelected) {
      return designs;
    }

    List<Design> filteredDesigns = designs.toList();

    // Filter by categories
    List<String> selectedCategories = [];
    for (int i = 0; i < isCategorieChecked.length; i++) {
      if (isCategorieChecked[i] == true) {
        String title = Categorie.categories[i].titre;
        selectedCategories.add(title);
      }
    }

    if (selectedCategories.isNotEmpty) {
      filteredDesigns = filteredDesigns
          .where((design) => selectedCategories.contains(design.type))
          .toList();
    }

    // Filter by apparels
    List<String> selectedApparels = [];
    for (int i = 0; i < isApparelChecked.length; i++) {
      if (isApparelChecked[i] == true) {
        String title = Apparel.apparels[i].title;
        selectedApparels.add(title);
      }
    }

    if (selectedApparels.isNotEmpty) {
      filteredDesigns = filteredDesigns
          .where((design) => selectedApparels.contains(design.typeS))
          .toList();
    }

    // Filter by price range
    filteredDesigns = filteredDesigns
        .where((design) =>
            design.prix >= currentRangeValues.start &&
            design.prix <= currentRangeValues.end)
        .toList();

    return filteredDesigns;
  }

  @override
  void initState() {
    super.initState();
    Pwear.pageController = PageController(initialPage: Pwear.currentpage);

    Timer(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });

    isCategorieChecked = List.generate(
      Categorie.categories.length,
      (catindex) => false,
    );
    isApparelChecked = List.generate(
      Apparel.apparels.length,
      (appindex) => false,
    );

    setState(() {
      if (MyApp.loggedin == true) {
        profOrSign = const Profile();
      } else if (MyApp.loggedin == null) {
        profOrSign = const LoginScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            drawerEnableOpenDragGesture: false,
            drawer: Drawer(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Divider(height: 50),
                    const Text('Categories'),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: Categorie.categories.length,
                      itemBuilder: (context, catindex) {
                        return SizedBox(
                          child: CheckboxListTile(
                            title: Text(Categorie.categories[catindex].titre),
                            value: isCategorieChecked[catindex],
                            onChanged: (value) {
                              setState(() {
                                isCategorieChecked[catindex] = value!;
                              });
                            },
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    const Text('Apparels'),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: Categorie.categories.length,
                      itemBuilder: (context, appindex) {
                        return SizedBox(
                          child: CheckboxListTile(
                            title: Text(Apparel.apparels[appindex].title),
                            value: isApparelChecked[appindex],
                            onChanged: (value) {
                              setState(() {
                                isApparelChecked[appindex] = value!;
                              });
                            },
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    const Text('Price range'),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Min: ${currentRangeValues.start.round()} Dh',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              Text(
                                'Max: ${currentRangeValues.end.round()} Dh',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                          RangeSlider(
                            values: currentRangeValues,
                            min: minValue,
                            max: maxValue,
                            onChanged: (RangeValues values) {
                              setState(() {
                                currentRangeValues = values;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          filteredDesigns = filterDesigns(Design.articles);
                        });
                        Navigator.of(context).pop();
                        //generate a filtered gridview
                      },
                      child: const Text('Filter'),
                    ),
                  ],
                ),
              ),
            ),
            body: PageView(
              controller: Pwear.pageController,
              onPageChanged: (value) {
                setState(() {
                  Pwear.currentpage = value;
                });
              },
              children: [
                const Favourits(),
                const Home(),
                StorePage(filteredDesigns: filteredDesigns ?? Design.articles),
                profOrSign!,
              ],
            ),
            bottomNavigationBar: Container(
              color: const Color(0xffEED59B),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: GNav(
                  tabBackgroundColor: Colors.grey.shade900,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  activeColor: Colors.white,
                  color: Colors.white,
                  backgroundColor: const Color(0xffEED59B),
                  gap: 8,
                  selectedIndex: Pwear.currentpage,
                  onTabChange: (value) {
                    setState(() {
                      Pwear.currentpage = value;
                    });
                  },
                  tabs: [
                    GButton(
                      icon: CupertinoIcons.heart,
                      text: 'Favourits',
                      onPressed: () {
                        Pwear.pageController!.animateToPage(0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOutCubicEmphasized);
                      },
                    ),
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                      onPressed: () {
                        Pwear.pageController!.animateToPage(1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOutCubicEmphasized);
                      },
                    ),
                    GButton(
                      icon: Icons.store_mall_directory_outlined,
                      text: 'Store',
                      onPressed: () {
                        Pwear.pageController!.animateToPage(2,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOutCubicEmphasized);
                      },
                    ),
                    GButton(
                      icon: Icons.person_4_outlined,
                      text: 'Profile',
                      onPressed: () {
                        Pwear.pageController!.animateToPage(3,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOutCubicEmphasized);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

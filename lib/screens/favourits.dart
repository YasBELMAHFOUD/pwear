import 'package:flutter/material.dart';
import 'package:pwear_store2/components/liked_product_card.dart';
import 'package:pwear_store2/databaseObjects/design.dart';
import 'package:pwear_store2/main.dart';
import 'package:pwear_store2/screens/login_screen.dart';
import 'package:pwear_store2/screens/signup_screen.dart';

class Favourits extends StatefulWidget {
  const Favourits({super.key});

  @override
  State<Favourits> createState() => _FavouritsState();
}

class _FavouritsState extends State<Favourits> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool logged = MyApp.loggedin == true ? false : true;
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: true,
          floating: true,
          title: Text(
            'Favourits',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        SliverToBoxAdapter(
          child: Visibility(
            visible: logged,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.grey.shade200,
              ),
              width: width * 0.8,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                        'To keep your favourits saved you have to log in or create an account'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ));
                          },
                          child: const Text('log in'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'sign up',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          sliver: SliverList.builder(
            itemCount: Design.articles.where((article) => article.liked).length,
            itemBuilder: (context, index) {
              Design likedProduct = Design.articles
                  .where((article) => article.liked)
                  .toList()[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: LikedProductCard(
                  onLikedChanged: (liked) {
                    setState(() {
                      likedProduct.liked = liked;
                    });
                  },
                  liked: true,
                  indexoflikedproduct: index,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

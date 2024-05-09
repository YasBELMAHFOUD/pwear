import 'package:flutter/material.dart';
import 'package:pwear_store2/databaseObjects/comment.dart';

class Design {
  int id;
  String path;
  String designName;
  double rating;
  double prix;
  int numOfRev;
  bool liked = false;
  List<Color> colorOptions;
  List<String> sizes;
  String type;
  String typeS;

  Design(
      {required this.id,
      required this.designName,
      required this.path,
      required this.rating,
      required this.prix,
      required this.numOfRev,
      required this.liked,
      required this.colorOptions,
      required this.sizes,
      required this.type,
      required this.typeS});
  static List<Design> articles = [
    Design(
        id: 0,
        designName: "unique cap",
        path: "assets/article_images/cap (no background).png",
        rating: 3,
        prix: 200,
        numOfRev: 15,
        liked: false,
        colorOptions: [
          Colors.black,
          Colors.blue,
          Colors.white,
          Colors.grey,
          Colors.amber,
        ],
        sizes: ["S", "M", "L", "XL", "XXL"],
        type: 'Cap',
        typeS: 'Baseball Cap'),
    Design(
        id: 1,
        designName: "cap all things are possible if you believe",
        path:
            "assets/article_images/cap all things are possible if you believe (background removed) - Copie.png",
        rating: 3,
        prix: 200,
        numOfRev: 15,
        liked: false,
        colorOptions: [
          Colors.black,
          Colors.blue,
          Colors.white,
          Colors.grey,
          Colors.amber,
          Colors.cyan,
        ],
        sizes: ["S", "M", "L", "XL", "XXL"],
        type: 'Cap',
        typeS: 'Baseball Cap'),
    Design(
        id: 2,
        designName: "cap be positive",
        path:
            "assets/article_images/cap be positive (background removed) - Copie.png",
        rating: 3,
        prix: 200,
        numOfRev: 15,
        liked: false,
        colorOptions: [
          Colors.black,
          Colors.blue,
          Colors.white,
          Colors.grey,
          Colors.amber,
          Colors.cyan,
        ],
        sizes: ["S", "L", "XL"],
        type: 'Cap',
        typeS: 'Baseball Cap'),
    Design(
        id: 3,
        designName: "cap colorfull realistic owel",
        path:
            "assets/article_images/cap colorfull realistic owel(background removed) - Copie.png",
        rating: 3,
        prix: 200,
        numOfRev: 15,
        liked: false,
        colorOptions: [
          Colors.black,
          Colors.blue,
          Colors.white,
          Colors.grey,
          Colors.amber,
          Colors.cyan,
        ],
        sizes: ["S", "L", "XL", "XXL"],
        type: 'Cap',
        typeS: 'Baseball Cap'),
    Design(
        id: 4,
        designName: "cap creativity comes from conflict of idieas",
        path:
            "assets/article_images/cap creativity comes from conflict of idieas(back ground removed).png",
        rating: 3,
        prix: 200,
        numOfRev: 15,
        liked: false,
        colorOptions: [
          Colors.black,
          Colors.blue,
          Colors.white,
          Colors.grey,
        ],
        sizes: ["S", "L", "XL"],
        type: 'Cap',
        typeS: 'Baseball Cap'),
//Round neck t-shirt _ Baseball Cap _ Pullover Hoodies
    Design(
        id: 5,
        designName: "hoodie all things are possible if you believe",
        rating: 5,
        path: "assets/article_images/Mon projet (1).png",
        prix: 175,
        numOfRev: 3,
        liked: false,
        colorOptions: [
          Colors.black,
          Colors.blue,
          Colors.white,
          Colors.grey,
          Colors.amber,
        ],
        sizes: ["S", "M", "L"],
        type: 'Hoodie',
        typeS: 'Pullover Hoodies'),
    Design(
        id: 6,
        designName: "hoodie colorfull realistic owel",
        rating: 5,
        path: "assets/article_images/Mon projet (2).png",
        prix: 175,
        numOfRev: 3,
        liked: false,
        colorOptions: [
          Colors.black,
          Colors.white,
          Colors.grey,
        ],
        sizes: [
          "L",
          "XL",
          "XXL",
        ],
        type: 'Hoodie',
        typeS: 'Pullover Hoodies'),
    Design(
        id: 7,
        designName: "hoodie hoodie creativity comes from conflict",
        rating: 5,
        path: "assets/article_images/Mon projet (3).png",
        prix: 175,
        numOfRev: 3,
        liked: false,
        colorOptions: [
          Colors.black,
          Colors.blue,
          Colors.white,
          Colors.amber,
        ],
        sizes: [
          "S",
          "M",
          "XL",
          "XXL",
        ],
        type: 'Hoodie',
        typeS: 'Pullover Hoodies'),
    Design(
        id: 8,
        designName: "hoodie do less with more focus",
        rating: 5,
        path: "assets/article_images/Mon projet (4).png",
        prix: 175,
        numOfRev: 3,
        liked: false,
        colorOptions: [
          Colors.black,
          Colors.blue,
          Colors.white,
          Colors.grey,
        ],
        sizes: [
          "S",
          "M",
          "L",
          "XL",
          "XXL",
        ],
        type: 'Hoodie',
        typeS: 'Pullover Hoodies'),

    Design(
        id: 9,
        designName: "t-shirt all things are possible if you believe",
        rating: 5,
        path: "assets/article_images/Mon projet (5).png",
        prix: 175,
        numOfRev: 3,
        liked: false,
        colorOptions: [
          Colors.blue,
          Colors.white,
          Colors.grey,
        ],
        sizes: [
          "S",
          "M",
          "L",
          "XL",
          "XXL",
        ],
        type: 'T-Shirt',
        typeS: 'Round neck t-shirt'),

    Design(
        id: 10,
        designName: "t-shirt be positive",
        rating: 5,
        path: "assets/article_images/Mon projet (6).png",
        prix: 175,
        numOfRev: 3,
        liked: false,
        colorOptions: [
          Colors.black,
          Colors.blue,
          Colors.white,
          Colors.amber,
          Colors.grey,
        ],
        sizes: [
          "S",
          "M",
          "L",
          "XL",
          "XXL",
        ],
        type: 'T-Shirt',
        typeS: 'Round neck t-shirt'),

    Design(
        id: 11,
        designName: "t-shirt clorfull realistic owel",
        rating: 5,
        path: "assets/article_images/Mon projet (7).png",
        prix: 175,
        numOfRev: 3,
        liked: false,
        colorOptions: [
          Colors.black,
          Colors.blue,
          Colors.white,
          Colors.grey,
        ],
        sizes: [
          "S",
          "M",
          "L",
          "XL",
          "XXL",
        ],
        type: 'T-Shirt',
        typeS: 'Round neck t-shirt'),

    Design(
        id: 11,
        designName: "t-shirt panda head with headphones",
        rating: 5,
        path: "assets/article_images/Mon projet (8).png",
        prix: 175,
        numOfRev: 3,
        liked: false,
        colorOptions: [
          Colors.black,
          Colors.blue,
          Colors.white,
          Colors.grey,
        ],
        sizes: [
          "S",
          "M",
          "L",
          "XL",
          "XXL",
        ],
        type: 'T-Shirt',
        typeS: 'Round neck t-shirt'),
  ];
  static double getAverageRatingForDesign(int designId) {
    // Get all comments for the given design ID
    List<Comment> commentsForDesign = Comment.getCommentsForDesign(designId);

    // Calculate the sum of ratings
    double sumOfRatings = 0;
    for (var comment in commentsForDesign) {
      sumOfRatings += comment.rating;
    }

    // Calculate the average rating
    if (commentsForDesign.isNotEmpty) {
      return sumOfRatings / commentsForDesign.length;
    } else {
      return 0.0; // Return 0 if there are no comments for the design
    }
  }

  static int getNumberOfCommentsForDesign(int designId) {
    // Get all comments for the given design ID
    List<Comment> commentsForDesign = Comment.getCommentsForDesign(designId);

    // Return the number of comments for the design
    return commentsForDesign.length;
  }
}

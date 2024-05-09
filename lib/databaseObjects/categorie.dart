class Categorie {
  String path;
  String titre;

  Categorie({
    required this.path,
    required this.titre,
  });
  static List<Categorie> categories = [
    Categorie(
      path: "assets/Categories_images/Hats.png",
      titre: "Cap",
    ),
    Categorie(
      path: "assets/Categories_images/T-shirts.png",
      titre: "T-Shirt",
    ),
    Categorie(
      path: "assets/Categories_images/Hoodies.png",
      titre: "Hoodie",
    ),
  ];
}

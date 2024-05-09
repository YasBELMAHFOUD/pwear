class Apparel {
  int id;
  String title;

  Apparel({
    required this.id,
    required this.title,
  });

  static List<Apparel> apparels = [
    Apparel(
      id: 0,
      title: 'Baseball Cap',
    ),
    Apparel(
      id: 1,
      title: 'Round neck t-shirt',
    ),
    Apparel(
      id: 2,
      title: 'Pullover Hoodies',
    ),
    Apparel(
      id: 3,
      title: 'Pocket T-shirt',
    ),
  ];
}

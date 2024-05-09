class Comment {
  int designid;
  String profileimage;
  String name;
  String comment;
  double rating;
  String date;

  Comment({
    required this.profileimage,
    required this.name,
    required this.comment,
    required this.rating,
    required this.date,
    required this.designid,
  });

  static List<Comment> comments = [];

  static List<Comment> getCommentsForDesign(int designId) {
    return comments.where((comment) => comment.designid == designId).toList();
  }
}

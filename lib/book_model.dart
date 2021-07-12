// class BookModel {
//   String imgAssetPath;
//   String title;
//   String description;
//   String category;
//   int rating;

//   BookModel(
//       {required this.title,
//       required this.description,
//       required this.category,
//       required this.rating,
//       required this.imgAssetPath});
// }

class BookModel {
  String id;
  String published;
  String publisher;
  String category;
  String name;
  String price;
  String language;

  BookModel(
      {required this.id,
      required this.published,
      required this.publisher,
      required this.category,
      required this.name,
      required this.price,
      required this.language});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      published: json['published'],
      publisher: json['publisher'],
      category: json['category'],
      name: json['name'],
      price: json['price'],
      language: json['language'],
    );
  }
}

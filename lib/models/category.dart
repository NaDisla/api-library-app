import 'dart:convert';

List<Category> categoriesFromJson(String str) =>
    List<Category>.from(json.decode(str).map((c) => Category.fromJson(c)));

class Category {
  int? catId;
  String? catName;

  Category({
    this.catId,
    this.catName,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      catId: json['catId'],
      catName: json['catName'],
    );
  }
}

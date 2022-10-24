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

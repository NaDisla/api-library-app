class Book {
  int? bookId;
  String title;
  String author;
  String? category;
  int? catId;
  double totalSales;

  Book({
    required this.title,
    required this.author,
    this.category,
    this.catId,
    required this.totalSales,
  });

  factory Book.fromJsonCustom(Map<String, dynamic> json) {
    return Book(
      title: json['bookTitle'],
      author: json['bookAuthor'],
      category: json['category'],
      totalSales: json['bookTotalSales'],
    );
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['bookTitle'],
      author: json['bookAuthor'],
      catId: json['catId'],
      totalSales: json['bookTotalSales'],
    );
  }
}

class Book {
  String title;
  String author;
  String category;
  int totalSales;

  Book({
    required this.title,
    required this.author,
    required this.category,
    required this.totalSales,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      author: json['author'],
      category: json['category'],
      totalSales: json['totalSales'],
    );
  }
}

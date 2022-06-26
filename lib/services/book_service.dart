import 'dart:convert';
import 'package:api_library_app/models/book.dart';
import 'package:http/http.dart' as http;

class BookService {
  final Uri apiUrl = Uri.parse(
      'https://api-library-na4.conveyor.cloud/api/books/custom_books');
  List<Book> parsedBooks = [];

  Future<List<Book>> getBooks() async {
    http.Client client = http.Client();
    http.Response booksResponse = await client.get(apiUrl);

    if (booksResponse.statusCode == 200) {
      String jsonStringBooks = booksResponse.body;
      parsedBooks = List<Book>.from(
          json.decode(jsonStringBooks).map((b) => Book.fromJson(b)));
    }
    return parsedBooks;
  }
}

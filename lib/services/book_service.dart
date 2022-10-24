import 'dart:convert';
import 'package:api_library_app/models/book.dart';
import 'package:http/http.dart' as http;
import 'services.dart';

String urlGetBooks = '${Global.urlApi}books/custom_books';
String urlBooks = '${Global.urlApi}books';

class BookService {
  http.Client client = http.Client();
  final Uri apiUrl = Uri.parse(urlGetBooks);

  //**********GET METHOD*************/
  Future<List<Book>> getBooks() async {
    List<Book> parsedBooks = [];
    http.Response booksResponse = await client.get(apiUrl);

    if (booksResponse.statusCode == 200) {
      String jsonStringBooks = booksResponse.body;
      parsedBooks = List<Book>.from(
          json.decode(jsonStringBooks).map((b) => Book.fromJsonCustom(b)));
      return parsedBooks;
    } else {
      throw "Failed loading books";
    }
  }
  //**********GET METHOD*************/

  //**********POST METHOD*************/
  Future<Book> createBook(Book newBook) async {
    Book? createdBook;
    Map bookData = {
      'bookTitle': newBook.title,
      'bookAuthor': newBook.author,
      'catId': newBook.catId,
      'bookTotalSales': newBook.totalSales,
    };
    http.Response postResponse = await client.post(Uri.parse(urlBooks),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(bookData));
    if (postResponse.statusCode == 201) {
      createdBook = Book.fromJson(jsonDecode(postResponse.body));
      return createdBook;
    } else {
      throw "Error creating book";
    }
  }
  //**********POST METHOD*************/

  //**********PUT METHOD*************/
  Future<Book> updateBook(int id, Book bookToUpdate) async {
    Book? updatedBook;
    Map<String, dynamic> bookData = {
      'bookId': id,
      'bookTitle': bookToUpdate.title,
      'bookAuthor': bookToUpdate.author,
      'catId': bookToUpdate.catId,
      'bookTotalSales': bookToUpdate.totalSales,
    };
    http.Response putResponse = await client.put(Uri.parse('$urlBooks/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(bookData));
    if (putResponse.statusCode == 204) {
      updatedBook = Book.fromJson(bookData);
      return updatedBook;
    } else {
      throw "Error updating book";
    }
  }
  //**********PUT METHOD*************/

  //**********DELETE METHOD*************/
  Future<String> deleteBook(int id) async {
    http.Response deleteResponse = await client.delete(
      Uri.parse('$urlBooks/$id'),
    );
    if (deleteResponse.statusCode == 204) {
      return "Book deleted successfully.";
    } else {
      throw "Failed to delete book.";
    }
  }
  //**********DELETE METHOD*************/
}

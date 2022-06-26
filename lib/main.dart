import 'package:api_library_app/screens/books_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ApiLibraryApp());

class ApiLibraryApp extends StatelessWidget {
  const ApiLibraryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const BooksScreen(),
    );
  }
}

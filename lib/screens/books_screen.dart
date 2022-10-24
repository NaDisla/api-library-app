import 'package:api_library_app/models/models.dart';
import 'package:api_library_app/screens/screens.dart';
import 'package:api_library_app/services/services.dart';
import 'package:api_library_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({Key? key}) : super(key: key);

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  List<Book> apiBooks = [];
  BookService bookService = BookService();
  late Future<List<Book>> futureBooks;
  TextStyle titleStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0);
  TextStyle propStyle = TextStyle(
    color: Colors.brown[900],
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    super.initState();
    futureBooks = getBooks();
  }

  Future<List<Book>> getBooks() {
    return bookService.getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.refresh_rounded),
          onPressed: () => setState(() {
            futureBooks = getBooks();
          }),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddBookScreen())),
          ),
        ],
      ),
      body: FutureBuilder<List<Book>>(
        future: futureBooks,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                final error = '${snapshot.error} 😢';
                return InfoWidget(info: error, color: Colors.red);
              } else if (snapshot.data!.isNotEmpty) {
                List<Book> data = snapshot.data!;
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, idx) {
                      return Card(
                        margin: const EdgeInsets.all(10.0),
                        color: Colors.brown.shade100,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, top: 5.0, bottom: 5.0),
                          child: Row(
                            children: [
                              BookDataWidget(
                                data: data,
                                titleStyle: titleStyle,
                                propStyle: propStyle,
                                position: idx,
                              ),
                              BookActionsWidget(
                                data: data,
                                bookService: bookService,
                                position: idx,
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return InfoWidget(
                  color: Colors.orange.shade900,
                  info: "Ups! There aren't books 🙁",
                );
              }
          }
        },
      ),
    );
  }
}

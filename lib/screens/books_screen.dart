import 'package:api_library_app/models/book.dart';
import 'package:api_library_app/screens/screens.dart';
import 'package:api_library_app/services/services.dart';
import 'package:api_library_app/widgets/book_detail_widget.dart';
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
                final error = snapshot.error;
                return Center(
                  child: Text(
                    '$error 😢',
                    style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                );
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[idx].title,
                                    style: titleStyle,
                                  ),
                                  const SizedBox(height: 5.0),
                                  BookDetailWidget(
                                      propIcon: Icons.category_rounded,
                                      propTitle: 'Category: ',
                                      propDetail: data[idx].category!,
                                      propStyle: propStyle),
                                  const SizedBox(height: 5.0),
                                  BookDetailWidget(
                                      propIcon: Icons.person,
                                      propTitle: 'Author: ',
                                      propDetail: data[idx].author,
                                      propStyle: propStyle),
                                  const SizedBox(height: 5.0),
                                  BookDetailWidget(
                                      propIcon: Icons.monetization_on,
                                      propTitle: 'Total Sales: ',
                                      propDetail: '${data[idx].totalSales}',
                                      propStyle: propStyle),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => EditBookScreen(
                                            selectedBook: data[idx]),
                                      )),
                                      child: const Icon(Icons.edit),
                                    ),
                                    TextButton(
                                      onPressed: () => showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Are you sure you want to delete this book?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                    String result =
                                                        await bookService
                                                            .deleteBook(
                                                                data[idx]
                                                                    .bookId!);
                                                    if (result.isNotEmpty) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Book deleted successfully'),
                                                              content:
                                                                  const Text(
                                                                'The book was deleted successfully. You can return and refresh the list. 🙌',
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context),
                                                                  child:
                                                                      const Text(
                                                                          'OK'),
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                    }
                                                  },
                                                  child: const Text('YES'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text('CANCEL'),
                                                ),
                                              ],
                                            );
                                          }),
                                      child: Icon(Icons.delete,
                                          color: Colors.red[900]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return Center(
                  child: Text(
                    "Ups! There aren't books 🙁",
                    style: TextStyle(
                        color: Colors.orange.shade900,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

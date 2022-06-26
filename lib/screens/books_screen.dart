import 'package:api_library_app/models/book.dart';
import 'package:api_library_app/services/book_service.dart';
import 'package:api_library_app/widgets/book_detail_widget.dart';
import 'package:flutter/material.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({Key? key}) : super(key: key);

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  List<Book>? apiBooks = [];
  TextStyle titleStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0);
  TextStyle propStyle = TextStyle(
    color: Colors.brown[900],
    fontWeight: FontWeight.bold,
  );
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getBooksData();
  }

  getBooksData() async {
    apiBooks = await BookService().getBooks();
    if (apiBooks != null) {
      setState(() => isLoaded = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
        centerTitle: true,
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
            itemCount: apiBooks?.length,
            itemBuilder: (context, idx) {
              return Card(
                margin: const EdgeInsets.all(10.0),
                color: Colors.brown.shade100,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${apiBooks?[idx].title}',
                        style: titleStyle,
                      ),
                      const SizedBox(height: 5.0),
                      BookDetailWidget(
                          propIcon: Icons.category_rounded,
                          propTitle: 'Category: ',
                          propDetail: '${apiBooks?[idx].category}',
                          propStyle: propStyle),
                      const SizedBox(height: 5.0),
                      BookDetailWidget(
                          propIcon: Icons.person,
                          propTitle: 'Author: ',
                          propDetail: '${apiBooks?[idx].author}',
                          propStyle: propStyle),
                      const SizedBox(height: 5.0),
                      BookDetailWidget(
                          propIcon: Icons.monetization_on,
                          propTitle: 'Total Sales: ',
                          propDetail: '${apiBooks?[idx].totalSales}',
                          propStyle: propStyle),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

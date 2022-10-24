import 'package:api_library_app/models/models.dart';
import 'package:api_library_app/screens/screens.dart';
import 'package:api_library_app/services/services.dart';
import 'package:api_library_app/widgets/alert_widget.dart';
import 'package:flutter/material.dart';

class BookActionsWidget extends StatelessWidget {
  const BookActionsWidget({
    Key? key,
    required this.data,
    required this.bookService,
    required this.position,
  }) : super(key: key);

  final List<Book> data;
  final BookService bookService;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  EditBookScreen(selectedBook: data[position]),
            )),
            child: const Icon(Icons.edit),
          ),
          TextButton(
            onPressed: () => showDialog(
                context: context,
                builder: (context) {
                  return AlertWidget(
                    title: 'Are you sure you want to delete this book?',
                    content: '',
                    actions: [
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          String result = await bookService
                              .deleteBook(data[position].bookId!);
                          if (result.isNotEmpty) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertWidget(
                                    title: 'Book deleted successfully',
                                    content:
                                        'The book was deleted successfully. You can return and refresh the list. 🙌',
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                });
                          }
                        },
                        child: const Text('YES'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('CANCEL'),
                      ),
                    ],
                  );
                }),
            child: Icon(Icons.delete, color: Colors.red[900]),
          ),
        ],
      ),
    );
  }
}

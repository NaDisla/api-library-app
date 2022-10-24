import 'package:api_library_app/models/models.dart';
import 'package:api_library_app/services/services.dart';
import 'package:api_library_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EditBookScreen extends StatefulWidget {
  final Book selectedBook;
  const EditBookScreen({super.key, required this.selectedBook});

  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController totalSalesController = TextEditingController();
  CategoryService catService = CategoryService();
  List<Category> apiCategories = [];
  int? catId;
  Category bookCategory = Category();
  BookService bookService = BookService();

  Future getCategories() {
    Future<List<Category>> futureCategories = catService.getCategories();
    futureCategories.then((list) {
      setState(() => apiCategories = list);
    });
    return futureCategories;
  }

  @override
  void initState() {
    super.initState();
    getCategories();
    nameController.text = widget.selectedBook.title;
    authorController.text = widget.selectedBook.author;
    totalSalesController.text = widget.selectedBook.totalSales.toString();
  }

  @override
  Widget build(BuildContext context) {
    // Book selectedBook = ModalRoute.of(context)!.settings.arguments as Book;
    return Scaffold(
      appBar: AppBar(
        title: Text('Editing Book: ${widget.selectedBook.title}'),
      ),
      body: Form(
        key: editFormKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              TextFieldWidget(
                controller: nameController,
                hintText: 'Book Title',
                labelText: 'Book Title',
                isDense: true,
                inputBorder: const OutlineInputBorder(),
                requiredText: 'Title is required.',
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFieldWidget(
                controller: authorController,
                hintText: 'Author',
                labelText: 'Author',
                isDense: true,
                inputBorder: const OutlineInputBorder(),
                requiredText: 'Author is required.',
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFieldWidget(
                controller: totalSalesController,
                hintText: 'Total Sales',
                labelText: 'Total Sales',
                isDense: true,
                inputBorder: const OutlineInputBorder(),
                requiredText: 'Total Sales is required.',
              ),
              const SizedBox(
                height: 20.0,
              ),
              DropdownButtonFormField<Category>(
                onChanged: (value) => setState(() {
                  catId = value!.catId;
                }),
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Category',
                  hintText: 'Category',
                ),
                items: apiCategories.map((cat) {
                  return DropdownMenuItem(
                    value: cat,
                    child: Text(cat.catName!),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 100.0),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    )),
                onPressed: () async {
                  if (editFormKey.currentState!.validate()) {
                    Book updatedBook = await bookService.updateBook(
                        widget.selectedBook.bookId!,
                        Book(
                          bookId: widget.selectedBook.bookId,
                          title: nameController.text,
                          author: authorController.text,
                          totalSales: double.parse(totalSalesController.text),
                          catId: catId!,
                        ));
                    if (updatedBook.title.isNotEmpty) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertWidget(
                                title: 'Book updated successfully',
                                content:
                                    'The book was updated successfully. You can go to home screen and refresh the list. 🙌',
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      editFormKey.currentState!.reset();
                                      nameController.clear();
                                      authorController.clear();
                                      totalSalesController.clear();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ]);
                          });
                    }
                  }
                },
                child: const Text('Save changes'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:api_library_app/models/models.dart';
import 'package:api_library_app/services/services.dart';
import 'package:api_library_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  GlobalKey<FormState> addFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController totalSalesController = TextEditingController();
  CategoryService catService = CategoryService();
  List<Category> apiCategories = [];
  int? catId;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Book'),
      ),
      body: Form(
        key: addFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Column(
            children: [
              TextFieldWidget(
                controller: nameController,
                icon: const Icon(Icons.text_fields_rounded),
                hintText: 'Book Title',
                requiredText: 'Title is required.',
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFieldWidget(
                  controller: authorController,
                  icon: const Icon(Icons.person),
                  hintText: 'Author',
                  requiredText: 'Author is required.'),
              const SizedBox(
                height: 20.0,
              ),
              TextFieldWidget(
                  controller: totalSalesController,
                  icon: const Icon(Icons.monetization_on),
                  hintText: 'Total Sales',
                  requiredText: 'Total Sales is required.'),
              const SizedBox(
                height: 20.0,
              ),
              DropdownButtonFormField<Category>(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.category_outlined),
                  ),
                  hint: const Text('Category'),
                  items: apiCategories.map((cat) {
                    return DropdownMenuItem(
                      value: cat,
                      child: Text(cat.catName!),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() {
                        catId = value!.catId;
                      })),
              const SizedBox(
                height: 50.0,
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
                  if (addFormKey.currentState!.validate()) {
                    Book newBook = await bookService.createBook(Book(
                      title: nameController.text,
                      author: authorController.text,
                      totalSales: double.parse(totalSalesController.text),
                      catId: catId!,
                    ));
                    if (newBook.title.isNotEmpty) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertWidget(
                              title: 'Book created successfully',
                              content:
                                  'The book was created successfully. You can go to home screen and refresh the list. 🙌',
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    addFormKey.currentState!.reset();
                                    nameController.clear();
                                    authorController.clear();
                                    totalSalesController.clear();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          });
                    }
                  }
                },
                child: const Text('Create book'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

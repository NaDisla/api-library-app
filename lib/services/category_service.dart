import 'package:api_library_app/models/models.dart';
import 'package:http/http.dart' as http;
import 'services.dart';
import 'dart:convert';

String categoriesUrl = '${Global.urlApi}categories';

class CategoryService {
  http.Client client = http.Client();
  final Uri apiUrl = Uri.parse(categoriesUrl);

  //**********GET METHOD*************/
  Future<List<Category>> getCategories() async {
    List<Category> parsedCategories = [];
    http.Response categoriesResponse = await client.get(apiUrl);

    if (categoriesResponse.statusCode == 200) {
      String jsonStringCategories = categoriesResponse.body;
      parsedCategories = List<Category>.from(
          json.decode(jsonStringCategories).map((b) => Category.fromJson(b)));
    }
    return parsedCategories;
  }
  //**********GET METHOD*************/
}

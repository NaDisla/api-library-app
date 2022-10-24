import 'dart:convert';

import 'package:api_library_app/models/models.dart';
import 'package:http/http.dart' as http;
import 'services.dart';

String categoriesUrl = '${Global.urlApi}categories';

class CategoryService {
  http.Client client = http.Client();
  final Uri apiUrl = Uri.parse(categoriesUrl);

  //**********GET METHOD*************/
  Future<List<Category>> getCategories() async {
    // List<Category> parsedCategories = [];
    http.Response categoriesResponse = await client.get(apiUrl);
    return categoriesFromJson(categoriesResponse.body);

    // if (categoriesResponse.statusCode == 200) {
    //   String jsonStringCategories = categoriesResponse.body;
    //   parsedCategories = List<Category>.from(
    //       json.decode(jsonStringCategories).map((b) => Category.fromJson(b)));
    // }
  }
  //**********GET METHOD*************/

  //**********GET BY ID METHOD*************/
  Future<Category> getCategory(int id) async {
    http.Response categoryResponse =
        await client.get(Uri.parse('$categoriesUrl/$id'));
    return Category.fromJson(jsonDecode(categoryResponse.body));
  }
  //**********GET BY ID METHOD*************/
}

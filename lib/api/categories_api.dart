import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:news/utilities/api_utilities.dart';
import 'package:news/models/category.dart';

class CategoriesApi {
  Future<List<Category>> fetchAllCategories() async{
    List<Category> categories = List<Category>();
    String allCategoriesUrl = baseUrl + allCategoriesApi;
    var response = await http.get(allCategoriesUrl);
    if(response.statusCode == 200){
      var jsonData = convert.jsonDecode(response.body);
      var data =jsonData["data"];
      for(var item in data){
        Category category = Category(item["id"].toString(), item["title"].toString());
        categories.add(category);
        //print(category.id);
      }
    }
    return categories;
  }
}

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:news/models/author.dart';
import 'package:news/utilities/api_utilities.dart';

class AuthorsAPI {
 Future<List<Author>> fetchAllAuthors() async {
    List<Author> authors = List<Author>();
    String allAuthorApiUrl = baseUrl + allAuthorApi;
    var response = await http.get(allAuthorApiUrl);
    if (response.statusCode == 200) {
      var jsonData = convert.jsonDecode(response.body);
      var data =jsonData["data"];
      for(var item in data){
        Author author = Author(item["id"], item["name"], item["email"], item["avatar"]);
        authors.add(author);
        print(author.id);
      }
    }
    return authors;
  }

}

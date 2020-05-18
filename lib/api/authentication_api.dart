import "package:http/http.dart" as http;
import "dart:convert" as convert;
import 'package:news/utilities/api_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationAPI {
  Future<bool> logIn(String email, String password) async {
    String authUrl = baseUrl + authenticationApi;
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded",
    };
    Map<String, String> body = {
      "email": email,
      "password": password,
    };
    var response = await http.post(authUrl, headers: headers, body: body);
    if (response.statusCode == 200) {
      try {
        var jsonData = convert.jsonDecode(response.body);
        var data = jsonData["data"];
        var token = data["token"];
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString("token", token);
        //print(token);
        return true;
      } catch (Exception) {
        return false;
      }
    }
  }
}

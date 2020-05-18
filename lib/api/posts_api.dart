import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:news/utilities/api_utilities.dart';
import 'package:news/models/post.dart';

class PostApi {
  Future<List<Post>> fetchPostsByCategoryId(String id) async {
    List<Post> posts = List<Post>();
    String postUrl = baseUrl + categoriesApi + id;
    var response = await http.get(postUrl);
    if (response.statusCode == 200) {
      var jsonData = convert.jsonDecode(response.body);
      var data = jsonData["data"];
      for (var item in data) {
        Post post = Post(
          id: item["id"].toString(),
          title: item["title"].toString(),
          dateWritten: item["date_written"].toString(),
          content: item["content"].toString(),
          featuredImage: item["featured_image"].toString(),
          votesUp: item["votes_up"],
          votesDown: item["votes_down"],
          votersUp: (item["voters_up"] == null)
              ? List<int>()
              : convert.jsonDecode(item["voters_up"]),
          votersDown: (item["voters_down"] == null)
              ? List<int>()
              : convert.jsonDecode(item["voters_down"]),
          categoryId: item["category_id"],
          userId: item["user_id"],
          authorName: item["author"]["name"],
          authorAvatar: item["author"]["avatar"],
          comments: item["comments"],
        );

        posts.add(post);
       // print(post.author);
      }
    }
    return posts;
  }
}

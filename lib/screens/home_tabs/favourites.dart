import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news/api/posts_api.dart';
import 'package:news/models/post.dart';
import 'package:news/screens/single_post.dart';
import 'package:news/utilities/data_utilities.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  PostApi postApi = PostApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postApi.fetchPostsByCategoryId("8"),
      // ignore: missing_return
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return loading();
            break;
          case ConnectionState.active:
            return loading();
            break;
          case ConnectionState.none:
            return connectionError();
            break;
          case ConnectionState.done:
            if (snapshot.hasError) {
              return error(snapshot.error);
            } else {
              List<Post> posts = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, position) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SinglePost(posts[position]);
                      }));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: <Widget>[
                            _drawAuthorRow(
                                posts[position].authorAvatar,
                                posts[position].authorName,
                                posts[position].dateWritten),
                            SizedBox(height: 10),
                            _drawItemRow(
                                posts[position].content,
                                posts[position].title,
                                posts[position].featuredImage),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: posts.length,
              );
            }
            break;
        }
      },
    );
  }

  Widget _drawAuthorRow(String avatar, String author, String dateWritten) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(avatar),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
              width: 40,
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    author,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        parseHumanDateTime(dateWritten),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        ".",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "Liyfe Style",
                        style: TextStyle(
                          color: _getRandomColor(),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        IconButton(
            icon: Icon(
              Icons.bookmark_border,
              color: Colors.grey,
            ),
            onPressed: () {})
      ],
    );
  }

  Widget _drawItemRow(String content, String title, String featuredImage) {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(featuredImage),
              fit: BoxFit.cover,
            ),
          ),
          width: 100,
          height: 100,
          margin: EdgeInsets.only(right: 16),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                content,
                style:
                    TextStyle(color: Colors.grey, fontSize: 13, height: 1.50),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getRandomColor() {
    List<Color> colorsList = [
      Colors.deepOrange,
      Colors.deepPurple,
      Colors.green,
      Colors.amber,
      Colors.purpleAccent,
      Colors.blueAccent
    ];
    Random random = Random();
    return colorsList[random.nextInt(colorsList.length)];
  }
}

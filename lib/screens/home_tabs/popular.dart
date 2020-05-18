import 'package:flutter/material.dart';
import 'package:news/api/posts_api.dart';
import 'package:news/models/post.dart';
import 'package:news/utilities/data_utilities.dart';

import '../single_post.dart';

class Popular extends StatefulWidget {
  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  PostApi postApi = PostApi();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: postApi.fetchPostsByCategoryId("3"),
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
                    return Card(
                      child: _drawSingleRawInStories(posts[position]),
                    );
                  },
                  itemCount: posts.length,
                );
              }
              break;
          }
        });
  }

  Widget _drawSingleRawInStories(Post post) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return SinglePost(post);
          }));
        },
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 100,
              height: 100,
              child: Image(
                image: NetworkImage(post.featuredImage),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    post.title,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(post.authorName.substring(0,10)),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.access_alarms,
                            size: 15,
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          Text(parseHumanDateTime(post.dateWritten))
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

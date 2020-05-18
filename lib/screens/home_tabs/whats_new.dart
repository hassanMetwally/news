import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/api/posts_api.dart';
import 'package:news/models/post.dart';
import 'package:news/screens/single_post.dart';
import 'package:news/utilities/data_utilities.dart';

class WhatsNew extends StatefulWidget {
  @override
  _WhatsNewState createState() => _WhatsNewState();
}

class _WhatsNewState extends State<WhatsNew> {

  PostApi postApi = PostApi();

  Color _getRandomColor() {
    Random random = Random();
    List<Color> colorsList = [
      Colors.deepOrange,
      Colors.deepPurple,
      Colors.green,
      Colors.amber,
      Colors.purpleAccent,
      Colors.blueAccent
    ];
    return colorsList[random.nextInt(colorsList.length)];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _drawHeader(),
          _drawTopStories(),
          _drawRecentUpdate()
        ],
      ),
    );
  }

  Widget _drawHeader() {
    TextStyle _headerTile = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20);
    TextStyle _headerDescription = TextStyle(color: Colors.white, fontSize: 15);
    return FutureBuilder(
      future: postApi.fetchPostsByCategoryId("1"),
      // ignore: missing_return
      builder: (context, AsyncSnapshot snapshot){
        switch(snapshot.connectionState){
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
            if(snapshot.hasError){
              return error(snapshot.error);
            }else{
              List<Post> posts = snapshot.data;
              Random random =Random();
              int randomIndex = random.nextInt(posts.length);
              Post post = posts[randomIndex];
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return SinglePost(post);
                  }));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(post.featuredImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                       post.title,
                        style: _headerTile,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          post.content.substring(0,100),
                          style: _headerDescription,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            break;
        }
      },
    );
  }

  Widget _drawTopStories() {
    return Container(
      color: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _drawSectionTitle("Top Stories"),
            Card(
              child: FutureBuilder(
                future: postApi.fetchPostsByCategoryId("1"),
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
                      if (snapshot.error != null) {
                        return error(snapshot.error);
                      } else {
                        if (snapshot.hasData) {
                          List<Post> posts = snapshot.data;
                          if (posts.length >= 3) {
                            Post post1 = snapshot.data[0];
                            Post post2 = snapshot.data[1];
                            Post post3 = snapshot.data[2];
                            return Column(
                              children: <Widget>[
                                _drawSingleRawInStories(post1),
                                Divider(height: 8, color: Colors.black54),
                                _drawSingleRawInStories(post2),
                                Divider(height: 8, color: Colors.black54),
                                _drawSingleRawInStories(post3),
                              ],
                            );
                          } else {
                            return noData();
                          }
                        } else {
                          return noData();
                        }
                      }
                      break;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawRecentUpdate() {
    return Container(
      color: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: FutureBuilder(
          future: postApi.fetchPostsByCategoryId("2"),
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _drawSectionTitle("Recent update"),
                      ListView.builder(
                        itemBuilder: (context, position){
                          return _drawRecentUpdateCard(posts[position]);
                        },itemCount: posts.length,
                        shrinkWrap: true,physics: new NeverScrollableScrollPhysics(),
                      )
                    ],
                  );
                }
                break;
            }
          },
        ),
      ),
    );
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
                child: Image.network(post.featuredImage, fit: BoxFit.cover)),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    post.title,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(post.authorName),
                      Row(
                        children: <Widget>[
                          Icon(Icons.access_alarms, size: 15),
                          SizedBox(width: 1),
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

  Widget _drawSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }

  Widget _drawRecentUpdateCard(Post post) {
    return Card(
      child: GestureDetector(
        onTap:(){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return SinglePost(post);
          }));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(post.featuredImage),
                    fit: BoxFit.cover,
                  ),
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .25),
            Container(
              padding: EdgeInsets.only(left: 24, right: 24),
              margin: EdgeInsets.all(8),
              child: Text(
                "SPORT",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                  color: _getRandomColor(),
                  borderRadius: BorderRadius.circular(4)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: Text(
                post.title,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.access_alarms,
                    size: 15,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(parseHumanDateTime(post.dateWritten))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}

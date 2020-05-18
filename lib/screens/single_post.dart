import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/models/post.dart';
import 'package:news/utilities/data_utilities.dart';

class SinglePost extends StatefulWidget {
  final Post post;

  SinglePost(this.post);

  @override
  _SinglePostState createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  @override
  Widget build(BuildContext context) {
    int _itemsCount = widget.post.comments.length + 3;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.post.featuredImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(16, 205),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(widget.post.authorAvatar),
                                  fit: BoxFit.cover,
                                ),
                                shape: BoxShape.circle,
                              ),
                              width: 40,
                              height: 40,
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.post.authorName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  parseHumanDateTime(widget.post.dateWritten),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          widget.post.title,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, position) {
                if (position == 0) {
                  return _drawPostDetails();
                } else if (position == 1) {
                  return _drawSectionTitle("Comments");
                } else if (position >= 2 && position < _itemsCount - 1) {
                  return _drawComments(
                      widget.post.comments[position - 2]["content"]);
                } else {
                  return _drawCommentEntry();
                }
              },
              childCount: _itemsCount,
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawPostDetails() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          child: Text(
            widget.post.content,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18,
              letterSpacing: .5,
              height: 1.25,
            ),
          ),
        ),
        Divider(height: 8, color: Colors.black54),
      ],
    );
  }

  Widget _drawSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
          child: Text(
        title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      )),
    );
  }

  Widget _drawComments(var content) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                  backgroundImage:
                      ExactAssetImage("assets/images/placeholder_bg.png")),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("hassan metwally"),
                  Text("1 houre"),
                ],
              )
            ],
          ),
          SizedBox(height: 16),
          Text(
            content,
            style: TextStyle(color: Colors.black54),
          ),
          SizedBox(height: 16),
          Divider(height: 8, color: Colors.black54, indent: 20, endIndent: 20),
        ],
      ),
    );
  }

  Widget _drawCommentEntry() {
    return Container(
      color: Color.fromRGBO(241, 245, 247, 1),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Write Comment here!",
                  contentPadding:
                      EdgeInsets.only(left: 16, top: 24, bottom: 24)),
              onTap: () {},
            ),
          ),
          FlatButton(
              onPressed: () {},
              child: Text(
                "send",
                style: TextStyle(color: Colors.red),
              ))
        ],
      ),
    );
  }
}

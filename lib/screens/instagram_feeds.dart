import 'package:flutter/material.dart';
import 'package:news/shared_ui/navigation_drawer.dart';

class InstagramFeeds extends StatefulWidget {
  @override
  _InstagramFeedsState createState() => _InstagramFeedsState();
}

class _InstagramFeedsState extends State<InstagramFeeds> {
  TextStyle _hashTagStyle = TextStyle(
    color: Colors.orange,
  );
  List<int > ids = [0, 2, 7];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instagram Feeds"),
        centerTitle: false,
      ),
      drawer: NavigationDrawer(),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemBuilder: (context, position) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _drawCardHeader(position),
                  _drawCardTitle(),
                  _drawCardHashTags(),
                  _drawCardBody(),
                  Divider(
                    height: .1,
                    thickness: 1,
                    endIndent: 10,
                    indent: 10,
                  ),
                  _drawCardFooter(),
                ],
              ),
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }

  Widget _drawCardHeader(int position) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage:
                    ExactAssetImage("assets/images/placeholder_bg.png"),
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Christina Meyers',
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Fri, 12 May 2017 • 14.30',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  if (ids.contains(position)) {
                    ids.remove(position);
                  } else {
                    ids.add(position);
                  }
                  setState(() {

                  });
                  print(ids);
                },
                color: (ids.contains(position)) ? Colors.red : Colors.black12,
              ),
              Transform.translate(
                  offset: Offset(-10, 0),
                  child: Text(
                    "20",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget _drawCardTitle() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
      ),
      child: Text(
        "We also talk about the future of work as the robots",
        style: TextStyle(
          color: Colors.grey.shade900,
        ),
      ),
    );
  }

  Widget _drawCardHashTags() {
    return Wrap(
      children: <Widget>[
        FlatButton(
          onPressed: () {},
          child: Text(
            "#advanced",
            style: _hashTagStyle,
          ),
        ),
        FlatButton(
          onPressed: () {},
          child: Text(
            "#advanced",
            style: _hashTagStyle,
          ),
        ),
        FlatButton(
          onPressed: () {},
          child: Text(
            "#advanced",
            style: _hashTagStyle,
          ),
        )
      ],
    );
  }

  Widget _drawCardBody() {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .25,
      child: Image(
        image: ExactAssetImage("assets/images/placeholder_bg.png"),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _drawCardFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
            onPressed: () {},
            child: Text(
              "COMENTS",
              style: _hashTagStyle,
            )),
        Row(
          children: <Widget>[
            FlatButton(
                onPressed: () {},
                child: Text(
                  "SHARE",
                  style: _hashTagStyle,
                )),
            FlatButton(
                onPressed: () {},
                child: Text(
                  "OPEN",
                  style: _hashTagStyle,
                )),
          ],
        )
      ],
    );
  }
}

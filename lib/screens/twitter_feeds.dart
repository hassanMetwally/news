import 'package:flutter/material.dart';
import 'package:news/shared_ui/navigation_drawer.dart';

class TwitterFeeds extends StatefulWidget {
  @override
  _TwitterFeedsState createState() => _TwitterFeedsState();
}

class _TwitterFeedsState extends State<TwitterFeeds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Twiitter feeds"),
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
                children: <Widget>[
                  _drawCardHeader(),
                  _drawCardBody(),
                  Divider(height: .1,thickness: 1,endIndent: 10,indent: 10,),
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

  Widget _drawCardHeader() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage:
                ExactAssetImage("assets/images/placeholder_bg.png"),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
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
                  width: 8,
                ),
                Text(
                  '@ch_meyers',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Fri, 12 May 2017 • 14.30',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }

  Widget _drawCardBody() {
    return Container(
      padding: EdgeInsets.only(left: 10,top: 5,bottom: 15,),
      child: Text(
        "We also talk about the future of work as the robots advance, and we ask whether a retro phone",
        style:
            TextStyle(fontSize: 15, height: 1.4, color: Colors.grey.shade900),
      ),
    );
  }

  Widget _drawCardFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(

                icon: Icon(
                  Icons.repeat,
                  size: 23,
                  color: Colors.orange,
                ),
                onPressed: () {}),
            Transform.translate(
              offset: Offset(-10,0),
              child: Text("25",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),),
            )
          ],
        ),
        Row(
          children: <Widget>[
            FlatButton(onPressed: (){},textColor: Colors.orange,color: Colors.white,child: Text("SHARE"),),

            FlatButton(onPressed: (){},textColor: Colors.orange,color: Colors.white,child: Text("OPEN"),)
          ],
        )
      ],
    );
  }
}

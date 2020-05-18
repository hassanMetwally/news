import 'package:flutter/material.dart';
import 'package:news/shared_ui/navigation_drawer.dart';
import 'home_tabs/favourites.dart';
import 'home_tabs/popular.dart';

class HeadlineNews extends StatefulWidget {
  @override
  _HeadlineNewsState createState() => _HeadlineNewsState();
}

class _HeadlineNewsState extends State<HeadlineNews>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Headline News'),
        centerTitle: false,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
        bottom: (TabBar(
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              child: Text("WHAT'S NEW"),
            ),
            Tab(
              child: Text('POPULAR'),
            ),
            Tab(
              child: Text('FAVOURITES'),
            ),
          ],
          controller: _tabController,
        )),
      ),
      drawer: NavigationDrawer(),
      body: Center(
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Favourites(),
            Popular(),
            Favourites(),
          ],
        ),
      ),
    );
  }
}

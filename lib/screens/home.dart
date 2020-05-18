import 'package:flutter/material.dart';
import 'package:news/screens/pages/about.dart';
import 'package:news/screens/pages/contact.dart';
import 'package:news/screens/pages/help.dart';
import 'package:news/screens/pages/settings.dart';
import 'package:news/shared_ui/navigation_drawer.dart';
import 'home_tabs/popular.dart';
import 'home_tabs/favourites.dart';
import 'home_tabs/whats_new.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
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

        title: Text('Explore'),
        centerTitle: false,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          _drawPopUpMenuButton(context),
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
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          WhatsNew(),
          Popular(),
          Favourites(),
        ],
      ),
    );
  }

  Widget _drawPopUpMenuButton(BuildContext context) {
    return PopupMenuButton<PupUpMenu>(
        itemBuilder: (context) {
          return [
            PopupMenuItem<PupUpMenu>(
              child: Text("ABOUT"),
              value: PupUpMenu.ABOUT,
            ),
            PopupMenuItem<PupUpMenu>(
              child: Text("CONTACT"),
              value: PupUpMenu.CONTACT,
            ),
            PopupMenuItem<PupUpMenu>(
              child: Text("HELP"),
              value: PupUpMenu.HELP,
            ),
            PopupMenuItem<PupUpMenu>(
              child: Text("SETTINGS"),
              value: PupUpMenu.SETTINGS,
            ),
          ];
        },
        onSelected: (PupUpMenu menu) {
          switch(menu){
            case PupUpMenu.ABOUT:
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return About();
              }));
              break;
            case PupUpMenu.CONTACT:
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return Contact();
              }));
              break;
            case PupUpMenu.HELP:
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return Help();
              }));
              break;
            case PupUpMenu.SETTINGS:
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return Settings();
              }));
              break;
          }
        },
        icon: Icon(Icons.more_vert));
  }
}

enum PupUpMenu { ABOUT, CONTACT, HELP, SETTINGS }

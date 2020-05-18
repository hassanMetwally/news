import 'package:flutter/material.dart';
import 'package:news/models/nav_menu.dart';
import 'package:news/screens/facebook_feeds.dart';
import 'package:news/screens/home.dart';
import 'package:news/screens/headline_news.dart';
import 'package:news/screens/instagram_feeds.dart';
import 'package:news/screens/login.dart';
import 'package:news/screens/twitter_feeds.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news/utilities/app_utilities.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  static bool isLoggedIn = true;

  List<NavMenuItem> navigationMenu = [
    NavMenuItem("Explore", () => Home()), // ال constructor لازم يتخزن جوا method عشان مينفذش الا عند الاستدعاء(resources optimization)
    NavMenuItem("Headline News", () => HeadlineNews()),
    NavMenuItem("Twitter Feeds", () => TwitterFeeds()),
    NavMenuItem("Instagram Feeds", () => InstagramFeeds()),
    NavMenuItem("Facebook Feeds", () => FacebookFeeds())
  ];

  @override
  void initState() {
    if (isLoggedIn) {
      navigationMenu.add(NavMenuItem("Log Out", () => LogIn()));
    }
    super.initState();
  }

  _checkToken()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.get("token");
    setState(() {
      if(token == null){
        isLoggedIn = false;
      }else{
        isLoggedIn = true;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    _checkToken();
    return Drawer(
      child: ListView.builder(
        padding: EdgeInsets.only(left: 40, top: 180),
        itemBuilder: (context, position) {
          return ListTile(
            title: Text(
              navigationMenu[position].title,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 20,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 13,
              color: Colors.grey.shade400,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                return navigationMenu[position].destination();
              }),(position == navigationMenu.length-1)?(Route rout) => false :(Route rout) => true);
            },
          );
        },
        itemCount: navigationMenu.length,
      ),
    );
  }
}

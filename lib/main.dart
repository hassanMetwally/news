import 'package:flutter/material.dart';
import 'screens/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home.dart';
import 'utilities/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //for SharedPreferences error

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seen = prefs.getBool('seen');
  Widget _screen;

  if (seen == null || seen == false) {
    _screen = OnBoarding();
  } else {
    _screen = Home();
  }

  runApp(NewsApp(_screen));
}

class NewsApp extends StatelessWidget {
  final Widget _screen;
  NewsApp(this._screen);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: this._screen,
    );
  }
}

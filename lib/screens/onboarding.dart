import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:news/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<String> images = [
    'assets/images/bg.png',
    'assets/images/bg2.png',
    'assets/images/bg3.png',
    'assets/images/bg4.png',
  ];

  List<IconData> icons = [
    Icons.ac_unit,
    Icons.accessibility,
    Icons.account_balance,
    Icons.brightness_7,
  ];

  List<String> description = [
    '1 - making frinds is easy as waving your hand back and fourth in easy',
    '2 - making frinds is easy as waving your hand back and fourth in easy',
    '3 - making frinds is easy as waving your hand back and fourth in easy',
    '4 - making frinds is easy as waving your hand back and fourth in easy',
  ];

  ValueNotifier<int> _pageIndexNotifier = ValueNotifier(0);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        PageView.builder(
          itemBuilder: (context, index) {
            return Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage(images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(0, -90),
                      child: Icon(
                        icons[index],
                        size: 90,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Welcome!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 48, right: 48, top: 10),
                      child: Text(
                        description[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ],
            );
          },
          itemCount: 4,
         onPageChanged: ( index ){
            _pageIndexNotifier.value = index;
         },
        ),
        Transform.translate(
          offset: Offset(0, 110),
          child: Align(
              alignment: Alignment.center,
              child: _displayPageViewIndicator(images.length)),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: SizedBox(
              width: double.infinity,
              height: 45,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    _updateSeen();
                    return Home();
                  }) );
                },
                color: Colors.red.shade700,
                child: Text(
                  'GET STARTED',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _displayPageViewIndicator(int length) {
    return PageViewIndicator(
      pageIndexNotifier: _pageIndexNotifier,
      length: length,
      normalBuilder: (animationController, index) => Circle(
        size: 8.0,
        color: Colors.grey,
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Circle(
          size: 12.0,
          color: Colors.red,
        ),
      ),
    );
  }

  void _updateSeen () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.setBool('seen', true);

  }
}

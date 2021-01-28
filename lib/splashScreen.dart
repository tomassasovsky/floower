import 'dart:async';
import 'package:floower/main.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 2500), () async {
      bool isLoggedIn = await isUserLoggedIn();
      if (isLoggedIn != null && isLoggedIn)
        setSelectedPosition(0);
      else
        setSelectedPosition(100);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.cyan),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(IconData(0xe900, fontFamily: 'splashIcon'), size: MediaQuery.of(context).size.height * 0.15)
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

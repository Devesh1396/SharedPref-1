import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomeUI.dart';
import 'LoginUI.dart';

class SplashUI extends StatefulWidget {
  @override
  _SplashUIState createState() => _SplashUIState();
}

class _SplashUIState extends State<SplashUI> {

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  void _checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? userSession = prefs.getBool('userSession') ?? false;

    Timer(Duration(seconds: 2), () {
      if (userSession) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeUI()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginUI()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FlutterLogo(
          size: 100,
        ),
      ),
    );
  }
}
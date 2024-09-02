import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_prefs_1/LoginUI.dart';

class HomeUI extends StatefulWidget {
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {

  String? _username;
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs!.getString('username');
    });
  }

  void _logout(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    await prefs!.setBool('userSession', false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginUI()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
            "Home",
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined),
            color: Colors.black,
            onPressed: (){
              _logout(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text(
                'Hello, ${_username ?? 'Guest'}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


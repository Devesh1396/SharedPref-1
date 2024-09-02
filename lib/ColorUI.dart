import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';


class ColorUI extends StatefulWidget {
  @override
  _ColorUIState createState() => _ColorUIState();
}

class _ColorUIState extends State<ColorUI> {

  TextEditingController _nameController = TextEditingController();
  String? _lastSavedName;
  SharedPreferences? prefs;
  List<String> logList = [];
  int appOpenCount = 0;
  Color? backgroundColor;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastSavedName = prefs!.getString('name');
      appOpenCount = prefs?.getInt('appOpenCount') ?? 0;
      logList = prefs?.getStringList('logList') ?? [];

      int? colorValue = prefs?.getInt('backgroundColor');
      if (colorValue != null) {
        backgroundColor = Color(colorValue);
      } else {
        backgroundColor = Colors.white; // Default color
      }

    });
    _logAppOpenTime();
  }

  void _logAppOpenTime() async {
    prefs = await SharedPreferences.getInstance();

    appOpenCount += 1;
    await prefs?.setInt('appOpenCount', appOpenCount);

    if (appOpenCount % 3 == 0) {
      _generateRandomColor();
    }

    String currentTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());

    logList.add('Open: $currentTime');
    await prefs?.setStringList('logList', logList);

    setState(() {
    });
  }

  void _generateRandomColor() {
    final random = Random();
    final color = Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );

    backgroundColor = color;
    prefs?.setInt('backgroundColor', color.value);
  }


  /*
  void _logAppCloseTime() async {
    prefs = await SharedPreferences.getInstance();

    String currentTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    logList[logList.length - 1] += ' | Close: $currentTime';
    await prefs?.setStringList('logList', logList);

    setState(() {
    });
  }
  */

  void _setName() async {
    String name = _nameController.text;
    if (name.isNotEmpty) {
      prefs = await SharedPreferences.getInstance();
      await prefs!.setString('name', name);

      setState(() {
        _lastSavedName = name;
        _nameController.clear();
      });
    }
  }

  @override
  void dispose() {
    //_logAppCloseTime();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Enter your name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _setName,
              child: Text('Save Name'),
            ),
            SizedBox(height: 20),
            if (_lastSavedName != null)
              Text(
                'Your last input name was: $_lastSavedName',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 20),
            Text(
              'No. of times App Open: $appOpenCount',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: logList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text('${index + 1}'),
                    title: Text(logList[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _textFieldController = TextEditingController();

  var homeTemp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(25),
            child: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(
                hintText: 'City',
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              try {
                var url = Uri.parse(
                    'http://api.weatherstack.com/current?access_key=afe27c8314fee09a44128a27988797d5&query=${_textFieldController.text}');

                var response = await http.get(url);

                var objectBody = jsonDecode(response.body);

                var tempCity = objectBody['current']['temperature'];

                if (response.statusCode == 200) {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => WeatherScreen(
                  //       temp: tempCity,
                  //       city: _textFieldController.text,
                  //     ),
                  //   ),
                  // );
                  homeTemp = '$tempCity';

                  setState(() {});
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Error',
                      style: TextStyle(fontSize: 30),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search),
                Container(width: 10),
                Text('Search'),
              ],
            ),
          ),
          Text(homeTemp),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:http_test_run/pages/homepage.dart';
import 'pages/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: ""),
      home: HomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

/*
* 
* {"abbreviation":"EEST","client_ip":"88.112.177.57","datetime":"2021-08-09T10:47:34.675306+03:00","day_of_week":1,"day_of_year":221,"dst":true,"dst_from":"2021-03-28T01:00:00+00:00","dst_offset":3600,"dst_until":"2021-10-31T01:00:00+00:00","raw_offset":7200,"timezone":"Europe/Helsinki","unixtime":1628495254,"utc_datetime":"2021-08-09T07:47:34.675306+00:00","utc_offset":"+03:00","week_number":32}
*/

//Future<String>
Future<InternetTime> callApi() async {
  var url = Uri.parse('http://worldtimeapi.org/api/timezone/Europe/Copenhagen');

  var resp = await http.get(url);

  return InternetTime.fromJson(jsonDecode(resp.body));
}

Future<Map<String, dynamic>> callApiRaw() async {
  var url = Uri.parse('http://worldtimeapi.org/api/timezone/Europe/Stockholm');

  var resp = await http.get(url);

  return jsonDecode(resp.body);
}

class InternetTime {
  final String abbreviation;
  final String clientIp;

  InternetTime({required this.abbreviation, required this.clientIp});

  factory InternetTime.fromJson(Map<String, dynamic> json) {
    return InternetTime(abbreviation: json['abbreviation'], clientIp: json['client_ip']);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<InternetTime> currentTime;

  // raw json result
  late Future<Map<String, dynamic>> jsonTime;

  void _incrementCounter() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    currentTime = callApi();
    jsonTime = callApiRaw();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: jsonTime,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //return Text(snapshot.data!['clientIp']);
              return Text(jsonEncode(snapshot.data!)); //!['client_ip']);

            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

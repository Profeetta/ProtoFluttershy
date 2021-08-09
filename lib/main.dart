import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  @override
  void initState() {
    super.initState();
    currentTime = callApi();
    jsonTime = callApiRaw();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
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

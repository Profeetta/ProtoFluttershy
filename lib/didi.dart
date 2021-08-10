/*import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http.get(
    Uri.parse("https:jsonplaceholder.typicode.com/albums/1"),
  );

  if (response.statusCode == 200) {
    return Album.fromJson(
      jsonDecode(response.body),
    );
  } else {
    throw Exception("Failed to load");
  }
}

class Album {
  final int userID;
  final int id;
  final String title;

  Album({
    required this.id,
    required this.title,
    required this.userID,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json["id"],
      title: json["title"],
      userID: json["userID"],
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Thing",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Didi"),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
*/
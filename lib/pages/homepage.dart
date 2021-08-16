import 'package:flutter/material.dart';

import 'datatable.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final patientInfo = patientInfoFromJson(jsonString);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: DataTableClass(),
      ),
    );
  }
}

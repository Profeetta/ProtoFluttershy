import 'package:flutter/material.dart';
import 'package:http_test_run/pages/homepage.dart';

class DataTableClass extends StatefulWidget {
  const DataTableClass({Key? key}) : super(key: key);

  @override
  _DataTableState createState() => _DataTableState();
}

class _DataTableState extends State<DataTableClass> {
  static const String _title = "Data thingies for doctorthingies";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
        ),
        body: const TheDataTableThing(),
      ),
    );
  }
}

class TheDataTableThing extends StatelessWidget {
  const TheDataTableThing({Key? key}) : super(key: key);

  static const String _age = "20";
  static const String _risk = "1";
  static const String _prio = "3";

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: Text(
            "Age",
            style: TextStyle(
              fontSize: 15,
              color: Colors.blueGrey[900],
            ),
          ),
        ),
        DataColumn(
          label: Text(
            "Risk class",
            style: TextStyle(
              fontSize: 15,
              color: Colors.blueGrey[600],
            ),
          ),
        ),
        DataColumn(
          label: Text(
            "Priority",
            style: TextStyle(
              fontSize: 15,
              color: Colors.blueGrey[900],
            ),
          ),
        ),
      ],
      rows: <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(
              Text("20"),
            ),
            DataCell(
              Text("2"),
            ),
            DataCell(
              Text("1"),
            ),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(
              Text("15"),
            ),
            DataCell(
              Text("2"),
            ),
            DataCell(
              Text("3"),
            ),
          ],
        ),
        DataRow(cells: <DataCell>[
          DataCell(
            Text("24"),
          ),
          DataCell(
            Text("1"),
          ),
          DataCell(
            Text("2"),
          ),
        ])
      ],
    );
  }
}

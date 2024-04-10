import 'package:flutter/material.dart';
import 'package:simple_database_sqflite_app/dbhealper.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowMaterialGrid: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final dbhelper = DatabaseHelper.instance;

  void insertData() async {
    Map<String, dynamic> row = {
      DatabaseHelper.colName: 'Prince',
      DatabaseHelper.colAge: 10,
    };
    final id = await dbhelper.insert(row);
    print(id);
  }

  void queryall() async {
    var allrows = await dbhelper.queryAll();
    allrows.forEach((row) {
      print(row);
    });
  }

  void querySpecific() async {
    var allrows = await dbhelper.querySpecific(18);
    print(allrows);
  }

  void delete() async {
    var id = await dbhelper.deletedata(2);
    print(id);
  }

  void update() async {
    var row = await dbhelper.updateData(4);
    print(row);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Database',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey,
      ),
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  insertData();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.pink),
                ),
                child: const Text('INSERT'),
              ),
              ElevatedButton(
                onPressed: () {
                  queryall();
                  // Perform query operation
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: const Text('QUERY'),
              ),
              ElevatedButton(
                onPressed: () {
                  querySpecific();
                  // Perform specific query operation
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: const Text('SPECIFIC QUERY'),
              ),
              ElevatedButton(
                onPressed: () {
                  update();
                  // Perform update operation
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange),
                ),
                child: const Text('UPDATE'),
              ),
              ElevatedButton(
                onPressed: () {
                  delete();
                  // Perform delete operation
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: const Text('DELETE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:studyng/pages/home_page.dart';
import 'package:studyng/model/todo_adapter.dart';

Future<List<Box>> _openBox() async {
  List<Box> boxList = [];
  Box<Todo> boxTodo = await Hive.openBox('todos');
  Box<Revenue> boxRevenue = await Hive.openBox('revenue');
  boxList.add(boxTodo);
  boxList.add(boxRevenue);
  return boxList;
}

void main() async {
  // Provider.debugCheckInvalidValueType = null;

  Hive
    ..registerAdapter(TodoAdapter())
    ..registerAdapter(RevenueAdapter());
  await Hive.initFlutter();

  // await Hive.openBox<Todo>('todos');
  // await Hive.openBox<Revenue>(name);

  await _openBox();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

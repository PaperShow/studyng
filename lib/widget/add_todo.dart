import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studyng/model/todo_adapter.dart';

class AddTodo extends StatefulWidget {
  AddTodo({Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  var title;
  var description;
  final _formkey = GlobalKey<FormState>();

  submitData() async {
    if (_formkey.currentState!.validate()) {
      Box<Todo> todoBox = Hive.box<Todo>('todos');
      todoBox.add(Todo(title: title, description: description));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: ListView(
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: InputDecoration(hintText: 'Title'),
            onChanged: (value) {
              setState(() {
                title = value;
              });
            },
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: InputDecoration(hintText: 'description'),
            onChanged: (value) {
              setState(() {
                description = value;
              });
            },
          ),
          ElevatedButton(
              onPressed: () {
                submitData();
              },
              child: Text('Save'))
        ],
      ),
    );
  }
}

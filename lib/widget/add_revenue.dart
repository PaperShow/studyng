import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studyng/model/todo_adapter.dart';

class AddRevenue extends StatefulWidget {
  AddRevenue({
    Key? key,
  }) : super(key: key);
  bool isPressed = false;

  @override
  State<AddRevenue> createState() => _AddRevenueState();
}

class _AddRevenueState extends State<AddRevenue> {
  var expense;
  var income;
  var transactiontype = false;
  late DateTime currentTime;
  String title = '';
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    setState(() {
      currentTime = DateTime.now();
    });
    print(currentTime);
  }

  submitData() async {
    if (_formkey.currentState!.validate()) {
      Box<Revenue> revenueBox = Hive.box<Revenue>('revenue');
      revenueBox.add(Revenue(
          income: income,
          transactiontype: transactiontype,
          expense: expense,
          dateTime: currentTime,
          title: title));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Expense'),
              Switch(
                value: transactiontype,
                onChanged: (bool newValue) {
                  setState(() {
                    transactiontype = newValue;
                  });
                },
              ),
              Text('Income'),
            ],
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: InputDecoration(hintText: 'title'),
            onChanged: (value) {
              setState(() {
                title = value;
              });
            },
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: InputDecoration(hintText: 'Value'),
            onChanged: (value) {
              setState(() {
                transactiontype ? income = value : expense = value;
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

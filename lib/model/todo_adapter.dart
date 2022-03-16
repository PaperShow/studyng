import 'package:hive/hive.dart';

part 'todo_adapter.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? description;

  Todo({this.description, this.title});
}

@HiveType(typeId: 1)
class Revenue extends HiveObject {
  @HiveField(0)
  var income;

  @HiveField(1)
  var expense;

  @HiveField(2)
  var title;

  @HiveField(3)
  var transactiontype;

  @HiveField(4)
  var dateTime;

  Revenue(
      {this.transactiontype,
      this.expense,
      this.income,
      this.title,
      this.dateTime});
}

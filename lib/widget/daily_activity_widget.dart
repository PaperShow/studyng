import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:studyng/model/todo_adapter.dart';
import 'package:studyng/widget/add_todo.dart';

class DailyActivityWidget extends StatefulWidget {
  const DailyActivityWidget({Key? key}) : super(key: key);

  @override
  _DailyActivityWidgetState createState() => _DailyActivityWidgetState();
}

class _DailyActivityWidgetState extends State<DailyActivityWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.58,
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.pink.shade100),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 10),
              Container(
                  color: Colors.amber,
                  child: Icon(
                    Icons.timelapse,
                    color: Colors.white,
                    size: 18,
                  )),
              Text(
                'Today\'s Schedule',
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return AddTodo();
                      });
                },
                child: Text(
                  'Add',
                  style: TextStyle(
                      color: Colors.purple, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          ValueListenableBuilder(
            valueListenable: Hive.box<Todo>('todos').listenable(),
            builder: (context, Box<Todo> box, _) {
              if (box.values.isEmpty) {
                return Container(
                  height: size.height * 0.15,
                  width: size.width * 0.5,
                  color: Colors.white,
                  child: Center(
                    child: Text('Do not available!'),
                  ),
                );
              }
              return CarouselSlider.builder(
                itemCount: box.length,
                options: CarouselOptions(
                    enableInfiniteScroll: false, enlargeCenterPage: true),
                itemBuilder: (context, index, pageindex) {
                  Todo? todo = box.getAt(pageindex);
                  return InkWell(
                    onLongPress: () async {
                      await box.deleteAt(pageindex);
                      setState(() {});
                    },
                    child: Container(
                      height: size.height * 0.18,
                      width: size.width * 0.5,
                      padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            todo!.title as String,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          Text(
                            todo.description as String,
                            style:
                                TextStyle(fontSize: 15, color: Colors.black38),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}

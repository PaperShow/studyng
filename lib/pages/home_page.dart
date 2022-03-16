import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:studyng/widget/daily_activity_widget.dart';
import 'package:studyng/pages/note_page.dart';
import 'package:studyng/widget/revenue_wallet.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var count = 1;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffe7dcc0),
      drawer: Container(
        margin: EdgeInsets.all(20),
        width: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Drawer(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.amber,
                    maxRadius: 40,
                  ),
                  Container(
                    height: size.height * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('DashBoard'),
                        Text('News'),
                        Text('Notes'),
                        Text('Calender'),
                        Text('Portal'),
                        Text('Finanace'),
                        Text('Contact'),
                        Text('Notifications'),
                        Text('Log Out'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          // alignment: AlignmentDirectional.topStart,
          children: [
            Container(
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'studyng',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.amber,
                          radius: 26,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi Ashukash',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Good Morning!',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 10),
                    height: size.height / 7,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blueGrey.shade100,
                              offset: Offset(2, 2),
                              blurRadius: 10)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DailyWidget(
                              icon: Icons.notes,
                              title: 'Notes',
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NotePage()));
                              },
                            ),
                            DailyWidget(
                              icon: Icons.assessment,
                              title: 'Assignment',
                            ),
                            DailyWidget(
                              icon: Icons.payment,
                              title: 'Payment',
                            ),
                            DailyWidget(
                              icon: Icons.calendar_today,
                              title: 'Presence',
                              press: () {},
                            )
                          ],
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 45,
                            height: 4.5,
                            color: Colors.grey.withOpacity(0.57),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: size.height * 0.22,
                    child: Row(
                      children: [
                        DailyActivityWidget(),
                        RevenueWallet(),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: size.height * 0.25,
                      child: Row(
                        children: [
                          Container(
                            width: size.width * 0.56,
                            margin: EdgeInsets.only(left: 20, top: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.amber.shade50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DailyWidget extends StatelessWidget {
  DailyWidget({this.title, this.icon, this.press});
  final title;
  final icon;
  final press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        child: Column(
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(10)),
              child: Icon(icon),
            ),
            SizedBox(height: 5),
            Text(title)
          ],
        ),
      ),
    );
  }
}


// Container(
//                                 margin: EdgeInsets.only(top: 10, bottom: 10),
//                                 padding: EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: Colors.white),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Object Oriented Programming ${index + 1}',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 14),
//                                     ),
//                                     Text(
//                                       '08:30 - 10:30',
//                                       style: TextStyle(
//                                           color: Colors.grey.shade500,
//                                           letterSpacing: 1,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     Text('Code Vode Course')
//                                   ],
//                                 ),
//                               );

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:studyng/model/todo_adapter.dart';
import 'package:studyng/widget/add_revenue.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return SizedBox(
                  height: size.height,
                  child: AlertDialog(
                    title: Text('Add your Expenses'),
                    content: SizedBox(
                      height: size.height / 3,
                      width: size.width,
                      child: AddRevenue(
                        key: key,
                      ),
                    ),
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: Hive.box<Revenue>('revenue').listenable(),
                builder: (context, Box<Revenue> box, _) {
                  int totalIncome = 0;
                  int totalExpense = 0;
                  for (var i = 0; i < box.length; i++) {
                    totalIncome = totalIncome +
                        int.parse(box.getAt(i)!.transactiontype
                            ? box.getAt(i)!.income.toString()
                            : '0');
                    totalExpense = totalExpense +
                        int.parse(box.getAt(i)!.transactiontype
                            ? '0'
                            : box.getAt(i)!.expense.toString());
                    // print(box.getAt(i)!.expense);

                  }
                  print(totalIncome);
                  print(totalExpense);

                  if (box.values.isEmpty) {
                    return Column(
                      children: [
                        WalletCard(
                            size: size,
                            totalIncome: totalIncome,
                            totalExpense: totalExpense),
                        SizedBox(height: 150),
                        Text(
                          'No any data added',
                          style: TextStyle(
                              color: Colors.black26,
                              fontSize: 25,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold),
                        ),
                        // SizedBox(height: 100),
                        Text(
                          'Press + button to add',
                          style: TextStyle(
                              color: Colors.black26,
                              fontSize: 18,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    );
                  }

                  return Column(
                    children: [
                      WalletCard(
                          size: size,
                          totalIncome: totalIncome,
                          totalExpense: totalExpense),
                      SizedBox(
                        height: size.height * 0.78,
                        width: size.width,
                        child: ListView.builder(
                            itemCount: box.length,
                            itemBuilder: (context, index) {
                              Revenue? revenue = box.getAt(index);
                              return InkWell(
                                onLongPress: () async {
                                  await box.deleteAt(index);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(20),
                                  padding: EdgeInsets.all(20),
                                  height: 100,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        // BoxShadow(
                                        //     color: Colors.lightBlue,
                                        //     offset: Offset(1, 1),
                                        //     blurRadius: 3)
                                      ]),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.orange,
                                            child: Text('₹',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18)),
                                          ),
                                          SizedBox(width: 20),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(revenue!.title!,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 21)),
                                              Text(
                                                  revenue.dateTime != null
                                                      ? DateFormat.yMMMd()
                                                          .add_jm()
                                                          .format(
                                                              revenue.dateTime)
                                                          .toString()
                                                      : '',
                                                  style: TextStyle(
                                                      color: Colors.white54,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 12)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Text(
                                          revenue.transactiontype == true
                                              ? '+ ₹ ' +
                                                  revenue.income.toString()
                                              : '- ₹ ' +
                                                  revenue.expense.toString(),
                                          style: TextStyle(
                                              color: revenue.transactiontype ==
                                                      true
                                                  ? Colors.white
                                                  : Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 21)),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WalletCard extends StatelessWidget {
  const WalletCard({
    Key? key,
    required this.size,
    required this.totalIncome,
    required this.totalExpense,
  }) : super(key: key);

  final Size size;
  final int totalIncome;
  final int totalExpense;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.22,
      width: size.width,
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade400,
                offset: Offset(1, 1),
                blurRadius: 20)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            'W A L L E T',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Colors.black54),
          )),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Income',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '+ ₹ ' + totalIncome.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.green.shade800,
                        fontSize: 21),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Expense',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '- ₹ ' + totalExpense.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.red,
                        fontSize: 21),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

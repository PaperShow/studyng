import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:studyng/model/todo_adapter.dart';
import 'package:studyng/pages/wallet_page.dart';

class RevenueWallet extends StatelessWidget {
  const RevenueWallet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WalletPage()));
      },
      child: ValueListenableBuilder(
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
            }

            return Container(
              width: size.width * 0.26,
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.pink),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.details,
                          color: Colors.amber,
                        ),
                        Text(
                          'SKS',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.amber,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Container(
                      height: 35,
                      width: 35,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            value: 3 / 4,
                            color: Colors.yellow,
                            strokeWidth: 5,
                          ),
                          Center(
                            child: Text('75%',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Income - ₹' + totalIncome.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Expense - ₹' + totalExpense.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

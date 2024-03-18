import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:wallet2/model/total_balance.dart';

class MyBalance extends StatefulWidget {
  MyBalance({super.key});

  @override
  State<MyBalance> createState() => _MyBalanceState();
}

class _MyBalanceState extends State<MyBalance> {
  late Future<TotalBalance> futureBalance;

  @override
  void initState() {
    super.initState();
    futureBalance = fetchBalance();
  }

  Future<TotalBalance> fetchBalance() async {
    final response = await http.get(Uri.parse(
        "https://crypto-wallet-server.mock.beeceptor.com/api/v1/balance"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return TotalBalance(
        balance: data['balance'].toString(),
        currency: data['currency'],
      );
    } else {
      throw Exception('Failed to load balance');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchBalance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return  SizedBox(
            height: 30.h,
            width: 40.w,
            child: const CircularProgressIndicator()
          );
        }
        if (snapshot.hasData) {
          final balances = snapshot.data;
          final balance = balances!.balance.toString();
          final currency = balances.currency;
          return Padding(
            padding:  EdgeInsets.all(14.w.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your current balance is",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp
                  ), 
                  
                  ),
                Row(
                  children: [Text(
                    '₦ ${balance}\n $currency ',
                    style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold),
                    )],
                ),
              ],
            ),
          );
        }
        return Text(
          "You brokeee",
          style: TextStyle(fontSize: 30.sp),
        );
      },
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet2/model/transaction.dart';
import 'package:http/http.dart' as http;

class TransactionList extends StatefulWidget {
  TransactionList({Key? key}) : super(key: key);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  late List<Transactions> transactions;

  @override
  void initState() {
    super.initState();
    transactions = [];
    getTransactions();
  }

  Future<void> getTransactions() async {
    final url =
        "https://crypto-wallet-server.mock.beeceptor.com/api/v1/transactions";
    final apiUrl = Uri.parse(url);
    final response = await http.get(apiUrl);
    final decode = json.decode(response.body);
    print(response.body);
    List<Transactions> fetchedTransactions = [];
    for (final data in decode['transactions']) {
      DateTime? timestamp;
      try {
        timestamp = DateTime.parse(decode['timestamp']);
      } catch (e) {
        print("Error parsing timestamp: $e");
      }
      final myTransaction = Transactions(
        id: data['id'] ?? "",
        fromWallet: data['fromWallet'] ?? "",
        type: data['type'] ?? "",
        amount: data['amount'] ?? "",
        currency: data['currency'] ?? "",
        timestamp: timestamp ?? DateTime.now(),
      );
      fetchedTransactions.add(myTransaction);
    }
    setState(() {
      transactions = fetchedTransactions;
    });
   
  }
 
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final currentTransaction = transactions[index];
                return ListTile(
                  leading: Icon(
                    currentTransaction.type == 'credit'
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    color: currentTransaction.type == 'credit'
                        ? Colors.green
                        : Colors.red,
                  ),
                  title: Text(
                    currentTransaction.id,
                    style: TextStyle(fontSize: 18.sp,),
                    ),
                  subtitle: Text(
                    '${currentTransaction.amount} ${currentTransaction.currency}',
                  ),
                  trailing: Text(
                    '${currentTransaction.timestamp}',
                    style:  TextStyle(fontSize: 12.sp),
                  ),
                );
              },
            ),
          );
  }
}

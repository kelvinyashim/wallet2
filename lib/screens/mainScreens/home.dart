import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet2/widgets/utils/balance.dart';
import 'package:wallet2/widgets/utils/list_transactions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key, required this.accessToken, required this.username});
  final String accessToken;
  final String username;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 10, 67, 1),
      body: Padding(
        padding:  EdgeInsets.only(top: 25.h),
        child: Stack(clipBehavior: Clip.hardEdge, children: [
          SafeArea(
            child: SizedBox(
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin:  EdgeInsets.all(10.w.h),
                          width: 50.w,
                          height: 50.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(50.r)),
                          padding:  EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 5.h),
                          child: const Icon(
                            Icons.align_horizontal_left,
                            color: Color.fromRGBO(255, 46, 99, 100),
                          ),
                        ),
                        Text(
                          "Hello, ${widget.username}",
                          style: TextStyle(fontSize: 24.sp, color: Colors.white),
                        ),
                        SizedBox(
                          width: 40.w,
                        ),
                        Container(
                          padding:  EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 8.h),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(33, 42, 107, 1),
                              border:
                                  Border.all(width: 1.w, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(20)),
                          child:const Text(
                            "Add money",
                            style:
                                TextStyle(color: Color.fromRGBO(66, 109, 220, 1)),
                          ),
                        ),
                      ]),
                  MyBalance(),
                  SizedBox(
                    height: 18.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 22.w, vertical: 14.h),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.w, style: BorderStyle.solid, color: Color.fromRGBO(70, 78, 138, 1)),
                          
                        ),
                        child: const Text("Request Money",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:  Color.fromRGBO(70, 78, 138, 1)
                        ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 22.w, vertical: 14.h),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.w, style: BorderStyle.solid, color:  Color.fromRGBO(70, 78, 138, 1)),
                        ),
                        child: const  Text("Send Money",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:  Color.fromRGBO(70, 78, 138, 1)
                        ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [],
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    width: double.infinity,
                    height: 550.h,
                    decoration:  BoxDecoration(
                        color: Color.fromRGBO(16, 25, 78, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.r),
                            topRight: Radius.circular(30.r))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.horizontal_rule_outlined,
                            size: 60, color: Color.fromRGBO(78, 88, 159, 1)),
                        Container(
                          padding: EdgeInsets.only(left: 20.w),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  'All transactions',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 6.w),
                                child: Text("sort by: " "Recent",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 5.w),
                                child:const Icon(
                                  Icons.arrow_downward,
                                  color: Color.fromRGBO(221, 217, 217, 1),
                                ),
                              )
                            ],
                          ),
                        ),
                        TransactionList()
                      ],
                    ),
                  ),
                ],
              ))
        ]),
      ),
    );
  }
}

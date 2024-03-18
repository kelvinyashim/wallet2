import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wallet2/screens/auth/form.dart';
import 'package:wallet2/screens/splash1.dart';
import 'package:wallet2/screens/splash2.dart';

class MainSplash extends StatefulWidget {
  const MainSplash({super.key});

  @override
  State<MainSplash> createState() => _MainSplashState();
}

class _MainSplashState extends State<MainSplash> {
  final pages = const [Splash1(), Splash2()];
  final _controller = PageController();
  bool isLastpage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (value) {
              setState(() {
                isLastpage = (value == 1);
              });
            },
            controller: _controller,
            children: pages,
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Column(
              children: [
                isLastpage
                    ? Container(
                        decoration:  BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(30.r)),
                          color: Colors.white,
                        ),
                        width: 323.w,
                        height: 224.h,
                        child: Padding(
                          padding:  EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 5.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmoothPageIndicator(
                                effect: const WormEffect(
                                  activeDotColor: Colors.amber,
                                  dotColor: Colors.grey,
                                ),
                                controller: _controller,
                                count: 2,
                              ),
                               SizedBox(
                                height: 10.h,
                              ),
                               Text(
                                "Transfer Money with Ease",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color:const Color.fromRGBO(28, 38, 92, 1),
                                    fontWeight: FontWeight.bold),
                              ),
                               SizedBox(
                                height: 10.h,
                              ),
                               Text(
                                "Making money is hard enough,we make transferring it easy enough ",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Color.fromRGBO(40, 52, 112, 1)),
                              ),
                               SizedBox(
                                height: 10.h,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Forms(),
                                      ));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(28, 38, 92, 1),
                                ),
                                child:  Text(
                                  "Start Banking",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(
                        decoration:  BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(30.r)),
                          color: Color.fromRGBO(23, 40, 142, 1),
                        ),
                        width: 350.w,
                        height: 222.h,
                        child: Padding(
                          padding:  EdgeInsets.symmetric(
                              horizontal: 20.0.w, vertical: 16.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmoothPageIndicator(
                                effect: const WormEffect(
                                  activeDotColor: Colors.amber,
                                  dotColor: Colors.grey,
                                ),
                                controller: _controller,
                                count: 2,
                              ),
                               SizedBox(
                                height: 10.h,
                              ),
                               Text(
                                "Transfer that is safe",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                               SizedBox(
                                height: 10.h,
                              ),
                               Text(
                                "You have nothing to be scared about, we got you covered ",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                ),
                              ),
                               SizedBox(
                                height: 10.h,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => const Forms(),
                                    ));
                                  },
                                  child: const Text("Start Banking"))
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

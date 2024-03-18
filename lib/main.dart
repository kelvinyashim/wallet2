import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet2/screens/main_splash.dart';
import 'package:wallet2/screens/splash1.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(16, 25, 78, 1))
);
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:const Size(411,890),
      child: MaterialApp(
        theme: theme,
        home: MainSplash(),
      ),
    );
  }
}

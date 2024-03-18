import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:wallet2/screens/mainScreens/home.dart';

class Forms extends StatefulWidget {
  const Forms({Key? key}) : super(key: key);

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  final formKey = GlobalKey<FormState>();
  var isLogin = true;
  var enteredName = "";
  var enteredEmail = "";
  var enteredPsw = "";
  bool isAuth = false;
  String? error;
  void signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    const apiUrl = "https://crypto-wallet-server.mock.beeceptor.com/api/v1/";
    final endpoint = isLogin ? "login" : "register";

    final url = Uri.parse('$apiUrl$endpoint');
    final body = isLogin
        ? json.encode({
            "username": enteredName,
            "password": enteredPsw,
          })
        : json.encode({
            "username": enteredName,
            "email": enteredEmail,
            "password": enteredPsw,
          });

    try {
      setState(() {
        isAuth = true;
      });
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'}, body: body);
      print(response.body);
      if (response.statusCode == 200) {
        final decode = jsonDecode(response.body);
        final accessToken = decode['access_token'] ?? "";
        final username =
            decode['username'] ?? ""; // Extract username from response

        if (isLogin) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                HomeScreen(accessToken: accessToken, username: username),
          ));
        } else {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Registered Successfully"),
            duration: Duration(milliseconds: 30),
          ));
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                HomeScreen(accessToken: accessToken, username: username),
          ));
        }
      } else {
        setState(() {
          isAuth = false;
        });
        final responseJson = jsonDecode(response.body);
        final errorMessage = responseJson['message'] ?? 'Something went wrong';
        setState(() {
          error = errorMessage;
        });
      }
    } catch (e) {
      setState(() {
        error = 'An error occurred. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return 
      AlertDialog(
        shape: CircleBorder(),
        alignment: Alignment.bottomCenter,
        elevation: 2.0,
        icon: Icon(Icons.error_outline),
        title:const Text("Error",
        style: TextStyle(
          color: Colors.white
        ), 
        ),
        backgroundColor:const Color.fromRGBO(16, 25, 78, 1) ,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Text(
              error!,
              style: TextStyle(
                color: Colors.white70
              ),
              )),
              SizedBox(height: 100.h,),
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("Okay")),
          ],
        ),
      );
    }
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context)
                      .colorScheme
                      .onPrimaryContainer
                      .withOpacity(0.9),
                  Theme.of(context).colorScheme.outline.withOpacity(0.3)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
              child: Text(
                isLogin ? "Welcome back \nMissed you" : "Hello\nSign Up",
                textAlign: TextAlign.left,
                style: GoogleFonts.amethysta(
                  color: Colors.white,
                  textStyle:  TextStyle(
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2.w,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Container(
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.r),
                      topRight: Radius.circular(32.r),
                    ),
                  ),
                  width: double.infinity,
                  height: 650.h,
                  padding:  EdgeInsets.all(30.r),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Center(
                          child: Icon(
                            Icons.person_outline_outlined,
                            size: 80.sp,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                         SizedBox(height: 30.h),
                        TextFormField(
                          onSaved: (newValue) {
                            enteredName = newValue!;
                          },
                          decoration: const InputDecoration(
                            hintText: "Name",
                            errorBorder: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().length < 5) {
                              return "Must be above 5 characters";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.sentences,
                          autocorrect: true,
                          enableSuggestions: true,
                        ),
                         SizedBox(height: 20.h),
                        if (!isLogin)
                          TextFormField(
                            onSaved: (newValue) {
                              enteredEmail = newValue!;
                            },
                            decoration: const InputDecoration(
                              hintText: "Email",
                              errorBorder: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains('@')) {
                                return "Invalid email";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                          ),
                         SizedBox(height: 20.h),
                        TextFormField(
                          onSaved: (newValue) {
                            enteredPsw = newValue!;
                          },
                          decoration: const InputDecoration(
                            hintText: "Password",
                            errorBorder: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().length < 8) {
                              return "8 - 15 characters";
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                         SizedBox(height: 20.h),
                        if (isAuth) const CircularProgressIndicator(),
                        if (!isAuth)
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: signUp,
                              child: Text(isLogin ? "Log in" : "Sign Up"),
                            ),
                          ),
                        if (!isAuth)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isLogin = !isLogin;
                              });
                            },
                            child: Text(
                              isLogin
                                  ? "Don't have an account?  Sign Up"
                                  : "Already have an account? Log in ",
                            ),
                          ),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  
  void initState() {
    Timer(
        Duration(seconds: 4),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Loginpage())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            
            Colors.redAccent,
            Colors.amber,
            Colors.blue,
            Colors.red,
            Colors.green
          ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'E-Commerce App',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
        );
  }
}

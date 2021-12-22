

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



void main()async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: Size(375,812),
      builder:(){
       return MaterialApp(
         debugShowCheckedModeBanner: false,
           title: 'EommerceApp-KM ',
           theme: ThemeData(
             primarySwatch: Colors.blue,
           ),
           home: homepage(),
       );
      }
      
    );
      
    
    
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_application_2/page/add.dart';
import 'package:flutter_application_2/page/homepage.dart';
import 'package:flutter_application_2/page/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class navigation extends StatefulWidget {
  const navigation({ Key? key }) : super(key: key);

  @override
  _navigationState createState() => _navigationState();
}

class _navigationState extends State<navigation> {
  @override
  var _page = 0;
  final Page = [
    Home(),
    add(),
    profile(),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
       bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.pink,
          items: [
          ListTile(
            title: Icon(Icons.home_filled),
            subtitle: Center(child: Text('Home')),
          ),
          ListTile(
            title: Icon(Icons.add),
            subtitle: Center(child: Text('Add')),
          ),
          ListTile(
            title: Icon(Icons.person),
            subtitle: Center(child: Text('Person')),
          ),
        ],
       onTap: (index){
          setState(() {
            _page = index;
          });
       },
        ),
      body: Page[_page],
    );
  }
}
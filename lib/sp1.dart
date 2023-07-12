import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sp extends StatelessWidget {
  const Sp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Child1(),
    );
  }
}
class Child1 extends StatefulWidget {
  const Child1({Key? key}) : super(key: key);

  @override
  State<Child1> createState() => _Child1State();
}

class _Child1State extends State<Child1> {
   SharedPreferences? s_prefs;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
   initvalue();

  }
  Future<void> initvalue() async {
    s_prefs = await SharedPreferences.getInstance();
  }

  String temp = "";



//   _ setState(() {
//
//   });
// }showSavedValue() async {



  @override
  Widget build(BuildContext context) {
    temp=s_prefs!.getString("KEY_1")!;
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(temp),


                ]
            )),
      ),
    );
  }


}



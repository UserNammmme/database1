import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'imagepicker.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs =await SharedPreferences.getInstance();
  var email=prefs.getString("email");
  print(email);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: email==null?Login():Home5(),));
}
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  var userctrler=TextEditingController();
  var pwdctrlr=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: userctrler,
            ),
            TextFormField(
              controller:pwdctrlr,
            ),

            ElevatedButton(
              onPressed: () async {
                SharedPreferences pref =await SharedPreferences.getInstance();
                pref.setString("email", userctrler.text.toString());
                pref.setString("password", pwdctrlr.text.toString());

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                  return  Home5();
                }));
              },
              child: const Text("Login",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
class Home5 extends StatefulWidget {
  const Home5({Key? key}) : super(key: key);

  @override
  State<Home5> createState() => _Home5State();
}

class _Home5State extends State<Home5> {
  var s,s2;
  Future<void> getdata()  async {
    var _pref= await SharedPreferences.getInstance();
    setState(() {
    s =  _pref.getString("email");
    s2=_pref.getString("password");
  });
  }
  @override
  Widget build(BuildContext context) {
  getdata();
    return Scaffold(
      appBar: AppBar(title: Text("Home"),),
      body: Center(
        child: Column(
          children: [
            Text(s.toString()), Text(s2.toString()),
            ElevatedButton(
              onPressed: () async {
                var _pref= await SharedPreferences.getInstance();
                print(_pref.getString("email"));
                _pref.remove("email");
                _pref.remove("password");

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                  return Login();
                }));
              },
              child: Text("Logout",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}



 





// import 'package:database/sp1.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//             appBar: AppBar(
//               title: const Text("Shared Preferences in Flutter"),
//             ),
//             body: Center(child: Child())));
//   }
// }
//
// class Child extends StatefulWidget {
//   Home createState() => Home();
// }
//
// class Home extends State<Child> {
//   TextEditingController T_controller = new TextEditingController();
//
//   late SharedPreferences s_prefs;
//
//   String temp = '';
//
//   _saveToShared_Preferences() async {
//     s_prefs = await SharedPreferences.getInstance();
//     s_prefs.setString("KEY_1", T_controller.text.toString());
//   }
//
//   _showSavedValue() async {
//     s_prefs = await SharedPreferences.getInstance();
//     setState(() {
//       temp = s_prefs.getString("KEY_1").toString();
//     });
//   }
//
//   _delete_Shared_Preferences() async {
//     s_prefs = await SharedPreferences.getInstance();
//     s_prefs.remove("KEY_1");
//     setState(() {
//       temp = " ";
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body:
//         SafeArea(
//             top: true,
//             child: Center(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                       padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                       margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
//                       child: TextField(
//                           controller: T_controller,
//                           decoration: const InputDecoration(
//                             labelText: 'Enter Text Here....',
//                             border: OutlineInputBorder(),
//                           ))),
//                   Container(
//                       margin: const EdgeInsets.fromLTRB(10, 15, 0, 0),
//                       child: ElevatedButton(
//                         child: const Text('Store Value in Shared Preferences'),
//                         onPressed: ()  => _saveToShared_Preferences(),
//                         // onPressed: () {
//                         //   Navigator.push(
//                         //     context,
//                         //     MaterialPageRoute(builder: (context) => NextPage()),
//                         //   );
//                         // },
//                         style: ElevatedButton.styleFrom(
//                           primary: Colors.green,
//                         ),
//                       )),
//                   Container(
//                       margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
//                       child: ElevatedButton(
//                           child: const Text(
//                               'Display Value Stored in Shared Preferences'),
//                           onPressed: () {
//                             Navigator.push(context,
//                               MaterialPageRoute(builder: (context) => Sp()),
//                             );
//
//
//                           }
//
//
//                       )),
//                   Container(
//                       margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
//                       child: ElevatedButton(
//                         child: const Text(
//                             'Delete Value Stored in Shared Preferences'),
//                         onPressed: () => _delete_Shared_Preferences(),
//                         style: ElevatedButton.styleFrom(
//                           primary: Colors.green,
//                         ),
//                       )),
//                   Container(
//                       margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
//                       child: Text(
//                         '${temp.toString()}',
//                         style:
//                         const TextStyle(fontSize: 25, color: Colors.black),
//                         textAlign: TextAlign.center,
//                       ))
//                 ],
//               ),
//             )));
//   }
// }
// //// Copyright 2013 The Flutter Authors. All rights reserved.
// // // Use of this source code is governed by a BSD-style license that can be
// // // found in the LICENSE file.
// //
// // // ignore_for_file: public_member_api_docs
// //
// // import 'dart:async';
// //
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // void main() {
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return const MaterialApp(
// //       title: 'SharedPreferences Demo',
// //       home: SharedPreferencesDemo(),
// //     );
// //   }
// // }
// //
// // class SharedPreferencesDemo extends StatefulWidget {
// //   const SharedPreferencesDemo({super.key});
// //
// //   @override
// //   SharedPreferencesDemoState createState() => SharedPreferencesDemoState();
// // }
// //
// // class SharedPreferencesDemoState extends State<SharedPreferencesDemo> {
// //   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
// //   late Future<int> _counter;
// //
// //   Future<void> _incrementCounter() async {
// //     final SharedPreferences prefs = await _prefs;
// //     final int counter = (prefs.getInt('counter') ?? 0) + 1;
// //
// //     setState(() {
// //       _counter = prefs.setInt('counter', counter).then((bool success) {
// //         return counter;
// //       });
// //     });
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _counter = _prefs.then((SharedPreferences prefs) {
// //       return prefs.getInt('counter') ?? 0;
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('SharedPreferences Demo'),
// //       ),
// //       body: Center(
// //           child: FutureBuilder<int>(
// //               future: _counter,
// //               builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
// //                 switch (snapshot.connectionState) {
// //                   case ConnectionState.none:
// //                   case ConnectionState.waiting:
// //                     return const CircularProgressIndicator();
// //                   case ConnectionState.active:
// //                   case ConnectionState.done:
// //                     if (snapshot.hasError) {
// //                       return Text('Error: ${snapshot.error}');
// //                     } else {
// //                       return Text(
// //                         'Button tapped ${snapshot.data} time${snapshot.data == 1 ? '' : 's'}.\n\n'
// //                         'This should persist across restarts.',
// //                       );
// //                     }
// //                 }
// //               })),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: _incrementCounter,
// //         tooltip: 'Increment',
// //         child: const Icon(Icons.add),
// //       ),
// //     );
// //   }
// // }
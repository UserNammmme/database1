import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dbmanager.dart';
import 'dart:async';

import 'grouplist.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboarddemo(),
    );
  }
}
class Dashboarddemo extends StatefulWidget {
  const Dashboarddemo({Key? key}) : super(key: key);

  @override
  State<Dashboarddemo> createState() => _DashboarddemoState();
}

class _DashboarddemoState extends State<Dashboarddemo> {
  final DBBloodManager dbBloodManager = DBBloodManager();
  final _nameController = TextEditingController();
  final _bloodgroupController = TextEditingController();

  //to validate text form field  we need to add this  key and wrap parent
  // widget with Form widget and provide this key to it
  final _formkey = GlobalKey<FormState>();
 late Blood st;
  Blood? blood;
  late int updateindex;

  late List<Blood> bloodlist;
  showAlertDialogdelete({required BuildContext context, required Blood st}) {
    //define ctrler
    var namectrlr=TextEditingController();
    var grpctrlr=TextEditingController();
    namectrlr.text=st.name;
    grpctrlr.text=st.bloodgroup;



    // set up the AlertDialog


    // AlertDialog alert = AlertDialog(
    //   title: Text("Edit"),
    //   content:Column(children: [
    //     Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: TextFormField(
    //         controller: namectrlr,
    //         decoration: InputDecoration(
    //           border: OutlineInputBorder(),
    //         ),
    //       ),
    //     ),Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: TextFormField(
    //         controller: grpctrlr,
    //         decoration: InputDecoration(
    //             border: OutlineInputBorder()
    //         ),
    //       ),
    //     )
    //   ],),
    //   actions: [
    //     continueButton,
    //   ],
    // );

    // show the dialog

  }
  showAlertDialog({required BuildContext context, required Blood st}) {
    //define ctrler
    var namectrlr=TextEditingController();
    var grpctrlr=TextEditingController();
    namectrlr.text=st.name;
    grpctrlr.text=st.bloodgroup;

    Widget continueButton = TextButton(
      child: Text("update"),
      onPressed:  () {
       Blood b=Blood(id:st.id,name: namectrlr.text, bloodgroup: grpctrlr.text);
        dbBloodManager.updateBlood(b);
      },
    );
    Widget dltbtn = TextButton(
      child: Text("YES"),
      onPressed: () {
        dbBloodManager.deleteBlood(st.id);
      },
    );

    // set up the AlertDialog
    AlertDialog alert1 = AlertDialog(
      title: Text("Delete"),
      content: Text("Do you want to delete?"),
      actions: [
        dltbtn,
      ],
    );

    AlertDialog alert = AlertDialog(
      title: Text("Edit"),
      content:Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: namectrlr,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: grpctrlr,
            decoration: InputDecoration(
                border: OutlineInputBorder()
            ),
          ),
        )
      ],),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Blood record"),
      ),
      body:
      ListView(
          children: <Widget>[
            FutureBuilder(
              future: dbBloodManager.getBloodList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  bloodlist = snapshot.data as List<Blood>;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: bloodlist == null ? 0 : bloodlist.length,
                    itemBuilder: (BuildContext context, int index) {
                  st = bloodlist[index];
                      return Card(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SizedBox(
                                width: width * 0.50,
                                child: Column(
                                  children: <Widget>[
                                    Text('ID: ${st.id}'),
                                    Text('Name: ${st.name}'),

                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showAlertDialog(context: context, st: st);
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: () {


                                showDialog (
                                  context: context,
                                  barrierDismissible: false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Delete'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: const  [
                                            Text('Do you want to delete?'),
                                          ],
                                        ),
                                      ),
                                      actions:  [
                                        TextButton(
                                          child: const Text('Delete'),
                                          onPressed: () {
                                            dbBloodManager.deleteBlood(st.id);
                                             Navigator.of(context).pop();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => const Dashboard()),
                                            );


                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );


                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return CircularProgressIndicator();
              },
            )
    ]
    ),
    );
  }
  void submitBlood(BuildContext context) {

    if (_formkey.currentState!.validate()) {
      //check  wether the student object alredy initalised ie, it is for updation
      if (Blood == null) {
        Blood st =  Blood(name: _nameController.text, bloodgroup: _bloodgroupController.text);
        dbBloodManager.insertBlood(st).then((value) => (){
          _nameController.clear();
          _bloodgroupController.clear();
          print("Student Data Add to database $value");
        });
      }
      else {
        blood?.name = _nameController.text;
        blood?.bloodgroup = _bloodgroupController.text;

        dbBloodManager.updateBlood(blood!).then((value) {
          setState(() {
            bloodlist[updateindex].name = _nameController.text;
            bloodlist[updateindex].bloodgroup = _bloodgroupController.text;
          });
          _nameController.clear();
          _bloodgroupController.clear();
          blood=null;
        });
      }
    }
  }
}

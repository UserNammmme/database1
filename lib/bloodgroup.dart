import 'package:flutter/material.dart';
import 'grouplist.dart';
import 'dash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood record',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DBBloodManager dbBloodManager = DBBloodManager();
  final _nameController = TextEditingController();
  final _bloodgroupController = TextEditingController();

  //to validate text form field  we need to add this  key and wrap parent
  // widget with Form widget and provide this key to it
  final _formkey = GlobalKey<FormState>();

  Blood? blood;
  late int updateindex;

  late List<Blood> studlist;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood record"),
      ),
      body: ListView(
        children: <Widget>[
          //wrap widget with form to validate
          Form(
            key: _formkey,
            //providing form kkey to form
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: "Name"),
                    controller: _nameController,

                    validator: (val) =>
                    val!.isNotEmpty ? null : "Name Should not be Empty",
                  ),
                  TextFormField(
                      decoration: InputDecoration(labelText: "bloodtype"),
                      controller: _bloodgroupController,
                      validator: (val) {
                        if(val!.isEmpty){
                          return "should not be empty";
                        }

                      }
                  ),
                  ElevatedButton(
                    child: Container(
                        width: width * 0.9,
                        child: Text(
                          "Submit",

                          textAlign: TextAlign.center,
                        )),
                    onPressed:() {

                      submitBlood(context);
                      _nameController.clear();
                      _bloodgroupController.clear();
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>const Dashboard()));

                    },
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void submitBlood(BuildContext context) {

    if (_formkey.currentState!.validate()) {
      //check  wether the student object alredy initalised ie, it is for updation
      if (blood == null) {
        Blood st =  Blood(name: _nameController.text, bloodgroup: _bloodgroupController.text);
        dbBloodManager.insertBlood(st).then((value) => (){


        });
      }
      else {
        blood?.name = _nameController.text;
        blood?.bloodgroup = _bloodgroupController.text;

        dbBloodManager.updateBlood(blood!).then((value) {
          setState(() {
            studlist[updateindex].name = _nameController.text;
            studlist[updateindex].bloodgroup = _bloodgroupController.text;
          });
          _nameController.clear();
          _bloodgroupController.clear();
          blood=null;
        });
      }
    }
  }
}

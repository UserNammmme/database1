
import 'dart:convert';
import 'dart:io';
import 'package:database/w.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'Product.dart';
import 'Products.dart';
//nghjfku
void main()=>runApp(
  MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>HomeeState())
  ]));

class ho extends StatelessWidget {
  const ho({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homee(),
    );
  }
}

class Homee extends StatelessWidget {
  const Homee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

    );
  }
}


class HomeeState with ChangeNotifier {

  List<Products>_plist = [];


  List<Products> get plist => _plist;


  Future<void> updatedata() async {
    Future<List<Products>> fetchProductss() async {
      //https://dummyjson.com/products
      final response =
      await http.get(Uri.parse('https://dummyjson.com/products'));
      if (response.statusCode == 200) {
        var getProductssData = json.decode(response.body.toString());
        var p = Product.fromJson(getProductssData) as Product;
        var listProductss = p.products;
        return listProductss;
      } else {
        throw Exception('Failed to load Products');
      }
    }
    _plist = await fetchProductss();
    notifyListeners();

  }
}



  class Home1 extends StatelessWidget {
    const Home1({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    context.read()<HomeeState>().updatedata();
   var list= context.watch()<HomeeState>().plist;
    // TODO: implement build
    return Scaffold(
        body:Container(
          height: double.infinity,
          child:     ListView.separated(
              itemBuilder: (context, index) {
                var p = list[index];
                return Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${p.title.toString()}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Description : ${p.description.toString()}',
                          ),
                          SizedBox(height: 5),
                          Image.network(
                            '${p.images[0]}',
                            fit: BoxFit.cover,
                          ),
                          Hero(
                              tag: '${p.title}',
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                          transitionDuration: const Duration(seconds: 5),
                                          pageBuilder: (_, __,___) => Details(
                                              products: p) // <-- here is the magic
                                      ));
                                },
                                child: Text(
                                  'More details',
                                ),
                              )
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: list.length),
        )



        );
  }
}

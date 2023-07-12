import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Products.dart';

class Details extends StatefulWidget {
  Products products;
  Details({Key? key, required this.products}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int currentIndex1 = 0;

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        body:
        Center(
          child: Hero(
            tag: '${widget.products.title}',
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(height: 300,
                // child:     Hero(
                //     tag: '${widget.products}',
                //     child: Image.network('${widget.products.images[0]}')),),
                Container(
                  height: 200,
                  width: 300,
                  child: widget.products.images.length>0?
                  CarouselSlider.builder(
                    itemCount: widget.products.images.length,
                    options: CarouselOptions(
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      onPageChanged: (index1, reason1) {
                        setState(() {
                          if(currentIndex1==(widget.products.images.length-1))
                          {
                            currentIndex1=0;
                          }else {
                            currentIndex1 = index1;
                          }
                        });
                      },
                    ),
                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Image.network('${widget.products.images[itemIndex]}'),
                  ) : Text("No photo data"),
                ),
                DotsIndicator(
                  dotsCount:widget.products.images.length,
                  position: currentIndex1.toInt(),
                  decorator: DotsDecorator(
                    shape: Border(),
                    activeColor: Colors.black,
                    color: Colors.green,
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),

                Text('${widget.products.title}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),

                SizedBox(height: 10),
                Row(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: 100),
                      child: Text("Brand: "),
                    ),
                    Text('${widget.products.brand}',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
                    ),
                  ],
                ),

                Row(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: 100),
                      child: Text("Description: "),
                    ),
                    Text('${widget.products.description}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: 100),
                      child: Text("Rating: "),
                    ),
                    Text('${widget.products.rating}',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: 100),
                      child: Text("Price: ₹"),
                    ),
                    Text('${widget.products.price}',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: 100),
                      child: Text("DiscountPercentage: ₹"),
                    ),
                    Text('${widget.products.discountPercentage}',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: 100),
                      child: Text("Stock left: "),
                    ),
                    Text('${widget.products.stock}',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
                    ),
                  ],
                ),
                SizedBox(height: 5),
              ],

            ),
          ),
        ));
  }
}
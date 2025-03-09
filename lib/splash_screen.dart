import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/screens/home.dart';

class splashscreen extends StatefulWidget{
  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  var _width=200.0;
  var _height=200.0;


  @override
 void initState() { // we put initState for the splash screen timer.
    super.initState();


    Timer(Duration(seconds: 3), (){

        Navigator.pushReplacement( // we use pushreplacement because we want splacescreen only when app opens.
            context,
            MaterialPageRoute(builder:(context) => MyApp(),));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );


    }

    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(

                colors:[
                  Color(0xff434343),
                  Color(0xff000000)
                ]

            ),
          ),
          child: Center(
            child: InkWell(
              onTap: (){
                setState(() {
                  _width=100.0;
                  _height=100.0;
                });
              },
              child: AnimatedContainer(
                child: Image.asset('assets/images/listimage.png',width: 150,
                  height: 150,),
                height: _height,
                width: _width,
                curve: Curves.bounceOut,
                duration: Duration(seconds: 4),

              ),
            ),
          ),
        )
    );

  }
}
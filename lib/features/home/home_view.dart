import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../dashpoard/dashboard.dart';


class HomeView extends StatefulWidget {

  const HomeView({super.key});

  @override
  _HomeViewState createState() =>  _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();


    Timer(const Duration(seconds: 3), () {
      setState(() {

        MaterialPageRoute homePageRoute =  MaterialPageRoute(
            builder: (BuildContext context) =>  Dashboard());
        Navigator.push(context, homePageRoute);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 55.0),
            child:  Text(
              "DASHBOARD",
              style: TextStyle(
                  fontSize: 25.0,
                  fontFamily: "Poppins-Medium",
                  fontWeight: FontWeight.w200),
            ),
          ),
          elevation: 0.0,
          backgroundColor: dashBoardColor,
          leading:  IconButton(
            onPressed: () {

            },
            icon:  const Icon(
              Icons.menu,
            ),
          ),
        ),
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  splashScreenColorBottom,
                  splashScreenColorTop
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topRight,
              ),
            ),
            child: const Column(children: <Widget>[
              LinearProgressIndicator(
                valueColor:  AlwaysStoppedAnimation<Color>(
                    splashScreenColorBottom),
              ),
              Padding(
                padding: EdgeInsets.all(40.0),
                child: Text(
                  "Please Wait..\nwhile we are setting up things",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              )
            ]
            )
        )

        );
  }
}

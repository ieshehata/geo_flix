import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geo_flix/features/home/home_view.dart';

import '../../core/constants/colors.dart';



class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
          () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeView()));
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration:  const BoxDecoration(
              gradient: LinearGradient(
                colors: [splashScreenColorBottom, splashScreenColorTop],
                begin: Alignment.bottomCenter,
                end: Alignment.topRight,
              ),
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                'assets/logo/logo-white.png',
                width: 200,
              ),
              Container(
                padding: const EdgeInsets.only(top: 80),
                child: const SpinKitThreeBounce(
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
              ]),

          ),

        ],
      ),
    );
  }
}

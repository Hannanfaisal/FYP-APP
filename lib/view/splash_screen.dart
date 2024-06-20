
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fyp/utils/app_styles.dart';
import 'package:fyp/utils/constants.dart';
import 'package:fyp/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    Timer(const Duration(seconds: 4), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
          colors: [
            Color(0XFF2BAC13),
            Color(0XFF0E530E),
          ]
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Image(image: AssetImage("assets/images/logo.png"), width: 100 ,filterQuality: FilterQuality.high,),
                  const SizedBox(height: 15,),
                  Center(child: Text(appName, style: headline1,)),
                ],
              ),



              const CircularProgressIndicator(color: Colors.lightGreen,)
            ],
          ),
        ),
      ),
    );
  }
}

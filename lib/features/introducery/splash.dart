// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:se7ety_app/core/functions/navigate.dart';
import 'package:se7ety_app/features/introducery/onboarding/onboarding_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
   Future.delayed(Duration(seconds: 3),(){
       navigateWithReplacement(context, OnboardingView());
   });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Image.asset("assets/Se7tec__1_-removebg-preview 1 (1).png", height:300)
            ],
          ),
        )
    );
  }
}


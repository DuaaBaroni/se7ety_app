// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:se7ety_app/core/utils/style.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         actions: [
           Icon(Icons.settings)
         ],
         centerTitle: true,
         title: Text("صحتي", style: getBodyStyle(fontSize: 25),
         ),
       ),
       body: Column(
         children: [
            Text("مرحبا سيد عبد العزيز", style:getTitleStyle()),
            Text("احجز الان وكن جزءا من رحلتك الصحيه", style: getBodyStyle(),)
        
         ],
       )
    );
  }
}


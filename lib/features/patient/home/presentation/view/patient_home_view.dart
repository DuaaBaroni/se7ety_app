// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_element, unused_field, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_app/core/functions/navigate.dart';
import 'package:se7ety_app/core/utils/color.dart';
import 'package:se7ety_app/core/utils/style.dart';
import 'package:se7ety_app/features/patient/home/presentation/widgets/card_specilization_list_view.dart';
import 'package:se7ety_app/features/patient/home/presentation/widgets/explore.dart';
import 'package:se7ety_app/features/patient/home/presentation/widgets/search_feild.dart';
import 'package:se7ety_app/features/patient/home/presentation/widgets/top_rated.dart';


class PatientHomeView extends StatefulWidget {
  const PatientHomeView({super.key});

  @override
  State<PatientHomeView> createState() => _PatientHomeViewState();
}

class _PatientHomeViewState extends State<PatientHomeView> {
  final TextEditingController _doctorName = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Icon(
            Icons.notifications,
            size: 30,
          ),
        ],
        centerTitle: true,
        title: Text("صـــحتـي",
            style: getBodyStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(TextSpan(children: [
                TextSpan(text: "مرحبا", style: getBodyStyle()),
                TextSpan(
                  text: user?.displayName,
                  style: getTitleStyle(),
                )
              ])),
              Gap(7),
              Text(
                "احجز الان وكن جزءا من رحلتك الصحية",
                style: getTitleStyle(color: AppColors.black),
              ),

              // search
              Gap(20),
              Container(
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 15,
                          color: AppColors.grey.withOpacity(.7),
                          offset: Offset(5, 5)),
                    ]),
                child: TextFormField(
                  textInputAction: TextInputAction.search,
                  cursorColor: AppColors.background,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      //  border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(25)
                      //  ),
                      hintStyle: getBodyStyle(),
                      hintText: "ابحث عن دكتور",
                      filled: true,
                      suffixIcon: Container(
                          decoration: BoxDecoration(
                            color: AppColors.background.withOpacity(.7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {
                               setState(
                            () {
                              _doctorName.text.isEmpty
                                  ? Container()
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SearchHomeView(
                                          searchKey: _doctorName.text,
                                        ),
                                      ),
                                    );
                            }
                               );  
                            },
                            color: AppColors.white,
                            icon: Icon(Icons.search),
                          ))),
                ),
              ),
              Gap(10),
              Text(
                "التخصصات",
                style: getTitleStyle(),
              ),
              Gap(10),
              SpecialistsBanner(),
              Gap(10),
              Text(
                "الاعلى تقييما",
                style: getTitleStyle(),
              ),
              Gap(10),
              const TopRateList(),
            ],
          ),
        ),
      ),
    );
  }
}

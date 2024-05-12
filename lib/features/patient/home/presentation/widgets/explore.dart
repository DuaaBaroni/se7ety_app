// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se7ety_app/core/functions/navigate.dart';
import 'package:se7ety_app/core/utils/color.dart';
import 'package:se7ety_app/core/utils/style.dart';
import 'package:se7ety_app/features/patient/home/presentation/view/patient_home_view.dart';
import 'package:se7ety_app/features/patient/home/presentation/widgets/doctor_card.dart';
import 'package:se7ety_app/features/patient/profile/presentation/widgets/doctor_profile.dart';


class ExploreList extends StatefulWidget {
  final String specialization;
  const ExploreList({super.key, required this.specialization});

  @override
  _ExploreListState createState() => _ExploreListState();
}

class _ExploreListState extends State<ExploreList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        centerTitle: true,
        title: Text(
          widget.specialization,style: getTitleStyle(color: AppColors.white),
        ),
        leading: GestureDetector(onTap: () {
          navigatoTo(context, const PatientHomeView());
        },
          child: Icon(Icons.arrow_back_ios, color:AppColors.white)),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('doctors')
            .orderBy('specialization')
            .startAt([widget.specialization]).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return snapshot.data!.docs.isEmpty
              ? Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/no-search.svg',
                          width: 250,
                        ),
                        Text(
                          'لا يوجد دكتور بهذا التخصص حاليا',
                          style: getBodyStyle(),
                        ),
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(15),
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: snapshot.data?.size,
                    itemBuilder: (context, index) {
                      DocumentSnapshot doctor = snapshot.data!.docs[index];
                      return DoctorCard(
                          name: doctor['name'],
                          image: doctor['image'],
                          specialization: doctor['specialization'],
                          rating: doctor['rating'],
                          onPressed: () {
                            Navigator.push(
                             context,
                              MaterialPageRoute(
                                builder: (context) => DoctorProfile(
                                  doctor: doctor['name'],
                                ),
                              ),
                            );
                          }
                          );
                    },
                  ),
             );
        },
      ),
    );
  }
}
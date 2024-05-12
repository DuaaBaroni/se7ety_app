// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se7ety_app/core/utils/color.dart';
import 'package:se7ety_app/core/utils/style.dart';
import 'package:se7ety_app/features/patient/home/presentation/widgets/doctor_card.dart';
import 'package:se7ety_app/features/patient/profile/presentation/widgets/doctor_profile.dart';


class SearchHomeView extends StatefulWidget {
  final String searchKey;
  const SearchHomeView({Key? key, required this.searchKey}) : super(key: key);

  @override
  _SearchHomeViewState createState() => _SearchHomeViewState();
}

class _SearchHomeViewState extends State<SearchHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          'ابحث عن دكتورك',
          style: getTitleStyle(color: AppColors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('doctors')
              .orderBy('name')
              .startAt([widget.searchKey]).endAt(
                  ['${widget.searchKey}\uf8ff']).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return snapshot.data?.size == 0
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
                            'لا يوجد دكتور بهذا الاسم',
                            style: getBodyStyle(),
                          ),
                        ],
                      ),
                    ),
                  )
                : Scrollbar(
                    child: ListView.builder(
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
                            });
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se7ety_app/features/patient/home/presentation/widgets/doctor_card.dart';
import 'package:se7ety_app/features/patient/profile/presentation/widgets/doctor_profile.dart';


class TopRateList extends StatefulWidget {
  const TopRateList({super.key});

  @override
  TopRateListState createState() => TopRateListState();
}

class TopRateListState extends State<TopRateList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('doctors')
            .orderBy('rating', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doctor = snapshot.data!.docs[index];
                if (doctor['name'] == null ||
                    doctor['image'] == null ||
                    doctor['specialization'] == null ||
                    doctor['rating'] == null) {
                  return const SizedBox();
                }
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
            );
          }
        },
      ),
    );
  }
}
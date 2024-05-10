// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:se7ety_app/core/utils/color.dart';
import 'package:se7ety_app/core/utils/style.dart';
import 'package:se7ety_app/features/patient/appoinments/presentation/widgets/scheduling.dart';

class AppointmentList extends StatefulWidget {
  const AppointmentList({super.key});

  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  String? _documentID;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  Future<void> deleteAppointment(
    String docID,
  ) {
    return FirebaseFirestore.instance
        .collection('appointments')
        .doc('appointments')
        .collection('pending')
        .doc(docID)
        .delete();
  }

  String _dateFormatter(String timestamp) {
    String formattedDate =
        DateFormat('dd-MM-yyyy').format(DateTime.parse(timestamp));
    return formattedDate;
  }

  String _timeFormatter(String timestamp) {
    String formattedTime =
        DateFormat('hh:mm').format(DateTime.parse(timestamp));
    return formattedTime;
  }

  showAlertDialog(BuildContext context, String docID) {
    return AlertDialog.adaptive(
      title: const Text("حذف الحجز"),
      content: const Text("هل انت متأكد من الحجز ؟"),
      actions: [
        TextButton(
          child: const Text("لا"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
            child: const Text("نعم"),
            onPressed: () {
              deleteAppointment(
                _documentID!,
              );
              Navigator.of(context).pop();
            })
      ],
    );
  }

  _checkDiff(DateTime date) {
    var diff = DateTime.now().difference(date).inHours;
    if (diff > 2) {
      return true;
    } else {
      return false;
    }
  }

  _compareDate(String date) {
    if (_dateFormatter(DateTime.now().toString())
            .compareTo(_dateFormatter(date)) ==
        0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('appointments')
            .doc('appointments')
            .collection('pending')
            .where('patientID', isEqualTo: '${user!.email}')
            .orderBy("date", descending: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return snapshot.data!.docs.isEmpty
              ? const NoScheduledWidget()
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data?.size,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    if (_checkDiff(document['date'].toDate())) {
                      deleteAppointment(
                        document.id,
                      );
                    }
                    return Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(-3, 0),
                                blurRadius: 15,
                                color: Colors.grey.withOpacity(.1),
                              )
                            ],
                          ),
                          child: ExpansionTile(
                            childrenPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            expandedCrossAxisAlignment: CrossAxisAlignment.end,
                            backgroundColor: AppColors.background,
                            collapsedBackgroundColor: AppColors.background,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    'د. ${document['doctors']}',
                                    style: getTitleStyle(),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 5, left: 5),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_month_rounded,
                                          color: AppColors.background,
                                          size: 16),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        _dateFormatter(document['date']
                                            .toDate()
                                            .toString()),
                                        style: getBodyStyle(),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        _compareDate(document['date']
                                                .toDate()
                                                .toString())
                                            ? "اليوم"
                                            : "",
                                        style: getBodyStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.watch_later_outlined,
                                          color: AppColors.background,
                                          size: 16),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        _timeFormatter(
                                          document['date'].toDate().toString(),
                                        ),
                                        style: getBodyStyle(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 5, right: 10, left: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "اسم المريض: " + document['name'],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on_rounded,
                                            color: AppColors.background,
                                            size: 16),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          document['location'],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.background),
                                          onPressed: () {
                                            _documentID = document.id;
                                            showAlertDialog(
                                                // context, document['doctorsID']);
                                                context,
                                                document.id);
                                          },
                                          child: const Text('حذف الحجز')),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
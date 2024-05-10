import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se7ety_app/core/utils/color.dart';
import 'package:se7ety_app/core/utils/style.dart';
import 'package:se7ety_app/features/patient/appoinments/presentation/view/appointments_list.dart';


class AppointmentsView extends StatefulWidget {
  const AppointmentsView({super.key});

  @override
  AppointmentsViewState createState() => AppointmentsViewState();
}

class AppointmentsViewState extends State<AppointmentsView> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        centerTitle: true,
        title:  Text(
          'مواعيد الحجز', style: getTitleStyle(color:AppColors.white),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: AppointmentList(),
      ),
    );
  }
}

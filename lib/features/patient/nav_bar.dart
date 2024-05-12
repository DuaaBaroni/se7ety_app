// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:se7ety_app/core/utils/color.dart';
import 'package:se7ety_app/features/introducery/onboarding/onboarding_model.dart';
import 'package:se7ety_app/features/patient/appoinments/presentation/view/appointment_view.dart';
import 'package:se7ety_app/features/patient/home/presentation/view/patient_home_view.dart';
import 'package:se7ety_app/features/patient/profile/presentation/view/profile_view.dart';
import 'package:se7ety_app/features/patient/search/presentation/view/search_view.dart';

class NavBarPatient extends StatefulWidget {
  const NavBarPatient({super.key, this.page});
  final int? page;

  @override
  State<NavBarPatient> createState() => _NavBarPatientState();
}

class _NavBarPatientState extends State<NavBarPatient> {
  int selectedIndex = 0;
  List<Widget> views = [
    const PatientHomeView(),
    const SearchView(),
    const AppointmentsView(),
    const ProfileView(),
  ];

  @override
  void initState() {
    selectedIndex = widget.page ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: views[selectedIndex],
      bottomNavigationBar: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColors.offWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: AppColors.black.withOpacity(.7),
                )
              ]),
          child: GNav(
              rippleColor: Colors.grey,
              hoverColor: Colors.grey,
              haptic: true,
              tabBorderRadius: 15,
              curve: Curves.easeOutExpo,
              duration: Duration(seconds: 1),
              gap: 8,
              color: Colors.grey[800],
              activeColor: AppColors.white,
              iconSize: 24,
              tabBackgroundColor: AppColors.background,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'الرئيسيه',
                ),
                GButton(
                  icon: Icons.search,
                  text: 'البحث',
                ),
                GButton(
                  icon: Icons.calendar_month,
                  text: 'الحجوزات',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'الحساب الشخصي',
                )
              ],
               selectedIndex: selectedIndex,
                onTabChange: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                }
              ),
              ),
    );
  }
}

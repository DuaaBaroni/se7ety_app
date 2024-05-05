// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:se7ety_app/core/utils/color.dart';
import 'package:se7ety_app/core/utils/style.dart';

class DoctorUploadData extends StatefulWidget {
  const DoctorUploadData({super.key});

  @override
  State<DoctorUploadData> createState() => _DoctorUploadDataState();
}

class _DoctorUploadDataState extends State<DoctorUploadData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           backgroundColor: AppColors.background,
           title: Text("اكمال عمليه التسجيل", style: getBodyStyle(color: AppColors.white),
           ),
        ),
    );
  }
}


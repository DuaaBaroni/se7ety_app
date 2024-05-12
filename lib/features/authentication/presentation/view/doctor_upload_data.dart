// ignore_for_file: unused_import, prefer_const_constructors, library_private_types_in_public_api, unused_field, avoid_unnecessary_containers, avoid_print, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:se7ety_app/core/functions/navigate.dart';
import 'package:se7ety_app/core/utils/color.dart';
import 'package:se7ety_app/core/utils/style.dart';
import 'package:se7ety_app/core/widgets/dialog.dart';
import 'package:se7ety_app/features/authentication/data/specilization.dart';
import 'package:se7ety_app/features/authentication/presentation/manger/auth_cubit.dart';
import 'package:se7ety_app/features/authentication/presentation/manger/auth_state.dart';
import 'package:se7ety_app/features/introducery/welcome.dart';
import 'package:se7ety_app/features/patient/home/presentation/view/patient_home_view.dart';

class DoctorUploadData extends StatefulWidget {
  const DoctorUploadData({super.key});

  @override
  _DoctorUploadDataState createState() => _DoctorUploadDataState();
}

class _DoctorUploadDataState extends State<DoctorUploadData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _bio = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _phone1 = TextEditingController();
  final TextEditingController _phone2 = TextEditingController();
  String _specialization = specialization[0];

  late String _startTime =
      DateFormat('hh').format(DateTime(2023, 9, 7, 10, 00));
  late String _endTime = DateFormat('hh').format(DateTime(2023, 9, 7, 22, 00));

  String? _imagePath;
  File? file;
  String? profileUrl;
  String? userID;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    userID = FirebaseAuth.instance.currentUser!.uid;
  }

  Future<String> uploadImageToFireStore(File image) async {
    Reference ref =
        FirebaseStorage.instanceFor(bucket: 'gs://se7ety-3a9eb.appspot.com')
            .ref()
            .child('doctors/$userID');
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    await ref.putFile(image, metadata);
    String url = await ref.getDownloadURL();
    return url;
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        file = File(pickedFile.path);
      });
    }
    profileUrl = await uploadImageToFireStore(file!);
  }

  @override
  Widget build(BuildContext context) {
    print(userID);
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UploadSuccessState){
          pushAndRemoveUntil(context, PatientHomeView());
          
        } else if (state is UploadErrorState){
           Navigator.pop(context);
          showErrorDialog(context, state.error);
        
        } else{
             showLoadingDialog(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
          centerTitle: true,
          title: Text(
            'إكمال عملية التسجيل',
            style: getTitleStyle(color: AppColors.white),
          ),
           actions: [
             IconButton(onPressed: (){
              navigateWithReplacement(context, WelcomeView());
             }, icon: Icon(Icons.arrow_back_ios, color: AppColors.white,))
           ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: (_imagePath != null)
                                  ? FileImage(File(_imagePath!)) as ImageProvider
                                  : const AssetImage('assets/user.png'),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await _pickImage();
                            },
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(9, 12, 9, 9),
                        child: Row(
                          children: [
                            Text(
                              'التخصص',
                              style: getBodyStyle(color: AppColors.black),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                            color: AppColors.offWhite,
                            borderRadius: BorderRadius.circular(20)),
                        child: DropdownButton(
                          isExpanded: true,
                          iconEnabledColor: AppColors.background,
                          icon: Icon(
                            Icons.expand_circle_down_outlined,
                            color: AppColors.background,
                          ),
                          value: _specialization,
                          onChanged: (String? newValue) {
                            setState(() {
                              _specialization = newValue ?? specialization[0];
                            });
                          },
                          items: specialization.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value,
                                style: getBodyStyle(),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Gap(10),
                      Row(
                        children: [
                          Text(
                            "نبذه تعريفيه",
                            style: getBodyStyle(),
                          ),
                        ],
                      ),
                      Gap(5),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.offWhite,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                "سجل المعلومات الطبيه العامه مثل تعليمك الاكاديمي و خبراتك السابقه",
                            hintMaxLines: 9,
                          ),
                        ),
                      ),
                      Gap(10),
                      Row(
                        children: [
                          Text(
                            "عنوان العياده",
                            style: getBodyStyle(),
                          ),
                        ],
                      ),
                      Gap(5),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.offWhite,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "5 شارع مصدق - الدقي - الجيزه",
                            hintMaxLines: 9,
                          ),
                        ),
                      ),
                      Gap(10),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:  EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'ساعات العمل من',
                                    style: getBodyStyle(color: AppColors.black),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Gap(10),
                          Expanded(
                            child: Padding(
                              padding:EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'الي',
                                    style: getBodyStyle(color: AppColors.black),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                               padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.offWhite,
                          borderRadius: BorderRadius.circular(20),
                        ),
                              child: TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                     border: InputBorder.none,
                                  suffixIcon: IconButton(
                                      onPressed: () async {
                                        await showStartTimePicker();
                                      },
                                      icon: Icon(
                                        Icons.watch_later_outlined,
                                        color: AppColors.background,
                                      )),
                                  hintText: _startTime,
                                ),
                              ),
                            ),
                          ),
                           Gap(10),
                          Expanded(
                            child: Container(
                               padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.offWhite,
                          borderRadius: BorderRadius.circular(20),
                        ),
                              child: TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                     border: InputBorder.none,
                                  suffixIcon: IconButton(
                                      onPressed: () async {
                                        await showEndTimePicker();
                                      },
                                      icon: Icon(
                                        Icons.watch_later_outlined,
                                        color: AppColors.background,
                                      )),
                                  hintText: _endTime,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:  EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'رقم الهاتف 1',
                              style: getBodyStyle(color: AppColors.black),
                            )
                          ],
                        ),
                      ),
                      Container(
                         padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.offWhite,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _phone1,
                          style: TextStyle(color: AppColors.black),
                          decoration:  InputDecoration(
                            border: InputBorder.none,
                            hintText: '+20**********',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'من فضلك ادخل الرقم';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'رقم الهاتف 2 (اختياري)',
                              style: getBodyStyle(color: AppColors.black),
                            )
                          ],
                        ),
                      ),
                      Container(
                         padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.offWhite,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _phone2,
                          style: TextStyle(color: AppColors.black),
                          decoration:  InputDecoration(
                               border: InputBorder.none,
                            hintText: '+20**********',
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(top: 25.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
               onPressed: () async {
                 if (_formKey.currentState!.validate()) {
                  context.read<AuthCubit>().uploadDoctor(
                      uid: userID ?? '',
                      image: profileUrl ?? '',
                      specialization: _specialization,
                      phone1: _phone1.text,
                      bio: _bio.text,
                      startTime: _startTime,
                      endTime: _endTime,
                      address: _address.text);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.background,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "التسجيل",
                style: getTitleStyle(fontSize: 16, color: AppColors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  showStartTimePicker() async {
    final datePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (datePicked != null) {
      setState(() {
        _startTime = datePicked.hour.toString();
      });
    }
  }

  showEndTimePicker() async {
    final timePicker = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
          DateTime.now().add(const Duration(minutes: 15))),
    );

    if (timePicker != null) {
      setState(() {
        _endTime = timePicker.hour.toString();
      });
    }
  }
}

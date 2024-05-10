// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:se7ety_app/core/utils/color.dart';
import 'package:se7ety_app/core/utils/style.dart';
import 'package:se7ety_app/core/widgets/custom_btn.dart';
import 'package:se7ety_app/core/widgets/dialog.dart';
import 'package:se7ety_app/features/patient/appoinments/presentation/view/appointment_view.dart';
import 'package:se7ety_app/features/patient/appoinments/presentation/view/appointments_list.dart';
import 'package:se7ety_app/features/patient/home/presentation/widgets/doctor_card.dart';
import 'package:se7ety_app/features/patient/search/data/doctor_model.dart';
import 'package:se7ety_app/features/patient/search/presentation/widgets/available_appoinments.dart';


class BookingView extends StatefulWidget {
  final Doctor doctor;

  const BookingView({
    super.key,
    required this.doctor,
  });

  @override
  _BookingViewState createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  String? dateUTC;
  String? date_Time;

  int isSelected = -1;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  List<int> times = [];
  getAvilableTimes() async {
    times.clear();
    AppointmentService()
        .getAvailableAppointments(
            selectedDate, widget.doctor.startHour, widget.doctor.endHour)
        .then((value) {
      for (var i in value) {
        times.add(i);
      }
    });
  }

  Future<void> selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.background,
            colorScheme: ColorScheme.light(primary: AppColors.background),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    ).then(
      (date) {
        if (date != null) {
          setState(
            () {
              selectedDate = date;
              String formattedDate =
                  DateFormat('dd-MM-yyyy').format(selectedDate);
              _dateController.text = formattedDate;
              dateUTC = DateFormat('yyyy-MM-dd').format(selectedDate);
              getAvilableTimes();
            },
          );
        }
      },
    );
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
        backgroundColor: AppColors.background,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColors.white,
            )),
        
        centerTitle: true,
        title:  Text(
          'احجز مع دكتورك', style: getTitleStyle(color:AppColors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              DoctorCard(
                  name: widget.doctor.name,
                  image: widget.doctor.imageUrl,
                  specialization: widget.doctor.specialization,
                  rating: widget.doctor.rating,
                  onPressed: () {}),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        '--ادخل بيانات الحجز--',
                        style: getTitleStyle(),
                      ),
                    ),
                   Gap(10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'اسم المريض',
                            style: getBodyStyle(color: AppColors.black),
                          )
                        ],
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                         border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)
                         ),
                         fillColor: AppColors.offWhite,
                         hintText: "دعاء هاشم"
                      ),
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) return 'من فضلك ادخل اسم المريض';
                        return null;
                      },
                      style: getBodyStyle(),
                      textInputAction: TextInputAction.next,
                    ),
                   Gap(10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'رقم الهاتف',
                            style: getBodyStyle(color: AppColors.black),
                          )
                        ],
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                       decoration: InputDecoration(
                         border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)
                         ),
                         fillColor: AppColors.offWhite,
                         hintText: "+20**********"
                      ),
                      controller: _phoneController,
                      style: getBodyStyle(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل رقم الهاتف';
                        } else if (value.length < 10) {
                          return 'يرجي ادخال رقم هاتف صحيح';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    Gap(10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'وصف الحاله',
                            style: getBodyStyle(color: AppColors.black),
                          )
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: _descriptionController,
                       decoration: InputDecoration(
                         border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)
                         ),
                         fillColor: AppColors.offWhite,
                         hintText: ""
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      style: getBodyStyle(),
                      textInputAction: TextInputAction.next,
                    ),
                    Gap(10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'تاريخ الحجز',
                            style: getBodyStyle(color: AppColors.black),
                          )
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          TextFormField(
                             decoration: InputDecoration(
                         border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)
                         ),
                        fillColor: AppColors.offWhite
                      ),
                            readOnly: true,
                            controller: _dateController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'من فضلك ادخل تاريخ الحجز';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            style: getBodyStyle(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: InkWell(
                              child: CircleAvatar(
                                backgroundColor: AppColors.background,
                                radius: 20,
                                child: const Icon(
                                  Icons.date_range_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                selectDate(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                   Gap(10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'وقت الحجز',
                            style: getBodyStyle(color: AppColors.black),
                          ),
                        ],
                      ),
                    ),
                    Wrap(
                      spacing: 8.0,
                      children: List.generate(
                        times.length,
                        (index) {
                          return ChoiceChip(
                            backgroundColor: AppColors.background,
                            checkmarkColor: AppColors.white,
                            selectedColor: AppColors.offWhite,
                            label: Text(
                              '${times[index].toString()}:00',
                              style: TextStyle(
                                color: index == isSelected
                                    ? AppColors.white
                                    : AppColors.black,
                              ),
                            ),
                            selected: index == isSelected,
                            onSelected: (selected) {
                              setState(() {
                                isSelected = index;
                                date_Time =
                                    '${(times[index] < 10) ? '0' : ''}${times[index].toString()}:00';
                              });
                            },
                          );
                        },
                      ),
                    ),
                   Gap(20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: CustomButton(
          
          text: 'تأكيد الحجز',
          onPressed: () {
            if (_formKey.currentState!.validate() && isSelected != -1) {
              _createAppointment();
              showAlertDialog(
                context,
                title: 'تم تسجيل الحجز !',
                ok: 'اضغط للانتقال',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  AppointmentList(),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _createAppointment() async {
    FirebaseFirestore.instance
        .collection('appointments')
        .doc('appointments')
        .collection('pending')
        .doc()
        .set({
      'patientID': user!.email,
      'doctorID': widget.doctor.email,
      'name': _nameController.text,
      'phone': _phoneController.text,
      'description': _descriptionController.text,
      'doctor': widget.doctor.name,
      'location': widget.doctor.address,
      'date': DateTime.parse('${dateUTC!} ${date_Time!}:00'),
      'isComplete': false,
      'rating': null
    }, SetOptions(merge: true));

    FirebaseFirestore.instance
        .collection('appointments')
        .doc('appointments')
        .collection('all')
        .doc()
        .set({
      'patientID': user!.email,
      'doctorID': widget.doctor.email,
      'name': _nameController.text,
      'phone': _phoneController.text,
      'description': _descriptionController.text,
      'doctor': widget.doctor.name,
      'address': widget.doctor.address,
      'date': DateTime.parse('${dateUTC!} ${date_Time!}:00'),
      'isComplete': false,
      'rating': null
    }, SetOptions(merge: true));
  }
}
// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se7ety_app/core/utils/color.dart';
import 'package:se7ety_app/core/utils/style.dart';
import 'package:se7ety_app/core/widgets/custom_btn.dart';


class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  List labelName = ["الاسم", "رقم الهاتف", "المدينة", "نبذه تعريفية", "العمر"];

  List value = ["name", "phone", "city", "bio", "age"];

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
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            splashRadius: 25,
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        centerTitle: true,
        title:  Text('اعدادات الحساب', style: getTitleStyle(color: AppColors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('patients')
              .doc(user!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var userData = snapshot.data;
            return ListView(
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(
                labelName.length,
                (index) => Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: InkWell(
                    splashColor: AppColors.offWhite,
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          var con = TextEditingController(
                              text: userData?[value[index]]?.isEmpty ?? true
                                  ? 'لم تضاف'
                                  : userData?[value[index]]);
                          var form = GlobalKey<FormState>();
                          return SimpleDialog(
                            alignment: Alignment.center,
                            contentPadding: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            children: [
                              Form(
                                key: form,
                                child: Column(
                                  children: [
                                    Text(
                                      'ادخل ${labelName[index]}',
                                      style: getBodyStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: con,
                                      
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'من فضلك ادخل ${labelName[index]}.';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CustomButton(
                                      text: 'حفظ التعديل',
                                      onPressed: () {
                                        if (form.currentState!.validate()) {
                                          updateData(value[index], con.text);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.offWhite,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 15),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              labelName[index],
                              style: getBodyStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              userData?[value[index]]?.isEmpty ?? true
                                  ? 'Not Added'
                                  : userData?[value[index]],
                              style: getBodyStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> updateData(String key, value) async {
    FirebaseFirestore.instance.collection('patients').doc(user!.uid).set({
      key: value,
    }, SetOptions(merge: true));
    if (key.compareTo('name') == 0) {
      await user?.updateDisplayName(value);
    }
    Navigator.pop(context);
  }
}
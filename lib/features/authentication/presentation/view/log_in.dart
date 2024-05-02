// ignore_for_file: unused_import, prefer_const_constructors, library_private_types_in_public_api, use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_app/core/functions/email_validate.dart';
import 'package:se7ety_app/core/functions/navigate.dart';
import 'package:se7ety_app/core/utils/color.dart';
import 'package:se7ety_app/core/utils/style.dart';
import 'package:se7ety_app/core/widgets/custom_btn.dart';
import 'package:se7ety_app/core/widgets/dialog.dart';
import 'package:se7ety_app/features/authentication/presentation/manger/auth_cubit.dart';
import 'package:se7ety_app/features/authentication/presentation/manger/auth_state.dart';
import 'package:se7ety_app/features/authentication/presentation/view/doctor_upload_data.dart';
import 'package:se7ety_app/features/authentication/presentation/view/register.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.index});
  final int index;

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isVisable = true;

  int index = 0;
  String handleUser() {
    return widget.index == 0 ? 'دكتور' : 'مريض';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/Se7tec__1_-removebg-preview 1 (1).png',
                    height: 200,
                  ),
                  Gap(20),
                  Text(
                    'سجل دخول الان كـ "${handleUser()}"',
                    style: getTitleStyle(),
                  ),
                  Gap(30),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'duaa@example.com',
                      prefixIcon: Icon(Icons.email_rounded,
                          color: AppColors.background),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل الايميل';
                      } else if (!emailValidate(value)) {
                        return "هذا الايميل غير صحيح";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Gap(20),
                  TextFormField(
                    controller: _passwordController,
                    textAlign: TextAlign.end,
                    style: TextStyle(color: AppColors.black),
                    obscureText: isVisable,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: '********',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisable = !isVisable;
                          });
                        },
                        icon: Icon(
                            (isVisable)
                                ? Icons.visibility_off_rounded
                                : Icons.remove_red_eye,
                            color: AppColors.background),
                      ),
                      prefixIcon: Icon(Icons.lock, color: AppColors.background),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'من فضلك ادخل كلمة السر';
                      return null;
                    },
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(top: 5, right: 10),
                    child: Text(
                      'نسيت كلمة السر ؟',
                      style: getSmallStyle(color: AppColors.black),
                    ),
                  ),
                  Gap(20),
                  CustomButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await context.read<AuthCubit>().login(
                            _emailController.text, _passwordController.text);
                      }
                       navigateWithReplacement(context, DoctorUploadData()
                       );
                     },
                    text: "تسجيل الدخول",
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ليس لدي حساب ؟',
                          style: getBodyStyle(color: AppColors.black),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => RegisterView(
                                  index: widget.index,
                                ),
                              ));
                            },
                            child: Text(
                              'سجل الان',
                              style: getBodyStyle(color: AppColors.background),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

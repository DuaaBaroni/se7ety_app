// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, avoid_print

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
import 'package:se7ety_app/features/authentication/presentation/view/log_in.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key, required this.index});
  final int index;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isVisable = true;
  int index = 0;

  String handleUser() {
    return widget.index == 0 ? 'دكتور' : 'مريض';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          //  print("Done");
          pushAndRemoveUntil(context, DoctorUploadData());
        } else if (state is RegisterErrorState) {
          Navigator.pop(context);
          showErrorDialog(context, state.error);
          // print("error");
        } else {
          showLoadingDialog(context);
          // print("error reg");
        }
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/Se7tec__1_-removebg-preview 1 (1).png",
                        height: 200),
                    Gap(10),
                    Text(
                      'سجل حساب جديد "كـ' "${handleUser()}",
                      style: getTitleStyle(),
                    ),
                    Gap(30),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _displayName,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'الاسم',
                        prefixIcon: Icon(Icons.person_2_rounded,
                            color: AppColors.background),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل الاسم';
                        }
                        return null;
                      },
                    ),
                    Gap(20),
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
                        }),
                    Gap(20),
                    TextFormField(
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
                        prefixIcon:
                            Icon(Icons.lock, color: AppColors.background),
                      ),
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) return 'من فضلك ادخل كلمة السر';
                        return null;
                      },
                    ),
                    Gap(20),
                    CustomButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (widget.index == 0) {
                            context.read<AuthCubit>().registerDoctor(
                                _displayName.text,
                                _emailController.text,
                                _passwordController.text);
                          } else {
                            context.read<AuthCubit>().registerPatient(
                                _emailController.text,
                                _passwordController.text,
                                _displayName.text);
                          }
                        }
                      },
                      // navigateWithReplacement(
                      //   context,
                      //   LoginView(index: widget.index),
                      // );

                      text: "تسجيل الحساب",
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}




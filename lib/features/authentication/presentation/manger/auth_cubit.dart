// ignore_for_file: empty_catches, avoid_print, unused_element, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety_app/features/authentication/presentation/manger/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  // login
  login(String email, String password) async {
    emit(LoginLoadingState());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginErrorState('الحساب غير موجود'));
      } else if (e.code == 'wrong-password') {
        emit(LoginErrorState('كلمة السر خطا'));
      } else {
        emit(LoginErrorState('حدثت مشكله في التسجيل حاول لاحقا'));
      }
    }
  }

// register a doctor
  registerDoctor(String name, String email, String password) async {
    emit(RegisterLoadingState());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credential.user!;
      user.updateDisplayName(name);

      // store in firestore
      FirebaseFirestore.instance.collection('doctors').doc(user.uid).set({
        'name': name,
        'image': '',
        'specialization': '',
        'rating': 3,
        'email': user.email,
        'phone1': '',
        'phone2': '',
        'bio': '',
        'openHour': '',
        'closeHour': '',
        'address': '',
        'uid': user.uid,
      }, SetOptions(merge: true));
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterErrorState('كلمة المرور ضعيفة'));
      } else if (e.code == 'email-already-found') {
        emit(RegisterErrorState('الحساب موجود بالفعل'));
      } else {
        emit(RegisterErrorState('حدثت مشكلة فالتسجيل'));
      }
    } catch (e) {
      emit(RegisterErrorState('حدثت مشكلة فالتسجيل'));
    }
  }

  // register as patient
  registerPatient(String email, String password, String name) async {
    emit(RegisterLoadingState());
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = credential.user!;
      await user.updateDisplayName(name);

      // store in firestore
      FirebaseFirestore.instance.collection("patients").doc(user.uid).set({
        "name": name,
        "image": "",
        "email": email,
        "phone": "",
        "city": "",
        "bio": "",
        "age": "",
        "uid": user.uid,
      }, SetOptions(merge: true));
      emit(RegisterSuccessState());
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(RegisterErrorState("لا يوجد مستخدم"));
      } else if (e.code == 'wrong-password') {
        emit(RegisterErrorState("كلمه المرور خطأ"));
      } else {
        emit(RegisterErrorState("حدث مشكله في التسجيل"));
      }
    }
  }
// upload 
 uploadDoctor(
      {required String uid,
      required String specialization,
      required String image,
      required String phone1,
      String? phone2,
      required String bio,
      required String startTime,
      required String endTime,
      required String address}) {
    emit(UploadLoadingState());
    try {
      FirebaseFirestore.instance.collection('doctors').doc(uid).set({
        'image': image,
        'specialization': specialization,
        'phone1': phone1,
        'phone2': phone2,
        'bio': bio,
        'openHour': startTime,
        'closeHour': endTime,
        'address': address,
      }, SetOptions(merge: true));
      emit(UploadSuccessState());
    } catch (e) {
      emit(UploadErrorState('حدثت مشكلة'));
    }
  }

}





 

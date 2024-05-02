// ignore_for_file: empty_catches, avoid_print, unused_element

import 'package:firebase_auth/firebase_auth.dart';
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

  // register as doctor
  registerDoctor(String email, String password, String name) async {
    emit(RegisterLoadingState());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credential.user!;
      user.updateDisplayName(name);
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterErrorState('كلمة المرور ضعيفة'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterErrorState('الحساب موجود بالفعل'));
      } else {
        emit(RegisterErrorState('حدثت مشكلة في التسجيل'));
      }
    } 
  }

  // register as patient
  registerPatient(String email, String password, String name) async {
    emit(RegisterLoadingState());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User user = credential.user!;
      await user.updateDisplayName(name);
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
}

// upload
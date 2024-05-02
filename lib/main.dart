// ignore_for_file: prefer_const_constructors, unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety_app/features/authentication/presentation/manger/auth_cubit.dart';
import 'package:se7ety_app/features/authentication/presentation/view/log_in.dart';
import 'package:se7ety_app/features/introducery/splash.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyBsISzCOE5rCNHqusPUvUTZZdf5ncTifHM",
    appId: "com.example.se7ety_ap",
    messagingSenderId: "621724057186",
    projectId: "se7ety-3a9eb",
  ));

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
       create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashView(),
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          );
        },
      ),
    );
  }
}

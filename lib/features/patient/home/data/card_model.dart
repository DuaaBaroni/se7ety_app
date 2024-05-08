import 'package:flutter/material.dart';
import 'package:se7ety_app/features/authentication/data/specilization.dart';


const Color skyBlue = Color(0xff71b4fb);
const Color lightBlue = Color(0xff7fbcfb);

const Color orange = Color(0xfffa8c73);
const Color lightOrange = Color(0xfffa9881);

const Color purple = Color(0xff8873f4);
const Color purpleLight = Color(0xff9489f4);

const Color green = Color(0xff4cd1bc);
const Color lightGreen = Color(0xff5ed6c3);

const Color yellow = Color(0xfffff200);
const Color lightYellow = Color(0xfff2ea4f);


class CardDoctorModel {
  String doctor;
  Color cardBackground;
  Color cardlightColor;

  CardDoctorModel(this.doctor, this.cardBackground, this.cardlightColor);
}

List<CardDoctorModel> cards = [
  CardDoctorModel(
    specialization[0], 
    skyBlue, 
    lightBlue
    ),
  CardDoctorModel(
    specialization[1],
    green,
    lightGreen,
  ),
  CardDoctorModel(
    specialization[2],
    yellow,
    lightYellow,
  ),
  CardDoctorModel(
    specialization[3],
    purple,
    purpleLight,
  ), 
  CardDoctorModel(
    specialization[4],
    orange,
    lightOrange,
  ), 
  CardDoctorModel(
    specialization[5],
    skyBlue,
    lightBlue,
  ), 
  CardDoctorModel(
    specialization[6],
    green,
    lightGreen,
  ), 
  CardDoctorModel(
    specialization[7],
    orange,
    lightOrange,
  ), 
  CardDoctorModel(
    specialization[8],
    purple,
    purpleLight,
  ), 
  CardDoctorModel(
    specialization[9],
    yellow,
    lightYellow,
  ), 
];
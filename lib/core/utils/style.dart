// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se7ety_app/core/utils/color.dart';

TextStyle getTitleStyle({double? fontSize , Color? color , FontWeight? fontWeight}){
   return TextStyle(
     fontFamily: GoogleFonts.cairo().fontFamily,
      fontSize: fontSize??20,
      fontWeight:fontWeight?? FontWeight.w600,
      color:  color??AppColors.background,
   );
}

TextStyle getBodyStyle({double? fontSize , Color? color , FontWeight? fontWeight}){
   return TextStyle(
     fontFamily: GoogleFonts.cairo().fontFamily,
      fontSize: fontSize??18,
      fontWeight:fontWeight?? FontWeight.normal,
      color:  color??AppColors.black,
   );
}

TextStyle getSmallStyle({double? fontSize , Color? color , FontWeight? fontWeight}){
   return TextStyle(
     fontFamily: GoogleFonts.cairo().fontFamily,
      fontSize: fontSize??16,
      fontWeight:fontWeight?? FontWeight.normal,
      color:  color??AppColors.container,
   );
}

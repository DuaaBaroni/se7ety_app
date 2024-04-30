
import 'package:flutter/material.dart';
import 'package:se7ety_app/core/utils/color.dart';
import 'package:se7ety_app/core/utils/style.dart';

class TextFormFeild extends StatelessWidget {
  const TextFormFeild({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
       keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.go,
          textAlign: TextAlign.end,
          decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              hintText: 'duaa@gmail.com',
              hintStyle: getSmallStyle(fontSize: 18, color: AppColors.black),
              prefixIcon: Icon(
                Icons.mail,
                color: AppColors.background,
              )
              ),
    );

      
    
  }
}


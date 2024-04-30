// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

navigatoTo(context,NewView){
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => NewView,
    ),
    );
}

navigateWithReplacement(context,NewView){
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => NewView,)
    );
}

pushAndRemoveUntil(BuildContext context, Widget newView) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => newView,
      ),
      (route) => false);
}

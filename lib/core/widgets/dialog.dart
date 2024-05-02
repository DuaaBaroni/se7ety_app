import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

showErrorDialog(context, errorText) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(errorText)
      )
      );
}

// loading
showLoadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(.7),
    context: context,
    builder: (BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/loading.json', width: 150, height: 150),
        ],
      );
    },
  );
}



import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

void awesomeDialog({required BuildContext context, required String content}) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    //animType: AnimType.rightSlide,
    title: 'Error',
    desc: content,
  ).show();
}

void SuccessAwesomeDialog({
  required BuildContext context,
  required String content,
}) {
  AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          //animType: AnimType.rightSlide,
          title: 'Success',
          titleTextStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          desc: content,
          descTextStyle: const TextStyle(fontSize: 18))
      .show();
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quotes/core/utils/app_colors.dart';

class Constants {
  static void showErrorDialog({
    required BuildContext context,
    required String message,
  }) {
    showDialog(
      context: context,
      builder: ((context) => CupertinoAlertDialog(
            title: Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: const Text('Ok'),
              )
            ],
          )),
    );
  }

  static void showToast({
    required String message,
    Color? color,
  }) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color ?? AppColors.primary,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

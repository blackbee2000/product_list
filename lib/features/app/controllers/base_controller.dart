import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  void showLoading() {
    if (EasyLoading.isShow) return;
    EasyLoading.show();
  }

  void hideLoading() {
    EasyLoading.dismiss(animation: true);
  }

  void showToastError({required String msg}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 14,
    );
  }
}

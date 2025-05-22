import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EasyLoadingConfig {
  static void config() {
    EasyLoading.instance.dismissOnTap = false;
    EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    EasyLoading.instance.backgroundColor = Colors.white;
    EasyLoading.instance.indicatorColor = Colors.purple;
    EasyLoading.instance.textColor = Colors.purple;
  }
}

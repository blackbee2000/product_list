import 'dart:async';

import 'package:get/get.dart';
import 'package:product_list/core/routes/app_routes.dart';
import 'package:product_list/features/app/controllers/base_controller.dart';

class SplashController extends BaseController {
  @override
  void onInit() {
    Timer(const Duration(milliseconds: 1000), () async {
      Get.offAllNamed(AppRoutes.productListScreen);
    });
    super.onInit();
  }
}

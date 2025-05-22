import 'package:get/get.dart';
import 'package:product_list/core/routes/app_routes.dart';
import 'package:product_list/features/app/controllers/product_list_controller.dart';
import 'package:product_list/features/app/controllers/splash_controller.dart';
import 'package:product_list/features/app/screens/product_list/product_list_screen.dart';
import 'package:product_list/features/app/screens/splash/splash_screen.dart';

class AppPages {
  AppPages._();

  static const Transition _kTransition = Transition.rightToLeft;
  static const Duration _kTransitionDuration = Duration(milliseconds: 200);

  static List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => const SplashScreen(),
      binding: BindingsBuilder.put(() => SplashController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.productListScreen,
      page: () => const ProductListScreen(),
      binding: BindingsBuilder.put(() => ProductListController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
  ];
}

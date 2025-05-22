import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:product_list/core/network/network_info.dart';
import 'package:product_list/features/data/repository/product_repository_impl.dart';
import 'package:product_list/features/domain/repository/product_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Connectivity>(
      Connectivity(),
      permanent: true,
    );
    Get.put<NetworkInfo>(
      NetworkInfoImpl(connectivity: Get.find<Connectivity>()),
      permanent: true,
    );

    /// Repository
    Get.lazyPut<ProductRepository>(
      () => ProductRepositoryImpl(networkInfo: Get.find<NetworkInfo>()),
      fenix: true,
    );
  }
}

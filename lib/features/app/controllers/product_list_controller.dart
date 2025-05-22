import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_list/core/extensions/dartz_extension.dart';
import 'package:product_list/core/network/network_info.dart';
import 'package:product_list/features/app/controllers/base_controller.dart';
import 'package:product_list/features/domain/entites/product_entity.dart';
import 'package:product_list/features/domain/repository/product_repository.dart';
import 'package:product_list/generated/l10n.dart';

class ProductListController extends BaseController {
  late final ProductRepository _productRepository;
  final _limit = 20;
  final _skip = 0.obs;
  final totalItems = 0.obs;
  final productList = <ProductEntity>[].obs;
  final isLoadMore = false.obs;
  final searchController = TextEditingController();
  final scrollController = ScrollController();

  @override
  void onInit() async {
    _productRepository = Get.find();
    await _getListProduct();
    super.onInit();
  }

  /// Get list product
  Future<void> _getListProduct() async {
    showLoading();

    final result = await _productRepository.getListProduct(
      skip: _skip.value,
      limit: _limit,
    );
    hideLoading();

    if (result.isLeft()) {
      showToastError(msg: result.asLeft().message);
      return;
    }

    totalItems.value = result.asRight().value1;
    productList.value = result.asRight().value2;

    final productListLocal = await _productRepository.getListProductLocal();
    if (productListLocal.isNotEmpty) {
      for (int i = 0; i < productListLocal.length; i++) {
        for (int j = 0; j < productList.length; j++) {
          if (productListLocal[i].id == productList[j].id) {
            productList[j] = productList[j].copyWith(
              isFavorite: productListLocal[i].isFavorite,
            );
          }
        }
      }
    }
  }

  /// Load more product
  Future<void> loadMoreProduct() async {
    _skip.value += 1;
    isLoadMore.value = true;

    final result = await _productRepository.getListProduct(
      skip: _skip.value,
      limit: _limit,
    );
    hideLoading();

    if (result.isLeft()) {
      showToastError(msg: result.asLeft().message);
      _skip.value = -1;
      isLoadMore.value = false;
      return;
    }

    final dataMore = result.asRight().value2;

    if (dataMore.isNotEmpty) {
      productList.addAll(dataMore);
      productList.refresh();

      final productListLocal = await _productRepository.getListProductLocal();
      if (productListLocal.isNotEmpty) {
        for (int i = 0; i < productListLocal.length; i++) {
          for (int j = 0; j < productList.length; j++) {
            if (productListLocal[i].id == productList[j].id) {
              productList[j] = productList[j].copyWith(
                isFavorite: productListLocal[i].isFavorite,
              );
            }
          }
        }
      }

      isLoadMore.value = false;
    }
  }

  /// Refresh data product
  Future<void> onRefreshDataProduct() async {
    final checkConnectInternet = await Get.find<NetworkInfo>().isConnect;

    if (!checkConnectInternet) {
      productList.value = [];
      showToastError(msg: S.current.noInternet);
      return;
    }

    if (productList.isNotEmpty) {
      scrollController.jumpTo(0);
    }
    _skip.value = 0;
    showLoading();

    final result = await _productRepository.getListProduct(
      skip: _skip.value,
      limit: _limit,
    );
    hideLoading();

    if (result.isLeft()) {
      showToastError(msg: result.asLeft().message);
      return;
    }

    totalItems.value = result.asRight().value1;
    productList.value = result.asRight().value2;
    productList.refresh();

    final productListLocal = await _productRepository.getListProductLocal();
    if (productListLocal.isNotEmpty) {
      for (int i = 0; i < productListLocal.length; i++) {
        for (int j = 0; j < productList.length; j++) {
          if (productListLocal[i].id == productList[j].id) {
            productList[j] = productList[j].copyWith(
              isFavorite: productListLocal[i].isFavorite,
            );
          }
        }
      }
    }
  }

  /// Get list product search
  Future<void> getListProductSearch({required String search}) async {
    _skip.value = 0;

    final result = await _productRepository.getListProductSearch(q: search);

    if (result.isLeft()) {
      showToastError(msg: result.asLeft().message);
      return;
    }

    productList.value = result.asRight().value2;
    productList.refresh();

    final productListLocal = await _productRepository.getListProductLocal();
    if (productListLocal.isNotEmpty) {
      for (int i = 0; i < productListLocal.length; i++) {
        for (int j = 0; j < productList.length; j++) {
          if (productListLocal[i].id == productList[j].id) {
            productList[j] = productList[j].copyWith(
              isFavorite: productListLocal[i].isFavorite,
            );
          }
        }
      }
    }
  }

  /// Toggle like product
  Future<void> onToggleProduct({required ProductEntity product}) async {
    /// Insert local
    final productListLocal = await _productRepository.getListProductLocal();
    final productLocal = productListLocal.firstWhereOrNull(
      (e) => e.id == product.id,
    );

    if (productLocal != null) {
      await _productRepository.updateProductLocal(
        product: product.copyWith(isFavorite: !product.isFavorite),
      );
    } else {
      await _productRepository.insertProductLocal(
        product: product.copyWith(isFavorite: !product.isFavorite),
      );
    }

    /// Update UI
    for (int i = 0; i < productList.length; i++) {
      if (productList[i].id == product.id) {
        productList[i] = productList[i].copyWith(
          isFavorite: !product.isFavorite,
        );
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:product_list/core/constants/app_url.dart';
import 'package:product_list/core/database/client_database.dart';
import 'package:product_list/core/database/client_manager_database.dart';
import 'package:product_list/core/network/client/dio_client.dart';
import 'package:product_list/features/data/model/dtos/product/product_model.dart';
import 'package:product_list/features/data/model/requests/get_list_product_request.dart';
import 'package:product_list/features/data/model/requests/get_list_product_search_request.dart';
import 'package:product_list/features/data/model/responses/product/product_response.dart';
import 'package:product_list/features/domain/entites/product_entity.dart';

class ProductDatasource {
  static ProductDatasource get to => ProductDatasource();

  Future<ProductResponse> getListProduct({
    required GetListProductRequest request,
  }) async {
    final response = await DioClient.instance.get(
      AppUrl.productList,
      queryParameters: request.toJson(),
    );

    return ProductResponse.fromJson(response.data);
  }

  Future<ProductResponse> getListProductSearch({
    required GetListProductSearchRequest request,
  }) async {
    final response = await DioClient.instance.get(
      AppUrl.productSearch,
      queryParameters: request.toJson(),
    );

    return ProductResponse.fromJson(response.data);
  }

  /// Get product data local
  Future<List<ProductEntity>> getProductLocalAll() async {
    try {
      final result = await ClientDatabaseManager.instance.query(
        ClientDatabase.tableProduct,
      );

      debugPrint('KET QUA ===> $result');

      return result.map((e) => ProductModel.fromJson(e).transfer()).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  /// Insert product local
  Future<bool> insertProductLocal({required ProductEntity product}) async {
    try {
      final result = await ClientDatabaseManager.instance.insert(
        ClientDatabase.tableProduct,
        product.toJsonLocal(),
      );

      debugPrint('KET QUA ===> $result');

      return result > 0 ? true : false;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  /// Update maintenance
  Future<bool> updateProductLocal({required ProductEntity product}) async {
    try {
      final result = await ClientDatabaseManager.instance.update(
        ClientDatabase.tableProduct,
        product.toJsonLocal(),
        where: ' id = ? ',
        whereArgs: [product.id],
      );

      debugPrint('KET QUA ===> $result');

      return result > 0 ? true : false;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  /// Delete maintenance
  Future<bool> deleteProductLocal({required ProductEntity product}) async {
    try {
      final result = await ClientDatabaseManager.instance.delete(
        ClientDatabase.tableProduct,
        where: ' id = ? ',
        whereArgs: [product.id],
      );

      return result > 0 ? true : false;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:product_list/core/errors/failure.dart';
import 'package:product_list/core/network/exception/network_exceptions.dart';
import 'package:product_list/core/network/network_info.dart';
import 'package:product_list/features/data/datasources/product_datasource.dart';
import 'package:product_list/features/data/model/requests/get_list_product_request.dart';
import 'package:product_list/features/data/model/requests/get_list_product_search_request.dart';
import 'package:product_list/features/domain/entites/product_entity.dart';
import 'package:product_list/features/domain/repository/product_repository.dart';
import 'package:product_list/generated/l10n.dart';

class ProductRepositoryImpl extends ProductRepository {
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({required this.networkInfo});

  @override
  Future<Either<Failure, Tuple2<int, List<ProductEntity>>>> getListProduct({
    int skip = 0,
    int limit = 20,
  }) async {
    try {
      if (!(await networkInfo.isConnect)) {
        return left(NetworkFailure(S.current.noInternet));
      }

      final response = await ProductDatasource.to.getListProduct(
        request: GetListProductRequest(limit: limit, skip: skip),
      );

      if (response.products != null) {
        return right(
          Tuple2(
            response.total ?? 0,
            response.products!.map((e) => e.transfer()).toList(),
          ),
        );
      }

      return left(ServerFailure(S.current.getProductListError));
    } catch (e) {
      final NetworkExceptions networkExceptions =
          NetworkExceptions.getDioException(e);
      return left(
        SystemFailure(
          NetworkExceptions.getErrorMessage(networkExceptions),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Tuple2<int, List<ProductEntity>>>>
      getListProductSearch({required String q}) async {
    try {
      // if (!(await network.isConnect)) {
      //   return left(NetworkFailure(S.current.noInternet));
      // }

      final response = await ProductDatasource.to.getListProductSearch(
        request: GetListProductSearchRequest(q: q),
      );

      if (response.products != null) {
        return right(
          Tuple2(
            response.total ?? 0,
            response.products!.map((e) => e.transfer()).toList(),
          ),
        );
      }

      return left(ServerFailure(S.current.getProductListError));
    } catch (e) {
      final NetworkExceptions networkExceptions =
          NetworkExceptions.getDioException(e);
      return left(
        SystemFailure(
          NetworkExceptions.getErrorMessage(networkExceptions),
        ),
      );
    }
  }

  @override
  Future<bool> deleteProductLocal({required ProductEntity product}) async {
    try {
      final result = await ProductDatasource.to.deleteProductLocal(
        product: product,
      );

      return result;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  @override
  Future<List<ProductEntity>> getListProductLocal() async {
    try {
      final result = await ProductDatasource.to.getProductLocalAll();

      return result;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  @override
  Future<bool> insertProductLocal({required ProductEntity product}) async {
    try {
      final result = await ProductDatasource.to.insertProductLocal(
        product: product,
      );

      return result;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  @override
  Future<bool> updateProductLocal({required ProductEntity product}) async {
    try {
      final result = await ProductDatasource.to.updateProductLocal(
        product: product,
      );

      return result;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}

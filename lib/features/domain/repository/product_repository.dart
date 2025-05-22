import 'package:dartz/dartz.dart';
import 'package:product_list/core/errors/failure.dart';
import 'package:product_list/features/domain/entites/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, Tuple2<int, List<ProductEntity>>>> getListProduct({
    int skip = 0,
    int limit = 20,
  });

  Future<Either<Failure, Tuple2<int, List<ProductEntity>>>>
      getListProductSearch({required String q});

  Future<List<ProductEntity>> getListProductLocal();

  Future<bool> insertProductLocal({
    required ProductEntity product,
  });

  Future<bool> updateProductLocal({
    required ProductEntity product,
  });

  Future<bool> deleteProductLocal({
    required ProductEntity product,
  });
}

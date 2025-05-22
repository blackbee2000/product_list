import 'package:json_annotation/json_annotation.dart';
import 'package:product_list/features/data/model/dtos/product/product_model.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse {
  final List<ProductModel>? products;
  final int? total;
  final int? skip;
  final int? limit;

  ProductResponse({this.products, this.total, this.skip, this.limit});

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}

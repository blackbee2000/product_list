import 'package:json_annotation/json_annotation.dart';
import 'package:product_list/features/domain/entites/product_entity.dart';
import 'package:product_list/features/domain/mapper/mapper.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel implements Transfer<ProductEntity> {
  final int? id;
  final String? title;
  final String? description;
  final String? category;
  final double? price;
  final double? discountPercentage;
  final double? rating;
  final int? stock;
  final List<String>? tags;
  final String? sku;
  final double? weight;
  final DimensionsModel? dimensions;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final List<ReviewModel>? reviews;
  final String? returnPolicy;
  final int? minimumOrderQuantity;
  final MetaModel? meta;
  final List<String>? images;
  final String? thumbnail;
  final int? isFavorite;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  ProductModel({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.images,
    this.thumbnail,
    this.isFavorite,
  });

  @override
  ProductEntity transfer() => ProductEntity(
        id: id ?? 0,
        title: title != null && title!.isNotEmpty ? title : null,
        description:
            description != null && description!.isNotEmpty ? description : null,
        category: category != null && category!.isNotEmpty ? category : null,
        price: price ?? 0,
        discountPercentage: discountPercentage ?? 0,
        rating: rating ?? 0,
        stock: stock ?? 0,
        tags: tags ?? [],
        sku: sku != null && sku!.isNotEmpty ? sku : null,
        weight: weight ?? 0,
        dimensions: dimensions?.transfer(),
        warrantyInformation:
            warrantyInformation != null && warrantyInformation!.isNotEmpty
                ? warrantyInformation
                : null,
        shippingInformation:
            shippingInformation != null && shippingInformation!.isNotEmpty
                ? shippingInformation
                : null,
        availabilityStatus:
            availabilityStatus != null && availabilityStatus!.isNotEmpty
                ? availabilityStatus
                : null,
        reviews: reviews != null && reviews!.isNotEmpty
            ? reviews!.map((e) => e.transfer()).toList()
            : [],
        returnPolicy: returnPolicy != null && returnPolicy!.isNotEmpty
            ? returnPolicy
            : null,
        minimumOrderQuantity: minimumOrderQuantity ?? 0,
        meta: meta?.transfer(),
        images: images ?? [],
        thumbnail:
            thumbnail != null && thumbnail!.isNotEmpty ? thumbnail : null,
        isFavorite: isFavorite != null && isFavorite == 1 ? true : false,
      );
}

@JsonSerializable()
class DimensionsModel implements Transfer<DimensionsEntity> {
  final double? width;
  final double? height;
  final double? depth;

  DimensionsModel({
    this.width,
    this.height,
    this.depth,
  });

  factory DimensionsModel.fromJson(Map<String, dynamic> json) =>
      _$DimensionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DimensionsModelToJson(this);

  @override
  DimensionsEntity transfer() => DimensionsEntity(
        width: width ?? 0,
        height: height ?? 0,
        depth: depth ?? 0,
      );
}

@JsonSerializable()
class ReviewModel implements Transfer<ReviewEntity> {
  final int? rating;
  final String? comment;
  final DateTime? date;
  final String? reviewerName;
  final String? reviewerEmail;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);

  ReviewModel({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  @override
  ReviewEntity transfer() => ReviewEntity(
        rating: rating ?? 0,
        comment: comment != null && comment!.isNotEmpty ? comment : null,
        date: date,
        reviewerEmail: reviewerEmail != null && reviewerEmail!.isNotEmpty
            ? reviewerEmail
            : null,
        reviewerName: reviewerName != null && reviewerName!.isNotEmpty
            ? reviewerName
            : null,
      );
}

@JsonSerializable()
class MetaModel implements Transfer<MetaEntity> {
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? barcode;
  final String? qrCode;

  MetaModel({
    this.createdAt,
    this.updatedAt,
    this.barcode,
    this.qrCode,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) =>
      _$MetaModelFromJson(json);

  Map<String, dynamic> toJson() => _$MetaModelToJson(this);

  @override
  MetaEntity transfer() => MetaEntity(
        createdAt: createdAt,
        updatedAt: updatedAt,
        barcode: barcode != null && barcode!.isNotEmpty ? barcode : null,
        qrCode: qrCode != null && qrCode!.isNotEmpty ? qrCode : null,
      );
}

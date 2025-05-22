class ProductEntity {
  final int id;
  final String? title;
  final String? description;
  final String? category;
  final double? price;
  final double? discountPercentage;
  final double? rating;
  final int? stock;
  final List<String> tags;
  final String? sku;
  final double? weight;
  final DimensionsEntity? dimensions;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final List<ReviewEntity> reviews;
  final String? returnPolicy;
  final int minimumOrderQuantity;
  final MetaEntity? meta;
  final List<String> images;
  final String? thumbnail;
  final bool isFavorite;

  ProductEntity({
    this.id = 0,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags = const [],
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews = const [],
    this.returnPolicy,
    this.minimumOrderQuantity = 0,
    this.meta,
    this.images = const [],
    this.thumbnail,
    this.isFavorite = false,
  });

  ProductEntity copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    double? price,
    double? discountPercentage,
    double? rating,
    int? stock,
    List<String>? tags,
    String? sku,
    double? weight,
    DimensionsEntity? dimensions,
    String? warrantyInformation,
    String? shippingInformation,
    String? availabilityStatus,
    List<ReviewEntity>? reviews,
    String? returnPolicy,
    int? minimumOrderQuantity,
    MetaEntity? meta,
    List<String>? images,
    String? thumbnail,
    bool? isFavorite,
  }) =>
      ProductEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        price: price ?? this.price,
        discountPercentage: discountPercentage ?? this.discountPercentage,
        rating: rating ?? this.rating,
        stock: stock ?? this.stock,
        tags: tags ?? this.tags,
        sku: sku ?? this.sku,
        weight: weight ?? this.weight,
        dimensions: dimensions ?? this.dimensions,
        warrantyInformation: warrantyInformation ?? this.warrantyInformation,
        shippingInformation: shippingInformation ?? this.shippingInformation,
        availabilityStatus: availabilityStatus ?? this.availabilityStatus,
        reviews: reviews ?? this.reviews,
        returnPolicy: returnPolicy ?? this.returnPolicy,
        minimumOrderQuantity: minimumOrderQuantity ?? this.minimumOrderQuantity,
        meta: meta ?? this.meta,
        images: images ?? this.images,
        thumbnail: thumbnail ?? this.thumbnail,
        isFavorite: isFavorite ?? this.isFavorite,
      );

  Map<String, dynamic> toJsonLocal() => {
        "id": id,
        "title": title,
        "description": description,
        "category": category,
        "price": price,
        "rating": rating,
        "stock": stock,
        "thumbnail": thumbnail,
        "isFavorite": isFavorite ? 1 : 0,
      };
}

class DimensionsEntity {
  final double width;
  final double height;
  final double depth;

  DimensionsEntity({
    this.width = 0,
    this.height = 0,
    this.depth = 0,
  });
}

class ReviewEntity {
  final int rating;
  final String? comment;
  final DateTime? date;
  final String? reviewerName;
  final String? reviewerEmail;

  ReviewEntity({
    this.rating = 0,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });
}

class MetaEntity {
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? barcode;
  final String? qrCode;

  MetaEntity({
    this.createdAt,
    this.updatedAt,
    this.barcode,
    this.qrCode,
  });
}

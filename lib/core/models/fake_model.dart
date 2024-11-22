import 'package:pdf_test/core/models/product_model.dart';

class FakeModel {
  final List<ProductModel> productModel;
  final String image;
  final DateTime createdAt;
  final String companyName;
  final String companyAddress;
  final String snCode;
  final String customer;
  final double totalPrice;
  final double totalQQS;
  final int stir;
  final int id;

  const FakeModel({
    required this.productModel,
    required this.image,
    required this.createdAt,
    required this.companyName,
    required this.companyAddress,
    required this.snCode,
    required this.customer,
    required this.totalPrice,
    required this.totalQQS,
    required this.stir,
    required this.id,
  });

  factory FakeModel.fromJson(Map<String, Object?> json) {
    return FakeModel(
      productModel: (json['productModel'] as List<ProductModel>)
          .map((item) => ProductModel.fromJson(item as Map<String, Object?>))
          .toList(),
      image: json['image'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      companyName: json['companyName'] as String,
      companyAddress: json['companyAddress'] as String,
      snCode: json['snCode'] as String,
      customer: json['customer'] as String,
      totalPrice: json['totalPrice'] as double,
      totalQQS: json['totalQQS'] as double,
      stir: json['stir'] as int,
      id: json['id'] as int,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'productModel': productModel.map((item) => item.toJson()).toList(),
      'image': image,
      'createdAt': createdAt.toIso8601String(),
      'companyName': companyName,
      'companyAddress': companyAddress,
      'snCode': snCode,
      'customer': customer,
      'totalPrice': totalPrice,
      'totalQQS': totalQQS,
      'stir': stir,
      'id': id,
    };
  }

  FakeModel copyWith({
    List<ProductModel>? productModel,
    String? image,
    DateTime? createdAt,
    String? companyName,
    String? companyAddress,
    String? snCode,
    String? customer,
    double? totalPrice,
    double? totalQQS,
    int? stir,
    int? id,
  }) {
    return FakeModel(
      productModel: productModel ?? this.productModel,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      companyName: companyName ?? this.companyName,
      companyAddress: companyAddress ?? this.companyAddress,
      snCode: snCode ?? this.snCode,
      customer: customer ?? this.customer,
      totalPrice: totalPrice ?? this.totalPrice,
      totalQQS: totalQQS ?? this.totalQQS,
      stir: stir ?? this.stir,
      id: id ?? this.id,
    );
  }
}

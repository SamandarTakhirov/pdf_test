class ProductModel {
  final String productName;
  final double price;
  final double qqs;
  final String productInfo;

  const ProductModel({
    required this.productName,
    required this.price,
    required this.qqs,
    required this.productInfo,
  });

  factory ProductModel.fromJson(Map<String, Object?> json) {
    return ProductModel(
      productName: json['productName'] as String,
      price: (json['price'] as num).toDouble(),
      qqs: (json['qqs'] as num).toDouble(),
      productInfo: json['productInfo'] as String,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'productName': productName,
      'price': price,
      'qqs': qqs,
      'productInfo': productInfo,
    };
  }

  ProductModel copyWith({
    String? productName,
    double? price,
    double? qqs,
    String? productInfo,
  }) {
    return ProductModel(
      productName: productName ?? this.productName,
      price: price ?? this.price,
      qqs: qqs ?? this.qqs,
      productInfo: productInfo ?? this.productInfo,
    );
  }
}

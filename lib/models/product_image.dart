class ProductImage {
  final String imageUrl, description;
  final int id;

  ProductImage({
    this.imageUrl,
    this.description,
    this.id,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      imageUrl: json['image'],
      description: json['description'],
    );
  }
}

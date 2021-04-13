class Product {
  final int id, price, category;
  final String title, description, image, state, url;

  Product({
    this.id,
    this.price,
    this.category,
    this.title,
    this.description,
    this.image,
    this.state,
    this.url,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      state: json['state'],
      image: json['image'],
      price: json['price'],
      url: json['url'],
      category: json['category'],
    );
  }
}

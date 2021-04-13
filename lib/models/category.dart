class Category {
  final int id;
  final String name, description, icon, url;

  Category({
    this.id,
    this.name,
    this.description,
    this.icon,
    this.url,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        icon: json['icon'],
        url: json['url']);
  }
}

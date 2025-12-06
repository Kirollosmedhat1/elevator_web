class ProductModel {
  final String? id;
  final String image;
  final String title;
  final String description;
  final String? fullDescription;
  final String? lang;
  final String? slug;

  ProductModel({
    this.id,
    required this.image,
    required this.title,
    required this.description,
    this.fullDescription,
    this.lang,
    this.slug,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] != null ? map['id'].toString() : null,
      image: (map['photo'] ?? map['image'] ?? '') as String,
      title: (map['name'] ?? map['title'] ?? '') as String,
      description: (map['intro'] ?? map['description'] ?? '') as String,
      fullDescription: map['reed more'] ?? map['fullDescription'],
      lang: map['lang'] as String?,
      slug: map['slug'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'photo': image,
      'name': title,
      'intro': description,
      'reed more': fullDescription,
      'lang': lang,
      'slug': slug,
    };
  }
}

class ProductModel {
  final String image;
  final String title;
  final String description;

  ProductModel({
    required this.image,
    required this.title,
    required this.description,
  });

  factory ProductModel.fromMap(Map<String, String> map) {
    return ProductModel(
      image: map['image'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }

  Map<String, String> toMap() {
    return {'image': image, 'title': title, 'description': description};
  }
}

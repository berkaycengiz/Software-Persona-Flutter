class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String category;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final rawId = json['id'];
    final idString = rawId != null ? rawId.toString() : '';
    
    final rawPrice = json['price'];
    double parsedPrice = 0.0;
    if (rawPrice != null) {
      if (rawPrice is num) {
        parsedPrice = rawPrice.toDouble();
      } else {
        parsedPrice = double.tryParse(rawPrice.toString()) ?? 0.0;
      }
    }

    final imageUrlString = json['imageUrl'] ?? json['image'] ?? '';

    return Product(
      id: idString,
      title: json['title'] ?? json['name'] ?? 'Unnamed Product',
      description: json['description'] ?? 'No description available.',
      price: parsedPrice,
      imageUrl: imageUrlString,
      category: json['category'] ?? 'General',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
    };
  }
}

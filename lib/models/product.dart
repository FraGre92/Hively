// lib/models/product.dart

class Product {
  final String id;
  final String name;
  final String brand;
  final double rating;
  final String priceRange;
  final String? imageUrl;
  final String? description;
  final List<String>? tags; // es. ['vegan', 'cruelty-free']
  final String? skinType; // Tipo di pelle consigliato
  final int reviewsCount;
  
  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.rating,
    required this.priceRange,
    this.imageUrl,
    this.description,
    this.tags,
    this.skinType,
    this.reviewsCount = 0,
  });
  
  // Conversione da JSON (per API future)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String,
      rating: (json['rating'] as num).toDouble(),
      priceRange: json['priceRange'] as String,
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>(),
      skinType: json['skinType'] as String?,
      reviewsCount: json['reviewsCount'] as int? ?? 0,
    );
  }
  
  // Conversione a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'rating': rating,
      'priceRange': priceRange,
      'imageUrl': imageUrl,
      'description': description,
      'tags': tags,
      'skinType': skinType,
      'reviewsCount': reviewsCount,
    };
  }
  
  // Helper per ottenere il simbolo $ in base al prezzo
  String getPriceSymbol() {
    if (priceRange.contains('\$\$\$\$')) return '\$\$\$\$';
    if (priceRange.contains('\$\$\$')) return '\$\$\$';
    if (priceRange.contains('\$\$')) return '\$\$';
    return '\$';
  }
}

// Model per le recensioni
class Review {
  final String id;
  final String productId;
  final String userId;
  final String username;
  final String? userAvatar;
  final double rating;
  final String? title;
  final String content;
  final DateTime createdAt;
  final List<String>? photos; // URL foto allegate
  final bool verified; // Acquisto verificato
  
  Review({
    required this.id,
    required this.productId,
    required this.userId,
    required this.username,
    this.userAvatar,
    required this.rating,
    this.title,
    required this.content,
    required this.createdAt,
    this.photos,
    this.verified = false,
  });
  
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as String,
      productId: json['productId'] as String,
      userId: json['userId'] as String,
      username: json['username'] as String,
      userAvatar: json['userAvatar'] as String?,
      rating: (json['rating'] as num).toDouble(),
      title: json['title'] as String?,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      photos: (json['photos'] as List<dynamic>?)?.cast<String>(),
      verified: json['verified'] as bool? ?? false,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'userId': userId,
      'username': username,
      'userAvatar': userAvatar,
      'rating': rating,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'photos': photos,
      'verified': verified,
    };
  }
}

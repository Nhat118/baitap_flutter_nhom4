class Product {
  int id;
  String title;
  dynamic price;
  String description;
  String category;
  String image;

  //Rating rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    // required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']??0,
      title: json['title']??"",
      price: json['price']??0,
      description: json['description']??"",
      category: json['category']??"",
      image: json['image']??"",
    );
  }
}

class Rating {
  double rate;
  int count;

  Rating({required this.rate, required this.count});

  // Thêm factory để parse JSON cho Rating
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num).toDouble(), // Chuyển đổi an toàn sang double
      count: json['count'] ?? 0,
    );
  }
}

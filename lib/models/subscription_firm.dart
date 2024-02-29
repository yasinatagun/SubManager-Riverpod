import 'package:subscription_manager/models/category.dart';

class SubscriptionFirm {
  final String name;
  final String imageUrl;
  final Category category;

  SubscriptionFirm({
    required this.name,
    required this.imageUrl,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'category': category.toMap(), 
    };
  }

  static SubscriptionFirm fromMap(Map<String, dynamic> map) {
    return SubscriptionFirm(
      name: map['name'],
      imageUrl: map['imageUrl'],
      category: Category.fromMap(map['category']),
    );
  }
}

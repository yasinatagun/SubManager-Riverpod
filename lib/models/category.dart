import 'package:flutter/material.dart';

enum Categories {
  entertainment,
  finance,
  sport,
  business,
  education,
  website,
  game,
}

class Category {
  final String categoryName;
  final Color color;

  Category({
    required this.categoryName,
    required this.color,
  });
   Map<String, dynamic> toMap() {
    return {
      'categoryName': categoryName,
      'color': color.value, // Convert Color to int
    };
  }

  static Category fromMap(Map<String, dynamic> map) {
    return Category(
      categoryName: map['categoryName'],
      color: Color(map['color']), // Convert int back to Color
    );
  }
}

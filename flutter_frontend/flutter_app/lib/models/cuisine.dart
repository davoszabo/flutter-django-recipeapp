import 'package:flutter/foundation.dart';

class Cuisine {
  final int id;
  final String name;
  final String image_url;
  final String description;
  final String cuisine;
  final String diet;
  final String prep_time;
  final String instructions;
  final int image_available;

  const Cuisine({
    @required this.id,
    @required this.name,
    @required this.image_url,
    @required this.description,
    @required this.cuisine,
    @required this.diet,
    @required this.prep_time,
    @required this.instructions,
    @required this.image_available,
  });

  factory Cuisine.fromJson(Map<String, dynamic> json) {
    return Cuisine(
      id: json['id'],
      name: json['name'],
      image_url: json['image_url'],
      description: json['description'],
      cuisine: json['cuisine'],
      diet: json['diet'],
      prep_time: json['prep_time'],
      instructions: json['instructions'],
      image_available: json['image_available'],
    );
  }
}

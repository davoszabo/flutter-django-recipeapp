import 'package:flutter/foundation.dart';

class Recipe {
  final int id;
  final String name;
  final String author_name;
  final String submitted;
  final String image_url;
  final int minutes;
  final String description;
  final String category;
  final List<String> tags;
  final List<String> search_terms;
  final List<String> steps;
  final List<String> ingredients;
  final List<String> ingredients_raw_str;
  final String serving_size;
  final int servings;
  final String calories;
  final String rating;
  final int review_count;

  const Recipe({
    @required this.id,
    @required this.name,
    this.author_name,
    this.submitted,
    @required this.image_url,
    @required this.minutes,
    this.description,
    this.category,
    this.tags,
    @required this.search_terms,
    this.steps,
    this.ingredients,
    this.ingredients_raw_str,
    this.serving_size,
    this.servings,
    this.calories,
    @required this.rating,
    this.review_count,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as int,
      name: json['name'],
      author_name: json['author_name'],
      submitted: json['submitted'],
      image_url: json['image_url'],
      minutes: json['minutes'],
      description: json['description'],
      category: json['category'],
      tags: json["tags"] != null
          ? new List<String>.from(json["tags"].map((x) => x))
          : [],
      search_terms: json["search_terms"] != null
          ? new List<String>.from(json["search_terms"].map((x) => x))
          : [],
      steps: json["steps"] != null
          ? new List<String>.from(json["steps"].map((x) => x))
          : [],
      ingredients: json["ingredients"] != null
          ? new List<String>.from(json["ingredients"].map((x) => x))
          : [],
      ingredients_raw_str: json["ingredients_raw_str"] != null
          ? new List<String>.from(json["ingredients_raw_str"].map((x) => x))
          : [],
      serving_size: json['serving_size'],
      servings: json['servings'],
      calories: json['calories'],
      rating: json['rating'],
      review_count: json['review_count'],
    );
  }
}

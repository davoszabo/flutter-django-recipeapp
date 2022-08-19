import 'package:flutter/material.dart';

import '../models/filter.dart';

class Filters with ChangeNotifier {
  List<Filter> filters = [
    Filter(category: "mealtime", name: "dinner"),
    Filter(category: "mealtime", name: "breakfast"),
    Filter(category: "mealtime", name: "dessert"),
    Filter(category: "mealtime", name: "lunch"),
    Filter(category: "mealtime", name: "side"),
    
    Filter(category: "health", name: "low-calorie"),
    Filter(category: "health", name: "vegetarian"),
    Filter(category: "health", name: "vegan"),
    Filter(category: "health", name: "healthy"),
    Filter(category: "health", name: "low-fat"),

    Filter(category: "allergenic", name: "diabetic"),
    Filter(category: "allergenic", name: "gluten-free"),
    Filter(category: "allergenic", name: "lactose-free"),

    Filter(category: "ingredient", name: "chicken"),
    Filter(category: "ingredient", name: "bread"),
    Filter(category: "ingredient", name: "pasta"),
    Filter(category: "ingredient", name: "salad"),
    Filter(category: "ingredient", name: "chicken"),
    Filter(category: "ingredient", name: "cake"),
    Filter(category: "ingredient", name: "cookie"),
    Filter(category: "ingredient", name: "soup"),

    Filter(category: "cuisine", name: "mexican"),
    Filter(category: "cuisine", name: "southern"),
    Filter(category: "cuisine", name: "european"),

  ];

  List<Filter> get items {
    return [...filters];
  }
}

import 'package:flutter/material.dart';

import '../models/filter.dart';

class Filters with ChangeNotifier {
  List<Filter> filters = [
    Filter(category: "meal-time", name: "dinner"),
    Filter(category: "meal-time", name: "breakfast"),
    Filter(category: "meal-time", name: "dessert"),
    Filter(category: "meal-time", name: "lunch"),
    Filter(category: "meal-time", name: "side"),
    Filter(category: "meal-time", name: "appetizer"),
    Filter(category: "meal-time", name: "snack"),
    Filter(category: "meal-time", name: "holiday-event"),
    
    Filter(category: "health", name: "vegetarian"),
    Filter(category: "health", name: "vegan"),
    Filter(category: "health", name: "healthy"),
    Filter(category: "health", name: "low-calorie"),
    Filter(category: "health", name: "low-cholesterol"),
    Filter(category: "health", name: "low-fat"),
    Filter(category: "health", name: "low-soduim"),
    Filter(category: "health", name: "low-carb"),

    Filter(category: "allergenic", name: "diabetic"),
    Filter(category: "allergenic", name: "gluten-free"),
    Filter(category: "allergenic", name: "lactose-free"),

    Filter(category: "ingredient", name: "chicken"),
    Filter(category: "ingredient", name: "bread"),
    Filter(category: "ingredient", name: "pasta"),
    Filter(category: "ingredient", name: "pizza"),
    Filter(category: "ingredient", name: "noodles"),
    Filter(category: "ingredient", name: "cheese"),
    Filter(category: "ingredient", name: "salad"),
    Filter(category: "ingredient", name: "vegetables"),
    Filter(category: "ingredient", name: "tomatoes"),
    Filter(category: "ingredient", name: "potatoes"),
    Filter(category: "ingredient", name: "fruit"),
    Filter(category: "ingredient", name: "pork"),
    Filter(category: "ingredient", name: "beef"),
    Filter(category: "ingredient", name: "rice"),
    Filter(category: "ingredient", name: "fish"),
    Filter(category: "ingredient", name: "shrimp"),
    Filter(category: "ingredient", name: "sandwich"),
    Filter(category: "ingredient", name: "cake"),
    Filter(category: "ingredient", name: "cookie"),
    Filter(category: "ingredient", name: "pie"),
    Filter(category: "ingredient", name: "pudding"),
    Filter(category: "ingredient", name: "soup"),
    Filter(category: "ingredient", name: "stew"),

    Filter(category: "cuisine", name: "mexican"),
    Filter(category: "cuisine", name: "southern"),
    Filter(category: "cuisine", name: "european"),
    Filter(category: "cuisine", name: "italian"),
    Filter(category: "cuisine", name: "french"),
    Filter(category: "cuisine", name: "german"),
    Filter(category: "cuisine", name: "english"),
    Filter(category: "cuisine", name: "thai"),
    Filter(category: "cuisine", name: "chinese"),
    Filter(category: "cuisine", name: "indian"),
    Filter(category: "cuisine", name: "greek"),
    Filter(category: "cuisine", name: "caribbean"),

    Filter(category: "preparation", name: "baked"),
    Filter(category: "preparation", name: "roast"),
    Filter(category: "preparation", name: "oven"),
    Filter(category: "preparation", name: "casserole"),
    Filter(category: "preparation", name: "barbecue"),

    Filter(category: "time", name: "15-minutes-or-less"),
    Filter(category: "time", name: "30-minutes-or-less"),
    Filter(category: "time", name: "60-minutes-or-less"),
    Filter(category: "time", name: "4-hours-or-less"),

  ];

  List<Filter> get items {
    return [...filters];
  }
}

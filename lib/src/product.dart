import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(nullable: false)
class Product {
  String name;
  String recipe;
  int quantity;
  double price;

  bool _checked = false;
  List<String> _categories = [];

  Product({this.name, this.quantity, this.price, this.recipe});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  /// Gets the cost of the product
  double getCost() => quantity * price;

  /// Returns if item has been checked off the list
  bool isChecked() => _checked;

  /// Checks the item off the list
  void check() => _checked = true;

  /// Adds a category to this item
  void addCategory(String category) {
    if (!_categories.contains(category)) {
      _categories.add(category);
    }
  }

  /// Removes a category from this item
  void removeCategory(String category) => _categories.remove(category);

  /// Returns the list of categories on the item
  List<String> getCategories() => _categories;
}
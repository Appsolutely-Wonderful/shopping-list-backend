import 'package:ShoppingListBackend/src/product.dart';

typedef ForEachCallback = void Function(Product item);

class ShoppingList {
  String _name;
  List<Product> _items = [];

  /// Used to track the current categories of items in the list
  Map<String, int> _categories = {};

  ShoppingList();

  factory ShoppingList.fromJson(Map<String, dynamic> json) =>
      _$ShoppingListFromJson(json);
  Map<String, dynamic> toJson() => _$ShoppingListToJson(this);

  /// Gets the name of the list
  String getName() => _name;

  /// Sets the name of the list
  String setName(String name) => _name = name;

  /// Adds an item to the list
  void add(Product item) {
    _addCategoriesOrIncrementRefs(item.getCategories());
    _items.add(item);
  }

  /// Removes an item from the list
  void removeAt(int index) {
    _removeCategoriesOrDecrementRefs(_items[index].getCategories());
    _items.removeAt(index);
  }

  /// Gets the item at the specified index
  Product getItem(int index) => _items.elementAt(index);

  /// Returns all categories in the list
  List<String> getCategories() => _categories.keys;

  /// Returns the total cost of all items in the list
  double getTotalCost() {
    double total = 0;
    _items.forEach((item) {
      total += item.getCost();
    });
    return total;
  }

  void forEach(ForEachCallback cb) {
    _items.forEach(cb);
  }

  Map<String, List<Product>> getItemsByCategory() {
    Map<String, List<Product>> groups;
    // Go through each item and add the items to a map where
    // the key is the category and associated list is the items in that
    // category.
    _items.forEach((Product item) {
      List<String> categories = item.getCategories();
      categories.forEach((String category) {
        if (groups.containsKey(category)) {
          groups[category].add(item);
        } else {
          groups[category] = [item];
        }
      });
    });
    return groups;
  }

  Map<String, List<Product>> getItemsByRecipe() {
    Map<String, List<Product>> groups;
    // Go through each item and add the items to a map where
    // the key is the category and associated list is the items in that
    // category.
    _items.forEach((Product item) {
      if (groups.containsKey(item.recipe)) {
        groups[item.recipe].add(item);
      } else {
        groups[item.recipe] = [item];
      }
    });
  }

  /// Adds each category to the ongoing categories
  void _addCategoriesOrIncrementRefs(List<String> categories) {
    _categories.forEach((String category, _) {
      // If there's no key in the category map
      // add it.
      if (!_isCategoryInList(category)) {
        _createCategory(category);
      }
      // If the key is already in the category map,
      // add one to the counter.
      else {
        _incrementCategoryRefs(category);
      }
    });
  }

  void _removeCategoriesOrDecrementRefs(List<String> categories) {
    _categories.forEach((String category, _) {
      // This function is only called when removing items from the list
      // So the key should always be in the map.
      assert(_categories.containsKey(category));
      _decrementCategoryRefs(category);
      if (_getCategoryRefs(category) == 0) {
        _categories.remove(category);
      }
    });
  }

  void _decrementCategoryRefs(String category) {
    assert(_categories.containsKey(category));
    _categories[category]--;
  }

  void _incrementCategoryRefs(String category) {
    assert(_categories.containsKey(category));
    _categories[category]++;
  }

  void _createCategory(String category) {
    assert(!_categories.containsKey(category));
    _categories[category] = 1;
  }

  int _getCategoryRefs(String category) {
    return _categories[category];
  }

  bool _isCategoryInList(String category) {
    return _categories.containsKey(category);
  }
}

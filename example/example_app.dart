import 'dart:io';

import 'package:ShoppingListBackend/src/product.dart';
import 'package:ShoppingListBackend/src/shopping_list.dart';

typedef ParseFn = Function(String);

class UserInterface {
  static dynamic getInputAndParse(ParseFn parser) {
    dynamic result = null;
    do {
      var userString = stdin.readLineSync();
      result = parser(userString);
    } while (result == null);
    return result;
  }

  static void writePrompt(String prompt) {
    stdout.write(prompt);
  }

  static String getInputString() {
    return stdin.readLineSync();
  }

  static double getInputDouble() {
    return getInputAndParse(double.tryParse);
  }

  static int getInputInteger() {
    return getInputAndParse(int.tryParse);
  }

  static void writeLine(String message) {
    stdout.writeln(message);
  }
}

/// Gets user input and creates a product through
/// command line input
class ProductGenerator {
  static String getName() {
    UserInterface.writePrompt("Enter product name: ");
    return UserInterface.getInputString();
  }

  static String getRecipe() {
    UserInterface.writePrompt("Enter recipe name: ");
    return UserInterface.getInputString();
  }

  static String getUnits() {
    UserInterface.writePrompt("Enter unit name: ");
    return UserInterface.getInputString();
  }

  static double getQuantity() {
    UserInterface.writePrompt("Enter quantity: ");
    return UserInterface.getInputDouble();
  }

  static double getPricePerUnit() {
    UserInterface.writePrompt("Enter price per unit: ");
    return UserInterface.getInputDouble();
  }

  static Product createProduct() {
    var name = getName();
    var recipe = getRecipe();
    var unit = getUnits();
    var quantity = getQuantity();
    var price = getPricePerUnit();
    return Product(
      name: name,
      recipe: recipe,
      unit: unit,
      quantity: quantity,
      price: price,
    );
  }
}

class ListManager {
  List<ShoppingList> _shoppingLists = [];

  ShoppingList getList(int index) {
    if (index <= _shoppingLists.length && index >= 0) {
      return _shoppingLists[index];
    } else {
      return null;
    }
  }

  String _getShoppingListName() {
    UserInterface.writePrompt("Enter list name: ");
    return UserInterface.getInputString();
  }

  ShoppingList createList() {
    var name = _getShoppingListName();
    ShoppingList newList = ShoppingList(name: name);
    _shoppingLists.add(newList);
    return newList;
  }

  void displayLists() {
    UserInterface.writeLine("--- All Lists ---");
    var prefix = 1;
    _shoppingLists.forEach((shoppingList) {
      UserInterface.writeLine("$prefix. ${shoppingList.getName()}");
      prefix++;
    });
    UserInterface.writeLine("--- End Lists ---");
  }
}

enum AppState { mainMenu, createList, selectList }

class App {
  ListManager _listManager = ListManager();
  ShoppingList _selectedList = null;

  static const int cmdCreateList = 1;
  static const int cmdDisplayList = 2;
  static const int cmdSelectList = 3;
  static const int cmdAddProduct = 4;
  static const int cmdDisplayItems = 5;
  static const int cmdExitProgram = 6;

  String _getSelectedListName() {
    var listName = _selectedList?.getName();
    if (listName == null) {
      listName = "No list selected";
    }
    return listName;
  }

  void _displayPrompt() {
    var listName = _getSelectedListName();
    UserInterface.writeLine("Selected List: ${listName}");
    UserInterface.writeLine("1. Create list");
    UserInterface.writeLine("2. Display lists");
    UserInterface.writeLine("3. Select List");
    UserInterface.writeLine("4. Add Product to selected list");
    UserInterface.writeLine("5. Display items in selected list");
    UserInterface.writeLine("6. Exit Program");
  }

  int _getCommand() {
    return UserInterface.getInputInteger();
  }

  void _createShoppingList() {
    _selectedList = _listManager.createList();
  }

  void _selectList() {
    _listManager.displayLists();
    int listIndexToSelect;
    ShoppingList newSelectedList = null;
    do {
      UserInterface.writeLine("Enter list # to select");
      listIndexToSelect = UserInterface.getInputInteger();
      newSelectedList = _listManager.getList(listIndexToSelect - 1);
    } while (newSelectedList == null);
    _selectedList = newSelectedList;
  }

  void _addProductToSelectedList() {
    Product newProduct = ProductGenerator.createProduct();
    _selectedList.add(newProduct);
  }

  void _displaySelectedListItems() {
    var name = _selectedList.getName();
    UserInterface.writeLine("Items in $name:");
    _selectedList.forEach((product) {
      UserInterface.writeLine(product.toString());
    });
  }

  void _dispatchCommand(int cmd) {
    switch (cmd) {
      case cmdCreateList:
        _createShoppingList();
        break;
      case cmdDisplayList:
        _listManager.displayLists();
        break;
      case cmdSelectList:
        _selectList();
        break;
      case cmdAddProduct:
        _addProductToSelectedList();
        break;
      case cmdDisplayItems:
        _displaySelectedListItems();
        break;
      case cmdExitProgram:
        exit(0);
        break;
    }
  }

  void _getAndExecuteCommand() {
    var cmd = _getCommand();
    _dispatchCommand(cmd);
  }

  void main() {
    while (true) {
      _displayPrompt();
      _getAndExecuteCommand();
    }
  }
}

void main() {
  App myApp = App();
  myApp.main();
}

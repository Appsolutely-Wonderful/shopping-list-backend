import 'package:ShoppingListBackend/src/product.dart';
import 'package:ShoppingListBackend/src/shopping_list.dart';
import 'package:test/test.dart';

void main() {
  test('Add an item to the shopping list', () {
    ShoppingList myList = ShoppingList();
    Product milk =
        Product(name: "Milk", price: 1.99, quantity: 1, unit: "Gallon");

    myList.add(milk);
    var listMilk = myList.getItem(0);
    expect(listMilk, milk);
  });

  test('Get items from the list grouped by categories', () {
    ShoppingList myList = ShoppingList();
    Product milk =
        Product(name: "Milk", price: 1.99, quantity: 1, unit: "Gallon");
    milk.addCategory('Dairy');
    Product eggs =
        Product(name: "Eggs", price: 1.99, quantity: 1, unit: "Dozen");
    eggs.addCategory('Dairy');

    myList.add(milk);
    myList.add(eggs);
    expect(myList.length, 2);

    var items = myList.getItemsByCategory();
    expect(items.keys, ["Dairy"]);
    expect(items["Dairy"].length, 2);
  });

  test('Get items from the list grouped by category with uncategorized items',
      () {
    ShoppingList myList = ShoppingList();
    Product milk =
        Product(name: "Milk", price: 1.99, quantity: 1, unit: "Gallon");
    Product eggs =
        Product(name: "Eggs", price: 1.99, quantity: 1, unit: "Dozen");

    myList.add(milk);
    myList.add(eggs);
    expect(myList.length, 2);

    var items = myList.getItemsByCategory();
    expect(items.keys, ["Uncategorized"]);
    expect(items["Uncategorized"].length, 2);
  });

  test('Get items from the list grouped by recipe', () {
    ShoppingList myList = ShoppingList();
    Product milk = Product(
        name: "Milk",
        price: 1.99,
        quantity: 1,
        unit: "Gallon",
        recipe: "Pancakes");
    Product eggs = Product(
        name: "Eggs",
        price: 1.99,
        quantity: 1,
        unit: "Dozen",
        recipe: "Pancakes");

    myList.add(milk);
    myList.add(eggs);
    expect(myList.length, 2);

    var items = myList.getItemsByRecipe();
    expect(items.keys, ["Pancakes"]);
    expect(items["Pancakes"].length, 2);
  });

  test('Get items from the list grouped by recipe', () {
    ShoppingList myList = ShoppingList();
    Product milk = Product(
      name: "Milk",
      price: 1.99,
      quantity: 1,
      unit: "Gallon",
    );
    Product eggs = Product(
        name: "Eggs",
        price: 1.99,
        quantity: 1,
        unit: "Dozen",
        recipe: "Pancakes");

    myList.add(milk);
    myList.add(eggs);
    expect(myList.length, 2);

    var items = myList.getItemsByRecipe();
    expect(items.keys, ["No Recipe", "Pancakes"]);
    expect(items["Pancakes"].length, 1);
    expect(items["No Recipe"].length, 1);
  });

  test('Get total cost of the shopping list', () {
    ShoppingList myList = ShoppingList();
    Product milk = Product(
      name: "Milk",
      price: 1.99,
      quantity: 1,
      unit: "Gallon",
    );
    Product eggs = Product(
        name: "Eggs",
        price: 1.99,
        quantity: 1,
        unit: "Dozen",
        recipe: "Pancakes");

    myList.add(milk);
    myList.add(eggs);
    expect(myList.length, 2);

    var cost = myList.getTotalCost();
    expect(cost, 3.98);
  });

  test('Categories are updated as the list is updated', () {
    ShoppingList myList = ShoppingList();
    Product productA = Product();
    Product productB = Product();
    Product productC = Product();
    productA.addCategory("Cat1");
    productB.addCategory("Cat2");
    productC.addCategory("Cat3");

    myList.add(productA);
    myList.add(productB);
    myList.add(productC);
    expect(myList.length, 3);

    var categories = myList.getCategories();
    expect(categories, ["Cat1", "Cat2", "Cat3"]);

    myList.removeAt(1);
    categories = myList.getCategories();
    expect(categories, ["Cat1", "Cat3"]);
  });
}

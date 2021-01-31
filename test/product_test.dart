import 'package:ShoppingListBackend/src/product.dart';
import 'package:test/test.dart';

void main() {
  test('Product can be initialized', () {
    Product newProduct =
        Product(name: "product", quantity: 4, price: 1.0, recipe: "Test");
    expect(newProduct.name, "product");
    expect(newProduct.quantity, 4);
    expect(newProduct.price, 1.0);
    expect(newProduct.recipe, "Test");
  });

  test('Product.getCost() return the total product cost', () {
    Product newProduct =
        Product(name: "product", quantity: 4, price: 1.25, recipe: "Test");
    expect(newProduct.getCost(), 5.0);
  });

  test('Product categories can be added', () {
    Product newProduct = Product();
    newProduct.addCategory("Category 1");
    newProduct.addCategory("Category 2");
    var categories = newProduct.getCategories();
    expect(categories, ["Category 1", "Category 2"]);
  });

  test('Product categories can be removed', () {
    Product newProduct = Product();
    newProduct.addCategory("Category 1");
    newProduct.addCategory("Category 2");
    newProduct.addCategory("Category 3");
    newProduct.removeCategory("Category 2");

    var categories = newProduct.getCategories();
    expect(categories, ["Category 1", "Category 3"]);
  });
}

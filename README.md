# Shopping List Backend
This contains all functionality for creating a shopping list
application. All that's missing is a front end.

## Classes
These are the classes included in this project

### ShoppingList
Represents a shopping list and has functions for operating
on the list's items.

#### Methods

| Method                   | Description
| --------------------     |--------------
| **setName(name)**        | Sets the name of the list.
| **getName()**            | Returns the name of the list.
| **add(item)**            | Adds an item to the shopping list.
| **removeAt(index)**      | Removes an item from the shopping list.
| **getItem(index)**       | Returns the item at the given index.
| **getCategories()**      | Returns a list of categories of items in the list.
| **getTotalCost()**       | Returns the total cost of all items in the list.
| **forEach(fn)**          | Executes a function on each item in the shopping list.
| **getItemsByCategory()** | Organizes the list to goup items by category (affects indices)
| **getItemsByRecipe()**   | Organizes the list to group items by recipe (affects indices)
| **toJson()**             | Serializes the list into a Map object
| **fromJson(jsonMap)**    | Creates an instance of the list based on a json map

### Product
Represents an individual item for the shopping list

#### Fields

| Field          | Description
| -----          | -----------
| **name**       | Name of the product
| **unit**       | Unit of each item
| **quantity**   | Quantity to purchase
| **categories** | A list of categories used for grouping items
| **price**      | Cost of one unit of the product

#### Methods

| Method                  | Description
| -------------           | -----------
| **getCost()**           | Total cost of the item. Price * Quantity
| **isChecked()**         | Checks if the item has been checked off the list
| **check()**             | Checks an item off the list
| **addCategory(str)**    | Adds a category to the product
| **removeCategory(str)** | Removes this category from the list
| **getCategories()**     | Retrieves the list of categories on the product
| **toJson()**            | Serializes the product into a Map object
| **fromJson(jsonMap)**   | Creates an instance of the project based on a json map

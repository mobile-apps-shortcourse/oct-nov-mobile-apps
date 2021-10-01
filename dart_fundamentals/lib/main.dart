/// class is a blueprint for creating objects.
/// we will model the relationship between objects in a shop.

/// shop owner
/// shop
/// employee

/// product
class Product {
  /// price, name, id, quantity, manufacturer, origin
  late String id;
  late String name;
  late int quantity;
  late String manufacturer;
  late String origin;

  /// constructor -> used to create instances of a class.
  /// It is also referred to as a special function because can take in arguments/ parameters
  /// there are 3 types of constructors: named, no-argument, parameterized.
  ///
  /// there are two types under the parameterized constructor: positional and named.

  /// This is a positional parameterized constructor.
  /// this uses the positions of the arguments rather than their names
  // Product(String id, String name, String manufacturer, String origin, [int quantity = 10]) {}

  /// This is a named parameterized constructor.
  Product({
    required String id,
    required String name,
    required String manufacturer,
    required String origin,
    int quantity = 0,
  }) {
    this.id = id;
    this.name = name;
    this.quantity = quantity;
    this.manufacturer = manufacturer;
    this.origin = origin;
  }

  /// function
  void doSomething(email, password) {}
}

void main() {
  var sampleProduct = Product(
    name: 'Fan',
    id: '12',
    origin: 'Ghana',
    manufacturer: 'DanSam Electronics',
  );

  /// two types of string joining: concatenation & interpolation
  ///
  /// this is concatenation
  print('Name = ' + sampleProduct.name);

  /// this is interpolation
  print('Manufacturer is ${sampleProduct.manufacturer}');
}

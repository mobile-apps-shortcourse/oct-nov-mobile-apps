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

class Editor {
  void edit(String value) {
    print(value);
  }
}

class LocalStorage {
  late Editor _editor;

  LocalStorage() {
    this._editor = Editor();
  }

  void edit(String value) => _editor.edit(value);
}

abstract class Employee {
  late String id;
  late String firstName;
  late String lastName;
  late int age;
  late double salary;
  late String email;
  late String department;
  late int phoneNumber;
}

class Supervisor extends Employee {
  Supervisor({
    required String id,
    required String firstName,
    required String lastName,
    required int age,
    required double salary,
    required String email,
    required String department,
    required int phoneNumber,
  }) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.age = age;
    this.salary = salary;
    this.email = email;
    this.department = department;
    this.phoneNumber = phoneNumber;
  }

  // String get fullName {
  //   return '$firstName $lastName';
  // }

  String get fullName => '$firstName $lastName';

  set newUserValue(String userValue) {
    var localStorage = LocalStorage();
    localStorage.edit(userValue);
  }
}

class Worker extends Employee {
  late String supervisor;

  Worker({
    required String id,
    required String firstName,
    required String lastName,
    required int age,
    required double salary,
    required String email,
    required String department,
    required int phoneNumber,
    required String supervisor,
  }) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.age = age;
    this.salary = salary;
    this.email = email;
    this.department = department;
    this.phoneNumber = phoneNumber;
    this.supervisor = supervisor;
  }
}

void main() {
  var sampleProduct = Product(
    name: 'Fan',
    id: '12',
    origin: 'Ghana',
    manufacturer: 'DanSam Electronics',
  );
  var person = Supervisor(
    id: '123',
    age: 30,
    department: 'Sales',
    email: 'john@work.com',
    firstName: 'John',
    lastName: 'Doe',
    phoneNumber: 2343298493,
    salary: 4500,
  );
  var workerSample = Worker(
    id: '89',
    firstName: 'Dennis',
    lastName: 'Bilson',
    age: 27,
    salary: 4500,
    email: 'quabynah@mail.com',
    department: 'Sales',
    phoneNumber: 05542398293,
    supervisor: '123',
  );

  print('is he an employee? ${person is Employee}');
  print('your full name is ${person.fullName}');

  /// don't do this for a setter
  // person.newUserValue('askjdksadas');

  /// do this instead
  person.newUserValue = 'aksjdkasd';

  /// two types of string joining: concatenation & interpolation
  ///
  /// this is concatenation
  print('Name = ' + sampleProduct.name);

  /// this is interpolation
  print('Manufacturer is ${sampleProduct.manufacturer}');
}

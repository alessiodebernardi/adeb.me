---
title: "Basics of OOP design - SOLID principles"
date: 2023-10-02T15:25:12Z
draft: false
tags:
  - Development
  - Software Engineering
---

SOLID is an acronym for five object-oriented design principles used to design 
software that is robust, testable, extensible, and maintainable.

These design principles are:
- [Single Responsibility Principle (SRP)](#single-responsibility-principle-srp)
- [Open-closed Principle (OCP)](#open-closed-principle-ocp)
- [Liskov substitution principle (LSP)](#liskov-substitution-principle-lsp)
- [Interface segregation principle (ISP)](#interface-segregation-principle-isp)
- [Dependency inversion principle (DIP)](#dependency-inversion-principle-dip)


### Single Responsibility Principle (SRP)
> A class should have one, and only one, reason to change

Each module should perform a single task or function, and should be responsible for that task only.
If a module has multiple responsibilities, it becomes difficult to understand, maintain, and test.

❌ Bad example:
```php
class Product {
    public function getName() {
        // Returns the product name
    }

    public function getSKU() {
        // Returns the product SKU
    }

    public function save() {
        // Saves the product in the database
    }
}
```
This class violates the SRP because it is responsible for two different tasks: providing information about
the product and saving the product in the database.

If we need to change the way that product is persisted into the database, we will need to modify the entire class.
This could have unintended consequences for the other tasks that the class is responsible for.

✅ Good example:
```php
class Product {
    public function getName() {
        // Returns the product name
    }

    public function getSKU() {
        // Returns the product SKU
    }
}

class ProductRepository {
    public function save(Product $product) {
        // Saves the product in the database
    }
}
```
Now, each class is responsible for a single task.
If we need to change the way products are saved into the database, we only need to modify the `ProductRepository` class,
without affecting other classes.
This makes the code more modular, easier to understand, and easier to maintain.

### Open-closed Principle (OCP)
> Software entities (classes, modules, functions, etc.) should be open for extension, but closed for modification

This means that you should be able to add new functionality to your software without having to modify existing code.

There are a few different ways to implement the OCP, but one common approach is to use abstraction and interfaces over implementations: abstraction 
allows you to define a common interface for a set of related classes, without having to specify the implementation details of each class.
In this way you can add new classes to the set without having to modify both the existing interface and implementations already in place.

❌ Bad example:
```php
class PaymentProcessor {
    public function process(Payment $payment) {
        if ($payment->type === 'credit_card') {
            // Process the credit card payment
        } elseif ($payment->type === 'bank_transfer') {
            // Process the bank transfer payment
        } else {
            throw new Exception('Invalid payment type');
        }
    }
}
```
This class violates the OCP because it is closed to extension: if we want to add support for a new payment type, 
we need to modify the `process()` method, with the risk of also affecting other payment types.

✅ Good example:
```php
interface PaymentMethod {
    public function process();
}

class CreditCardPayment implements PaymentMethod {
    public function process() {
        // Process the credit card payment
    }
}

class BankTransferPayment implements PaymentMethod {
    public function process() {
        // Process the bank transfer payment
    }
}

class PaymentProcessor {
    public function process(PaymentMethod $paymentMethod) {
        $paymentMethod->process();
    }
}
```

Now, the `PaymentProcessor` class is open to extension. We can add support for a new payment type by simply creating a new class 
that implements the `PaymentMethod` interface. This does not require us to modify the `PaymentProcessor` class, which makes the code 
more robust and maintainable.

### Liskov substitution principle (LSP)
> Objects of a superclass should be replaceable with objects of its subclasses without breaking the application

This means that you should be able to use a subclass in place of its superclass without causing any errors or unexpected behavior.
One common approach to implement LSP is to use inheritance and polymorphism: inheritance allows you to create new classes that 
inherit the functionality of existing classes. Polymorphism allows you to call the same method on different objects, 
even if the objects are of different types.
In this way you can create a subclass that overrides the methods of its superclass, but still maintains the same interface. 
This allows you to use the subclass in place of the superclass without causing any errors or unexpected behavior.

❌ Bad example:
```php
class Animal {
    public function eat() {
        // Eat food
    }
}

class Bird extends Animal {
    public function eat() {
        // Eat food
        // Fly
    }
}

function feedAnimal(Animal $animal) {
    $animal->eat();
}

$bird = new Bird();
feedAnimal($bird); // Unexpected behavior: the bird eat but also fly!
```

In this example, the `Bird` class inherits from the `Animal` class, but it overrides the `eat()` method to implement its own specific 
behavior for eating. However, the `Bird` class does not implement the `eat()` method in a way that is compatible with the Animal class.
The `feedAnimal()` function expects the `Animal` object that is passed to it to have an `eat()` method that simply eats. 
However, the `Bird` class's `eat()` method also makes the bird fly. This is unexpected behavior, and it could break other code in the application.

This example violates the LSP because you cannot substitute a `Animal` object with a `Bird` object without causing unexpected behavior. 
Passing a `Bird` object to the `feedAnimal()` function will cause a bird that will also fly, which is not what is expected from the
method behaviour

✅ Good example:
```php
class Animal {
    public function eat() {
        // Eat food
    }
}

class Bird extends Animal {
    public function eat() {
        // Eat food
    }
    public function fly() {
        // Fly
    }
}

function feedAnimal(Animal $animal) {
    $animal->eat();
}

$bird = new Bird();
feedAnimal($bird); // Expected behavior: the bird eat
```

Now the `Bird` class implements the `eat()` method in a way that is compatible with the `Animal` class, by extracting the fly behavior
into a separate method. This allows us to use the `Bird` class in place of the `Animal` class without causing any unexpected behavior.

### Interface segregation principle (ISP)
> Clients should not be forced to depend on interfaces that they do not use

In other words, interfaces should be split into smaller, more specific interfaces, so that clients only have to depend on the interfaces 
that they actually need. This can make the code more flexible and reusable, and it can also reduce the amount of coupling between 
different parts of the system.

One way to think about the ISP is to imagine a set of tools. If you have a single tool that has a lot of different features, 
but you only need to use a few of those features, then you are forced to carry around the entire tool even though you don't need all of it.
This can be bulky and inconvenient. A better approach would be to have a set of smaller, more specialized tools, each of which performs 
a specific task. This way, you can only bring the tools that you need for the job at hand.

The same principle applies to interfaces in software development. If an interface has too many methods, then clients are forced to depend 
on methods that they don't need. This can make the code more complex and difficult to maintain. A better approach is to split the 
interface into smaller, more specialized interfaces. This way, clients can only depend on the interfaces that they actually need.

❌ Bad example:
```php
interface Vehicle {
    public function start();
    public function stop();
    public function accelerate();
    public function brake();
    public function turnLeft();
    public function turnRight();
}
```

This interface is quite large, and it includes methods that are not needed by all types of vehicles. 
For example, a bicycle does not need a `start()` or `stop()` method.

✅ Good example:
```php
interface Vehicle {
    public function accelerate();
    public function brake();
    public function turnLeft();
    public function turnRight();
}

interface MotorVehicle extends Vehicle {
    public function start();
    public function stop();
}

interface NonMotorVehicle extends Vehicle {
    // Specific methods for non-motor vehicles
}
```

This approach is more flexible and reusable than having a single `Vehicle` interface with a lot of methods.
Now, we can create classes that implement the specific interfaces that they need. 
For example, a `Car` class would implement the `MotorVehicle` interface, and a `Bicycle` class would implement the `NonMotorVehicle` interface.

### Dependency inversion principle (DIP)
> Depend on abstractions, not concretions

In other words, the DIP states that high-level modules should not be directly coupled to low-level modules. 
Instead, they should be coupled to abstractions, such as interfaces or abstract classes. 
This makes the code more flexible and reusable, as changes to the low-level modules can be made without affecting the high-level modules.

The DIP can be implemented using dependency injection. Dependency injection is a technique in which dependencies are provided to a class at runtime, 
rather than being tightly coupled to the class itself. This allows the dependencies to be easily changed or mocked, which makes the code more testable and maintainable.

❌ Bad example:
```php
class User {
    private $databaseConnection;

    public function __construct() {
        $this->databaseConnection = new MySQLDatabaseConnection();
    }

    public function getName() {
        $sql = 'SELECT name FROM users WHERE id = 1';
        $result = $this->databaseConnection->query($sql);
        $user = $result->fetch_assoc();
        return $user['name'];
    }
}
```
This code violates the DIP, because the `User` class is directly dependent on the `MySQLDatabaseConnection` class. 
This means that if we want to change the way that database connections are handled, we would need to modify the `User` class and
all the other classes in the codebase that are using it. It's easy to see how this could quickly become a maintenance nightmare, especially in large projects.

✅ Good example:
```php
interface DatabaseConnection {
    public function connect();
    public function query($sql);
    public function close();
}

class MySQLDatabaseConnection implements DatabaseConnection {
    // ...
}

class PostgresSQLDatabaseConnection implements DatabaseConnection {
    // ...
}

class User {
    private $databaseConnection;

    public function __construct(DatabaseConnection $databaseConnection) {
        $this->databaseConnection = $databaseConnection;
    }

    public function getName() {
        $sql = 'SELECT name FROM users WHERE id = 1';
        $result = $this->databaseConnection->query($sql);
        $user = $result->fetch_assoc();
        return $user['name'];
    }
}
```

This code follows the DIP because the `User` class depends on the `DatabaseConnection` interface, not on a concrete database connection class. 
Using this approach we can easily swap out the database connection class without having to modify the `User` class.
For example, if we wanted to start using PostgreSQL instead of MySQL, we could simply create a new instance of the `PostgreSQLDatabaseConnection` class
and pass it to the `User` constructor. This would allow us to easily switch between different database systems without having to make any changes to our existing code.
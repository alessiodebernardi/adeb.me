---
title: "Hexagonal (Ports and Adapters) Architecture"
date: 2023-11-12T11:04:29Z
draft: false
tags:
  - Development
  - Software Engineering
  - Software Architecture
---

In the realm of software architecture, various design patterns and principles aim to enhance the flexibility, maintainability,
and scalability of applications. One such pattern that has gained prominence is the **Hexagonal Architecture**, also known as 
**Ports and Adapters**. This architectural style, introduced by [Alistair Cockburn](https://alistaircockburn.com/) in 2005, provides a clean separation between the core 
business logic of an application and its external dependencies, such as the user interface, database, and external systems.

## What is Hexagonal Architecture
At its core, Hexagonal Architecture revolves around the idea of separating the concerns of an application into distinct layers or components.
It is visualized as a hexagon, with the core application logic in the center and the external concerns surrounding it. 
The core application logic communicates with the external actors through ports and adapters.

![hexagonal-scheme-1.png](hexagonal-scheme-1.png)

The main components are:
- **Core business logic**: This is the heart of the application where the domain-specific logic resides. 
  It encapsulates the essential functionality and rules that define the purpose of the software.
- **Ports**: Ports are interfaces that define how the application interacts with the external world. 
  They serve as entry and exit points for data and operations. Examples include interfaces for databases, external services, and user interfaces.
- **Adapters**: Adapters are the implementations of the ports. They are responsible for connecting the application to external systems. 
  Adapters convert data from the external format to the internal format and vice versa, ensuring seamless communication between the application and its dependencies.

The **driving side** (also called "primary adapters" or "presentation/UI" side) is the part of the system that initiates communication with the core business logic, like Web Servers, Event buses or CLI interfaces. 
It is responsible for translating external requests into internal commands and for delivering the results of the core logic back to the external world.

The **driven side** (also called "secondary adapters" or "infrastructure" side) is the part of the system that is dependent on external systems and resources,
like databases, file systems or external APIs.
It is responsible for interacting with the outside world and providing data and functionality to the application core.

## Key Principles
- **Dependency inversion**: Hexagonal Architecture adheres to the Dependency Inversion Principle, which states that high-level modules 
 (the core business logic in this case) should not depend on low-level modules. Instead, both should depend on abstractions. 
 This promotes flexibility and allows for easy substitution of components.
- **Isolation of concerns**: The architecture isolates the core business logic from external dependencies. 
  This isolation makes the system more maintainable, as changes to external components do not impact the core logic, and vice versa.
- **Testability**: Hexagonal Architecture facilitates easy testing by decoupling the core logic from its external dependencies. 
  With ports acting as interfaces, it becomes straightforward to create mock implementations for testing purposes.
- **Maintainability**: The core logic is not tightly coupled to any specific external frameworks, libraries, or databases, 
making it easier to maintain and evolve.
- **Extensibility**: New ports and adapters can be added to the application without affecting the core logic, 
making it easy to extend the application's functionality.

## Why is called "Hexagonal"?
This architecture was originally called "Hexagonal" to visually highlight the asymmetry between the inside and outside, as well as the common characteristics of (classic) ports,
and to get rid of the classic one-dimensional layered picture.
It is also useful to mentally visualize the existence of a specified number of ports.

The hexagon is not chosen for its significance in representing the number six. Instead, it provides flexibility for individuals creating diagrams 
to incorporate ports and adapters as they needed. This design choice liberates them from the confines of a one-dimensional layered illustration. 
The term 'hexagonal architecture' is derived from this distinctive visual impact.

## How to implement it
Here some basics steps to follow:
1. **Identify the core**: Define the core domain of your application, that contains the essential business logic and rules.
2. **Identify ports and adapters**:
   - Ports: Identify the interfaces through which your application interacts with the external world. 
   - Adapters: Implement the adapters that connect your application to the external dependencies, such as databases, UI frameworks, or external services.
3. **Implement core business logic**: Implement the core business logic at the center of your architecture. This should be independent of the external concerns and 
should focus solely on solving the problems of the core domain.
4. **Define ports (interfaces)**: Define interfaces (ports) for the external dependencies. For example, if your application needs to interact with a database,
define an interface for the repository.
5. **Implement adapters**: Create adapter implementations for the interfaces defined in the previous step. These adapters are responsible for translating the core 
application's needs into actions that the external dependencies can understand.
6. **Keep in mind Dependency Inversion Principle (DIP)**: Follow the Dependency Inversion Principle by inverting the dependencies. 
Internal modules (core business logic) should not depend on external modules (external dependencies). Both should depend on abstractions (interfaces).
7. **Test each layer**: Write tests for each layer of your application. Test the core business logic in isolation using unit tests. 
Test the adapters using integration tests to ensure they correctly interact with external dependencies.
8. **Separate the configuration:** Keep the configuration for external dependencies separate from the core business logic. Dependency injection is a 
common technique for achieving this separation.

### How to structure the code

The directory structure of a project following hexagonal architecture principles may vary based on the programming language, the framework used and so on, but here's a general outline:
```php
- core
  - domain /* core business logic, domain entities, value objects, and domain services) */
  - application /* application services and use cases that orchestrate interactions between different parts of the domain) */
- ports
  - inbound /* interfaces for incoming adapters (e.g., REST API controllers, GraphQL resolvers, etc.). These interfaces represent the entry points to the application) */
  - outbound /* interfaces for outgoing adapters (e.g., database repositories, external service clients, etc.). These interfaces represent the exit points from the application) */
- adapters
  - inbound /* implements the incoming adapters, such as REST API controllers or GraphQL resolvers) */
  - outbound /* implements the outgoing adapters, such as database repositories or external service clients) */
- infrastructure
  - configurations /* contains infrastructure-related code, such as database configurations, dependency injection, etc) */
```

### Example
Let's implement (some parts of) a very simple application that saves users in the database using Hexagonal Architecture.

We will structure the code as it follows:
- Core: we will use a _User_ class to model the user domain entity, and a _CreateUserUseCase_ class for the user creation business logic.
- Ports: for the driving side, we will define a _UserController_ interface to interact with the REST calls, and for the driven side a _UserRepository_ to interact with the storage.
- Adapters: we will implement a _UserRestController_ for the _UserController_ port and a _MariaDBUserRepository_ for the _UserRepository_ port.

![hexagonal-scheme-2.png](hexagonal-scheme-2.png)

Core:

```php
class User {
    // implementation of the User class
    private string $name;
    private string $email;
    ...
}

class CreateUserUseCase {
    // MariaDBUserRepository can be injected from outside (ex. configuration)
    private UserRepository $userRepository;
    ...
    public function execute(string $name, string $email): User {
        // Business logic and rules to create the user
        ...
        $user = new User($name, $email);
        $this->userRepository->save($user);
        return $user;
    }
}
```

Ports:

```php
// Inbound port
interface UserController {
    public function create(Request $request): void;
}

// Outbound port
interface UserRepository {
    public function save(User $user): void;
}
```

Adapters:

```php
// Inbound adapter
class UserRestController implements UserController {
    private CreateUserUseCase $createUserUseCase;
    ...
    function create(Request $request): void { 
        $user = $this->createUserUseCase->execute(
            $request->get('name'), 
            $request->get('email')
        );
    }
}

// Outbound adapter
class MariaDBUserRepository implements UserRepository {
    public function save(User $user): void {
        // Logic to persist the user
    }
}
```  

This is just a basic example. A real-world implementation would be more complex, obviously, 
but it should give you a starting point for understanding the structure of a project using hexagonal architecture, and some ideas to start implementing it in your own code.

## Conclusions

Hexagonal Architecture offers a structured and modular approach to designing software systems. By emphasizing the separation of concerns and promoting
the use of interfaces, it provides a robust foundation for building adaptable and maintainable applications.
It can be applied to various types of applications, including web applications, microservices, and traditional monolithic systems too.
It is particularly beneficial in scenarios where the external dependencies of an application are subject to change or where a high degree of flexibility and maintainability is required.



## References
- https://alistair.cockburn.us/hexagonal-architecture/
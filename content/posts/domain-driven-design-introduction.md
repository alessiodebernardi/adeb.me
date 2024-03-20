---
title: "Domain Driven Design - A quick introduction"
date: 2024-03-12T19:41:37Z
draft: false
tags:
  - Development
  - Software Engineering
  - Domain-Driven-Design
---

## What is Domain Driven Design?

**Domain-driven design** (DDD) is a software design approach that focuses on modeling software by matching a specific area of
the business, called **domain**. In this approach, as the name suggest, the domain is the "center of gravity", and everything
else orbits around it. The domain is typically divided into **subdomains**, which are smaller, more focused areas of the domain.

> Let's consider a hypothetical e-commerce application as an example:
> - The _domain_ of the software is the e-commerce business. This is the overall domain representing the entire business area.
The whole software system revolves around facilitating sales, order management, customers, inventory, stock and so on.
> - A first _subdomain_ could the Product Management. This subdomain is focused on managing the products that the e-commerce sells, 
like adding new products and categories, updating product details and managing inventory.
> - Another _subdomain_ could be the Order Management. This subdomain is focused on managing the orders that the e-commerce receives,
like processing orders, managing payments and handling the shipping.

## Approach
Domain Driven Design promotes close and continuous collaboration between developers, domain experts and all the stakeholders
involved in the project, to ensure that the software accurately reflects the business domain. 

The ideal approach is centered around understanding and modeling the domain in a way that aligns as close as possible with business needs and objectives.

There are two main complementary strategies that are used to model the domain and design the software:
- **Strategic Design**: is the high-level design of the software, focused on defining the overall architecture and the relationships between different parts of the system.
- **Tactical Design**: is the low-level design of the software, focused on defining the internal structure of the software, including the domain model, the business logic, and the data access.

## Strategic design
**Strategic design** addresses the broader architectural concerns of the entire application. 
It deals with the division of the domain into multiple bounded contexts and how these contexts interact and integrate with each other. 
It emphasizes the identification of ubiquitous language in each bounded contexts, defining context maps to manage the relationships between them and identifying strategies to maintain integrity and consistency in the domain.

Its objective is to ensure that the software architecture aligns with the expectations and dynamics of the business domain, facilitating scalability and growth of the system.

The key concepts of strategic design are:
- [Ubiquitous Language](#ubiquitous-language)
- [Domain Model](#domain-model)
- [Bounded Context and Context Mapping](#bounded-context)

Let's see them in detail.

### Ubiquitous Language
A **ubiquitous language** is a shared vocabulary used by all the people involved in the project, from domain experts to stakeholders to developers.
It is a way to communicate about the project in a clear, concise and standardized way that everyone can understand, and it helps to reduce misunderstandings and miscommunications.
This vocabulary needs to be constantly updated and evolved as the project progresses, to ensure that it accurately reflects the domain.

A simple term-definition list is usually enough to take advantage of this technique.

> For example, following our e-commerce application, we could have this ubiquitous language:
> - Product: A physical or digital item that is sold on the platform.
> - Customer: A person or entity registered on the platform who can browse and purchase products.
> - Shopping Cart: A temporary container where customers can add products before proceeding to checkout.
> - Order: A confirmed request by a customer to purchase one or more products.
> - Payment: The process of transferring funds from the customer to the platform in exchange for products.

### Domain Model
A **domain model** is a conceptual and simplified model of the domain that the software is trying to model, and it's used to guide the design of the system.
It is an abstraction, a collection of objects and relationships that capture the essential concepts and rules of the domain, created
through the collaboration between domain experts and software developers.

The domain model can be expressed using a variety of techniques, such as UML diagrams, entity-relationship diagrams, 
and natural language descriptions.

The creation of domain model is not a once-in-a-project activity, but it should be updated and eventually modified as the domain knowledge evolves. 
This ensures that the software continues to accurately represent the real world and that it meets the needs of the domain experts.

> Here is a simple example of a domain model for our e-commerce application:
> ![domain-model.png](domain-model.png)

### Bounded Context
A **bounded context** is a central concept used in the strategic design: it is used to divide large systems into smaller, more manageable parts. 
It helps to establish clear boundaries within which a particular domain model is defined and operates consistently, without being affected by concerns from other parts of the system.
These boundaries are defined by linguistic, functional, and organizational criteria.

Key aspects of bounded contexts include:
- Manageability: large and complex domains can be difficult to model and manage effectively. 
Bounded contexts help break down the domain into smaller, more manageable parts.
- Ubiquitous Language: Each bounded context has its own set of terms and concepts that are specific to that context.
- Bounded ≠ isolated: While each context has its own language and potentially its own models, bounded contexts collaborate with each other to 
deliver the overall functionality of the system. Different contexts can interact and share data following specific integration patterns and rules.

#### How to define bounded contexts?
There are several ways to define bounded contexts, and the choice depends on the specific needs of the project.
The most common approaches are:

- By Subdomain: a large domain is divided into smaller subdomains, each with its own bounded context.
- By Process: the context is defined around a specific business process, with models and language tailored to that process.
- By Team: the context is defined around a specific team or group of teams, with models and language tailored to the needs of that team.
- By Integration: the context is defined around a specific integration point, with models and language tailored to that integration (with external systems, for example).
- By Customer: the context is defined around a specific customer or group of customers, with models and language tailored to their needs. 

> Following our e-commerce example, we could identify the following bounded contexts:
> - Product Catalog: This context focuses on managing product information. Its models would include Product, Category, and Attribute. 
The ubiquitous language would involve terms like "stock keeping unit (SKU)", "product variants" and "product specifications".
> - Order Management: This context deals with the order lifecycle, from adding items to the cart to processing payments and fulfilling orders. 
Models here could be Order, OrderItem and Payment. The language might include terms like "discount codes", "shipping methods" and "order fulfillment".
> - Customer Management: This context handles customer accounts, including registration, login, and profile management.
Here models could be Customer, Address, and Wishlist. The language would involve terms like "customer authentication", "loyalty programs" and "order history".

#### Context Mapping
Strictly related to bounded contexts we could find the concept of **context mapping**.

Context mapping is a technique used to visualize the relationships between bounded contexts: it's like a map that shows how these distinct areas within the domain interact and communicate.
It helps us identify connections, how data flows, how functionalities collaborate and the level of dependency between contexts.

> Here is a simple example of a context map for our e-commerce application:
> ![context-mapping.png](context-mapping.png)

## Tactical Design
While strategic design focuses on the high-level architecture and relationships between different parts of the system, **tactical design** focuses on the internal structure of a single bounded context within the domain. 
It deals with the organization of classes, modules, and relationships within this context to reflect domain concepts.
Its goal is to implement a robust, scalable and maintainable domain model within a bounded context.

Tactical design makes uses of some patterns to properly model domain entities and their interactions:
- [Entities](#entities)
- [Value Objects](#value-objects)
- [Aggregates](#aggregates)
- [Repositories](#repositories)
- [Services](#services)
- [Domain Events](#domain-events)

### Entities
An **entity** refers to an object within a domain model that is uniquely identifiable and is distinguished from other objects based on its identity rather than its attributes.

Key characteristics of entities include:
- Identity: Each entity has a unique identity that distinguishes it from other entities, even if their attributes are the same. This identity is usually represented by a unique identifier, such as a primary key in a database.
- Mutability: Entities typically have mutable attributes; their state can change over time while their identity remains constant. This means that changes to an entity's attributes represent changes to the same entity, rather than the creation of a new one.
- Lifecycle: Entities have a lifecycle that spans multiple interactions and operations within the domain. They are created, modified, and possibly deleted as the system evolves.

> Following the e-commerce example, we could have entities like:
> - Product: An entity representing a product available for sale. Each product has attributes such as a unique identifier, name, description, price, and quantity available.
> - Customer: An entity representing a customer who can place orders. Each customer has attributes such as a unique identifier, name, email, and shipping address.
> - Order: An entity representing a customer's order. Each order has attributes such as a unique identifier, customer, order items, and total amount.

### Value Objects
A **value object** is a type of object that is characterized by its attributes rather than its identity. 
Unlike entities, which are defined by their unique identities and lifecycles, value objects are immutable and are typically used to represent concepts 
or attributes within the domain model that are considered interchangeable uniquely based on their attribute values.

> In the context of our e-commerce application, we could have value objects like:
> - Size: A value object representing the size of a product. It could include attributes such as dimensions (length, width, height) or clothing sizes (e.g., small, medium, large).
> - Postal Code: A value object representing a postal code or ZIP code, including validation logic for different countries' formats.
> - Money: A value object representing a monetary amount, including attributes such as currency and amount, and methods for performing arithmetic operations.

### Aggregates
An **aggregate** is a cluster of related domain objects (like entities or value objects) that are treated as a single unit. 
This unit is responsible for maintaining the consistency and integrity of the objects within it, and it's useful to enforce transactional boundaries and encapsulate business logic.

Each aggregate has a single entity, called the _aggregate root_, that acts as the main entry point for the entire aggregate. 
The aggregate root is responsible for controlling the lifecycle and the behaviour of the aggregate, as well as coordinating operations on the other objects within the aggregate.

Key characteristics of aggregates includes:
- Consistency boundaries: Aggregates define consistency boundaries within the domain model. All changes to objects within the aggregate must be made 
through the aggregate root, ensuring that the aggregate remains in a consistent state.
- Transactional boundaries: Operations performed on objects within an aggregate are typically performed within a single transaction, ensuring atomicity and consistency of changes.
- Encapsulation: Aggregates encapsulate the internal structure and behavior of the objects they contain. Objects outside the aggregate can only interact using the aggregate root, which controls access to the internal objects.
- Invariants: Aggregates enforce invariants, which are business rules or constraints that must be maintained to ensure the integrity of the domain model.
- Lifecycle Management: Aggregates manage the lifecycle of the objects they contain. Objects within the aggregate are typically created and destroyed as part of the aggregate's lifecycle, ensuring that they are always in a valid state.

> In our e-commerce application, we could have aggregates like:
> - Order aggregate: it might include the Order entity as the aggregate root, along with related entities such as OrderItems. 
All changes to the order and its items would be made through the Order aggregate root, ensuring that the order remains in a consistent state.
> - Product aggregate: it might include the Product entity as the aggregate root, along with related entities such as Product Variants and Product Attributes.

### Repositories
A **repository** is a pattern used to provide a mechanism for encapsulating the logic to access and manipulate domain objects within a data store, such as a database. 
The repository acts as an intermediary between the domain model and the data access layer, abstracting the details of how data is persisted and retrieved.
It typically provides methods for CRUD operations, as well as methods for querying and retrieving domain objects based on various criteria.

Repositories often works with aggregates, allowing callers to interact with entire aggregates rather than individual objects. This helps to maintain consistency and integrity within the domain model.

> For example:
> - A Product Repository might provide methods for adding, updating, deleting, and querying products and related entities like Product Variants and Product Attributes.
It encapsulates the logic required to interact with the underlying product data store, such as a database table.

### Services
A **service** is a pattern used to encapsulate and represent domain-specific operations or business logic that do not naturally belong to any specific entity or value object 
within the domain model. 

Services are used to model behavior that is more about the interactions and collaborations between objects rather than the intrinsic behavior of a single object.
Services are typically stateless, meaning that they do not maintain any state between invocations. They operate using only the input provided to them and do not rely on any internal state.

> Some examples for our e-commerce application could be:
> - Order Processing: A service responsible for processing orders, coordinating interactions between the order, customer, and inventory entities.
> - Payment Processing: A service responsible for processing payments, coordinating interactions between the order, customer, and external payment gateways.

### Domain Events
**Domain events** are used to represent significant state changes or occurrences within the domain model. 
They capture meaningful moments or transitions in the system's behavior and are used to communicate these events to other parts of the system, like other bounded contexts or external systems.

Domain events are immutable objects, meaning that once they are created, their state cannot be changed.
They promote loose coupling between different parts of the system by allowing components to communicate through events rather than direct calls.

> Examples:
> - Order Placed event: A domain event representing the placement of a new order by a customer.
It can be used to notify the inventory management context that new items need to be reserved, or to notify the customer management context that a new order has been placed.
> - Inventory Updated event: Indicates that the quantity of a product in the inventory has been updated.
It can be used to notify the product catalog context that a product is out of stock.

## Conclusions
Domain Driven Design is a powerful approach to software development that can bring several benefits, such as:
- Improved accuracy and completeness: 
developers are pushed to learn about the domain and to work closely with domain experts. This results in a better understanding of the domain, which leads to better software.
- Increased understandability and maintainability: 
the domain model is designed to be understandable by domain experts and not only the developers, which makes it easier to maintain and evolve the software.
- Improved flexibility and scalability:
the domain logic is separated from the application logic, so changes in one side have little or no impact at all in the other side.
- More expressive software:
developers are encouraged to create software systems that are expressive of the domain. This means that the code is easier 
to understand for domain experts and that it is easier to make changes without breaking it.

However, implementing Domain Driven Design properly and continuously is **challenging**: it's a complex approach, and it can be difficult to implement it correctly, especially if there are no experts involved.
Developers needs to have a good understanding of the domain, and sometimes it can be difficult to achieve, especially if the domain is complex or unfamiliar. 
But, above all, It requires commitment and the cooperation of every part involved, and this can be difficult to achieve, especially in the long run when priorities change.

### So it worth it?
The answer is: **it depends**.

Domain Driven Design can be powerful, especially when applied correctly and with the right conditions, but it's important to underline that is not a silver bullet, and there are no guarantees to success. 

Using Domain Driven Design **it's not always the right choice**: for example, if you are working on simple projects, or projects with tight deadlines and/or limited resources, or if the domain is not well-defined or changes constantly, 
then DDD may be overkill and not worth the effort.

## Further reading

This was just a quick introduction to Domain Driven Design, and there is much more to explore and learn about it. 
If you are interested in learning more, here are a couple of books that I recommend:
- "Domain-Driven Design: Tackling Complexity in the Heart of Software" by Eric Evans, 2003
- "Implementing Domain-Driven Design" by Vaughn Vernon, 2013
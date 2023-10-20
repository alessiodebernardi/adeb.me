---
title: "Domain Driven Design - A quick introduction"
date: 2023-09-12T19:41:37Z
draft: true
tags:
  - Development
  - Software Engineering
  - Domain-Driven-Design
---

**Domain-driven design** (DDD) is a software design approach that focuses on modeling software by matching a specific area of
the business, called **domain**. In this approach, as the name suggest, the domain is the "center of gravity", and everything
else orbits around it. The domain is typically divided into **subdomains**, which are smaller, more focused areas of the domain.

### Approach
Domain Driven Design promotes close and continuous collaboration between developers, domain experts and all the stakeholders
involved in the project, to ensure that the software accurately reflects the business domain.

Two key concepts in Domain Driven Design are the **domain model** and the **ubiquitous language**.

#### Domain Model
A **domain model** is a conceptual and simplified model of the domain that the software is trying to model, used to guide the design of the system.
It is an abstraction, a collection of objects and relationships that capture the essential concepts and rules of the domain, and is created
through the collaboration between domain experts and software developers.

The domain model can be expressed using a variety of techniques, such as UML diagrams, entity-relationship diagrams, 
and natural language descriptions.

The creation of domain model is not a once-in-a-project activity, but it should be updated and eventually modified as the domain knowledge evolves. 
This ensures that the software continues to accurately represent the real world and that it meets the needs of the domain experts.

#### Ubiquitous Language
A **ubiquitous language** is a shared vocabulary used by all the people involved in a project, from domain experts to stakeholders to developers.
It is a way to communicate about the project in a clear and concise way that everyone can understand, and it helps to reduce misunderstandings and miscommunications.

A simple term-definition list is usually enough to take advantage of this technique. As for the domain model, also the ubiquitous language 
needs to be updated and evolved during the project development.

##### Under domain-driven design, the structure and language of software code (classes, methods, variables) should match the business domain.

### Benefits
- Improved accuracy and completeness: 
DDD forces developers to learn about the domain and to work closely with domain experts. This results in a better understanding of the domain, which leads to better software.
- Increased understandability and maintainability: 
the domain model is designed to be understandable by domain experts and not only the developers, which makes it easier to maintain and evolve the software.
- Improved flexibility and scalability:
DDD helps to separate the domain logic from the application logic, so changes in one side have little or no impact at all in the other side.
- More expressive software:
DDD encourages developers to create software systems that are expressive of the domain. This means that the code is easy 
to understand for domain experts and that it is easier to make changes to the software without breaking it.

### It's challenging!
Implementing Domain Driven Design properly and continuously is **challenging**.

- Developers needs to have a good understanding of the domain. This can be difficult to achieve, especially if the domain is complex or unfamiliar.
- DDD it's a complex approach, and it can be difficult to implement correctly, especially if there are no experts involved.
- It requires commitment: the cooperation of ALL the stakeholders is required. This can be difficult to achieve, especially if stakeholders have different priorities.

DDD is a powerful approach to software development, but **it's not always the right choice**. For example, you should avoid it if you are working on simple projects (DDD may be overkill in this case),
or projects with tight deadlines and/or limited resources (DDD is time-consuming and resource-intensive), or if the domain is not well-defined or changes constantly.

It is important to understand that DDD is not a silver bullet. It's not a guarantee that a project will be successful.
However, when used correctly adn with the right conditions, DDD can help you to develop high-quality, maintainable software that meets the needs of your users.

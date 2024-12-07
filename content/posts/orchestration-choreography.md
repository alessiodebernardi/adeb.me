---
title: "Finding harmony in Microservices: Choreography vs Orchestration"
date: 2024-12-07T10:52:11Z
draft: false
tags:
  - Development
  - Software Engineering
---

When designing complex systems, especially those involving microservices and distributed environments, you often get to the point where you have to design a way to get different services to collaborate, to work together to accomplish some kind of workflow.

For example, let's think about an order in an e-commerce system: we might have several services involved, such as warehouse, payment, shipping, just to name a few. Often these services are implemented in stand-alone microservices, which must somehow act together and synchronize in order to properly fulfill the order.

Two important approaches, or rather patterns, come to our aid in these cases: the **orchestration** pattern and **choreography** pattern.

## Orchestration
Think of **orchestration** as a conductor leading an orchestra: the conductor (your orchestrator) directs each musician (or service), telling them when to start and stop. 

In a distributed system, this translates to a centralized approach where a single component is responsible for coordinating and controlling how other components interact.

![orchestration-1.png](orchestration-1.png)

Let's use an e-commerce application as an example:
> - A user places an order
> - The order orchestrator manage the entire flow by:
>   - Instructing the inventory service to check and block the stock
>   - Telling the payment service to process the transaction
>   - Triggering the shipping service to prepare and ship the package
>   - Calling the notification service to notify the customer

Everything follows a clear sequence controlled by the orchestrator as it is the owner of the execution flow.

Note: this does not mean that in an orchestation approach is not possible to use asynchronous events or communications. It is absolutely possible to do so,
but it is still always the orchestrator that handles the flow and the order of the invocation.

### Pros and challanges

Pros of orchestation:
- The centralized logic makes workflows easier to understand, especially the most complex ones
- It's easier to monitor and debug since all interactions are performed in the same place
- It's ideal for workflows that requires a strict control on the order of execution

Challanges:
- The orchestrator is the single point of failure, and if it goes down the entire workflow can be disrupted
- The whole system is tighty coupled with the orchestrator component, and this can limit its flexibility and scalability
- In complex contexts the orchestrator can grow a lot and become hard to maintain and manage
- The orchestator itself can become a performance bottleneck

## Choreography
To imagine **choreography**, think of a group of dancers: all moving together to the rhythm of music to achieve the best possible performance, but without an actual director. Everyone knows their steps and knows that the other dancers will do the same.

In fact, in choreography there’s no central authority. Instead, services interact based on a shared set of rules: each service knows its role and what to do, and communicates with others by emitting or reacting to events.

![orchestration-2.png](orchestration-2.png)

Using the same e-commerce example:
> - A user places an order
> - The order service emits an `OrderPlaced` event
> - The inventory service listen to `OrderPlaced` event, checks the stock and blocks it. Then emits an `InventoryUpdated` event
> - The payment service listen to `InventoryUpdated` event and process the transaction. Then emits an `OrderPayed` event
> - The shipping service listen to `OrderPayed` event, prepare and ship the package. Then emits an `OrderShipped` event
> - The notification service listen to `OrderShipped` event and notify the customer

Instead of being told what to do, each service acts based on the events it receives. This approach is often implemented using event-driven tools and message queues.

### Pros and challanges

Pros of choreography:
- Services are decoupled and so the system is more flexible
- It's easier to scale the system since there is not a central component responsible for coordination
- It's easier to evolve the services since they have more autonomy and independency

Challanges:
- Because there is no central point whose flow is coordinated, understanding its operation can be more difficult, especially for complex workflows
- More work and attention is needed to properly coordinate and make services communicate with each other
- It's harder to track and debug
- Data consistency may be more difficult to manage (eventual consistency)

## Conclusions
Both **orchestration** and **choreography** aim to make services work together effectively but take very different approaches.

Orchestration is powerful when centralized control and clear, predictable workflows are essential. It’s the best choice for systems where sequencing and oversight are critical to success.

On the other hand, choreography thrives in distributed, scalable architectures where flexibility, autonomy, and loose coupling are priorities. It’s particularly well-suited for event-driven systems that need to adapt and grow with minimal friction.

Choosing the right approach depends on your system’s needs for control, scalability, and adaptability.
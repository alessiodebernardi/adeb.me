---
title: "Trunk-based development - TBD"
date: 2023-10-30T10:20:42Z
draft: false
tags:
  - Development
  - Software Engineering
  - Git
---

Trunk-based development (TBD) is a software development workflow that emphasizes frequent, small commits to a single codebase branch, 
called **trunk** or **main** branch.

![tbd-good-example.svg](tbd-good-example.png)

In TBD, developers works and push their changes directly into the trunk branch, or create short-lived feature branches 
that are merged back into the trunk **frequently**.
This helps to keep the trunk branch up-to-date and ready for deployment at any time.

This is in contrast with other branching models, such as [Git Flow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow), 
which uses multiple long-lived branches for different purposes (such as development/staging/production and releases).
Feature branches can also be included in this category, if they are long-lived ones (weeks, or even months before the merging).

![tbd-bad-example.png](tbd-bad-example.png)

### Benefits
TBD has a number of benefits, including:
- Faster delivery: Because the trunk branch is always ready for deployment, teams can release new features more quickly.
- Improved quality: TBD encourages developers to write smaller, more focused commits, which makes it easier to identify and fix bugs.
- Increased visibility: With all changes happening on the trunk branch, everyone on the team has a clear view of what is happening and can provide feedback early and often.
- Reduced complexity: TBD eliminates the need for multiple branching models, which can simplify the development process and reduce the risk of errors.

### Challenges
Trunk-based development is a powerful workflow that can help teams to deliver software faster and more reliably. 
However, it is important to be aware of the challenges of TBD and to have a plan in place for addressing them,
especially for teams that are used to using other branching models. 

Some of the challenges of TBD include:
- Overcoming the fear of merging: Some developers may be hesitant to merge their changes to the trunk branch frequently, for fear of breaking the build or introducing bugs. However, it is important to remember that the trunk branch should always be in a deployable state.
- Keeping the trunk branch stable: If developers are merging their changes to the trunk branch frequently, it is important to have a process in place for ensuring that the trunk branch remains stable. This may involve using automated testing and having a dedicated person or team responsible for reviewing and merging changes.
- Managing dependencies: If multiple developers are working on the same feature, it is important to manage dependencies carefully. This can be done using tools such as dependency management systems and version control systems.

### How to implement trunk-based development
If you are new to TBD, here are a few tips on how to implement it:

- Start by merging all of your existing branches into the trunk branch. This will give you a clean starting point. 
- Create a short-lived feature branch for each new feature or bug fix that you are working on. Each branch should be merged back into the trunk branch as soon as it is ready, and in any case no later than 2 days (max).
- Alternatively, you can commit straight into the trunk branch, with a pre-integration step (such as a CI pipeline) that runs tests and checks for errors after each commit.

### References
- https://trunkbaseddevelopment.com
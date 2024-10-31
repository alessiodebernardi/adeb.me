---
title: "Git merge vs git rebase"
date: 2024-10-31T13:50:12Z
draft: false
tags:
  - Development
  - Software Engineering
  - Git
---

Anyone who has worked with Git at least once faced the dilemma of choosing between `git merge` (merging) and `git rebase` (rebasing). 
Both commands are used to integrate changes from one branch into another, but they do it in fundamentally different ways and have different use cases, both with their own pros and cons.
Let's try to understand how they work and the differences between them.

## Git Merge
The **merge** command integrates changes from one branch into another by creating a new commit (called _merge commit_) that combines the changes from the source branch with the target branch.
Basically it combines the history of two branches into a single branch.

![merge_vs_rebase_1.png](merge_vs_rebase_1.png)

The usage is pretty straightforward:
1. Checkout the branch you want to merge into (target branch): 
   - `git checkout <target_branch>`
2. Run the merge command with the branch you want to merge from (source branch): 
   - `git merge <source_branch>`

For example, if you have a feature branch and you want to merge it into the master branch, you would do the following:

```sh
git checkout master
git merge feature-branch
```

### Fast-Forward (or two-way) Merge
If there have been no commits on the target branch, Git automatically moves the pointer (of the target branch) forward to the top of the source branch.
This is the simplest scenario and occurs when there's a linear path between the two branches, meaning the target branch is a direct ancestor of the source branch.
In this case no new merge commit is created and the commit history is preserved clean and linear.

![merge_vs_rebase_2.png](merge_vs_rebase_2.png)

If you want to force a merge commit to be created even if a fast-forward merge is possible (for example to keep a more detailed history), you can use the `--no-ff` flag:
`git merge --no-ff <target_branch>`

### Three-Way Merge
If the source branch and the target branch diverged (there have been commits in both branches since branching) then a three-way merge is performed.
This is the most common scenario (especially in collaborative environments where multiple developers are working on the same project) 
and Git will create a new _merge commit_ that combines the changes from both branches.

## Git Rebase
The **rebase** command applies a series of commits from one branch onto another.
It rewrites the history of the source branch, making it appear as if the commits were made directly on the target branch.

![merge_vs_rebase_3.png](merge_vs_rebase_3.png)

The usage is similar to the merge command:
1. Checkout the branch you want to rebase: 
   - `git checkout <source_branch>`
2. Run the rebase command with the destination branch of the rebase: 
   - `git rebase <target_branch>`

For example, if you have a feature branch and you want to rebase it onto the master branch, you would do the following:

```sh
git checkout feature-branch
git rebase master
```

### Standard Rebase
Using the rebase command without any flags will perform a standard rebase. In this case,
Git will automatically take the commits in your current working branch and apply them to the head of the passed branch.

### Interactive Rebase
Running the rebase command with the `--interactive` flag will begin an interactive rebasing session: 
```sh
git rebase --interactive <target_branch>
```
This means that instead of just (trying to) automatically move all the commits to the new branch 
the interactive rebase will allow you to alter the commits in the process. This is useful to clen up the history, remove or alter commits, reorder them, squash and so on.

### An example
Let's say that we have a `main` branch and a `feature` branch branched from `main`. In both of them we have some commits and we want to align our `feature` branch with the latest changes from `main`.

We can then rebase `main` into `feature`:
```sh
git checkout main
git rebase feature
```

Git will replay (rewrite with new hashes) the commits from `feature` on top of `main`, like if `feature` was branched from the latest commit of `main`.

![merge_vs_rebase_4.png](merge_vs_rebase_4.png)

Now the `feature` branch is up to date with the latest changes from `main` with a clean history and without any merge commits.

## Squashing Commits
The **squashing** is a technique used to combine multiple commits into a single one.

It's a common practice to keep the commit history clean and concise and can be used **in both rebase and merge**.
This is often used to clean up the history before merging or rebasing a feature branch into the main branch, making it easier to read and understand.

### Squashing in Interactive Rebase
During an interactive rebase session, you can squash commits by changing from `pick` command to `squash` (or `s`) for the commits you want to squash.

### Squashing in Merge
During a merge operation, you can squash commits by using the `--squash` flag:
```sh
git merge --squash <source_branch>
```

## Conclusions
Both merge and rebase are powerful tools that can be used to integrate changes from one branch into another, even though they do it in fundamentally different ways and with different results.

Let's wrap up the main differences between them.

### History
  - Merge combines the histories of two branches, creating a new "merge commit" that has two parent commits. This keeps the original branch history intact, preserving all commits and showing a clear picture of when branches diverged and converged.
  - Rebase moves (replays) your branch's commits on top of another base commit, rewriting the commit history to make it look as if the work was done linearly. This results in a cleaner history without the additional merge commits, but it changes the commit hashes of the rebased branch.

### Use cases
  - Merge is useful when you want to preserve the full history and context, such as in collaborative projects where branch histories provide insight into how features and fixes were developed over time.
  - Rebase is often used for keeping a feature branch up to date with the main branch by replaying your work on top of the latest changes, especially before merging a feature branch into main to avoid unnecessary merge commits and ensure a clean history.

### Collaboration
  - Merge is safe to use on both public and private branches since it doesn’t rewrite history, just adds a new merge commit.
  - Rebase should be used carefully, especially on shared branches, because it rewrites commit history. Changing commits can cause issues for other collaborators if they have already based their work on the original commits.

In conclusion, there is no right or wrong choice between merge and rebase, all depends on the context (like team size and skill level, project complexity, personal preference) and the desired outcome.
The important thing is to understand how they work and what effect they have on your project's history.
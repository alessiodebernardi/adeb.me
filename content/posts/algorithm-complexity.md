---
title: "Algorithm complexity"
date: 2023-11-28T18:27:06Z
draft: false
tags:
  - Development
  - Software Engineering
  - Computer Science
---

Algorithm complexity is a crucial concept in computer science that helps us analyze the efficiency of algorithms. 
Whether you're a budding programmer or a seasoned developer, understanding algorithm complexity is essential for writing 
efficient and scalable code. In this blog post, we'll explore the basics of algorithm complexity and guide you through the process of calculating it.

### What is Algorithm Complexity?

Algorithm complexity is a measure of the efficiency of an algorithm in terms of the resources it consumes. 
The two primary resources considered are time and space:
- **Time complexity**: estimates the amount of time an algorithm takes to complete based on the input size
- **Space complexity**: estimates the amount of memory an algorithm uses to run based on the input size

To describe this measurement rigorously, we need to get into the math using **Big O notation**.

### Big O Notation

Big O notation is a [mathematical notation](https://en.wikipedia.org/wiki/Big_O_notation) that describes the limiting behavior of a function when the argument tends towards a particular value or infinity.

It is used, among other things, to describe the efficiency of an algorithm, like **the upper bound on the growth rate of an algorithm's time complexity or space complexity as a function of the input size**.
In other words, it provides an asymptotic analysis of how the runtime or memory requirements increase as the size of the input increases.

It is expressed using the "`O`" letter followed by a function that represents the upper bound.
For example, if an algorithm has a time complexity of `O(n)`, it means that the running time of the algorithm grows linearly with the size of the input (n).

![big-o.png](big-o.png)

When analyzing algorithms, Big O notation is particularly useful for comparing the efficiency of different algorithms and understanding how their performance scales with larger inputs.
Usually it is used to focus on the worst-case scenario, providing an upper bound on the execution time or space requirements, 
but it can also be used to describe the average-case scenario or the best-case scenario as well.

It's important to note that Big O notation describes the growth rate without considering constant factors, so two algorithms with the same 
Big O complexity may still have slightly different actual runtimes.

Here some examples (ordered from best to worst in terms of performance):
- `O(1)`: Constant time complexity
- `O(log n)`: Logarithmic time complexity
- `O(n)`: Linear time complexity
- `O(n log n)`: Linearithmic time complexity
- `O(n^2)`,`O(n^3)`, etc: Polynomial time complexity _(⚠️ Here things are getting bad)_
- `O(2^n)`, etc: Exponential time complexity _(🚨 Here things are getting really bad)_
- `O(n!)`: Factorial time complexity _(☢️ Here things are getting really really bad)_

![functions.png](functions.png)

### Calculating Time Complexity
Here are the steps to calculate the time complexity of an algorithm:
1. Counting operations: The first step in calculating time complexity is to count the number of basic operations an algorithm performs. This step involves identifying key operations like assignments, comparisons, and loops.
    - Nested loops: If an algorithm has nested loops, multiply the number of operations in each loop to calculate the total number of operations. For example, if an algorithm has two nested loops, one with `n` iterations and the other with `m` iterations, the total number of operations is `n * m`. 
    - Recursive algorithms: If an algorithm is recursive, use the [recursion tree method](https://www.geeksforgeeks.org/analysis-algorithm-set-4-master-method-solving-recurrences/) to calculate the time complexity.
2. Big O Notation: Once you've counted the operations, express the growth rate of the algorithm's running time in terms of Big O notation. For example, if an algorithm performs `n` operations, its time complexity is `O(n)`.
3. Simplify: Finally, simplify the Big O expression by removing the constants and lower-order terms. For example, if an algorithm performs `3n + 2` operations, its time complexity is `O(n)`.
4. Best, worst, and average case: In some cases, you may need to calculate the time complexity for the best, worst, and average case.

#### Example 1 - Maximum element in an array

```python
function findMax(arr):
    maxElement = arr[0]
    for element in arr:
        if element > maxElement:
            maxElement = element
    return maxElement
```

1. Counting operations
   - The first assignment `maxElement = arr[0]` can be ignored, since it's executed only once per execution
   - Then we have one comparison `element > maxElement` and one assignment `maxElement = element` performed for every item of the input array
2. Big O Notation
   - We have 2 operations (one comparison and one assignment) performed for each item of the array (that has `n` items, so `n` times)
   - So our Big O Notation is `O(2n)`
3. Simplify
   - We can remove the constant term from our expression, so our final complexity is `O(n)` 

#### Example 2 - Binary search

```python
# We assume that the input array is sorted.
def binary_search(arr, target):
    low, high = 0, len(arr) - 1
    
    while low <= high:
        mid = (low + high) // 2
        if arr[mid] == target:
            return True
        elif arr[mid] < target:
            low = mid + 1
        else:
            high = mid - 1
    
    return False
```
1. Counting operations
   - We can ignore the first assignment `low, high = 0, len(arr) - 1`, since it's executed only once per execution
   - Then we have one comparison `low <= high` and one assignment `mid = (low + high) // 2` performed for every iteration of the loop
   - Inside the loop we have one comparison `arr[mid] == target` (that become 2 in the worst case scenario) and one assignments (`low = mid + 1` or `high = mid - 1`, always in the worst case scenario)
   - So, in total, we have 5 operations performed for every iteration of the loop
2. Big O Notation
   - In each step, the search range is reduced by half, so the number of iterations is `log(n)`
   - So our Big O Notation is `O(5 log(n))`
3. Simplify
   - We can remove the constant term from our expression, so our final complexity is `O(log(n))`

#### Example 3 - Bubble sort

```python
def bubble_sort(arr):
   n = len(arr)
    for i in range(n):
        # Last i elements are already sorted, so we don't need to check them
        for j in range(0, n-i-1):
            if arr[j] > arr[j+1]:
                # Swap if the element found is greater than the next element
                arr[j], arr[j+1] = arr[j+1], arr[j]
```

1. Counting operations
   - We can ignore the first assignment `n = len(arr)`, since it's executed only once per execution
   - Then we have one comparison `arr[j] > arr[j+1]` and one assignment `arr[j], arr[j+1] = arr[j+1], arr[j]` performed for every iteration of the inner loop
2. Big O Notation
   - The outer loop is executed `n` times
   - The inner loop is executed `n - i - 1` times
   - So our Big O Notation is `O(2 * n * (n - i - 1))`
3. Simplify
   - We can remove the constant  and lower order terms from our expression, so our final complexity is `O(n^2)`


### Calculating Space Complexity
To calculate space complexity, we need to consider the memory used by the algorithm in terms of auxiliary space
(extra space used by the algorithm, not including the input) and input space (space required by the input itself).

Here are the steps to calculate the space complexity of an algorithm:
1. Identify Variables and Data Structures
   - Identify all the variables and data structures used by the algorithm. This includes not only the input variables but also any additional variables or data structures created during the execution of the algorithm.
   - Determine the size of each variable and data structure in terms of the input size. This step involves understanding how the memory requirements for different types of variables (e.g., integers, arrays, objects) scale with the size of the input.
   - If the algorithm involves recursion, consider the space required for each recursive call. This may include the function call stack, where each recursive call adds a new frame to the stack.
   - Count any additional space used by the algorithm that is not directly related to the input size. This includes constants, temporary variables, and any other auxiliary space.
2. Big O Notation: Once you've determined the space usage in terms of the input size, express the relationship using big O notation.
3. Simplify: Similar to time complexity, ignore constant factors and lower-order terms, focusing on the dominant factor that determines how the space requirements grow with the input size.
4. Best, worst, and average case: In some cases, you may need to calculate the space complexity for the best, worst, and average case.

#### Example - Array sum

```python
def sum_of_array(arr):
    sum = 0
    for element in arr:
        sum += element
    return sum
```

1. Identify Variables and Data Structures 
   - We have one variable `sum` and one array `arr`
   - The size of the variable `sum` is constant
   - The size of the array `arr` is `n`
2. Big O Notation
   - The space complexity is `O(1 * n)`
3. Simplify 
   - We can remove the constant term from our expression, so our final complexity is `O(n)`

### Conclusions
Understanding algorithm complexity is fundamental in the realm of computer science and software development. 
The efficiency of an algorithm can significantly impact the performance of a system, influencing everything from response times to resource utilization.
Whether it's optimizing existing algorithms or designing new ones, a good understanding of time and space complexity 
empowers developers to make informed decisions that improve the overall user experience.

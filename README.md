# Module 8: Introduction to Lists

## Overview
In this module, we'll cover an additional R data type called lists. Lists are somewhat similar to vectors, but can store more types of data and more details _about_ that data (with some cost). Lists are R's version of a **Map**, which is a common and extremely useful way of organizing data in a computer program. Moreover: lists are used to create _data frames_, which is the primary data storage type we'll use for working with sets of real data in R. This module will cover how to create and access elements in a list, as well as how to apply functions to lists or vectors.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Contents**

- [Resources](#resources)
- [What is a List?](#what-is-a-list)
  - [Creating Lists](#creating-lists)
  - [Accessing Lists](#accessing-lists)
  - [List Indicies](#list-indicies)
    - [Single vs. Double Brackets](#single-vs-double-brackets)
  - [Modifying Lists](#modifying-lists)
- [The `tapply()` Function](#the-tapply-function)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Resources
- [R Tutorial: Lists](http://www.r-tutor.com/r-introduction/list)
- [R Tutorial: Named List Members](http://www.r-tutor.com/r-introduction/list/named-list-members)
- [StackOverflow: Single vs. double brackets](http://stackoverflow.com/questions/1169456/in-r-what-is-the-difference-between-the-and-notations-for-accessing-the)

## What is a List?
A **List** is a lot like a vector, in that it is a one-dimensional collection of data. However, lists have two main differences from vectors:

1. Unlike a vector, you can store elements of _different types_ in a list: that is a list can contain numeric data _and_ character string data.
2. Elements in a list can be **tagged** with with names which we can use to easily refer to them&mdash;rather than talking about the list's "element \#1 of the list", we can talk about the list's "`first.name` element".

The second feature is the most significant, as it allows us to use lists to create a type of **map**. In computer programming, a map (or "mapping") is a way of associating one value with another. The most common example is a _dictionary_ or _encyclopedia_: a dictionary associates each word with it's definition: you can "look up" a definition by using the word itself, rather than needing to look up the 201st definition in the book. In fact, this same data structure is called a `dictionary` in the Python programming language!

Lists are extremely useful for organizing data. They allow us to group together data like a person's name (character), job title (character), salary (number), and whether they are in a union (logical)&mdash;and we don't have to remember whether whether the person's name or title was the first element!

### Creating Lists
We create a list by using the `list()` function and passing it any number of **arguments** (separated by commas) that we want to make up that list, similar to the `c()` functon for vectors.

However, we can specify the _tags_ for each element in the list by putting the name of the tag (which is like a variable name), followed by an equal symbol (**`=`**), followed by the value we want to go in the list. For example:

```r
person <- list(first.name = "Ada", job = "Programmer", salary = 78000, in.union = TRUE)
```

This creates a list of 4 elements: `"Ada"` which is tagged with `first.name`, `"Programmer"` which is tagged with `job`, `78000` which is tagged with `salary`, and `TRUE` which is tagged with `in.union`.

- Note that you can also have _vectors_ as elements of a list!

This use of the `=` symbol here an example of assigning a value to a specific named argument. We can actually use this syntax for _any_ function (e.g., rather than listing arguments in order, we can explicit "assign" a value to each argument), but it is more common to just use the normal order of the arguments if there aren't very many.

It is possible to create a list without tagging the elements:

```r
person.alt <- list("Ada", "Programmer", 78000, TRUE)
```

But it will make code harder to read and more error-prone, so isn't as common.


### Accessing Lists
If you printed out the above `person` list, you would see the following:

```
> print(person)
$first.name
[1] "Ada"

$job
[1] "Programmer"

$salary
[1] 78000

$in.union
[1] TRUE
```

Notice that it lists each tag name prepended with a dollar sign (**`$`**) symbol, and then on the following line the vector that is the element itself. The `$` symbol is one of the easiest ways of accessing list elements

Because list elements are (usually) tagged, we can access them by their tag name rather than by the index number we used with vectors. We do this by using **dollar notation**: you refer to the element with a particular tag in a list by writing the name of the list, followed by a `$`, following by the element tag:

```r
person <- list(first.name = "Ada", job = "Programmer", salary = 78000, in.union = TRUE)

person$first.name  # [1] "Ada"
person$salary  # [1] 78000
```

(See below for other options for accessing list elements).

You can almost read the dollar sign as like an "apostrophe s" (possessive) in English: so `person$salary` would mean "the `person` list's `salary` value".

Dollar notation allows list elements to almost be treated as variables in their own right, specifying e.g., that you're talking about the `salary` variable in the `person` list, rather than the `salary` variable in some other list (or not in a list at all!).

```r
person <- list(first.name = "Ada", job = "Programmer", salary = 78000, in.union = TRUE)

# use elements as function or operation arguments
paste(person$job, person$first.name)   # [1] "Programmer Ada"

# assign values to list element
person$job <- "Senior Programmer"  # a promotion!
print(person$job)  # [1] "Senior Programmer"

# assign value to list element from itself
person$salary <- person$salary * 1.15  # a 15% raise!
print(person$salary)  # [1] 89700
```

Note that if you need to, you can get a _vector_ of element tags using the `names()` function:

```r
person <- list(first.name = "Ada", job = "Programmer", salary = 78000, in.union = TRUE)
names(person)  # [1] "first.name" "job"  "salary"  "in.union"
```

### List Indicies
Whether or not a list element has a tag, we can also access it by its numeric index (i.e., if it is the 1st, 2nd, etc. item in the list). We do this by using **double-bracket notation**: you refer to the element at a particular index of a list by writing the name of the list, followed by double square brackets (**`[[]]`**) that contain the index of interest:

```r
# note: list and not a vector, even though same types
animals <- list("Aardvark", "Baboon", "Camel")

animals[[1]]  # [1] "Aardvark"
animals[[3]]  # [1] "Camel"
animals[[4]]  # Error: subscript out of bounds!
```

We can also use double-bracket notation to access an element by its tag if we put a character string (in `""`) of the tag inside the brackets. This is particularly useful if you want the tag itself to be a variable!

```r
person <- list(first.name = "Bob", last.name = "Wong", salary = 77000, in.union = TRUE)

person[["first.name"]]  # [1] "Bob"
person[["salary"]]  # [1] 77000

name.to.use <- "last.name"  # choose name (i.e., based on formality)
person[[name.to.use]]  # [1] "Wong"
name.to.use <- "first.name"  # change name to use
person[[name.to.use]]  # [1] "Bob"

# We can use indices for tagged elements as well!
person[[1]]  # [1] "Bob"
person[[4]]  # [1] TRUE
```

#### Single vs. Double Brackets
**Wach out!**: vectors use ___single___-bracket notation for accessing by index, but lists use ___double___-bracket notation for accessing by index!

This is because the single-bracket syntax for vectors isn't actually selecting by index: rather it **filtering** by whatever vector is inside the brackets (which may be just a single element: the index number to extract). In R, single brackets _always_ mean to filter the collection. This means if you put single-brackets after a list, what you're actually doing is getting a **sub-list** of the elements that have those indicies, just single brackets on a vector return a subset of elements in that vector:

```r
my.list <- list('A', 201, TRUE, 'rhinoceros')

# SINGLE brackets returns a list
my.list[1]
            # [[1]]
            # [1] "A"

# DOUBLE brackets returns a vector
my.list[[1]]  # [1] "A"

# can use any vector as the argument to single brackets, just like with vectors
my.list[1:3]
            # [[1]]
            # [1] "A"
            #
            # [[2]]
            # [1] 201
            #
            # [[3]]
            # [1] TRUE
```

In sum, remember that **single-brackets gives a list, double-brackets gives a vector**. We almost always want to be refering to the value itself (the vector&mdash;everything is a vector!) rather than a list, so almost always want to use ___double-brackets___.


### Modifying Lists
Unlike with vectors, we are also able to change the _number_ of elements that are inside a list&mdash;we can add and remove elements from a list!

We can add elements to a list by simply assigning a value to a tag (or index) in the list that doesn't yet exist:

```r
person <- list(first.name = "Ada", job = "Programmer", salary = 78000, in.union = TRUE)
# has no `age` element
person$age  # NULL

person$age <- 40
person$age  # [1] 40

# assign using index
person[[10]] <- "Tenth field"
# elements 6-9 will be NULL
```

We can also remove elements by assiging the special value `NULL` to their tag or index:

```r
a.list <- list('A',201,True)
a.list[[2]] <- NULL  # remove element #2
print(a.list)
            # [[1]]
            # [1] "A"
            #
            # [[2]]
            # [1] TRUE
```


For practice working with lists, see [exercise-1](exercise-1).

## The `tapply()` Function
Since everything is a vector in R, and most functions are _vectorized_, can can pass most functions (e.g., `paste()`, `round()`, etc) a vector and the function will be applied to each item in the vector. It "just works". But if we want to apply a function to each item in a _list_, we need to put in a bit more effort.

In particular, we need to use a function called **`lapply()`** (for _list apply_). This function takes two arguments: the first is a list or vector we want to modify, and the second is a function we want to "apply" to each item in that list. For example:

```r
# list, not a vector
names <- list("Sarah", "Amit", "Zhang")

# apply the `toupper()` function to each element in `names`
names.upper <- lapply(names, toupper)
            # [[1]]
            # [1] "SARAH"
            #
            # [[2]]
            # [1] "AMIT"
            #
            # [[3]]
            # [1] "ZHANG"

# apply the `paste()` function to each element in `names`, with an addition argument `"dances!"` to each call
dance.party <- lapply(names, paste, "dances!")
```

Notice that the second argument to `lapply()` is just the name of the function: not a character string (it's not in `""`), and we're not actually _calling_ that function (there are no `()` after it). Just put the name of the function! After that, you can put any additional arguments you want the applied function to be called with: for example, how many digits to round to, or what value to paste to the end of a string.

Also notice that the `lapply()` function returns a _new_ list; the original one is unmodified (though if the list contains vectors or other lists as elements, it's possible for those values to be changed).

We commonly use `lapply()` with our own custom functions which define what we want to do to a single item:

```r
# A function that prepends "Hello" to any item
Greet <- function(item) {
  return( paste("Hello", item) )
}

# a list of names
names <- list("Sarah", "Amit", "Zhang")

# greet each name
greetings <- lapply(names, Greet)
            # [[1]]
            # [1] "Hello Sarah"
            #
            # [[2]]
            # [1] "Hello Amit"

            # [[3]]
            # [1] "Hello Zhang"
```


Additionall, `lapply()` is a member of the `"*apply()"` family of functions; a set of functions that each starts with a different letter and applies to a different data structure, but otherwise all work basically the same. For example, `lapply()` is used for lists, while `sapply()` (simplified apply) works well for vectors. We'll look at more `*apply()` functions throughout the course.

For practice working with lists, see [exercise-2](exercise-2).

# Exercise 1: Lists

# Create a vector of everything you ate for breakfast
my.breakfast <- c('toast', 'eggs', 'tea')

# Create a vector of everything you ate for lunch
my.lunch <- c('soup', 'pb + j')

# Create a list "meals" that has contains your `breakfast` and `lunch`
meals <- list(breakfast = my.breakfast, lunch = my.lunch)

# Add a "dinner" element to your "meals" list that has what you plan to eat for dinner
meals$dinner <- c('curry', 'rice')

# Use dollar notation to extract your `dinner` element from your list
# and save it in a vector called 'dinner'
dinner <- meals$dinner

# Use double-bracket notation to extract your `lunch` element from your list
# and save it in your list as the element at index 5 (no reason)
meals[[5]] <- meals[['lunch']]

# Use single-bracket notation to extract your breakfast and lunch from your list
# and save them to a list called `early.meals`
early.meals <- meals[1:2]


### Bonus ###
# Create a list that has the number of items you ate for each meal
# Hint: use the `lappy()` function
items <- lapply(meals, length)

# Write a function that adds pizza to every meal
AddPizza <- function(x) {
  x <- c(x, 'pizza')
}

# Add pizza to every meal!
better.meals <- lapply(meals, AddPizza)

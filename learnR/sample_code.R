# Here is some sample R code. This is mostly supplemental to the pdf.
# Feel free (and in fact I recommment) editing this, running it in your
# own R environment, and seeing what you can do.
# Author: Sam Pollard (sam.d.pollard@gmail.com)
# Last Modified: 10 April 2015
# Note: This file can be run as is, but won't do very much if not run
# in interpreted mode. If you want to run the whole thing at once but
# still see output, you can sprinkle some calls to print throughout.
# For example, print(mydf) will achieve the same effect as if you were
# to type "mydf" (without the quotes) at the prompt.

# 1. Introduction
data(trees) # Load a sample dataset
nrow(trees) # Count the sample size
colnames(trees)
max(trees["Volume"]) # Find the largest in the column
max(trees[3]) # The same as above because we access the third column
apply(trees, 2, mean)

# 2. Basic Syntax and Examples
name <- c("H","He","Li") # c can be thought of as "combine"
mass <- c(1.0079,4.0026,6.941)
atomic_number <- seq(1,length(name))
mydf <- data.frame(atomic_number, name, mass)

# 3. Some Subtleties
# 3.1 Vectors
n <- nrow(trees)           # The number of trees
tag <- seq(1,n)            # A sequence from 1 to n, inclusive
lifespan <- 70*runif(n)    # Random values between 0 and 70, inclusive
volume <- trees["Volume"]  # The Volume of each tree
lifespan <- lifespan + 15

# Some helpful functions
class(volume)
volumevec <- trees[["Volume"]]
class(volumevec)
ls() # List all the variables in the current workspace

# 3.2 Building Up
treenames <- paste("T", tag, sep = "")
mydf <- cbind(treenames, trees, lifespan)
rownames(mydf) <- treenames
mydf <- mydf[,-1]
# Alternatively,
# mydf <- mydf[,c(2,3,4,5)]
# mydf[1] <- NULL
sample <- mydf[seq(4,9),]

# 4. Regression and Plotting
# Generate the noisy data and time samples
lb <- 0
ub <- 10
time <- seq(from = lb, to = ub, length.out = 100)
noisy_data <- rnorm(100, mean = 0, sd = 5) + 10 # Equivalently: rnorm(100,10,5)
noisy_data <- noisy_data + time^2
# Make a scatterplot of the data
plot(time, noisy_data)
# Try fitting a linear model
linearmodel <- lm(noisy_data ~ time)
# Get the coefficients to overlay the best-fit line over the scatterplot
intercept <- coef(linearmodel)[1]
slope <- coef(linearmodel)[2]
curve(slope * x + intercept, add = TRUE)
linearanalysis <- summary(linearmodel)
# quadratic interpreted as f(x) = p1 x^2 + p2 where p1 and p2 are parameters
# Here is the model we guess the data to follow
quadratic <- noisy_data ~ p1*time^2 + p2
model <- nls(quadratic, start = list(p1=0, p2=0))
# Plot the new, least-squares quadratic
p1 <- coef(model)[1]
p2 <- coef(model)[2]
curve(p1*x^2 + p2, from = lb, to = ub, add = TRUE)
quadraticanalysis <- summary(model)

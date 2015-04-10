# Here is some sample R code. This is mostly supplemental to the pdf.
# Feel free (and in fact I recommment) editing this, running it in your
# own R environment, and seeing what you can do.
# Author: Sam Pollard (sam.d.pollard@gmail.com)
# Last Modified: 9 April 2015
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
n <- nrow(trees)           # 1. The number of trees
tag <- seq(1,n)            # 2. A sequence from 1 to n, inclusive
lifespan <- 70*runif(n)    # 3. Random values between 0 and 70, inclusive
volume <- trees["Volume"]  # 4. The Volume of each tree
lifespan <- lifespan + 15

# Some helpful functions
classof(volume)
volumevec <- trees[["Volume"]] # 5.
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

# 4. Plotting
noisy_data <- rnorm(500)*sample(2000:5000,500)
measured_cats <- ceiling(noisy_trend^2 * sample(2000:5000,500))
time <- seq(0,499)
plot(time, measured_cats)
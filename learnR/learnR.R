### R code from vignette source 'learnR.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Introduction
###################################################
data(trees) # Load a sample dataset
nrow(trees) # Count the sample size
colnames(trees)
max(trees["Volume"]) # Find the largest in the column
max(trees[3]) # The same as above because we access the third column
apply(trees, 2, mean)


###################################################
### code chunk number 2: Basic Syntax and Examples
###################################################
name <- c("H","He","Li")       # c can be thought of as "combine"
mass <- c(1.0079,4.0026,6.941) # i.e. make a vector from the arguments
atomic_number <- seq(1,length(name))
mydf <- data.frame(atomic_number, name, mass)
mydf                           # Print out the data.frame


###################################################
### code chunk number 3: Vectors Part 1
###################################################
n <- nrow(trees)           # The number of trees
tag <- seq(1,n)            # A sequence from 1 to n, inclusive
lifespan <- 70*runif(n)    # Random values between 0 and 70, inclusive
volume <- trees["Volume"]  # The volume of each tree


###################################################
### code chunk number 4: Vectors Part 2
###################################################
mean(volume)


###################################################
### code chunk number 5: Vectors Part 3
###################################################
volumevec <- trees[["Volume"]]



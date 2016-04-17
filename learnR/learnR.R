# Here is some sample R code. This is mostly supplemental to the pdf.
# Feel free (and in fact I recommend) editing this, running it in your
# own R environment, and seeing what you can do.
# Author: Sam Pollard (sam.d.pollard@gmail.com)
# Last Modified: 4 April 2016
# Note: This file can be run as is, but won't do very much if not run
# in interpreted mode. If you want to run the whole thing at once but
# still see output, you can sprinkle some calls to print throughout.
# For example, print(mydf) will achieve the same effect as if you were
# to type "mydf" (without the quotes) at the prompt.

### Part I
# 1. Introduction
data(trees) # Load a sample dataset
nrow(trees) # Count the sample size
colnames(trees)
max(trees["Volume"]) # Find the largest in the column
max(trees[3]) # The same as above because we access the third column
apply(trees, 2, mean)

# 2. Basic Syntax and Examples
name <- c("H","He","Li")        # c can be thought of as "combine"
mass <- c(1.0079,4.0026,6.941)  # i.e. make a vector from the arguments
atomic_number <- seq(1,length(name))
mydf <- data.frame(atomic_number, name, mass)
mydf # Typing the variable name prints out the variable
# 2.1 Optional Arguments
write.csv(mydf, "report.csv", row.names = FALSE)
read.csv("report.csv") # Gives the same output as mydf

# 3. Some Subtleties
# 3.1 Vectors
n <- nrow(trees)           # The number of trees
tag <- seq(1,n)            # A sequence from 1 to n, inclusive
lifespan <- 70*runif(n)    # n uniformly distributed random numbers in [0,70]
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
# 4.1 Regression
# Generate the noisy data and time samples
lb <- 0
ub <- 10
time <- seq(from = lb, to = ub, length.out = 100)
noisy_data <- rnorm(100, mean = 0, sd = 5) + 10 # Equivalently: rnorm(100,10,5)
noisy_data <- abs(noisy_data) + time^2
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

# 4.2 Plotting
# Close the basic plots we were using and start the driver to make a pdf plot
dev.off()
pdf("sample_plot.pdf")

# Make the scatterplot and label the axes
plot(time, noisy_data, xlab = "Time (months)",
     ylab = "Number of Cats (millions)")
# Change the title and marginal text
title("Number of Cats Over Time", line = 2, cex.main = 1.6)
mtext("What do we do with all these cats?\nBy Sam Pollard", font = 3,
      cex = 0.8)
# Overlay the linear and quadratic best fit curves
curve(slope * x + intercept, add = TRUE, lwd = 2, col = "red")
curve(p1*x^2 + p2, add = TRUE, lwd = 2, col = "blue")
# Create the legend
quadtext <- paste0(format(round(p1, 2), nsmall = 2), " t^2 + ",
                   format(round(p2, 2), nsmall = 2))
linetext <- paste0(format(round(slope, 2), nsmall = 2), " t + ",
                   format(round(intercept, 2), nsmall = 2))
legendtext <- c(quadtext, linetext)
legend("topleft", legend = legendtext, col = c("blue","red"), lwd = c(2,2))
# Say that we're finished plotting so the pdf can be saved
dev.off()

### Part II
# 6. Functions
parenthesize <- function(x) {
	interior <- paste(x, collapse = " ")
	return(paste("(", interior, ")"))	
}

# 6.1. A (Seemingly) More Complex Function
proteins <- c("3G73","3CO6","1VDE","1AF5","1EVX","2OST","1QQC","1KN9","3BF0")
# The desired output
protein_string <- "3G73,3CO6,1VDE,1AF5,1EVX,2OST,1QQC,1KN9,3BF0"

intersperse <- function(vec, ele) {
	vlen <- length(vec)
	if (vlen >= 1) {
		y <- vec[1]
	} else {
		return("")
	}
	if (vlen > 1) {
		for (i in seq(2,vlen)) {
			y <- paste(y, ele, vec[i], sep = "")
		}
	}
	return(y)
}

# 6.1.2. A Simpler Version
intersperse <- function(vec, ele) {
	if (length(vec) < 2) {
		return(vec)
	}
	y <- vector("character", length = 2*length(vec) - 1)
	y[seq(2, length(y), 2)] <- ele
	y[seq(1, length(y), 2)] <- vec
	return(paste0(y, collapse = ""))
}

# 6.1.3. KISS (Keep It Simple, Stupid)
intersperse <- function(vec, ele) {
	return(paste(vec, ele))
}


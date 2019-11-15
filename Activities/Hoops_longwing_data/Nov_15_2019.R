#####
# Day 2 of R
# Hoops and Dr. McNelis
# 2019-11-15
#####

# Weds. review
carrots <- read.csv("carrots.csv")
head(carrots, n = 4)
hist(mass) # Doesn't work!
hist(carrots$mass)

# Making a boxplot
boxplot(carrots$mass)
# In R, the Boolean value "true" is T or TRUE.
boxplot(carrots$mass, horizontal = TRUE)
boxplot(carrots$mass,
        horizontal = TRUE,
        xlab = "Mass (g)",
        main = "Distribution of Carrot Mass")
# Separate by carrot types: two ways.
boxplot(carrots$mass[carrots$type == 0],
        carrots$mass[carrots$type == 1],
        horizontal = TRUE,
        names = c("Napoli", "Yaya"),
        col = c("firebrick3", "deepskyblue"),
        xlab = "Mass (g)",
        main = "Distribution of Carrot Mass")

# This way plots all types and adds labels.
# Doesn't work if we only want certain groups.
boxplot(carrots$mass~carrots$type,
        horizontal = TRUE,
        names = c("Napoli", "Yaya"),
        xlab = "Mass (g)",
        ylab = NULL,
        main = "Distribution of Carrot Mass")

# Allowed colors: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
# Allowed line types: http://www.sthda.com/english/wiki/line-types-in-r-lty

# Pairwise matrix of all possible scatterplots.
pairs(carrots)

# Scatterplot of mass vs. leaves (two ways)
plot(mass~leaves, data = carrots,
     col = "darkorange", cex = 2)
# This also works: plot(x = carrots$leaves, y = carrots$mass)

# Make a linear regression model of mass vs. leaves.
my_model <- lm(mass~leaves, data = carrots)
summary(my_model)
abline(my_model, col = "springgreen4",
       lty = 2, lwd = 2)

# Importing butterfly data
butterfly <- read.csv("hoops_longwing_sample.csv")
butterfly <- butterfly[ , -1] # Remove first column
str(butterfly)
pairs(butterfly)

# Feeding range vs. age exponential fit
butterfly$log_fr <- log(butterfly$feeding_range)
hist(butterfly$log_fr)
plot(log_fr~age, data = butterfly)
fr_age_model <- lm(log_fr~age, data = butterfly)
summary(fr_age_model)

# Get coefficients for the model
model_coefs <- coef(fr_age_model)
k <- model_coefs[[2]]
A <- exp(model_coefs[[1]])

# We had to do some sorting to make the plot work.
fr_hat <- A * exp(k * sort(butterfly$age))
plot(feeding_range~age, data = butterfly)
par(new=TRUE)
plot(sort(butterfly$age), fr_hat, type = "l", lty = 2)


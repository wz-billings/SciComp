###Kinetics: Intro to R Plotting and Regression###
#Zane Billings#
#MATH 340 Spring 2019#
setwd("/Users/zanebillings/Documents/Spring 2019/Sci Comp")

###Part 1: A simple Lineweaver-Burke Plot
#the data frame "ex" will contain a very basic data fit that was
#created specifically to show a good LB-fit.
ex <- data.frame(matrix(c(2,3,4,5,6,7,8,9,10,
                   2.9,3.8,4.4,5.0,5.4,5.8,6.2,6.4,6.7),
                 ncol = 2, byrow = F))

#rename the columns to make everything easier and print a basic plot
colnames(ex) <- c("S","V")
plot(ex)

#Let's create a linear model, using the reciprocals of the data.
#This is the most basic way to do this transformation,
#But it works just fine for a simple LB plot.
ex.model <- lm(formula = I(1/V)~I(1/S),
               data = ex)

lb.ex <- data.frame(
  s.recip <- 1/ex$S,
  v.recip <- 1/ex$V
)

model <- lm(
  formula = v.recip~s.recip,
  data = lb.ex
)

summary(model)

#print a summary of the linear model.
summary(ex.model)
#let's generate the LB plot and see how it looks.
plot(x = 1/ex$S,
     y = 1/ex$V,
     main = "Lineweaver-Burke Plot",
     xlab = "1/[S]",
     ylab = "1/V")
abline(ex.model,lty=2) #this adds the line to the plot
#Now, we can use the model to calculate Km and Vmax.
cfs <- coef(ex.model) #we will need the coefficients.
#both of the below formulae can be obtained by easy algebra.
vmax <- as.numeric(1/cfs[1])
km <- as.numeric((1/cfs[1])*cfs[2])
vmax;km #print the values.

#Let's plot the model. Generate a vector of the predicted y-values, then plot.
vhat <- (vmax*ex$S)/(km+ex$S)
plot(ex,main = "Lineweaver-Burke Example") + lines(x = ex$S, y = vhat,lty=2)


###Part 2: Importing the second (more realistic) data set
#Import the data from the provided csv file
kinetics <- read.csv("kineticsdata.csv")
#change the column names, units just make it harder to call columns
colnames(kinetics) <- c("concentration","v1","v2","v3")
#Take the means across all rows but row 1.
kinetics <- transform(kinetics, vave = rowMeans(kinetics[,-1]))

#cursory plot of the data
plot(x = kinetics$concentration,y = kinetics$vave)

###Part 3: Lineweaver-Burk Plot and its issues
#Instead of just plugging into the LM fxn, a new data frame is easy to make.
lb.data <- data.frame(c.recip = 1/kinetics$concentration,
                      v.recip = 1/kinetics$vave)

#Make the LB line and generate the LB plot
lb.model <- lm(formula = v.recip~c.recip,
               data = lb.data)
summary(lb.model)
plot(lb.data) + abline(lb.model, lty=2)

#Well that sure looks bad.

#extract KM and VMax
lb.cf <- coef(lb.model) #extract the coefficients
lb.vmax <- as.numeric(1/lb.cf[1])
lb.km <- as.numeric(1/(lb.cf[1])*lb.cf[2])

###Part 4: Hanes-Woolf Plot (correction of LB model)
#The Hanes-Woolf model corrects for error in the LB plot by multiplying the entire
#LB equation by the substrate concentration.

#Generate a new data frame for the HW correction
hw.data <- data.frame(c.hw = kinetics$concentration,
                      v.hw = lb.data$v.recip*kinetics$concentration)
#generate and plot a linear model
hw.model <- lm(formula = v.hw~c.hw,
               data = hw.data)
summary(hw.model)
plot(hw.data) + abline(hw.model, lty=2)

#Now we can extract the coefficients.
hw.cf <- coef(hw.model)
hw.vmax <- as.numeric(1/hw.cf[2]) #algebra is slightly different but not hard
hw.km <- as.numeric((1/hw.cf[2])*hw.cf[1])
#these results are (obviously) more trustworthy than the LB model for these data.

###Part 5: Nonlinear Least-Squares (the better way)
#That's right: why do transforms and algebra when your computer can just do it.
nls.model <- nls(formula = vave ~ Vmax * concentration/(Km + concentration), 
                 data = kinetics,
                 start = list(Km = max(kinetics$vave)/2,
                              Vmax = max(kinetics$vave)))
summary(nls.model) 
nls.cf <- coef(nls.model) #extract the parameters of the model
#let's make a yhat vector for plotting.
nls.yhat <- (as.numeric(nls.cf[2])*kinetics$concentration)/(as.numeric(nls.cf[1])+kinetics$concentration)
plot(x = kinetics$concentration,
     y = kinetics$vave) + lines(x = kinetics$concentration, y = nls.yhat, lty=2)

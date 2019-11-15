###
# Generating Hoops' Longwing Butterfly sample study data
# @author Zane Billings
# @data 2019-11-14
# Generates a mock dataset representing an observational study of the fictional
#  Moluccan butterfly Hoops' Longwing (Heliconius Hoopsus).
###

# Parameters for data generation.
set.seed(340)
N <- 50

# Wing length is normally distributed with mean 24 inches and SD 3 inches.
wing_length <- rnorm(N, 24, 3)

# Hoops' Longwing can be found on three islands. 60% chance a sample was 
#  collected on Ternate, 35% on Tidore, and 15% on Kayoa.
population <- sample(c("Ternate", "Tidore", "Kayoa"), 
                               N, replace = TRUE, 
                               prob = c(0.6, 0.35, 0.15))

# Adjust wing length based on population.
for (i in 1:length(population)) {
  if (population[i] == "Ternate") {
    wing_length[i] <- wing_length[i] * 0.6
  } else if (population[i] == "Tidore") {
    wing_length[i] <- wing_length[i] * 1.2
  }
}

wing_length <- round(wing_length, 2)

# Wing width (inches) is a function of wing length.
wing_width <- round((wing_length/3 + 2) + rnorm(N, 0, 1), 2)

# Age (months) follows this distribution that I made up.
age <- sample(0:3, size = N, replace = TRUE, prob = c(0.5,0.25, 0.15, 0.1))
age <- age * 12
age <- floor(age + rnorm(N, mean = 12, sd = 3))

# Number of offspring is a function of age.
num_offspring <- floor(8.2 * log(age) + 4 + rnorm(N, 0, 1))

# Feeding range (sq km) is a function of age.
feeding_range <- round((0.2 * 1.1^age) + rnorm(N, 2, 0.7), 2)

# Color peak (UV-Vis spec., nm) is normally distributed. 
color_peak <- round(rnorm(N, mean = 392, sd = 9), 2)

# Dispersal distance (km) is a function of color peak. (No bio. reason why!)
dispersal_distance <- round((color_peak/12 - 8) + rnorm(N, 0, 0.25), 2) 

# Number of mates is a polynomial function of color peak.
num_mates <- floor((0.01 * wing_length^(2) + 0.1*wing_length) + rnorm(50, 0, 1))

# Average scale size is a function of wing length.
avg_scale_size <- round((0.04*wing_length^2 + 20) + rnorm(N, mean = 0, sd = 0.1 * mean(wing_length)),2)

# Antenna length is a function of the log of wing length.
antenna_length <- round((3.2*log(wing_length) - 10)+ rnorm(N, log(wing_length), 0.02*log(wing_length)),2)

# Num spots is a hyperbolic function of wing width.
num_spots <- floor(50/wing_width)

# Unique sample id
library(stringi)
library(stringr)
sample_id_pop <- str_trunc(population, 3, side = "right", ellipsis = "")
sample_id_sample <- str_pad(as.character(1:N), nchar(as.character(N)), pad = "0", "left")
collector_id <- sample(c("ZB", "MP", "EM", "ZW"), size = N, replace = TRUE)
sample_id <- paste(sample_id_pop, sample_id_sample, collector_id, sep = "_")

# Total body size is a multivariate function.
body_length <- round((0.2*wing_length + 0.2*wing_width + 1) + rnorm(N,0,1),2)

# Join together into data frame.
butterfly <- data.frame(wing_length, wing_width, age, num_offspring, 
                        feeding_range, color_peak, num_mates, avg_scale_size,
                        antenna_length, num_spots, population, dispersal_distance,
                        body_length, sample_id)
#pairs(butterfly)

write.csv(butterfly, "hoops_longwing_study.csv")

butterfly_sample <- data.frame(wing_length, wing_width, age, num_offspring, feeding_range)
#pairs(butterfly_sample)
write.csv(butterfly_sample, "hoops_longwing_sample.csv")

#reading file
data <- read.csv('udemy_courses.csv', header = TRUE, sep = ",", stringsAsFactors = FALSE)

#redefining some columns
data["level"] <- factor(data$level, levels = unique(data$level), labels = unique(data$level))
data["subject"] <- factor(data$subject, levels = unique(data$subject), labels = unique(data$subject))
data["is_paid"] <- as.logical(data$is_paid)

###################################################
### Ejercicio 2 - Preparación (tidyr, reshape2) ###
###################################################

library(tidyr)
library(reshape2)

#1.Crea una nueva course_id_title que sea la concatenación de ambas mediante un guion bajo
data <- unite(data, course_id_title, course_id, course_title, sep = "_", remove = FALSE)


#2. Sobreescribe el valor de las columnas published_timestamp por una columna de tipo fecha.
data["published_timestamp"] <- as.Date(data$published_timestamp)


#3. Crea un long dataset ... (from wide to long)
#tidyr
long_dataset_tidyr <- pivot_longer(data, 
                            cols = c(num_subscribers, num_reviews,  num_lectures), 
                            names_to = "VARIABLE", 
                            values_to = "VALUE")[c("course_id", "course_title", "VARIABLE", "VALUE")]


#reshape2
long_dataset_reshape2 = melt(data, 
                             id.vars = setdiff(colnames(data), c("num_subscribers", "num_reviews",  "num_lectures")),
                             variable.name="VARIABLE", 
                             value.name="VALUE")[c("course_id", "course_title", "VARIABLE", "VALUE")]


#4. proceso inverso (from long to wide)
#tidyr
original_dataset_tidyr = pivot_wider(long_dataset_tidyr,
                                     names_from = "VARIABLE",
                                     values_from = "VALUE")



#reshape2
original_dataset_reshape2 = dcast(long_dataset_reshape2,
                                  formula = course_id + course_title ~ VARIABLE,
                                  value.var = "VALUE")



######################################################
### Ejercicio 2 - Manipulación (dplyr, data.table) ###
######################################################



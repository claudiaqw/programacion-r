### Ejercicio 2

#reading file
data <- read.csv('udemy_courses.csv', header = TRUE, sep = ",", stringsAsFactors = FALSE)

#redefining some columns
data["level"] <- factor(data$level, levels = unique(data$level), labels = unique(data$level))
data["subject"] <- factor(data$subject, levels = unique(data$subject), labels = unique(data$subject))
data["is_paid"] <- as.logical(data$is_paid)





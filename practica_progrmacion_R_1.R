#1
data <- read.csv('udemy_courses.csv')

#2
class(data)

#3
str(data)

#4
head(data, 18)

#5
tail(data,25)

#6
dim(data)

#7
colnames(data)

#8
any(is.na.data.frame(data))

#9
data["level"] <- factor(data$level, levels = c("Beginner Level", "Intermediate Level", "Expert Level", "All Levels"), labels = c("Beginner Level", "Intermediate Level", "Expert Level", "All Levels"))
data["subject"] <- factor(data$subject, levels = c("Business Finance", "Graphic Design", "Musical Instruments", "Web Development"), labels = c("Business Finance", "Graphic Design", "Musical Instruments", "Web Development"))

#10



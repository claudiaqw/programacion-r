#1
data <- read.csv('udemy_courses.csv', header = TRUE, sep = ",")

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
data["is_paid"] <- as.data.frame.logical(data)

#11
mean(data$num_subscribers)

#12
media <- c(mean(data$num_subscribers), mean(data$num_lectures))

#13
sapply(data, is.numeric)

#14 #TODO


#15
data[1:30, 1:(ncol(data)-3)]

#16
data[-31: -nrow(data), -(ncol(data)-2):-ncol(data)]






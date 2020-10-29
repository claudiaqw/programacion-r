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
level_factor <- factor(data["level"], levels = c(""))
level_factor

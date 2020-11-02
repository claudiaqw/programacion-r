#1
data <- read.csv('udemy_courses.csv', header = TRUE, sep = ",", stringsAsFactors = FALSE)

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

#10 #TODO
data["is_paid"] <- as.logical(data$is_paid)

#11
mean(data$num_subscribers)

#12
media <- c(mean(data$num_subscribers), mean(data$num_lectures))

#13
numeric_columns <- sapply(data, is.numeric)

#14
sapply(data[numeric_columns][,-1], mean)

#15
data[1:30, 1:(ncol(data)-3)]

#16
data[-31: -nrow(data), -(ncol(data)-2):-ncol(data)]

#17
quantile(data$price, probs = seq(0, 1, 0.25))

#18
quantile(data$price, seq(0, 1, 0.1))

#19
summary(data)

#20
length(unique(data$course_title))

#21
nrow(subset(data, subset = num_reviews > 1000))

#22
data[order(data$course_id[1:100], decreasing = TRUE),]

#23
head(data[order(data$num_lectures, decreasing = FALSE),])

#24. Obtén los índices de los registros para los que el valor de la variable num_reviews es superior a la mediana.
which(data$num_reviews > median(data$num_reviews))

#25. ¿Cuántos cursos existen para el nivel “Intermediate Level”? 
length(which(data$level == "Intermediate Level"))

#26. ¿Qué curso tiene el mayor número de estudiantes? ¿Y el menor?
data[which(data$num_subscribers == max(data$num_subscribers)),]
data[which(data$num_subscribers == min(data$num_subscribers)),]

#27. ¿Qué cursos son gratuitos? 
data[which(data$price == 0),]

#28. Comprueba utilizando el boxplot si la variable num_reviews tiene outliers.
boxplot(data$num_reviews)

#29. Pinta un histograma de la variable price. 
hist(data$price)

#30. Crea una función (cheap_expensive) ...
cheap_expensive <- function (price, threshold){
  if(price < threshold)
    return("CHEAP")
  else
    return("EXPENSIVE")
}
cheap_expensive(100, mean(data$price))
cheap_expensive(45,mean(data$price))

#31. ...aplica la función anterior a toda la columna price_detail_amount.
data <- cbind(data, cheap_expensive = sapply(data$price, cheap_expensive, threshold = mean(data$price)))

#32. Repite el ejercicio anterior usando el paquete PURRR
library(purrr)
data <- cbind(data, cheap_expensive_purr = map_chr(data$price, cheap_expensive, threshold = mean(data$price)))

identical(data$cheap_expensive,data$cheap_expensive_purr)

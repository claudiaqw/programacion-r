### Ejercicio 1

#1. Lee el fichero y asígnalo a una variable. 
data <- read.csv('data/udemy_courses.csv', header = TRUE, sep = ",", stringsAsFactors = FALSE)

#2. ¿De qué clase es el objeto? 
class(data)

#3. ¿Cómo se pueden ver el tipo de cada columna y una muestra de ejemplos? 
str(data)

#4. Muestra los primeros 18 registros del dataset. 
head(data, 18)

#5. Muestra los últimos 25 registros del dataset. 
tail(data,25)

#6. ¿Cuáles son las dimensiones del dataset? 
dim(data)

#7. ¿Cuáles son los nombres de las variables del dataset? 
colnames(data)

#8. Comprueba si alguna de las variables contiene NAs
any(is.na(data))

#9. Crea un factor con etiquetas para dicha columna (level y subject) y asígnalo a la columna de nuevo
# Via 1
data["level"] <- factor(data$level, 
                        levels = c("Beginner Level", "Intermediate Level", "Expert Level", "All Levels"), labels = c("Beginner Level", "Intermediate Level", "Expert Level", "All Levels"))
data["subject"] <- factor(data$subject, levels = c("Business Finance", "Graphic Design", "Musical Instruments", "Web Development"), labels = c("Business Finance", "Graphic Design", "Musical Instruments", "Web Development"))

#Via 2
data["level"] <- factor(data$level, levels = unique(data$level), 
                        labels = unique(data$level))
data["subject"] <- factor(data$subject, levels = unique(data$subject), 
                          labels = unique(data$subject))


#10. Conviérte a variable booleana (is_paid) y asígnala a la propia columna.
data["is_paid"] <- as.logical(data$is_paid)

#11. Calcula la media de la columna num_subscribers. 
mean(data$num_subscribers)

#12. Guarda en un vector (media) la media de las columnas num_subscribers y num_lectures. 
media <- c(mean(data$num_subscribers), mean(data$num_lectures))

#13.  ¿Qué variables son numéricas?
numeric_columns <- sapply(data, is.numeric)

#14.  Selecciona aquellas columnas numéricas y calcula la media de aquellas en las que tenga sentido. 
sapply(data[numeric_columns][,-1], mean)

#15. Selecciona las 30 primeras filas y todas las columnas menos las tres últimas (sólo con índices positivos).
data[1:30, 1:(ncol(data)-3)]

#16. Selecciona las 30 primeras filas y todas las columnas menos las tres últimas (sólo con índices negativos). 
data[-31: -nrow(data), -(ncol(data)-2):-ncol(data)]

#17. Obtén los cuartiles de la variable price.
quantile(data$price, probs = seq(0, 1, 0.25))

#18. Obtén los deciles de la variable price. 
quantile(data$price, seq(0, 1, 0.1))

#19. Obtén los estadísticos básicos de todas las variables en un solo comando. 
summary(data)

#20. ¿Cuántos títulos de cursos distintos aparecen en el dataset? 
length(unique(data$course_title))

#21. ¿Cuántos registros tienen más de 1000 reviews? 
nrow(subset(data, subset = num_reviews > 1000))

#22.  Ordena de mayor a menor los 100 primeros elementos de la variable course_id. 
data[order(data$course_id[1:100], decreasing = TRUE),]

#23. Ordena el dataset por la variable num_lectures de manera ascendente. Inspecciona los primeros resultados
head(data[order(data$num_lectures, decreasing = FALSE),])

#24. Obtén los índices de los registros para los que el valor de la variable num_reviews es superior a la mediana.
which(data$num_reviews > median(data$num_reviews))

#25. ¿Cuántos cursos existen para el nivel “Intermediate Level”? 
length(which(data$level == "Intermediate Level"))

#26. ¿Qué curso tiene el mayor número de estudiantes? ¿Y el menor?
data[which(data$num_subscribers == max(data$num_subscribers)),]
data[which(data$num_subscribers == min(data$num_subscribers)),]

#27. ¿Qué cursos son gratuitos?
data[data$is_paid == F,]

#28. Comprueba utilizando el boxplot si la variable num_reviews tiene outliers.
boxplot(data$num_reviews)

#29. Pinta un histograma de la variable price. 
hist(data$price)

#30. Crea una función (cheap_expensive) ...
cheap_expensive <- function (price, threshold=6000){
  if(price < threshold)
    return("CHEAP")
  else
    return("EXPENSIVE")
}
cheap_expensive(100)
cheap_expensive(7000)

#31. ...aplica la función anterior a toda la columna price_detail_amount.
data <- cbind(data, cheap_expensive = sapply(data$price, cheap_expensive))

#32. Repite el ejercicio anterior usando el paquete PURRR
library(purrr)
data <- cbind(data, cheap_expensive_purr = map_chr(data$price, cheap_expensive, threshold = mean(data$price)))

identical(data$cheap_expensive,data$cheap_expensive_purr)


unique(data$level)

d1 <- factor(data$level, levels = c("Beginner Level", "Intermediate Level", "Expert Level", "All Levels"), labels = c("Beginner Level", "Intermediate Level", "Expert Level", "All Levels"))
d2 <- factor(data$level, levels = unique(data$level), labels = unique(data$level))

identical(d1,d2)
class(d1)
class(d2)



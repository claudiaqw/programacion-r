
####################
### Ejercicio 3 ####
####################

library(tidyr)
library(dplyr)
library(stringr)

data <- read.csv('data/book1-100k.csv', header = TRUE, sep = ",", stringsAsFactors = FALSE)

#Data exploration

dim(data)

class(data)

summary(data)

str(data)

head(data)

#Data preparation

data[data==""]<-NA

any(is.na(data))

head(data)

data$RatingDist1 <- as.numeric(sub("\\d:", "", data$RatingDist1))
data$RatingDist2 <- as.numeric(sub("\\d:", "", data$RatingDist2))
data$RatingDist3 <- as.numeric(sub("\\d:", "", data$RatingDist3))
data$RatingDist4 <- as.numeric(sub("\\d:", "", data$RatingDist4))
data$RatingDist5 <- as.numeric(sub("\\d:", "", data$RatingDist5))

data$RatingDistTotal <- as.numeric(sub("(total):", "", data$RatingDistTotal))

boxplot(data$Rating)

hist(data$Rating)


#Data manipulation

#1. Determinar cuántos libros tienen la máxima evaluación

data %>% 
  filter(Rating == max(Rating)) %>% 
  summarise(count = n())


#2. Determinar los libros que tienen la máxima evaluación
data %>% 
  select(Name, Rating) %>% 
  filter(Rating == max(Rating))


#3. Determinar los libros que han logrado recoger el mayor número de reviews y Ratings de los lectores
data %>% 
  select(Name, RatingDistTotal, CountsOfReview) %>% 
  arrange(desc(CountsOfReview), desc(RatingDistTotal))


#4. Mostrar los libros que mayor cantidad de ratings con valor 5 tienen y sus autores
data %>% 
  select(Name, Authors, RatingDist5) %>%
  arrange(desc(RatingDist5))
  

#5. Determinar la cantidad de libros publicados por editorial
data %>% 
  group_by(Publisher) %>% 
  summarize(books_count = n()) %>% 
  arrange(desc(books_count))
  

####AUTHORS####

#6. Listar la media de ratings obtenida por autor para aquellos autores que han publicado al menos 50 títulos
data %>% 
  group_by(Authors) %>% 
  summarise(mean = mean(Rating), count = n()) %>% 
  filter(count >= 50) %>% 
  arrange(desc(mean))


#7. Promedio de páginas por autor para aquellos autores con más de 10 libros incluidos en la lista
data %>%
  group_by(Authors) %>% 
  summarise(mean = mean(pagesNumber), count = n()) %>% 
  filter(count >= 10) %>% 
  arrange(desc(mean))


#8. La cantidad de libros escritos por idioma
data %>% 
  group_by(Language) %>% 
  summarise(count = n()) %>% 
  arrange(desc(count))


#9. Los años donde mayor número de reviews fueron logrados
data %>% 
  group_by(PublishYear) %>% 
  summarise(review_count = sum(CountsOfReview)) %>% 
  arrange(desc(review_count))


#10. El libro que ha recibido el mejor rating en cada año
data %>% 
  select(Name, PublishYear, Rating) %>% 
  group_by(PublishYear) %>% 
  filter(Rating == max(Rating)) %>% 
  arrange(desc(Rating))

 
#11. Cantidad de libros publicados por año
data %>% 
  group_by(PublishYear) %>% 
  summarise(count = n()) %>% 
  arrange(desc(count))





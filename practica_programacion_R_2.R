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
# data["published_timestamp"] <- as.Date(data$published_timestamp) -> information about hour,day,minute, timezone is lost
data["published_timestamp"] <- as.POSIXct(data$published_timestamp, format = "%y-%m-%dT%h:%m:%s", tz = Sys.timezone())


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

library(dplyr)
#1. precio medio de los cursos dependiendo de su temática y ordena el resultado según el precio medio
data  %>% 
  group_by(subject) %>% 
  summarise(price_mean = mean(price)) %>% 
  arrange(desc(price_mean))

#2. Calcula la duración máxima y mínima dependiendo de si un curso es gratuito o de pago.
data %>% 
  group_by(is_paid) %>% 
  summarise(min = min(content_duration), max = max(content_duration))
  
#3. Calcula el número de cursos publicado cada año. 
data %>% 
  mutate(year = format(data$published_timestamp, format="%Y")) %>% 
  group_by(year) %>% 
  summarise(courses_per_year = n())
  

#4. Cuál es la temática que tiene el mayor número de clases medias
data %>% 
  group_by(subject) %>% 
  summarize(class_mean = mean(num_lectures)) %>% 
  arrange(desc(class_mean)) %>% 
  slice(1)


#5. Restringiéndonos a los cursos lanzados en 2016, ¿qué temática cuenta con más horas de clase?
data %>% 
  mutate(year = format(data$published_timestamp, format="%Y")) %>% 
  filter(year == "2016") %>% 
  group_by(subject) %>% 
  summarise(hours_of_classes = sum(content_duration)) %>%
  arrange(desc(hours_of_classes)) %>% 
  slice(1)


#6. Para todos los cursos posteriores a 2015, calcula las horas del curso más largo, del más corto y el número de estudiantes medio.
data %>% 
  mutate(year = as.numeric(format(data$published_timestamp, format="%Y"))) %>% 
  filter(year > 2015) %>% 
  group_by(year) %>% 
  summarise(longest_course = max(content_duration), shortest_course = min(content_duration), students_mean = mean(num_subscribers))
  
  
  






















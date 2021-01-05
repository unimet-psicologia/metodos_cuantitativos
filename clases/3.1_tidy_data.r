#' ---
#' title: "Semana 3.1 - Tidy Data"
#' author: "Diego Gimenez"
#' date: "25/01/2021"
#' ---


## Informacion sobre el dataset:
# https://catalog.data.gov/dataset/behavioral-risk-factor-data-tobacco-use-2011-to-present
# https://bookdown.org/hneth/ds4psy/
# Leyendo data en R -------------------------------------------------------

# Instalar paquetes si no estan instalados

# Cargar librerias

library(dplyr)
library(readxl)

original_df <- read_csv("datasets/Behavioral_Risk_Factor_Data__Tobacco_Use__2011_to_present_.csv")

# Vamos a utilizar el dataset starwars_characters
# este dataset esta ubicado en el paquete dplyr
# Al utilizar library(dplyr) estamos cargando el dataset!

starwars_characters <- starwars

# Pipe operator -----------------------------------------------------------

# El pipe operator es utilizado para pasar cualquier objeto en la izquierda como
# el primer argumento de la funcion de la izquierda
# El shortcut para utilizarlo en rstudio es ctrl+shift+m o cmd+shift+m

# Ejemplo:

summary(starwars_characters)
# Es equivalente a:

starwars_characters %>% summary()

## Por que este operador es relevante?
# Imaginate que estamos utilizando multiples comandos

# Esto es much mas leible
starwars_characters %>% # Es mas facil escribir comentarios
  filter(homeworld == "Tatooine") %>% # Filtramos a todos aquellos que son de Tatooine
  group_by(species, gender) %>% # Agrupamos por la especie y el genero
  summarise( # Aca vamos a computar los estadisticos que queremos
    count = n(), # La variable count va a ser la cantidad de especies segun su genero
    mn_height = mean(height), # El promedio de la altura
    mn_mass = mean(mass, na.rm = TRUE) # El prmedio de masa, removiendo Nulls
  )

summarise(
  group_by(filter(
    starwars_characters, homeworld == "Tatooine"
  ), species, gender),
  count = n(),
  mn_height = mean(height),
  mn_mass = mean(mass, na.rm = TRUE)
)

# arrange -----------------------------------------------------------------

## Esta funcion es utilizada para ordenar filas segun columna(s).
# Es utilizada de la siguiente forma:
# arrange(data, columna(s) )
# Ejemplo:

starwars_characters %>%
  arrange(eye_color) %>% # Ordenamos segun 1 sola columna
  head()

starwars_characters %>%
  arrange(eye_color, gender) %>% # Por default se ordenan de manera ascendente
  head()

starwars_characters %>%
  arrange(eye_color, desc(gender)) %>% # Utilizar desc para ordenar descendentemente
  head()


# filter ------------------------------------------------------------------

## Esta funcion es utilizada Seleccionar filas segun algun criterio

# Quienes son de Alderaan?
# Spoiler alert: Quizas esta sea la poblacion total de Alderaan!

starwars_characters %>%
  filter(homeworld == "Alderaan")

# Quienes no son humanos?

starwars_characters %>%
  filter(species != "Human")

# Quienes no son humanos y NO son de sexo masculino

starwars_characters %>%
  filter(species != "Human" & gender != "masculine")

# select ------------------------------------------------------------------

## Funcion utilizada para seleccionar columnas

# Seleccionemos solo la columna name

starwars_characters %>%
  select(name)

# Seleccionemos la columna name y genero

starwars_characters %>%
  select(name, gender)

# Podemos utilizar el numero de las columnas

starwars_characters %>%
  select(1, 2, 4)

# Seleccionar rangos de columnas

starwars_characters %>% # Seleccionamos desde name hasta skin_color
  select(name:skin_color)

# Tambien podemos reeordenar columnas! Utilizamos everything() para esto
# Coloquemos el genero luego del nombre
# OJO: Nuestro dataframe NO se va a actualizar.
# Para actualizarlo es necesario reescribir el dataframe

starwars_characters %>%
  select(name, gender, everything())

# Seleccionemos SOLO EL NOMBRE de aquellos que no son humanos y NO son de sexo masculino

# Es tu turno!! Completa el codigo aca



# mutate ------------------------------------------------------------------

## Funcion para crear nuevas variables

# Crear nueva variable height_feet

# OJO: Al utilizar mutate NO se guarda la data en el dataframe.


starwars_characters %>%
  mutate(height_feet = .032808399 * height)

starwars_characters %>%
  colnames() # Chequear nombre de columnas

# Si quieres que starwars_characters se actualice, es necesario reescribir el dataframe

starwars_characters <- starwars_characters %>%
  mutate(height_feet = .032808399 * height)


starwars_characters %>%
  colnames() # Chequear nombre de columnas

# Tambien podemos crear nuevas columnas basadas en condiciones

starwars_characters <- starwars_characters %>%
  mutate(is_tall_character = height > 174) # El promedio de altura es 174 cm

# Creemos una nueva columna: ID

starwars_characters <- starwars_characters %>%
  mutate(id = n())

# Por default nuevas variables van a ser agregadas al final del dataframe
starwars_characters %>%
  colnames()


# Movamos la columna id al comienzo del dataframe
starwars_characters <- starwars_characters %>%
  select(id, everything())

starwars_characters %>%
  colnames()


# Ahora tu turno!
## Crea la variable BMI (Body Mass index)
## Guardala el nuevo dataframe en starwars_characters!
## Y muevela luego name
# BMI es igual a ->  masa / ((altura / 100)  ^ 2)


## Filtra los top 5 personajes con mayor bmi!


# summarise ---------------------------------------------------------------

## Esta funcion utiliza otras funciones (por ejemplo estadisticos descriptivos)

## Encontremos el promedio de altura
starwars_characters %>%
  summarise(mean_height = mean(height, na.rm = TRUE)) # OJO: Utilizar na.rm para no incluir valores nules


## Podemos incluir tantas funciones como queramos!

starwars_characters %>%
  summarise( # Descriptives of height:
    n_height = sum(!is.na(height)),
    mn_height = mean(height, na.rm = TRUE),
    sd_height = sd(height, na.rm = TRUE),
    # Descriptives of mass:
    n_mass = sum(!is.na(mass)),
    mn_mass = mean(mass, na.rm = TRUE),
    sd_mass = sd(mass, na.rm = TRUE),
    # Counts of character variables:
    n_names = n(),
    n_species = n_distinct(species),
    n_worlds = n_distinct(homeworld)
  )

## Ahora tu turno!

# Cuantos personajes tienen tienen una altura mayor al promedio?


# group_by ----------------------------------------------------------------

## Funcion utilizada para crear tablas pivote o agregaciones
# Utilizacion:
# group_by(dataframe, columns)
# la columnas son aquellas en la cuales vamos a basar nuestra agregacion


# Cuantas especies hay?
starwars_characters %>%
  group_by(species) %>% # Agrupamos basado en especies
  count() %>% # Contamos cuantas especies hay
  arrange(desc(n)) # Ordenamos de manera descendente

# Ahora tu!
# Como quitarias ese null Value?


## Combinando groupby con sumarise

starwars_characters %>%
  group_by(species) %>%
  summarise(
    individuals_count = n(),
    height_mean = mean(height, na.rm = TRUE),
    mass_mean = mean(mass, na.rm = TRUE)
  ) %>%
  arrange(desc(height_mean))

## Agrupando con dos variables
# Cuantos personajes hay por especie y genero?
# Tambien calcular la media de altura y masa por especie y genero

starwars_characters %>%
  group_by(species, gender) %>%
  summarise(
    individuals_count = n(),
    height_mean = mean(height, na.rm = TRUE),
    mass_mean = mean(mass, na.rm = TRUE)
  ) %>%
  arrange(desc(individuals_count))



## Mutate + group_by = combinacion poderosa!
# Vamos utilizar mutate y groupby cuando queremos almacenar los resultados
# en nuestro dataframe

# Vamos a calcular:
# la cantidad de especies por personaje,
# la altura promedio de la especie del personaje
# y vamos a guardar los resultados en nuestro dataframe!

starwars_characters <- starwars_characters %>%
  group_by(species) %>%
  mutate(
    count_species = n(),
    height_mean_species = mean(height, na.rm = TRUE)
  )

starwars_characters %>%
  select(name, species, count_species, height_mean_species)

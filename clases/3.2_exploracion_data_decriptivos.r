#' ---
#' title: "Semana 3.2 - Exploracion de datos (EDA) - Estadisticos descriptivos"
#' author: "Diego Gimenez"
#' date: "27/01/2021"
#' ---


library(dplyr)
library(readr)
library(haven)
library(readxl)
library(stringr)
library(ggplot2)
library(tidyr)
library(psych)

# Sobre el dataset:
# https://beta.ukdataservice.ac.uk/datacatalogue/studies/study?id=854297
# https://reshare.ukdataservice.ac.uk/854297/

# Paper del dataset:
# https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0239666#sec012


# Este dataset contiene 119 columnas.
## Para esta clase vamos a enfocarnos en las siguientes columnas:
# gender, country, education, age, age_group,

# Leamos el data_dictionary y el archive_dataset

data_dictionary <- read_excel("datasets/study1_predictors_of_likelihood_of_sharing_disinformation_on_social_media/Social Media Disinformation Study 1 data dictionary.xlsx")

# Tu turno! Completa esta funcion
# study_1_original_df <- ______("datasets/study1_predictors_of_likelihood_of_sharing_disinformation_on_social_media/Social Media Disinformation Study 1 archive dataset.sav")

study_1_original_df <- read_sav("datasets/study1_predictors_of_likelihood_of_sharing_disinformation_on_social_media/Social Media Disinformation Study 1 archive dataset.sav")



# Primer Vistazo ------------------------------------------------


study_1_original_df %>% head()

study_1_original_df %>% colnames()




# Editar nombre de variables a un mejor formato ----------------------------------------

# Es necesario que todas las columnas tengan el siguiente formato:
# Esten en lower case
# No tengan espacios


# Esto va a hacer que nuestra vida sea Mucho mas sencilla!!

colnames(study_1_original_df) <- study_1_original_df %>%
  colnames() %>% # Seleccionamos el nombre de Todas columnas
  tolower() %>% # Lo convertimos a lower case
  str_replace(" ", "_") # Reemplazamos espacios con underscores

colnames(study_1_original_df)


# Seleccionemos las variables de interes ----------------------------------

# editemos el nombre de las variables sc0, sc1 y sc2 a algo mas entendible
## sc0: Total Sharing
# sc1: Total Truthful
# sc2: Total Seen Before


study_1_original_df <- study_1_original_df %>%
  rename(total_sharing = sc0, total_truth = sc1, total_seen_before = sc2)


# Ahora seleccionamos las variables de interes y creamos un nuevo dataframe

study_1_subset_df <- study_1_original_df %>%
  select(
    age,
    gender,
    age_group,
    country,
    fbook,
    occupation,
    openness,
    conscientiousness,
    extraversion,
    agreeableness,
    neuroticism,
    conservatism,
    total_nmls,
    total_sharing,
    total_truth,
    total_seen_before
  )


# Verifiquemos el tipo de data de cada variable ---------------------------

study_1_subset_df %>%
  str()

study_1_subset_df %>%
  select(gender)

## Genero: Esta variable está codificada como numeric (double)

# Ojo: Si no le decimos a R que esta variable es un factor, nos va a dar la
# media de genero!

study_1_subset_df$gender %>% summary()

study_1_subset_df$gender %>% class()

# Es por esto que tenemos que cambiar la variable a factor

study_1_subset_df$gender <- study_1_subset_df$gender %>%
  factor(
    levels = c(1, 2, 3, 4),
    labels = c("male", "female", "other", "pnts")
  )

# Mira la diferencia luego de haber creado el factor!
study_1_subset_df$gender %>% summary()


## Tu turno!
# Que otras variables deberiamos cambiar de tipo?
#
#
#

# Veamos nuestros primeros datos descriptivos! ----------------------------


study_1_subset_df %>%
  summary()



# Valores Nulos -----------------------------------------------------------

# Total de valores nulos en el dataframe
study_1_subset_df %>%
  is.na() %>%
  sum(axis = 1) # Axis = 1 Realiza la suma por columnas

# Que sujetos tienen valores nulos?
study_1_subset_df %>%
  filter_all(any_vars(is.na(.)))


# Que columnas tienen valores nulos?
study_1_subset_df %>%
  sapply(function(x) sum(is.na(x)))



# Analisis descriptivo ----------------------------------------------------

## Volvamos a utilizar summary

study_1_subset_df %>% summary()

## Tambien podemos utilizar describe del paquete psych
describe(study_1_subset_df, mad = TRUE)

# Hay un error en la funcion de arriba, cual crees que es?

## Distribucion de grupos etarios

study_1_subset_df %>% 
  group_by(age_group) %>% 
  summarise(frecuencia = n()) %>% # Contamos freqcuencia de cada grupo etario
  mutate(porcentaje = frecuencia / sum(frecuencia) * 100) # Utilizamos frecuencia para calcular la proporcion

# Visualizaciones Univariantes ---------------------------------------------------------

## Veamos la distribucion de la edad de los sujetos
# Que grafico utilizarias?

study_1_subset_df %>% 
  ggplot(aes(x = age)) + 
  geom_histogram(bins = 50)

## Exploremos los grupos etarios
# Que grafico utilizarias?

study_1_subset_df %>% 
  ggplot(aes(x = age_group)) +
  geom_bar(stat="count") +
  scale_x_continuous("age_group", breaks = c(1:6))

## Tu turno! 
 # Exploremos las variables descriptivas restantes!

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

colnames(study_1_original_df)<- study_1_original_df %>% 
  colnames() %>% # Seleccionamos el nombre de Todas columnas
  tolower() %>%  # Lo convertimos a lower case
  str_replace(" ", "_") # Reemplazamos espacios con underscores

colnames(study_1_original_df)

# Seleccionemos las variables de interes ----------------------------------

study_1_original_df %>% 
  select(openness, conscientiousness, extraversion ,agreeableness, neuroticism, conservatism, media)






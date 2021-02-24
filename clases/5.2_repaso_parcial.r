#' ---
#' title: "Semana 5.2 - Repaso Parcial eda y Anova Unifactorial"
#' author: "Diego Gimenez"
#' ---


library(dplyr) # Data Wrangling
library(readr) # Leer Data CSV
library(haven) # Leer Data de SPSS (.sav)
library(readxl) # Leer data de excel (.xls)
library(stringr) # String Wrangling
library(ggplot2) # Visualizaciones
library(tidyr) # Data Wrangling
library(psych) # Analisis descriptivo
library(visdat) # Visualizaciones datos ausentes
library(DescTools) # Eta cuadrado
library(rcompanion) # Computar Cramer's V


# Sobre el dataset:
# https://beta.ukdataservice.ac.uk/datacatalogue/studies/study?id=854297
# https://reshare.ukdataservice.ac.uk/854297/

# Paper del dataset:
# https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0239666#sec012


# Este dataset contiene 119 columnas.
## Para esta clase vamos a enfocarnos en las siguientes columnas:
# gender, country, education, age, age_group, politics



# Leer Data y basic data wrangling ----------------------------------------


# Leamos el data_dictionary y el archive_dataset

data_dictionary <- read_excel("datasets/psicologia_social/study1_predictors_of_likelihood_of_sharing_disinformation_on_social_media/Social Media Disinformation Study 1 data dictionary.xlsx")

study_1_original_df <- read_sav("datasets/psicologia_social/study1_predictors_of_likelihood_of_sharing_disinformation_on_social_media/Social Media Disinformation Study 1 archive dataset.sav")



## Primer vistazo al dataframe

study_1_original_df %>% head()

study_1_original_df %>% colnames()


## Editar nombre de variables a un mejor formato

# Es necesario que todas las columnas tengan el siguiente formato:
# Esten en lower case
# No tengan espacios


# Esto va a hacer que nuestra vida sea Mucho mas sencilla!!

colnames(study_1_original_df) <- study_1_original_df %>%
  colnames() %>% # Seleccionamos el nombre de Todas columnas
  tolower() %>% # Lo convertimos a lower case
  str_replace(" ", "_") # Reemplazamos espacios con underscores

colnames(study_1_original_df)


## Seleccionemos las variables de interes

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
    education,
    politics,
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
  )

# EDA Inicial ----------------------------------------------------

## Verifiquemos el tipo de data de cada variable

study_1_subset_df %>%
  ____()

## Genero: Esta variable esta codificada como numeric (double)

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


## _____ esta codificada como numeric (double). Convierte esta variable a factor

study_1_subset_df$______ <- study_1_subset_df$______ %>% 
  factor(
    levels = c(1,2,3,4,5,6),
    labels = c("18-29","30-39","40-49","50-59","60-69","70+")
  )
 
## _____ esta codificada como numeric (double). Convierte esta variable a factor



# Mira la diferencia luego de haber creado el factor!
study_1_subset_df$gender %>% summary()


## Tu turno!
# Que otras variables deberiamos cambiar de tipo?
#
#
#


# Valores Nulos -----------------------------------------------------------


vis_miss(study_1_subset_df, sort_miss = TRUE)


# Total de valores nulos en el dataframe
study_1_subset_df %>%
  is.na() %>%
  sum(axis = 1) # Axis = 1 Realiza la suma por columnas

# Que sujetos tienen valores nulos?
study_1_subset_df %>%
  filter_all(any_vars(is.na(.)))


# Valores nulos por columna
null_count <- sapply(study_1_subset_df, function(x) sum(is.na(x)))

null_count <- sort(null_count, decreasing = FALSE)
null_count_df <- data.frame(null_count)
tail(null_count_df) # Cuales son las columnas con mas datos ausentes?

# Eliminemos todas las filas que tienen valores nulos
# Hacemos esto porque la mayoria de valores nulos no provienen de una columna en particular.

study_1_subset_df <- study_1_subset_df %>% _____() 

# EDA Descriptivo Univariante  ----------------------------------------------------

## Volvamos a utilizar summary

study_1_subset_df %>% summary()

## Tambien podemos utilizar describe del paquete psych
describe(study_1_subset_df)

# Hay un error en la funcion de arriba, cual crees que es?

## Distribucion de grupos etarios

study_1_subset_df %>% 
  ____(age_group) %>% 
  summarise(frecuencia = n()) %>% # Contamos freqcuencia de cada grupo etario
  mutate(porcentaje = frecuencia / sum(frecuencia) * 100) # Utilizamos frecuencia para calcular la proporcion

### Visualizaciones Univariantes

## Veamos la distribucion de la edad de los sujetos
# Que grafico utilizarias?

study_1_subset_df %>% 
  ggplot(aes(x = age)) + 
  geom_histogram(bins = 50)

## Exploremos los grupos etarios
# Que grafico utilizarias?

ggplot(data=study_1_subset_df) +
  geom_bar(aes(x = age_group), stat="count") +
  scale_x_continuous("age_group", breaks = c(1:6))

## Tu turno! 
# Exploremos las variables descriptivas restantes!



# Ahora analicemos la variable dependiente

## Veamos la distribucion de la variable dependiente  
# Cual es la asimetria de esta variable?
ggplot(data=study_1_subset_df) +
  geom_histogram(aes(x = total_sharing),bins = 30) +
  scale_x_continuous("Likelihood Of Sharing (total_sharing)", # aÃ±adir todos lo numeros en X Axis.
                     breaks = c(min(study_1_subset_df$total_sharing):max(study_1_subset_df$total_sharing)))



# EDA Bivariante ----------------------------------------------------------

### Visualizaciones Bivariantes


## Como las variables independientes cuantitativas varian junto a la variable dependiente?

ggplot(data = study_1_subset_df) +
  geom_point(mapping = aes(x = openness, y = total_sharing)) +
  ggtitle("Opennes and Total Sharing")

ggplot(data = study_1_subset_df) +
  geom_point(mapping = aes(x = conscientiousness, y = total_sharing)) +
  ggtitle("Conscientiousness and Total Sharing")


ggplot(data = study_1_subset_df) +
  geom_point(mapping = aes(x = extraversion, y = total_sharing)) +
  ggtitle("Extraversion and Total Sharing")

ggplot(data = study_1_subset_df) +
  geom_point(mapping = aes(x = agreeableness, y = total_sharing)) +
  ggtitle("Agreeableness and Total Sharing")

ggplot(data = study_1_subset_df) +
  geom_point(mapping = aes(x = neuroticism, y = total_sharing)) +
  ggtitle("Neuroticism and Total Sharing")

ggplot(data = study_1_subset_df) +
  geom_point(mapping = aes(x = conservatism, y = total_sharing)) +
  ggtitle("Conservatism and Total Sharing")


ggplot(data = study_1_subset_df) +
  geom_point(mapping = aes(x = total_nmls, y = total_sharing)) +
  ggtitle("New Media Literacy Scale and Total Sharing")

### Como las variables cualitativas varian junto a la VD?

# Genero y VD
  # Que error tiene este grafico?
study_1_subset_df %>%
  ggplot(aes(y = gender, fill = total_sharing)) +
  geom_boxplot()

# Age group y VD
study_1_subset_df %>%
  ggplot(aes(y = total_sharing, fill = politics)) +
  geom_boxplot()

# Politics y VD


### Correlacion de las variables cuantitativas con la variable dependiente

# Veamos la correlacion entre las variables cuantitativas y la variable dependiente
study_1_subset_df %>% 
  select(age, openness, conscientiousness, agreeableness, neuroticism, total_nmls, total_sharing) %>% 
  na.omit() %>% 
  cor()

# Cual es el p valor de la correlacion entre total_nmls y total_sharing?

cor.test(study_1_subset_df$_____, study_1_subset_df$_____)

# Cual es el p valor de la correlacion de pearson entre age y total_sharing?

______


# Contexto --------------------------------------------------

# Vamos a suponer que hemos realizado un estudio experimental donde:
#   Factor: politics
#   VD: total_sharing



# EDA evaluacion de supuestos -----------------------------------------------------------

## Normalidad de VD

# Metodo grafico (normality plot)
qqPlot(study_1_subset_df$total_sharing)

# Metodo prueba de hipotesis (shapiro wilks)
shapiro.test(study_1_subset_df$total_sharing)

# Igualdad de Varianzas
# Recordatorio: Si el p valor es > 0.05, existe igualdad de las varianzas
# Utilizamos la sintaxis de formula
# VD ~ Factor

leveneTest(____ ~ _____, data = study_1_subset_df)


# Anova -------------------------------------------------------------------

# Computamos Anova
res.aov <- aov(_____ ~ _____, data = study_1_subset_df)

# Chequeamos si el model es significativo
summary(res.aov)



# Chequeamos la magnitud de efecto
EtaSq(x = res.aov)



# Post Hoc ----------------------------------------------------------------

# Si el modelo es es estadisticamente significativo, chequeamos las diferencias.
TukeyHSD(res.aov)


# Chi Cuadrado ------------------------------------------------------------

# La edad y la orientacion politica son dependientes o independientes?

# Creamos tabla de contingencia con la funcion table
contingency_gendergroup <- table(study_1_original_df$politics, study_1_original_df$age_group)
contingency_gendergroup
# Utilizamos la tabla de contingencia dentro de chisq.test
result_chi_gendergroup <- chisq.test(contingency_gendergroup, simulate.p.value = TRUE)
result_chi_gendergroup # Veamos los resultados

cramerV(contingency_gendergroup)


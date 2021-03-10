#' ---
#' title: "Semana 8.2 - ANOVA Factorial"
#' author: "Diego Gimenez"
#' ---

library(dplyr)
library(readr)
library(haven)
library(readxl)
library(stringr)
library(ggplot2)
library(tidyr)
library(psych)
library(GGally)
library(broom) # Paquete nuevo!
library(fastDummies) # Paquete nuevo!


# Leer Data ---------------------------------------------------------------

study_1_original_df <- read_sav("datasets/psicologia_social/study1_predictors_of_likelihood_of_sharing_disinformation_on_social_media/Social Media Disinformation Study 1 archive dataset.sav")

colnames(study_1_original_df) <- study_1_original_df %>%
  colnames() %>% # Seleccionamos el nombre de Todas columnas
  tolower() %>% # Lo convertimos a lower case
  str_replace(" ", "_") # Reemplazamos espacios con underscores

study_1_original_df <- study_1_original_df %>%
  rename(total_sharing = sc0, total_truth = sc1, total_seen_before = sc2)

study_1_subset_df$gender <- study_1_subset_df$gender %>%
  factor(
    levels = c(1, 2, 3, 4),
    labels = c("male", "female", "other", "pnts")
  )

study_1_subset_df <- study_1_original_df %>%
  select(
    age,
    gender,
    politics,
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


# EDA Inicial -------------------------------------------------------------

# Total de valores nulos en el dataframe
study_1_subset_df %>%
  is.na() %>%
  sum() 

study_1_subset_df <- study_1_subset_df %>%
  na.omit()

# EDA Univariante ---------------------------------------------------------

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



## Veamos la distribucion de la variable dependiente  
ggplot(data=study_1_subset_df) +
  geom_histogram(aes(x = total_sharing),bins = 40) +
  scale_x_continuous("Likelihood Of Sharing (total_sharing)", # aÃ±adir todos lo numeros en X Axis.
                     breaks = c(min(study_1_subset_df$total_sharing):max(study_1_subset_df$total_sharing)))

# EDA Bivariante ----------------------------------------------------------

ggplot(data = study_1_subset_df) +
  geom_point(mapping = aes(x = age, y = total_sharing)) +
  ggtitle("Age and Total Sharing")

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


# Feature engineering -----------------------------------------------------

# Ahora tu turno! 
  # Es necesario convertir politics a factor

# Creamos dummies con dummy_cols
study_1_subset_df <- study_1_subset_df %>% 
  dummy_cols("politics")

View(study_1_subset_df)

# EDA Supuestos Regresion Lineal Simple --------------------------------------------------------

# Primero calculamos el modelo
  # Recuerda: VD ~ VI
model_age <- lm(total_sharing ~ age, data = study_1_subset_df)

# Linealidad de la data
  # Idealmente no debe haberun patron.L linea roja debe ser lo mas horizontal posible.
plot(model_age, 1)

# Homogeneidad de la varianza
  # Los residuos debe ser homocedantes (distribuidos de una manera equitativa)
plot(model_age, 3)


# Normalidad de los residuos
plot(model_age, 2)


# Obtenemos la informacion del modelo
  # Estimate: Coeficiente beta estandarizado
  # Pr>: P valor del coeficiente.
  # p-value: P valor del modelo
  # Adjusted R Squared: R cuadrado ajustado del modelo
summary(model_age)


# Ahora vamos a ver los errores de nuestro modelo segun la VI y VD
model.diag.metrics <- augment(model_age) # Augment es cargado del paquete broom
ggplot(model.diag.metrics, aes(age, total_sharing)) +
  geom_point() +
  stat_smooth(method = lm, se = FALSE) +
  geom_segment(aes(xend = age, yend = .fitted), color = "red", size = 0.3)


# Regresion Lineal Multiple  --------------------------------------------------------


# Primero calculamos el modelo
# Recuerda: VD ~ VI
model_age_bigfive <- lm(total_sharing ~ age + openness + conscientiousness + extraversion + agreeableness + neuroticism + conservatism + total_nmls, data = study_1_subset_df)

# Linealidad de la data
# Idealmente no debe haberun patron.L linea roja debe ser lo mas horizontal posible.
plot(model_age_bigfive, 1)

# Homogeneidad de la varianza
# Los residuos debe ser homocedantes (distribuidos de una manera equitativa)
plot(model_age_bigfive, 3)


# Normalidad de los residuos
plot(model_age_bigfive, 2)


# Obtenemos la informacion del modelo
# Estimate: Coeficiente beta estandarizado
# Pr>: P valor del coeficiente.
# p-value: P valor del modelo
# Adjusted R Squared: R cuadrado ajustado del modelo
summary(model_age_bigfive)


# Ahora tu turno! Que otras variables agregarias a nuestro modelo? --------

# Indica las variables que agregarias


# Crea otro modelo de regresion lineal multiple!

#' ---
#' title: "Semana 5.2 - ANOVA"
#' author: "Diego Gimenez"
#' ---

library(readr)
library(dplyr)
library(ggplot2)
library(visdat)
library(stringr)
library(stringi)
library(car)
library(DescTools)





# Leer data e inspeccionar nombre de variables ----------------------------------------

data_practica_anova <- read_csv("datasets/practica_anova/data_practica_anova.csv")

head(data_practica_anova)

colnames(data_practica_anova) <- data_practica_anova %>%
  colnames() %>% # Seleccionamos el nombre de Todas columnas
  tolower() %>% # Lo convertimos a lower case
  str_replace_all(" ", "_") %>% # Reemplazamos espacios con underscores
  stri_trans_general("Latin-ASCII") # Reemplazamos acentos


head(data_practica_anova)


# EDA ---------------------------------------------------------------------

# Valores ausentes
vis_miss(data_practica_anova, sort_miss = TRUE)


# Valores atipicos

data_practica_anova %>%
  ggplot(aes(y = rendimiento_en_actividad)) +
  ______ # Que grafico utilizarias para evaluar explorar si hay datos atipicos?


  # EDA Univariante

  ## Factores

  # `método de formación` se encuentra equitativamente distribuido

  data_practica_anova %>%
  ggplot(aes(x = metodo_de_formacion)) +
  geom_bar()


# personalidad se encuentra equitativamente distribuido
data_practica_anova %>%
  ggplot(aes(x = personalidad)) +
  geom_bar()


## Variable dependiente

# Este grafico esta mal hecho, que cambiarias?
# Que otro grafico utilizarias?

data_practica_anova %>%
  ggplot(aes(x = rendimiento_en_actividad)) +
  geom_bar()

# EDA Bivariante
# Vamos a utilizar unicamente el factor metodo de formacion

data_practica_anova %>%
  ggplot(aes(y = rendimiento_en_actividad, fill = metodo_de_formacion)) +
  geom_boxplot()


### Comprobacion de supuestos

## Normalidad de VD

# Metodo grafico (normality plot)
qqPlot(data_practica_anova$rendimiento_en_actividad)

# Metodo prueba de hipotesis (shapiro wilks)
shapiro.test(data_practica_anova$rendimiento_en_actividad)

# Igualdad de Varianzas
# Recordatorio: Si el p valor es > 0.05, existe igualdad de las varianzas
# Utilizamos la sintaxis de formula
# VD ~ Factor

leveneTest(rendimiento_en_actividad ~ metodo_de_formacion, data = data_practica_anova)

# Anova -------------------------------------------------------------------

# Utilizamos la sintaxis de formula
# VD ~ Factor

# Computamos Anova
res.aov <- aov(rendimiento_en_actividad ~ metodo_de_formacion, data = data_practica_anova)

# Chequeamos si el model es significativo
summary(res.aov)


# Chequeamos la magnitud de efecto
EtaSq(x = res.aov)



# Post Hoc ----------------------------------------------------------------

# Si el modelo es es estadisticamente significativo, chequeamos las diferencias.
TukeyHSD(res.aov)

# INTERPRETACION
# Como lo interpretarias?

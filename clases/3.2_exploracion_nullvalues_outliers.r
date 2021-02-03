#' ---
#' title: "Semana 3.2 - Exploración de Datos Introducción  Datos Ausentes y Outliers"
#' author: "Diego Gimenez"
#' date: "03/02/2021"
#' ---


# Paquetes ----------------------------------------------------------------


library(haven) # Leer data de SPSS
library(naniar) # Data Structures, Summaries, and Visualisations for Missing Data
library(ggplot2)
library(visdat)
library(plotly)

# Leer dataset ------------------------------------------------------------


original_df <- read_sav("datasets/psicologia_social/study1_predictors_of_likelihood_of_sharing_disinformation_on_social_media/Social Media Disinformation Study 1 archive dataset.sav")


# Datos Ausentes ----------------------------------------------------------


## Visualizar datos ausentes
vis_miss(original_df, sort_miss = TRUE)

## Contar Datos ausentes con sapply
null_count <- sapply(original_df, function(x) sum(is.na(x)))

null_count <- sort(null_count, decreasing = FALSE)
null_count_df <- data.frame(null_count)
tail(null_count_df) # Cuales son las columnas con mas datos ausentes?


## Contar Datos ausentes por columna con colSums
null_count <- colSums(is.na(original_df))
null_count <- sort(null_count, decreasing = FALSE)
null_count_df <- data.frame(null_count)
tail(null_count_df) # Cuales son las columnas con mas datos ausentes?


# Total de datos ausentes
null_total <- sum(is.na(original_df))
nrow(original_df)

total_data_points <- (nrow(original_df) * ncol(original_df)) # columns * rows = total amount of datapoints

null_total / (nrow(original_df) * ncol(original_df))

## Eliminar sujetos con datos ausentes
# Utilizamos na.omit para esto

clean_df <- na.omit(original_df)


total_dropped_values <- nrow(original_df) - nrow(clean_df)

print(paste("Hemos eliminado", total_dropped_values, "sujetos del estudio"))


# Outliers ----------------------------------------------------------------

# Ahora visualicemos los Outliers a traves del metodo boxplot


boxplot(original_df$SC0) # Utilizamos los gráficos nativos de R para un ejemplo rápido
## Puedes notar que hay 4 outliers!

## Calculemos el threshold para detectar outliers
# Todo lo que esté por debajo de low_bound_threshold
# y por encima de hi_bound_threshold va a ser considerado un outlier

q1 <- quantile(original_df$SC0, 0.25, names = FALSE) # Cuartil 1
q3 <- quantile(original_df$SC0, 0.75, names = FALSE) # Cuartil 2

iqr <- q3 - q1 # Rango Intercuartil

low_bound_threshold <- q1 - 1.5 * iqr # Threshold para valores muy pequeños
hi_bound_threshold <- q3 + 1.5 * iqr # Threshold para valores muy grandes


# Grafiquemos un boxplot con ggplot

boxplot_sc0 <- original_df %>%
  ggplot(aes(y = SC0)) +
  geom_boxplot()

# Tambien podemos convertirlo a un gráfico interactivo!
# Ojo: Es necesario haber instalado y cargado la libreria plotly
boxplot_sc0 %>% ggplotly()


## Ahora tu turno!!
# Realiza este análisis con la variable sc1 o con otro dataset en datasets/

#' ---
#' title: "Semana 4.2 - Exploracion de datos (EDA) - Evaluación de supuestos"
#' author: "Diego Gimenez"
#' ---


# Paquetes ----------------------------------------------------------------

library(haven)
library(ggpubr)
library(stringr)
library(dplyr)

# Leer dataset ------------------------------------------------------------


study_1_original_df <- read_sav("datasets/psicologia_social/study1_predictors_of_likelihood_of_sharing_disinformation_on_social_media/Social Media Disinformation Study 1 archive dataset.sav")

# Cambiemos el nombre de las variables a un formato unico

colnames(study_1_original_df) <- study_1_original_df %>%
  colnames() %>% # Seleccionamos el nombre de Todas columnas
  tolower() %>% # Lo convertimos a lower case
  str_replace(" ", "_") # Reemplazamos espacios con underscores

# Renombremos las variables
study_1_original_df <- study_1_original_df %>%
  rename(total_sharing = sc0, total_truth = sc1, total_seen_before = sc2)


# Seleccionemos data de interés --------------------------------------------------

# Consideramos total likelihood of sharing (total_sharing) como nuestra variable dependiente
# Calculemos


# Nuevamente sleccionemos variables de interes
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
    total_sharing
  )

# Vamos a eliminar los valores ausentes
# Ojo: Es necesario realizar el analisis pertinente con respecto a valores ausentes
# Referirse al script 3.2_exploracion_nullvalues_outliers
null_total <- sum(is.na(study_1_subset_df))
nrow(study_1_subset_df) / (nrow(study_1_subset_df) * ncol(study_1_subset_df))
# 7% de valores ausentes

# Ahora eliminamos valores ausentes
study_1_subset_df <- na.omit(study_1_subset_df)


# Normalidad de la Variable Dependiente -----------------------------------

# QQ Plot (Normality Plot):
# En la medida que los puntos se alineen con la linea continua, la variable seguira una distribucion normal.

ggqqplot(study_1_subset_df$total_sharing)


# Shapiro Wilks
# Si el p valor es mayor a 0.05, la distribucion de la variable es igual a una distribucion normal
shapiro.test(study_1_subset_df$total_sharing)

# Asimetria y curtosis

skew_vd <- skewness(study_1_subset_df$total_sharing)
kurt_vd <- kurtosis(study_1_subset_df$total_sharing)
n_observations <- nrow(study_1_subset_df)

skey_z <- vd_skew / (sqrt(6 / n_observations))
skey_z

kurt_z <- kurt_vd / (sqrt(24 / n_observations))
kurt_z

# Distribucion de Variable dependiente

ggplot(data = study_1_subset_df, aes(x = total_sharing)) +
  geom_histogram(bins = 15) +
  ggtitle("Distribucion de la variable dependiente")


# Linealidad --------------------------------------------------------------

# Correlacion Lineal (pearson) entre variables independientes y variable dependiente
  # La correlacion de pearson requiere que ambas variables sean cuantitativas de razon

  # Creamos matriz de correlaciones
study_1_subset_df_cor <- cor(study_1_subset_df, method = "pearson") 

  # Convertimos la matriz en dataframe para manipularla mas sencillamente
study_1_subset_df_cor <- data.frame(study_1_subset_df_cor)

  # seleccionamos la variable dependiente y ordenamos las correlaciones segun su valor absoluto
    # Ojo: El valor absoluto es la magnitud de la correlacion. 
      # Nos interesa saber cuales VI correlacionan mas la variable dependiente 

# Reemplaza los _____ con las funciones correspondientes de dplyr
study_1_subset_df_cor %>%
  _____(total_sharing) %>% # Seleccionamos la VD
  _____(desc(abs(total_sharing))) # Ordenamos segun el valor absoluto (utilizamos la funcion abs())


# Ahora tu turno!
  # Que variables NO deberiamos incluir en el dataframe de correlaciones study_1_subset_df_cor?
  # Ejemplo: genero


# Grafico de dispersion


study_1_subset_df %>% 
  ggplot(aes(x = agreeableness, y = total_sharing)) +
  geom_point()

# Ahora tu turno! 
  # Crea graficos de dispersion entre las variables independientes y variable dependiente
    # (segun la variables independientes que sean pertinentes)



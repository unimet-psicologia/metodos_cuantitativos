#' ---
#' title: "Semana 4.2 - Exploracion de datos (EDA) - Estadisticos descriptivos bivariantes - Chi Cuadrado"
#' author: "Diego Gimenez"
#' ---

library(haven) # Para leer Archivos de SPSS
library(rcompanion) # Computar Cramer's V


# Leemos Dataset
study_1_original_df <- read_sav("datasets/psicologia_social/study1_predictors_of_likelihood_of_sharing_disinformation_on_social_media/Social Media Disinformation Study 1 archive dataset.sav")


# Creamos tabla de contingencia con la funcion table
contingency_gendergroup <- table(study_1_original_df$gender, study_1_original_df$age_group)

# Utilizamos la tabla de contingencia dentro de chisq.test
result_chi_gendergroup <- chisq.test(contingency_gendergroup, simulate.p.value = TRUE)
result_chi_gendergroup # Veamos los resultados

# Realicemos la preuba de V de Cramer
cramerV(contingency_gendergroup)


# Ahora tu turno!
# Realiza el mismo analisis con las variables gender y educacion!

clean_column_names <- function(dataframe) {
  result <- dataframe %>%
    colnames() %>%
    tolower() %>%
    str_replace_all(" ", "_") %>% # Reemplazar espacios en blanco por underscores
    str_replace_all("\\[|\\]|\\?|\\¿|\\(|\\)|,|\\.", "") %>% # Eliminar caracteres raros
    str_replace_all(">>", "") %>%
    stri_trans_general("Latin-ASCII") %>% 
    str_replace_all("no_label__", "")# Eliminar tildes
  return(result)
}

calculate_factorial_score <-
  function(dataframe_raw_items,
           dataframe_factorial_coefficients) {
    mat_raw <- as.matrix(dataframe_raw_items)
    
    mat_coeff <- as.matrix(dataframe_factorial_coefficients)
    
    print(class(mat_coeff))
    
    mat_dot_product_result <- mat_raw %*% mat_coeff
    
    df_result <- as_tibble(mat_dot_product_result)
    
    return (df_result)
    
  }

recode_variables <- function(dataframe,
                             vector_variables_to_remap,
                             vector_replacement_mapping) {
  result <- dataframe %>%
    mutate_at(
      vector_variables_to_remap,
      ~ as.numeric(str_replace_all(., pattern = vector_replacement_mapping))
    )
  
  return(result)
}

get_colnames_vector_by_index <- function(dataframe,index){
  return(colnames(dataframe[, index]))
  
}

print_colnames_by_index(df_raw_answers,62:71)  

library(readr)
library(tidyverse)
library(stringi)

# read data ---------------------------------------------------------------


df_raw_answers <-
  read_csv(
    "material_extra/scripts_de_referencia/calculo_puntaje_factorial/ansiedad_miedo-covid_redes-soci2022-03-02_06_10_42.csv"
  )



colnames(df_raw_answers) <- clean_column_names(df_raw_answers)


df_stai_factorial_coefficients <-
  read_csv(
    "material_extra/scripts_de_referencia/calculo_puntaje_factorial/normas/stai_norma.csv"
  )

df_covid_miedo_factorial_coefficients <- read_csv(
  "material_extra/scripts_de_referencia/calculo_puntaje_factorial/normas/norma_miedo_covid.csv"
)


# Convert Answers to numerical format -------------------------------------

# Replacement mappings 
replacemant_map_ansiedad <- c(
  "Nada" = "1",
  "Algo" = "2",
  "Bastante" = "3",
  "Mucho" = "4",
  "Casi nunca" = "1",
  "A veces" = "2",
  "A menudo" = "3",
  "Casi siempre" = "4"
)

replacement_map_miedo_covid <- c(
  "Muy en desacuerdo" = "1",
  "En Desacuerdo" = "2",
  "Ni de acuerdo ni en desacuerdo" = "3",
  "De acuerdo" = "4", 
  "Muy de acuerdo" = "5"
)

replacement_graffar <- c( #TODO: Fix
  "Universitaria" = "1",
  "Técnica superior" = "2",
  "Empleado sin profesión universitaria" = "3",
  "Obrero especializado" = "4",
  "Obrero no especializado" = "5",
  "Secundaria completa o Técnica superior completa" = "2",
  "Secundaria incompleta" = "3",
  "Primaria o alfabeto" = "4",
  "Analfabeta" = "5",
  "Fortuna heredada o adquirida" = "1",
  "Honorarios profesionales" = "2",
  "Sueldo mensual" = "3",
  "Sueldo semanal" = "4",
  "Donaciones" = "5",
  "Óptimas con gran lujo" = "1",
  "Óptimas con lujos sin exceso" = "2",
  "Buenas condiciones sanitarias" = "3",
  "Condiciones sanitarias deficientes" = "4"
)

## Variable Names

variables_ansiedad <- c("me_siento_calmado",
                        "me_siento_seguro",
                        "me_siento_tenso",
                        "estoy_contrariado",
                        "me_siento_comodo_estoy_a_gusto",
                        "estoy_preocupado_ahora_por_posibles_desgracias_futuras",
                        "me_siento_descansado",
                        "me_siento_angustiado",
                        "me_siento_confortable",
                        "me_siento_nervioso",
                        "estoy_relajado",
                        "me_siento_satisfecho",
                        "estoy_preocupado",
                        "me_siento_alegre",
                        "en_este_momento_me_siento_bien",
                        "me_siento_bien",
                        "me_canso_rapidamente",
                        "siento_ganas_de_llorar",
                        "me_preocupo_demasiado_por_cosas_sin_importancia",
                        "suelo_tomar_las_cosas_demasiado_seriamente",
                        "me_siento_triste_melancolico",
                        "me_rondan_y_molestan_pensamientos_sin_importancia",
                        "me_afectan_tanto_los_desenganos_que_no_puedo_olvidarlos",
                        "soy_una_persona_estable",
                        "cuando_pienso_sobre_asuntos_y_preocupaciones_actuales__me_pongo_tenso_y_agitado"
                        )

variables_covid <- get_colnames_vector_by_index(df_raw_answers, 48:54)

variables_graffar <- c( "profesion_del_jefe_o_jefa_de_familia",
                        "nivel_de_instruccion_de_la_madre",
                        "principal_fuente_de_ingreso_de_la_familia",
                        "condiciones_de_la_vivienda")

## Replace values based on each instrument
df_raw_answers_recoded <- recode_variables(df_raw_answers,variables_ansiedad,replacemant_map_ansiedad)
df_raw_answers_recoded <- recode_variables(df_raw_answers_recoded,variables_covid,replacement_map_miedo_covid)
df_raw_answers_recoded <- recode_variables(df_raw_answers_recoded, variables_graffar, replacement_graffar)

df_raw_answers_recoded<- df_raw_answers_recoded %>% 
  mutate(graffar_puntuacion = sum(profesion_del_jefe_o_jefa_de_familia,
                                                           nivel_de_instruccion_de_la_madre,
                                                           principal_fuente_de_ingreso_de_la_familia,
                                                           condiciones_de_la_vivienda
                                                           )
                                  )

# Calculate Factorial Score -----------------------------------------------


result_factorial_score_ansiedad <-
  calculate_factorial_score(df_raw_answers_recoded[, variables_ansiedad],
                            df_stai_factorial_coefficients[,-1])


result_factorial_score_covid_fear <- 
  calculate_factorial_score(df_raw_answers_recoded[, variables_covid],
                            df_covid_miedo_factorial_coefficients[,1])


df_factorial_score <-
  bind_cols(df_raw_answers_recoded, result_factorial_score, result_factorial_score_covid_fear)


# Subset variables to write -----------------------------------------------



df_to_write <- df_factorial_score %>% select(
  submission_date,
  submission_id,
  `Factor_1_emociones-adaptativas`,
  `Factor_2-ansiedad-rasgo`,
  `Factor_3-ansiedad-estado`,
  `factor_1-Miedo-Al-COVID`,
  cuantos_dias_has_utilizado_redes_sociales_15_minutos_antes_de_irte_a_dormir__cantidad_de_dias,
  cuantos_dias_has_utilizado_redes_sociales_mientras_desayunas__cantidad_de_dias,
  cuantos_dias_has_utilizado_redes_sociales_mientras_cenas__cantidad_de_dias,
  cuantos_dias_has_utilizado_redes_sociales_en_los_15_minutos_posteriores_a_desperarte_por_la_manana___cantidad_de_dias,
  cuantos_dias_usaste_las_redes_sociales_mientras_almorzabas__cantidad_de_dias,
  como_percibe_el_futuro_en_el_pais,
  desea_emigrar,
  como_percibe_la_situacion_actual_del_pais,
  sexo,
  municipio_de_residencia,
  tiene_algun_familiar_en_venezuela__nucleo_mama_papa_o_hermanos,
  nivel_educativo,
  ciudad_de_residencia,
  edad,
  ocupacion,
  cual_es_el_ingreso_aproximado_mensual_de_la_familia_expresado_en_dolares
)

df_to_write %>% write.table("data_trabajo_final_2122-metodos_cuantitativos.csv",
                            sep=",",
                            row.names = FALSE,
                            fileEncoding = "UTF8")

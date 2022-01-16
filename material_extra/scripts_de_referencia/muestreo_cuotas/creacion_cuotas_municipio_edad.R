#' ---
#' author: "Diego Gimenez"
#' date: "16/01/2022"
#' ---

# Sobre este script: Este script contiene el proceso de creacion de cuotas para realizar muestre
"
SOBRE ESTE SCRIPT

Este scripte contiene el proceso de creacion de cuotas para realizar muestreo no probabilistico por cuotas o
muestreo probabilístico estratificado. La data utilizada consta del censo realizado por el INE en 2011, el censo más reciente para la fecha de la creación de este script.

La población utilizada en el presente script está conformada por adultos entre 20 y 59 años ubicados en el Area Metropolitana de Caracas.


El proceso general consiste en:

1. Definir variables poblacionales para utilizar como cuotas (en este caso se utilizó edad y municipio)
2. Encontrar los porcentajes de cada grupo etario y municipio en la población a generalizar.

 Paso Extra: explorar si ambas cuotas difieren al ser cruzadas.
          Por ejemplo, ¿existe algún municipio que tenga una proporción muy distinta de personas entre 20-24 años?

"

library(readxl)
library(dplyr)

poblacion_df <-
  read_excel(
    "material_extra/scripts_de_referencia/muestreo_cuotas/poblacion_grupos_edad_municipio_censo_2011_area_metropolitana_caracas_venezuela.xlsx",
    sheet = "poblacion_r_import"
  )


poblacion_df_20_59 <- poblacion_df %>%
  select(
    # Modificar Select si se van a utilizar grupos etarios distintos
    "Municipio",
    "De 20 a 24 años",
    "De 25 a 29 años",
    "De 30 a 34 años",
    "De 35 a 39 años",
    "De 40 a 44 años",
    "De 45 a 49 años",
    "De 50 a 54 años",
    "De 55 a 59 años"
  )


# Cuotas Municipio --------------------------------------------------------
poblacion_df_20_59_groupby_municipio <- poblacion_df_20_59 %>%
  group_by(Municipio) %>%
  summarise(across(everything(), list(sum)))

poblacion_df_20_59_groupby_municipio$total <-
  poblacion_df_20_59_groupby_municipio %>% select_if(is.numeric) %>% rowSums(.)

poblacion_df_20_59_groupby_municipio$percent_of_total <-
  poblacion_df_20_59_groupby_municipio$total / sum(poblacion_df_20_59_groupby_municipio$total)

# Total de personas viviendo en el Area Metropolitana de Caracas en las edades filtradas.
poblacion_df_20_59_groupby_municipio$total %>% sum()


# Cuotas edad ---------------------------------------------------------------

poblacion_df_20_59_edad <-
  poblacion_df_20_59 %>% select_if(is.numeric) %>%
  reshape2::melt(variable.name = "grupos_etarios") %>%
  group_by(grupos_etarios) %>%
  summarize(total = sum(value)) %>%
  mutate(percent_of_total = total / sum(total))

poblacion_df_20_59_edad
# Cuotas grupos etarios y municipios ---------------------------------------------------

# Cruzando grupos etarios y municipios para evaluar si hay algún municipio con una cantidad muy distinta de personas de algun grupo etario.

poblacion_df_20_59_groupby_municipio_edad <- poblacion_df_20_59 %>%
  group_by(Municipio) %>%
  summarize_each(list(sum))


poblacion_df_20_59_groupby_municipio_edad <-
  poblacion_df_20_59_groupby_municipio_edad %>% reshape2::melt(id.vars = "Municipio", variable.name =
                                                                 "grupos_etarios") %>%
  group_by(Municipio, grupos_etarios) %>% summarize(total = sum(value)) %>% mutate(percent_of_total = total /
                                                                                     sum(total))


poblacion_df_20_59_groupby_municipio_edad



# Discrepancias -----------------------------------------------------------

# Los grupos etarios varían mucho al segmentar los municipios?
# respuesta: no. La mayor diferencia de grupo etario total y grupo etario de municipio es del 3% (chacao de 20 a 24 años)

poblacion_df_20_59_join <-
  poblacion_df_20_59_groupby_municipio_edad %>%
  inner_join(
    poblacion_df_20_59_edad,
    by = "grupos_etarios",
    suffix = c("_municipio_edad", "_edad")
  ) %>%
  mutate(difference = percent_of_total_municipio_edad - percent_of_total_edad)


poblacion_df_20_59_join



# Grupos Etarios ----------------------------------------------------------


# Edad
poblacion_df_20_59_edad %>% select(grupos_etarios, percent_of_total)

# Municipio
poblacion_df_20_59_groupby_municipio %>% select(Municipio, percent_of_total)

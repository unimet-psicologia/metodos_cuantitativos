#' ---
#' title: "Semana 2.1 - Recoleccion de datos "
#' author: "Diego Gimenez"
#' date: "25/01/2021"
#' ---


# Cargando Librerias ------------------------------------------------------

library(readr)
library(dplyr)
library(readxl)
library(haven)
library(writexl)

# Leyendo data en R -------------------------------------------------------

## Vamos a leer tres tipos de formatos:
# - `csv`: Comma separated values.
# - `xls`: Archivo de excel
# - `sav`: Archivo de SPSS

## A traves de comandos:
original_anova_csv <- read_csv("datasets/data_practica_anova.csv")
original_anova_excel <-
  read_excel("datasets/data_practica_anova_excel.xls")
original_anova_sav <-
  read_sav("datasets/data_practica_anova_spss.sav")


## A traves de interfaz grafica (RStudio)
# Referirse a la presentacion 2.1.Recolección de datos y tipos de muestreo


# Posibles errores leyendo data -------------------------------------------

## Especificar el directory path incorrecto
# Tenemos que especificar excatament donde esta el archivo
# El siguiente comando va a retornar un error

original_anova_csv <- read_csv("data_practica_anova.csv")
# Error: 'data_practica_anova.csv' does not exist in current
# working directory ('/home/diego/Documents/metodos_cuantitativos').
# Esto se debe a que la data esta en `datasets/data_practica_anova.csv`


## Leer un archivo con un formato distinto
# Al utilizar read_csv, estamos asumiendo que el archivo esta separado por comas ","
# Sin embargo, el archivo que estamos leyendo abajo NO esta separado por comas.
# Al tratar de leerlo, va a retornar un warning: Warning: 90 parsing failures.
# El dataframe leido solo contiene 1 columna!
original_anova_csv_semicolon <-
  read_csv("datasets/data_practica_anova_semicolonsep.csv")
colnames(original_anova_csv_semicolon) # Solo hay 1 columna

# Al inspeccionar el dataframe nos damos cuenta que esta dividido por el simbol punto y coma (;)
head(original_anova_csv_semicolon)

# Leemos nuevamente el dataframe,
# 1. Utilizamos la funcion read_delim
# 2. Cambiamos el argumento "delim"
original_anova_csv_semicolon <-
  read_delim("datasets/data_practica_anova_semicolonsep.csv", delim = ";")
colnames(original_anova_csv_semicolon) # Ahora hay 3 columnas

# Al inspeccionar el dataframe podemos ver que la data fue leida correctamente
head(original_anova_csv_semicolon)


# Escribiendo data en R ---------------------------------------------------

# Primero, vamos a introducir un cambio a nuestro dataframe
original_anova_csv$columna_nueva <- "mi primer columna!"


# Ahora vemos los contenidos de nuestro dataframe modificado!
head(original_anova_csv)

# Tu turno! Crea una columna en el dataframe original_anova_excel

# original_anova_excel


## Escribiendo un csv
# Vamos a crear un csv desde un csv
# Tenemos que escribir el path, nombre del archivo y su extension (en este caso csv)
write_csv2(x = original_anova_csv, file = "datasets/archivos_guardados/mi_archivo_guardado.csv")

# Ahora vamos a escribir un csv desde un dataframe que fue leido originalmente como un archivo EXCEL!
# Tenemos que utilizar la funcion write_excel_csv2()
write_excel_csv2(x = original_anova_excel, file = "datasets/archivos_guardados/mi_archivo_guardado_desdeundfxls.csv", delim = ",")

## Escribiendo un archivo excel
# OJO: Anadir extension ".xls" al final del nombre del archivo.
write_xlsx(x = original_anova_csv, path = "datasets/archivos_guardados/mi_archivo_guardado_excel.xlsx")

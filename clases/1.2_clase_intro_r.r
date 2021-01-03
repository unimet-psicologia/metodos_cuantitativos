#' ---
#' title: "Clase 2"
#' author: "Diego Gimenez"
#' date: "13/01/2021"
#' ---


# Corriendo nuestro primer comando ----------------------------------------

## Corramos nuestro primer comando!
# Hacer click en run o utilizar teclas ctrl-enter | cmd-enter.

print("Hola Unimet!")


# Comentarios -------------------------------------------------------------


# Esto es un comentario, no va a correr!
# Todos los comentarios en R son precedidos por un numeral (#)

## Ejemplo:
# El comando que utilizamos anteriormente no va a correr:
# print("Hola Unimet!")
# Sin embargo, mira que pasa si colocamos el # al frente de la funcion
print("Hay un comentario al frente de mí!") # Hola, soy un comentario

# Declaración de Variables ------------------------------------------------

## Declarando variables
# Se utiliza el operador de asignación `<-`
numero_estudiantes <- 10

## Viendo nuestro directorio de trabajo
# carpeta en la que nos encontramos
getwd()

# Paquetes ----------------------------------------------------------------

## Método 1 para instalar paquetes
# A través de RStudio: Ir a packages / install y escribir el nombre del paquete

## Método 2 para instalar paquetes
# Utilizar la siguiente función:
install.packages("dplyr")


# Cargando paquetes ya instalados -----------------------------------------


# Utilizamos la función library(<NOMBRE DE PAQUETE>)
library(dplyr)

# El siguiente error aparecerá si el paquete NO está instalado:
# Error in library(dplyr) : there is no package called ‘dplyr’



# Utilizando la ayuda de R ------------------------------------------------

## Ver lista de funciones de un paquete
# Packages / buscar nombre de paquete / click en el nombre del paquete

# Mostrar la ayuda de una función:
help(summary) # Opción 1
? summary # Opción 2

## Estructura de la ayuda de una función en R
# Description: Descripción de lo que hace la función.
# Usage: Sintaxis básica de la función.
# Arguments: Argumentos que acepta la función.
# Value: Valor retornado por la función.
# Examples: Ejemplos de cómo se utiliza la función.


# Tipos de datos básico en R ----------------------------------------------


# Numeric
numero_entero <- 2
class(numero_entero)

numero_decimal <- (0.5)
class(numero_decimal)

# Character
nombre_mandalorian <- "Din Djarin"
print(nombre_mandalorian)

# Logical
print(TRUE == FALSE)
print(TRUE + TRUE) # Internamente R interpreta TRUE como un 1 y False como 0
print(TRUE + FALSE)
print(FALSE + FALSE)



# Vectores ----------------------------------------------------------------

## Descripcion ##
# Colección de uno o más datos del mismo tipo.
# Utilizamos c() para concatenar múltiples elementos y crear vectores.

## Vector de numeros ##
# Vamos a crear un vector con las notas de los estudiantes
estudiantes_notas <- c(20, 18, 19, 20, 16, 17)
print(estudiantes_notas)

## Vector de characters ##
# Vamos a crear un vector con el nombre de los estudiantes
estudiantes_nombres <-
  c("juan", "pepe", "maria", "carolina", "gonzalo", "lucy")
print(estudiantes_nombres)

## Vectores de valores logicos ##
# Vamos a crear un vector sobre si al estudiante le gusta el chocolate
estudiantes_chocolate <- c(TRUE, FALSE, TRUE, TRUE, TRUE, FALSE)

## Accediendo a vectores ##
# Utilizamos el nombre del vector seguido del corchete.
# La posición del primer vector es 1.

# Primer estudiante
estudiantes_nombres[1]

# tercer estudiante
estudiantes_nombres[3]



# Matrices ----------------------------------------------------------------

## Definición:
# En R, una matriz es una colecicón de elementos del mismo tipo de dato.
# Las matrices son estructuradas en filas y columnas.

## Creando Matrices

## 1. Utilizando función matrix
matriz_1 = matrix(1:20, byrow = TRUE, nrow = 5)
matriz_1

## 2. Creando una matriz a partir de vectores
#   OJO:
#   Debido a que estamos utilizando un vector con variables de tipo numeric
#   y de tipo character, TODOS los datos en la matriz van a ser transformados
#   a character
clase_metodos <-
  matrix(c(
    estudiantes_nombres,
    estudiantes_notas,
    estudiantes_chocolate
  ),
  nrow = 6)
clase_metodos

# Para ver info basica de la matriz vamos a utilizar la función str
# Vas a ver como todos los elementos son de tipo chr (character)
str(clase_metodos)

## 2.2 Que crees que pase si creamos la matriz sin el argument nrow? ##

clase_metodos_sinnrow <-
  matrix(c(estudiantes_nombres, estudiantes_notas))
clase_metodos_sinnrow

# Viendo los nombres de columnas y filas
colnames(clase_metodos)
rownames(clase_metodos)

# Creando nombres de files y columnas.
colnames(clase_metodos) <-
  c("estudiante", "nota_final", "assert_gusta_choco")
rownames(clase_metodos) <- c(
  "estudiante_1",
  "estudiante_2",
  "estudiante_3",
  "estudiante_4",
  "estudiante_5",
  "estudiante_6"
)

# Accediendo a elementos en una matriz

## Los elementos en una matriz se acceden a traves de un corchete con
### el siguiente formato: [NUMERO_FILA,NUMERO_COLUMNA]

## Ejemplos:

# 1. Nota del primer estudiante
clase_metodos[1, 2]

# 2. Nombre del primer estudiante
clase_metodos[1, 1]

# 3. Nombre y nota del primer estudiante
## En este caso, seleccionamos la primera fila (primer estudiante)
## Se dejan las columnas vacias para retornar todas las columnas (nombres, notas)
clase_metodos[1,] # OJO, al dejar las columnas vacias, va a retornar todas las columnas

# 4. Nombre de todos los estudiantes
## En esta caso, seleccionamos la primera columna (nombres)
## Se dejan las filas vacias para retornar todas las filas de la primera columna.
clase_metodos[, 1] # OJO, al dejar las filas vacias, va a retornar todas las filas



# Factores ----------------------------------------------------------------

## Descripción
# Utilizamos factores para almacenar variables categoricas:
# Variables nominales u ordinales (dicotómicas o policotómicas)

## Creando Factores

# Variable nominal dicotomica
# Vamos a crear un vector con el sexo biológico de los estudiantes
estudiantes_sexo_bio <- c("m", "m", "f", "f", "m", "f")

estudiantes_sexo_bio_factor <- factor(estudiantes_sexo_bio)
estudiantes_sexo_bio_factor

# Variables ordinales policotomicas
# Vamos a crear un vector con la lejanía de cada estudiante con respecto a la UNIMET

estudiantes_distancia <-
  c("cerca", "muy lejos", "cerca", "lejos", "muy lejos", "lejos")

estudiantes_distancia_factor <- # Creando el factor
  factor(
    estudiantes_distancia,
    order = TRUE,
    # OJO, debido a que es ordinal queremos que este ordenado
    levels = c("cerca", "lejos", "muy lejos") # Niveles de menor a mayor
  )

## Cambiando el nombre de nivel de los factores ##
# Esto va a ser sumamente util cuando veamos regresion logistica.

# Ahora queremos que femenino sea 2 y masculino 1

# Chequeamos los niveles de la variable sexo biologico
levels(estudiantes_sexo_bio_factor)
estudiantes_sexo_bio_factor # Vemos el contenido original de este vector

# Cambiamos los niveles del factor
levels(estudiantes_sexo_bio_factor) <- c(2, 1)
estudiantes_sexo_bio_factor # Vemos el contenido modificado del vector

# Veamos un overview de los factores que hemos
summary(estudiantes_sexo_bio_factor)
summary(estudiantes_distancia_factor)


# Dataframes --------------------------------------------------------------

# Descripcion

## Un Dataframe es una matriz que puede tener múltiples tipos de datos.
### Recuerda: en una matriz solo puede haber 1 tipo de dato.

## Ya has utilizado dataframes antes!!
## Una hoja de excel es equivalente a un dataframe!

# Creando un Data Frame

clase_metodos_df <- data.frame(clase_metodos)

## Ampliando nuestra matriz con column bind - funcion cbind()
# Esta función añade un vector como columnas al dataframe.
clase_metodos_df <-
  cbind(clase_metodos_df, estudiantes_sexo_bio_factor)
clase_metodos_df <-
  cbind(clase_metodos_df, estudiantes_distancia_factor)

## Veamos la estructura del dataframe
str(clase_metodos_df)
# Las variables de tipo factor fueron añadidas correctamente.

## Accedamos a la variable nota_final ##
#
# Metodo 1 (Utilizando el signo de dolar y el nombre de la columna)
clase_metodos_df$nota_final

# Metodo 2 (Utilizando corchetes y nombre de columna)
clase_metodos_df["nota_final"]

# Metodo 3 (numero de columna)
clase_metodos_df[2]


## Ahora necesitamos convertir la variable nota final a numeric.
# Para esto utilizaremos as.numeric().
clase_metodos_df$nota_final <-
  as.numeric(clase_metodos_df$nota_final)

## Ahora vamos a convertir la variable chocolate a logical
clase_metodos_df$assert_gusta_choco <-
  as.logical(clase_metodos_df$assert_gusta_choco)

# Veamos los primeros 2 elementos de nuestro dataframe
head(clase_metodos_df, n = 2)

# veamos los ultimos 2 elementos de nuestro dataframe
tail(clase_metodos_df, n = 2)

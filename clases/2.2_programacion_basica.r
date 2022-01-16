#' ---
#' title: "Semana 2.2 - Tidy Data"
#' author: "Diego Gimenez"
#' date: "20/01/2021"
#' ---

 
library(readr)

# Operadores Relacionales ------------------------------------------------------

estudiantes <- 31
preparadores <- 2
profesor <- 1
grupos_estudiantes <- 6

fruta1 <- "manzana"
fruta2 <- "pera"

# Alumnos de dos materias distintas a lo largo de 3 trimestres
alumnos_psicometria <- c(30, 20, 10) # Alumnos de psicometria
alumnos_metodos <- c(32, 15, 10) # alumnos de metodos de investigacion


# Igualdad: ==
# Desigualdad: !=
# Mayor a: >
# Mayor igual a: >=
# Menor a: <
# Menor igual a: <


## Ahora tu turno!



# Responde las siguientes preguntas a traves de operadores logicos:

## Hay mas estudiantes que preparadores?


## Fruta1 y fruta2 son iguales o distintas?

## En que trimestres hubo mas alumnos de metodos que de psicometria?

## En que trimestre hubo menos alumnos metodos que de psicometria?

## En que trimestre hubo igual numero de alumnos de metodos y de psicometria?



# Operadores logicos ------------------------------------------------------

promedio_metodos <- 16

## De igual manera podemos utilizar operadores logicos para evaluar relaciones
# mas complejas

# And: &
# OR: |
# Not: !


## Ahora tu turno!

## El numero de preparadores es mayor o igual que la cantidad de grupos o
# el numero de prepradores + el profesor son mayor o igual que a la cantidad de grupos?



# If Else -----------------------------------------------------------------

## Sintaxis:

# if (`condicion`) {
#
#   # Esta seccion corre si la condicion es TRUE
#
# } else {
#
#   # Esta seccion corre si la condicion es FALSE
#
# }

# IMPORTANTE:
# Cuando la condicion se cumple (es TRUE), el if else statement va a detenerse.
# En otras palabras, cuando una condicion es TRUE, las siguientes condiciones NO van a ejecutarse.

if (1 > 2) {
  print("Condicion 1 es verdadera!")
} else {
  print("Condicion 1 es falsa!")
}



## Ahora tu turno!
# Que crees que se va a imprimir aca?

if (1 > 2 | 1 != 2) {
  print("Condicion 1 es verdadera!")
} else {
  print("Condicion 1 es falsa!")
}



## Ahora tu turno!
# La condicion del else statement va a correr en mas condiciones.
# Solo va a correr si hay la misma cantidad de preparadores que de profesores?
# En que otras condiciones va a correr?

if (preparadores > profesor) {
  print("Hay mas preparadores que profesores en la materia")
} else {
  print("Hay la misma cantidad de preparadores y de profesores en la materia")
}


## Utilizando else if para mas condiciones
## Sintaxis:

# if (`condicion`) {
#
#   # Esta seccion corre si la condicion es TRUE
#
# } else if () {
#
#   # Esta seccion corre si la condicion es TRUE
#
# } else {
#
#   # Esta seccion corre si la condicion es FALSE
#
# }

## Ahora tu turno!
# Que print statement se va a ejecutar, por que?

if (1 > 2) {
  print("Condicion 1 es verdadera!")
} else if (1 == 2 & 1 > 2 & 2^3 == 8) {
  print("condicion 2 es verdadera!")
} else if (1 == 2 | 1 > 2 | 2^3 == 8) {
  print("condicion 3 es verdadera!")
} else {
  print("Condicion 1, 2 y 3 son falsas!")
}


# Que print statement se va a ejecutar, por que?
if (grupos_estudiantes > preparadores) {
  print("Hay mas grupos de estudiantes que preparadores en la materia.")
} else if (grupos_estudiantes > preparadores + profesor) {
  print("Hay mas grupos de estudiantes que preparades y profesores en la materia.")
} else if (grupos_estudiantes == profesor | grupos_estudiantes == preparadores) {
  print("Hay la misma cantidad de grupos que profesores o preparadores")
}



# While Loop --------------------------------------------------------------

## El While Loop es utilizado para realizar repeticiones mientras una condicion sea TRUE

# while (condition) {
#   # PRINT WHEN TRUE
# }

# Ejemplo:

# Esta es la variable contador o counter. Se inicializa afuera del while loop.
# Esta variable es utilizada para evaluar el while loop.
numero <- 1
while (numero <= 10) {
  print(paste("El numero es", numero, sep = " "))
  numero <- numero + 1 # La variable contador debe ser incrementada cada iteracion.
}

## Ahora tu turno!
# Que crees que pase si corremos el siguiente while loop?
# Como o arreglarias?

# numero <- 1
# while (numero <= 10) {
#   print(paste("El numero es", numero, sep = " "))
# }




# For Loop ----------------------------------------------------------------

## Repetir un loop un número determinado de veces


# for ( <elemento> in <arreglo>) {
#   print(<elemento>)
# }


## Ejemplos

## Podemos iterar sobre un vector

vector_numeros <- 1:5 # creemos un vector con numeros del 1 al 5
# Equivalente a c(1,2,3,4,5,6)

# Podemos hacer print de cada numero.
# cada iteracion es dividida por "---------"
for (numero in vector_numeros) {
  print(paste("Iteracion: ", numero))
  print("----------------")
}

## De igual manera podemos iterar sobre un vector de characters

vector_unimet <- c("u", "n", "i", "m", "e", "t")

for (letra in vector_unimet) {
  print(letra)
  print("---------------")
}


## Por ultimo, es muy comun iterar sobre los indices de un vector o un arreglo.
# Utilizamos 1:length(<VECTOR>)
# Tip: Utiliza ?length para chequear que hace esta funcion.

for (indice_letra in 1:length(vector_unimet)) {
  print(paste("Iteracion: ", indice_letra))
  print(vector_unimet[indice_letra])
  print("----------------")
}


# Funciones ---------------------------------------------------------------

# Utilizamos funciones cuando repetimos logica o repetimos otras funciones multiples veces.

# mi_primer_funcion <- function(<ARGUMENTOS>) {
#   LOGICA
# }


## Ejemplo:

# Sintaxis basica.

# Argumento sin valor default

imprimir_nombre_sindefault <- function(nombre) {
  print(nombre)
}


imprimir_nombre_sindefault("Eugenio Mendoza")


# Argumento con valor default

imprimir_nombre_condefault <- function(nombre = "Nombre Default") {
  print(nombre)
}

imprimir_nombre_condefault()



# Ejercicio ---------------------------------------------------------------

## Leamos un dataframe

data_practica_anova <- read_csv("datasets/data_practica_anova.csv")


## Queremos saber cual es la media y desviacion estandar segun el tipo de personalidad

# 1er paso: Encontrar cuales son los datos que son de Tipo A
boolean_mask <- (data_practica_anova$personalidad == "Tipo A")
boolean_mask # Veamos que tiene Boolean Mask.

# 2do paso: Utilizar la variable boolean_mask para encontrar los valores que son TRUE
# Importante: Se deben pasar estos valores como filas! (primera parte del corchete)
# esto se debe a que queremos encontrar
data_practica_anova[boolean_mask, ]

# 3er paso: Imprimir Media y desviacion estandar segun Tipo
# Importante: Al copiar y pegar codigo es muy facil cometer errores!!
print("Media Rendimento en actividad Tipo A")
mean(data_practica_anova$personalidad == "Tipo A")
print("Desviacion Estandar Rendimento en actividad Tipo A")
sd(data_practica_anova$personalidad == "Tipo A")


print("Media y mediana Rendimento en actividad Tipo B")
mean(data_practica_anova$personalidad == "Tipo B")
print("Desviacion Estandar en actividad Tipo B")
sd(data_practica_anova$personalidad == "Tipo B")

# 4to paso: Crear funcion
# Como crearias una funcion para reutilizar el codigo del 3er paso

imprimir_media_desviacion <- function() {
  # ESCRIBIR CODIGO ACA
}

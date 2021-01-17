#' ---
#' title: "Semana 2.2 - Tidy Data"
#' author: "Diego Gimenez"
#' date: "20/01/2021"
#' ---



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

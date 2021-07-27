## Prepa 1 29/04/2021 ## Subir datos y construir variables


# Objetos en R ------------------------------------------------------------


## Objetos 
# Todo en R es un objeto.
# Cada objeto va a pertenecer a una categoría de acuerdo al tipo de data que contenga.

# los objetos en R pueden entenderse como una caja.
# en estaS caja puedes guardar elementos
# Las cajas ser van organizar de acuerdo al tipo de elemento que se le coloque

# Algunos objetos en R van a ser nuestras variables de estudio, segun sea nuestro interes
# Cada variable va a tener in tipo de informacion. Esta es relevante para nosotros

### vectores (vectores atomicos)
# tienen 2 caracteristicas: tipo y largo
# contienen un tipo especifico de elementos:

# Logical ----> valores de TRUE y FALSE
a <- c(T, F, F, T, T)
print(a)
typeof(a)
length(a)

# Character ----> todo dato dentro de "comillas". Se les conoce como strings 
b <- "merequetengue"
print(b)
typeof(b)
length(b)

# Numeric ----> numeros. Pueden ser double o integer
c <- c(4, 25.5 , -80)
print(c)
typeof(c)
length(c)

# si quieres saber si un objeto o variable es un vector puedes:
# 1. revisar el objeto en la parte derecha superior donde esta el environment. 
# 2. usar la funcion is.vector()

is.vector(a)  

# Se puede transformar cada uno de ellos a otros tipos de vectores con las funciones:
as.character()
as.numeric()
as.integer()
as.double()
as.logical()

### listas
# Alamacenan elementos dentro de grupos de datos del mismo tipo. Estos pueden ser vectores o listas 
lista <- list(a, b, c)
print(lista)
str(lista) # esta funcion nos sirve para ver la estructura de un objeto

### matrices
# Estan ordenados de acuerdo a columnas y filas
# Almacenan un solo tipo de datos
# Por defecto los ordena por columnas

m <- matrix(c(1:3, 10:15), nrow = 3)
print(m)
typeof(m)

# para elegir un elemento de la matrix se deben usar los []

m[2,2] # [row, col]

# factors
# Sirven para guardar datos o variables categoricas
# Se parte de un vector para ordenar sus datos en niveles
fac <- c("limon", "mango", "parchita", "lechosa")
total_fac1 <- factor(fac) #asi se asignan los niveles en orden alfabetico

total_fac2 <- factor(fac, levels = c("mango", "parchita", "limon", "lechoza"))
# con levels podemos ordenarlos a gusto

# Funciones para ver la informacion de las variables
str(total_fac2) # te permite ver la estructura de los datos
class(m)        # te dice la clase del objeto 


## dataframes
# contienen datos ordenados en variables en dos dimensiones 
# las columnas representan cada variable
# las filas representan las observaciones o valores de cada variable
# pueden almacenar diferentes tipos de datos

# dataframe
fruta <- as.factor(replicate(8, sample(total_fac1))) 
sabor <- sample(c(1:10), 32, replace = TRUE)

df <- data.frame(fruta, sabor)

str(df)

# los datos obtenidos del formulario de sus proyecto final van a estar contenidas dentro de un dataframe

library(gapminder) # lo usaran en datacamp. Contiene un dataframe con datos sobre los paises
library(ggplot2) # sirve para hacer graficos
library(dplyr) # sirve para manjear los datos en un dataframe

# hare un grafico para mostrar que se puede hacer con un dataframe

ven <- gapminder %>%
  filter(country == "Venezuela")

head(ven) # permite ver los primeros valores de un dataframe
View(ven) # permite ver el dataframe

ggplot(ven, aes(x = year, y = lifeExp)) +
  geom_point() +
  geom_line() +
  expand_limits(y = 0)



# Parte pr?ctica de la prepa ----------------------------------------------



# Lo que primero siempre debemos hacer es cargar los paquetes necesarios a R

library(readr) # Este paquete nos permite leer data de archivos csv
library(readxl) # Este paquete nos permite leer data de archivos xls o xlsx
library(dplyr) # Este paquete nos ofrece muchas funciones utiles en R, sobretodo %>% 


# Shortcuts en R ----------------------------------------------------------

# # Si hacen clic en Ctrl + Shift + C pueden hacer comentarios r?pidos de las l?neas 
# # seleccionadas
# 
# Si hacen clic en Ctrl + Enter pueden correr la l?nea de c?digo seleccionada
#  o l?nea por l?nea
# 
# Si hacen clic en Crt + Shit + M les permite ingresar un pipeline de manera r?pida
# OJO: Esto no funciona en DataCamp
# 
# Si hacen clic en Ctrl + Alt + B les permite correr todas las l?neas de c?digo
# hasta donde se encuentren ubicados



# Definiendo variables ----------------------------------------------------



# Ahora bien nosotros podemos crear cualquier tipo de variable que necesitemos,

# Recuerden que en R siempre cuando definamos variables, los nombres los colocamos a la izquierda y la definici?n a la derecha

# Por ejemplo creemos una variable fija con valor 1

uno <- 1

# Como la variable "uno" es num?rica, podemos hacer c?lculos con ella

9600* uno

1 + uno

TRUE + uno # Cuando hacemos c?lculos con la variables l?gicas, TRUE = 1 Y FALSE = 0

# Tambi?n podemos crear vectores en R, esto es un conjunto de datos

vector_del_1_al_6 <- c(1:6) 

vector_nombres <- c ("Alejandro", "Pedro", "Carlos", "Diana", "Carla", "Mar?a")

vector_logico <- c (TRUE, FALSE, TRUE, TRUE, FALSE, FALSE) 

vector_del_1_al_6 + vector_nombres # Esto nos va a dar error, pues R no puede sumar dos vectores que no son num?ricos

vector_del_1_al_6 + vector_logico # ?Por qu? aqu? si nos da un resultado?


#Cbind nos permite unir dos columnas en un solo dataframe o matriz

vectores_unidos <- cbind(vector_del_1_al_6, vector_logico, vector_nombres) 

str(vectores_unidos) # Veamos la estructura de la data creada

numeros_primos <- c(1,2,3,5,7,11)

numeros_primos_alcuadrado <- c(1*1, 2*2, 3*3, 5*5, 7*7, 11*11)

lista_num_primos <- cbind(numeros_primos, numeros_primos_alcuadrado) %>% as.matrix()

lista_num_primos + 1 # Al hacer esto, se aplican reglas matem?ticas de suma de matrices, por ende se suma 1 a TODOS los valores de la matriz


# Transformando las matrices en data frame nos permite tener datos de diferentes tipos en una sola lista

df_numeros_primos <- lista_num_primos  %>% as.data.frame() 


# Ahora si juntamos todos en uno con cbind se va a generar como dataframe y no como una matriz

todos <- cbind(df_numeros_primos, vector_del_1_al_6, vector_logico, vector_nombres) 



# Tambi?n podemos unir listas por filas con la funci?n rbind

todos_filas <-rbind(numeros_primos, vector_del_1_al_6, vector_logico, vector_nombres)


# Subiendo data a R -------------------------------------------------------

# Primero establecemos el directorio de trabajo 

setwd("C:/Users/Sergio/Desktop/Prepas cuanti")

# Luego procedemos a cargar la data en R

# # Para poder utilizarla y realizarle modificaciones despu?s es necesario definir
# una variable con toda la data

data <- read_xlsx("Metodos cuanti.xlsx")


# Ahora con la data podemos tomar columnas o datos en espec?fico para generar otras variables

# Por ejemplo seleccionemos la columna de sexo

sexo <- data[,2]

# Veamos la estructura de la variable sexo

str(sexo) # Esto medice que el tipo de data es un data.frame con variables tipo character

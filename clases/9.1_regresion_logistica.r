# Paquetes
library(readr)
library(dplyr)
library(skimr) # Nuevo paquete! (lo tendras que instalar)
library(dlookr) # Nuevo paquete! (lo tendras que instalar)
library(inspectdf) # Nuevo paquete! (lo tendras que instalar)
library(polycor)
library(stringr)
library(ggplot2)
library(caret)
library(ggiraphExtra)
library(rcompanion)


# Leer Data --------------------------
original_df <- read_csv("../datasets/psicologia_organizacional/hr-employee-attrition.csv")

original_df %>%
  View()

colnames(original_df) <- original_df %>%
  colnames() %>% # Seleccionamos el nombre de Todas columnas
  tolower() %>% # Lo convertimos a lower case
  str_replace(" ", "_") # Reemplazamos espacios con underscores



# Inspeccionemos rapidamente nuestro dataframe
dplyr::glimpse(original_df)


# Ahora tu turno! Transforma las variables relevantes a factor

# La primera ya esta hecha:
original_df$attrition <- factor(original_df$attrition,
                                levels = c("Yes", "No"),
                                labels = c(1, 0)
)

# Ahora completa el resto!


# Ojo: Necesitamos crear una nueva variable con nuestro factor convertido a varaible numerica
# La variable debe ser de tipo numeric para poder computar la regresion logistica

original_df$attrition_target <- original_df$attrition %>%
  as.character() %>%
  as.numeric()




# Eda Inicial -------------------------------------------------------------

# Total de valores nulos en el dataframe
original_df %>%
  is.na() %>%
  sum()

# Outliers
df_outliers <- dlookr::diagnose_outlier(original_df)

df_outliers %>%
  filter(outliers_cnt > 0) %>%
  arrange(desc(outliers_cnt))



# EDA: Analisis descriptivo univariante -----------------------------------

skimr::skim(original_df)
inspectdf::inspect_cat(original_df)

original_df %>% 
  ggplot(aes(x=attrition)) +
  geom_bar()




# EDA: Analisis descriptivo bivariante ------------------------------------

bivariate_explorer <- function(variable_independiente) {
  original_df %>% 
    ggplot(aes_string(x = "attrition", y = vi)) +
    geom_boxplot()
  
}

bivariate_explorer(variable_independiente="age")
bivariate_explorer(variable_independiente="dailyrate")
# Completa las variables independientes que quedan...



# Analisis confirmatorio: Regresion logistica -----------------------------

# Creemos modelo 
model_lr <- glm(attrition ~ age, data = original_df, family = "binomial")

# Veamos los resultados
summary(model_lr)

tidy(model_lr) # coeficientes
glance(model_lr) # Coeficientes - Tidy Way

# Odds
odds <- exp(model_lr$coefficients)
odds

# Probabilities
# Ahora tu turno! Como calcularias las probabilidades de cada coeficiente?



# Bonus: Inspeccionemos como se ve nuestro modelo -------------------------


original_df <- original_df %>% 
  mutate(probability = predict(model_lr, original_df, type = "response"),
         predicted_class = ifelse(probability > 0.2, 1, 0))

original_df$probability

original_df %>%
  ggplot(aes(age, attrition_target)) +
  geom_point(alpha = 0.2) +
  geom_smooth(method = "glm", method.args = list(family = "binomial")) +
  labs(
    title = "Logistic Regression Model", 
    x = "Age",
    y = "Probabilidad de Attrition"
  )


# Bonus: Intro a Machine Learning -----------------------------------------


# Dejo esta función que pueden utilizar para calcular las métricas que hablamos en clase

get_model_metrics <- function(dataframe,variable_dependiente, formula){
  # Creamos los train y test splits
  
  idx = createDataPartition(dataframe[[variable_dependiente]], p = 0.75, list = FALSE)
  trn = original_df[default_idx, ]
  tst = original_df[-default_idx, ]
  tst_y <- original_df$attrition %>% as.character() %>% as.numeric()
  
  # Entrenamos el modelo
  model_lr_machinelearning = train(
    form = as.formula(formula),
    data = trn,
    trControl = trainControl(method = "cv", number = 5),
    method = "glm",
    family = "binomial"
  )
  
  # Guardaamos predicciones
  preds <- predict(model_lr_machinelearning,tst, type = "raw")
  
  summary(model_lr_machinelearning)
  
  
  metric_conf_matrix = confusionMatrix(model_lr_machinelearning)
  
  metric_precision = ModelMetrics::precision(actual = tst_y, predicted =  preds)
  metric_recall = ModelMetrics::recall(actual = tst_y, predicted =  preds)
  
  print(metric_conf_matrix)
  
  print(str_glue(
    
    "
    Precision: {metric_precision}
    Recall: {metric_recall}
    "
  ))
  
  
}

get_model_metrics(dataframe = original_df, variable_dependiente = "attrition",
                  formula = "attrition ~ age")

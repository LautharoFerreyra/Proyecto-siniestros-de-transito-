#¿En qué días de la semana ocurren más siniestros?
#¿Qué tipo de vehículo está más involucrado en siniestros graves o fatales?
#¿Hay diferencias por sexo o edad en los siniestros con resultado fatal?
#¿En qué departamentos o zonas se concentran más los siniestros fatales?
#¿Usar casco o cinturón está asociado a menor gravedad en los siniestros?

#Librerias necesarias
library(tidyverse)      # manipulación de datos + ggplot2
library(here)           # rutas relativas
library(readr)          # leer documentos
library(janitor)        # renombrar columnas

#cargar datos
df <- read_csv("C:/Users/User/OneDrive/Desktop/Personas lesionadas en siniestros de tránsito/siniestros2022.csv")
colnames(df)


#Limpieza de los datos
#Renombrar columnas
df <- df %>%
  rename(
    dia_semana= `DI�a de la semana`,
    usa_cinturon = `Usa cinturI�n`,
    tipo_de_resultado = 'Tipo de resultado',
    tipo_de_siniestro = 'Tipo de siniestro',
    fecha = 'Fecha',
    edad = 'Edad',
    rol = 'Rol',
    calle = 'Calle',
    zona = 'Zona',
    novedad = 'Novedad',
    tipo_de_Vehiculo = 'Tipo de Vehiculo',
    usa_casco = 'Usa casco'
  )
# Detectar solo columnas tipo texto y reemplazar "SIN DATOS" por NA
df <- df %>%
  mutate(across(where(is.character), ~na_if(.x, "SIN DATOS")))

#¿Usar casco está asociado a menor gravedad en los siniestros?
#Valores correctos en tipo_de_resultado
 casco <- df %>%
  filter(!is.na(usa_casco), !is.na(tipo_de_resultado)) %>%
  filter(tipo_de_resultado %in% c("HERIDO LEVE", "HERIDO GRAVE")) %>%
  count(usa_casco, tipo_de_resultado) %>%
  pivot_wider(names_from = tipo_de_resultado, values_from = n, values_fill = 0)
 
#Grafico usa casco si o no
df %>%
  filter(!is.na(usa_casco), !is.na(tipo_de_resultado)) %>%
  filter(tipo_de_resultado %in% c("HERIDO LEVE", "HERIDO GRAVE")) %>%
  count(usa_casco, tipo_de_resultado) %>%
  ggplot(aes(x = usa_casco, y = n, fill = tipo_de_resultado)) +
  geom_col(position = "fill") +
  scale_y_continuous(labels = scales::percent) +
  labs(
    title = "Proporción de tipo de herida según uso de casco",
    x = "¿Usaba casco?",
    y = "Proporción (%)",
    fill = "Tipo de herida"
  ) +
  theme_minimal()
df
#¿En qué días de la semana ocurren más siniestros?
#Filtro pra resultados correctos
df %>% 
  filter(!is.na(dia_semana), !is.na(tipo_de_resultado)) %>%
  filter(tipo_de_resultado %in% c("HERIDO LEVE", "HERIDO GRAVE")) %>%
  count(dia_semana, tipo_de_resultado) %>%
  pivot_wider(names_from = tipo_de_resultado, values_from = n, values_fill = 0)



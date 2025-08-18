#¿En qué días de la semana ocurren más siniestros?
#¿Qué tipo de vehículo está más involucrado en siniestros graves o fatales?
#¿Hay diferencias por sexo o edad en los siniestros con resultado fatal?
#¿Usar casco o cinturón está asociado a menor gravedad en los siniestros?
#¿Como evoluciono los siniestros mes a mes?

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

#-------------------------------------------------------------------------------

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

#-------------------------------------------------------------------------------

#¿En qué días de la semana ocurren más siniestros?
#Filtro pra resultados correctos.
df %>% 
  filter(!is.na(dia_semana), !is.na(tipo_de_resultado)) %>%
  filter(tipo_de_resultado %in% c("HERIDO LEVE", "HERIDO GRAVE", "FALLECIDO EN CENTRO DE ASISTENCIA", 
                                  "FALLECIDO EN EL LUGAR")) %>%
  count(dia_semana, tipo_de_resultado) %>%
  pivot_wider(names_from = tipo_de_resultado, values_from = n, values_fill = 0)

#Grafico de los dias
orden_dias <- c("LUNES", "MARTES", "MIERCOLES", "JUEVES", "VIERNES", "SABADO", "DOMINGO")
df %>%
  filter(!is.na(dia_semana), !is.na(tipo_de_resultado)) %>%
  filter(tipo_de_resultado %in% c("HERIDO GRAVE", 
    "FALLECIDO EN CENTRO DE ASISTENCIA", 
    "FALLECIDO EN EL LUGAR")) %>%
  mutate(dia_semana = factor(dia_semana, levels = orden_dias)) %>%
  count(dia_semana, tipo_de_resultado) %>%
  ggplot(aes(x = dia_semana, y = n, fill = tipo_de_resultado)) +
  geom_col() +
  labs(
    title = "Cantidad de accidentes por día y tipo de resultado",
    x = "Día de la semana",
    y = "Cantidad de casos",
    fill = "Tipo de resultado"
  ) +
  theme_minimal()

#-------------------------------------------------------------------------------

#¿Como evoluciono los siniestros mes a mes?


df_filtrado <- df %>%
  filter(!is.na(fecha)) %>%
  mutate(
    fecha = dmy(fecha),
    mes = floor_date(fecha, "month")
  ) %>%
  count(mes)
df_filtrado

df %>%
  filter(!is.na(fecha)) %>%
  mutate(
    fecha = dmy(fecha),
    mes = floor_date(fecha, "month")
  ) %>%
  count(mes) %>%
  ggplot(aes(x = mes, y = n)) +
  geom_line(size = 1.2, color = "#2c3e50") +
  geom_point(size = 2, color = "#2c3e50") +
  labs(
    title = "Evolución mensual de siniestros",
    x = "Mes",
    y = "Cantidad total de siniestros"
  ) +
  theme_minimal() +
  scale_x_date(date_labels = "%b %Y", date_breaks = "1 month") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


#-------------------------------------------------------------------------------

#¿Qué tipo de vehículo está más involucrado en siniestros graves o fatales?

library(tidyverse)

df %>% 
  filter(!is.na(tipo_de_Vehiculo), !is.na(tipo_de_resultado)) %>%
  filter(tipo_de_resultado %in% c("HERIDO GRAVE", 
                                  "FALLECIDO EN CENTRO DE ASISTENCIA", 
                                  "FALLECIDO EN EL LUGAR"),
         tipo_de_Vehiculo != "CHAPA MATRICULA") %>%   
  count(tipo_de_Vehiculo, tipo_de_resultado) %>%
  pivot_wider(names_from = tipo_de_resultado, values_from = n, values_fill = 0) %>%
  pivot_longer(cols = -tipo_de_Vehiculo,
               names_to = "resultado",
               values_to = "cantidad") %>%
  group_by(tipo_de_Vehiculo) %>%
  mutate(total = sum(cantidad)) %>%
  ungroup() %>%
  ggplot(aes(x = fct_reorder(tipo_de_Vehiculo, total), 
             y = cantidad, fill = resultado)) +
  geom_col() +
  coord_flip() +
  labs(x = "Tipo de vehículo", y = "Cantidad", fill = "Resultado")

#-------------------------------------------------------------------------------

#¿Hay diferencias por sexo o edad en los siniestros con resultado fatal?

class(df$edad)
unique(df$edad)
df$edad <- as.numeric(df$edad)

#Filtro pra resultados correctos.
df %>% 
  filter(!is.na(edad), !is.na(Sexo)) %>%
  filter(tipo_de_resultado %in% c("HERIDO LEVE", "HERIDO GRAVE", "FALLECIDO EN CENTRO DE ASISTENCIA", 
                                  "FALLECIDO EN EL LUGAR")) %>%
  count(Sexo, tipo_de_resultado) %>%
  pivot_wider(names_from = tipo_de_resultado, values_from = n, values_fill = 0) 


library(forcats)

df %>%
  filter(!is.na(Sexo)) %>%
  mutate(grupo_edad = cut(edad, 
                          breaks = c(0, 17, 29, 44, 59, 74, Inf), 
                          labels = c("0-17", "18-29", "30-44", "45-59", "60-74", "75+"))) %>%
  mutate(grupo_edad = fct_explicit_na(grupo_edad, na_level = "Desconocido")) %>%
  count(Sexo, grupo_edad) %>%
  ggplot(aes(x = grupo_edad, y = n, fill = Sexo)) +
  geom_col(position = "dodge") +
  labs(x = "Grupo etario", y = "Cantidad", title = "Fallecidos por sexo y edad")




# Análisis de siniestros de tránsito en Uruguay (2022)

Este proyecto realiza un análisis exploratorio de los siniestros de tránsito en Uruguay utilizando datos abiertos de personas lesionadas en 2022.  
El objetivo es responder preguntas clave relacionadas con la frecuencia, gravedad y características de los siniestros.

## 📌 Preguntas de investigación
- ¿En qué días de la semana ocurren más siniestros?  
- ¿Qué tipo de vehículo está más involucrado en siniestros graves o fatales?  
- ¿Hay diferencias por sexo o edad en los siniestros con resultado fatal?  
- ¿El uso de casco o cinturón está asociado a menor gravedad en los siniestros?  
- ¿Cómo evolucionaron los siniestros mes a mes?  

## 🛠️ Librerías utilizadas
El proyecto hace uso de las siguientes librerías de R:

- **tidyverse** → manipulación de datos y gráficos con `ggplot2`  
- **here** → gestión de rutas relativas  
- **readr** → lectura de archivos CSV  
- **janitor** → limpieza y renombrado de columnas  
- **forcats** → manipulación de factores  

## 📂 Datos
El dataset utilizado proviene de registros oficiales de siniestros viales en Uruguay.  
Archivo utilizado:
https://catalogodatos.gub.uy/dataset/base-anual-de-personas-lesionadas-en-siniestros-de-transito/resource/f1157e84-9577-4d8f-b2f3-92c1d720ae93?inner_span=True

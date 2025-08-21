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


---

## 🔧 Preparación y limpieza de datos
El flujo de trabajo en la limpieza incluyó:

- **Renombrado de columnas** con nombres más claros.  
- **Tratamiento de valores faltantes**: se reemplazaron los registros con `"SIN DATOS"` por `NA`.  
- **Conversión de variables**:  
  - Fechas transformadas al tipo `Date` y agrupadas por mes.  
  - Edad convertida a variable numérica y agrupada en tramos etarios.  
- **Filtrado de datos** para quedarnos solo con resultados válidos en los análisis.  

---

## 📊 Análisis y visualizaciones realizadas

### 1. Uso de casco y gravedad del accidente
- Se midió la relación entre el uso de casco y el tipo de herida sufrida (leve o grave).  
- Se graficó la **proporción de heridas graves vs leves según uso de casco**.  

### 2. Distribución semanal de siniestros
- Se contó cuántos siniestros graves o fatales ocurrieron por día de la semana.  
- Se visualizó en un **gráfico de barras**, permitiendo ver qué días presentan mayor riesgo.  

### 3. Evolución mensual
- Se agrupó la información por mes.  
- Se generó un **gráfico de línea** que muestra la evolución de la cantidad de siniestros a lo largo del año.  

### 4. Vehículos más involucrados en siniestros graves/fatales
- Se filtraron siniestros graves y fatales.  
- Se contó el número de casos por tipo de vehículo.  
- Se graficó en **barras horizontales**, mostrando qué vehículos presentan más riesgo.  

### 5. Diferencias por sexo y edad
- Se analizó cómo se distribuyen los siniestros fatales entre hombres y mujeres.  
- Se agruparon edades en tramos etarios.  
- Se generó un **gráfico de barras comparando sexos en cada grupo de edad**.  

---

## 📈 Resultados esperados
Al ejecutar el script, se obtienen tablas y gráficos que permiten responder las preguntas planteadas.  
Ejemplos de visualizaciones generadas:  

- Proporción de heridas según uso de casco.  
- Accidentes por día de la semana.  
- Evolución mensual de siniestros.  
- Vehículos más involucrados en siniestros graves/fatales.  
- Distribución de fallecidos por sexo y edad.  

---

## 🚀 Ejecución
1. Clonar este repositorio.  
2. Instalar las librerías necesarias en R:  

   ```R
   install.packages(c("tidyverse", "here", "readr", "janitor", "forcats"))

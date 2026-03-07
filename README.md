## Carga y Exploración de Datos: COVID-19 Dataset

### Descripción del Proyecto
Este proyecto se centra en la exploración y limpieza de datos sobre la pandemia de COVID-19 utilizando **MySQL**. 
El análisis abarca desde el inicio de la pandemia hasta abril de 2021, enfocándose en métricas de mortalidad, tasas de infección y el progreso de la vacunación a nivel global y regional.

El valor principal de este proyecto reside en el **proceso de ETL**, donde los datos brutos fueron transformados y estandarizados directamente durante la carga para asegurar la integridad del análisis.


### Herramientas Utilizadas
  * **Base de Datos:** MySQL
  * **Lenguaje:** SQL
  * **Técnicas de Datos:** Importación y Limpieza, Conversión de Data Types, Aggregate Functions, Joins, Temp Tables, CTE's, 


### Dataset
Los datos se dividieron en dos tablas principales:
  * **CovidDeaths:** Información sobre casos, muertes y población.
  * **CovidVaccinations**: Información sobre pruebas y administración de vacunas. 


### Proceso de Datos (ETL)
A diferencia de un proceso de carga simple, en este proyecto implementé una lógica de limpieza avanzada para manejar inconsistencias en los archivos CSV originales:
  1. **Estandarización de Fechas:** Conversión de formatos *String (dd/mm/yyyy)* a tipos de datos *DATE* mediante *STR_TO_DATE*.
  2. **Manejo de Valores Nulos:** Transformación de celdas vacías ('') en *NULL* reales para no sesgar las funciones de agregado *(AVG, SUM)*.
  3. **Limpieza de Caracteres Especiales:** Uso de *TRIM*, *REPLACE* y *CHAR(160)* para eliminar espacios existentes y caracteres no deseados en las métricas numéricas.
  4. **Validación Numérica:** Aplicación de *REGEXP* para asegurar que campos críticos solo contengan datos numéricos antes de su inserción.


### Resolución de Jerarquías Geográficas (País vs. Continente)
Durante la exploración, identifiqué que la columna *location* contenía tanto países como agrupaciones (continentes y totales mundiales).
  * El Problema: Al sumar por continente, las cifras no coincidían con los reportes oficiales porque el dataset incluía filas donde *location* era el nombre del continente y la columna *continent* estaba vacía.
  * La Solución:
    1. Ejecuté un *UPDATE* para convertir cadenas vacías en *NULL* en la columna *continent*. 
    2. Ajusté las consultas para excluir términos como 'World', 'European Union' e 'International' al realizar rankings por continente, logrando una precisión del 100% en los resultados.


### Consultas Clave e Insights
  * **Letalidad del Virus:** Análicé la relación entre casos confirmados y fallecimientos por país.
  * **Impacto Poblacional:** Cálculo del porcentaje de la población infectada históricamente y de forma diaria.
  * **Vacunación vs Población:** Unión de tablas (JOIN) para comparar el total de habitantes frente a las nuevas dosis aplicadas. ERROR


### Visualización Interactiva en Tableau
El análisis culmina en un Dashboard interactivo que permite explorar la evolución de la pandemia. Puedes interactuar con los datos en tiempo real aquí:

<img width="1553" height="701" alt="Dashboard" src="https://github.com/user-attachments/assets/974fded0-5304-4e49-bae5-c966722182d1" />

**[🔗 Ver Dashboard en Tableau Public](https://public.tableau.com/app/profile/rbdp/viz/Covid-19Dashboard_17728266476620/Dashboard1)**


### Hallazgos del Análisis Visual
A través de las visualizaciones creadas, se identificaron los siguientes patrones:
  1. **Correlación de Letalidad Global:** A nivel mundial, la tasa de mortalidad se estabilizó cerca del **2.1%**. Sin embargo, el dashboard permite observar picos de letalidad en regiones con sistemas de salud saturados durante los primeros meses de 2021.
  2. **Disparidad Geográfica en Infecciones:** El mapa de calor revela que, aunque los países con mayor población absoluta (como India o EE. UU.) tienen los conteos más altos, países con menor población presentan porcentajes de infección per cápita significativamente más agresivos.
  3. **Impacto de la Inmunización:** Al cruzar los datos de vacunación con las muertes, se visualiza una tendencia a la baja en la letalidad en aquellos países que lograron superar el 10% de su población vacunada antes del cierre del análisis (abril 2021).  ERROR
	4. **Dinámica Temporal:** La visualización por fecha muestra cómo los focos de infección migraron de Asia a Europa y posteriormente a América, permitiendo comparar la velocidad de propagación entre continentes.

	
### Estructura del Repositorio
  * _consultas/_: Contiene el script completo de creación, carga y exploración.
  * *datasets/*: Enlace a la fuente original de los datos (Our World in Data).
  * *visuales/*: Enlaces a los dashboards de Tableau.


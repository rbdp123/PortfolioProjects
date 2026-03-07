-- CREACION DE DATABASE

	-- 1. Creación de Tablas
DROP TABLE IF EXISTS covid_deaths;
CREATE TABLE covid_deaths(
	iso_code CHAR(10),
	continent VARCHAR(50),
	location VARCHAR(100),
	`date` VARCHAR(25),
	population BIGINT,
	total_cases BIGINT,
	new_cases BIGINT,
	new_cases_smoothed DECIMAL(15, 4),
	total_deaths BIGINT, 
	new_deaths BIGINT, 
	new_deaths_smoothed DECIMAL(15, 4),
	total_cases_per_million DECIMAL(15, 4),
	new_cases_per_million DECIMAL(15, 4),
	new_cases_smoothed_per_million DECIMAL(15, 4),
	total_deaths_per_million DECIMAL(15, 4),
	new_deaths_per_million DECIMAL(15, 4),
	new_deaths_smoothed_per_million DECIMAL(15, 4),
	reproduction_rate DECIMAL(15, 4),
	icu_patients BIGINT, 
	icu_patients_per_million DECIMAL(15, 4),
	hosp_patients BIGINT,
	hosp_patients_per_million DECIMAL(15, 4),
	weekly_icu_admissions DECIMAL(15, 4),
	weekly_icu_admissions_per_million DECIMAL(15, 4),
	weekly_hosp_admissions DECIMAL(15, 4),
	weekly_hosp_admissions_per_million DECIMAL(15, 4)
);

DROP TABLE IF EXISTS covid_vaccinations;
CREATE TABLE covid_vaccinations(
	iso_code CHAR(10),
	continent VARCHAR(50),
	location VARCHAR(100),
	`date` VARCHAR(25),
	new_tests BIGINT,
	total_tests BIGINT,
	total_tests_per_thousand DECIMAL(15, 4),
	new_tests_per_thousand DECIMAL(15, 4),
	new_tests_smoothed BIGINT,
	new_tests_smoothed_per_thousand	DECIMAL(15, 4),
	positive_rate DECIMAL(15, 4),
	tests_per_case DECIMAL(15, 4),
	tests_units VARCHAR(50),
	total_vaccinations BIGINT,
	people_vaccinated BIGINT,
	people_fully_vaccinated BIGINT,
	new_vaccinations BIGINT,
	new_vaccinations_smoothed BIGINT,
	total_vaccinations_per_hundred DECIMAL(15, 4),
	people_vaccinated_per_hundred DECIMAL(15, 4),
	people_fully_vaccinated_per_hundred DECIMAL(15, 4),
	new_vaccinations_smoothed_per_million BIGINT,
	stringency_index DECIMAL(15, 4),
	population_density DECIMAL(15, 4),
	median_age DECIMAL(15, 4),
	aged_65_older DECIMAL(15, 4),
	aged_70_older DECIMAL(15, 4),
	gdp_per_capita DECIMAL(15, 4),
	extreme_poverty DECIMAL(15, 4),
	cardiovasc_death_rate DECIMAL(15, 4),
	diabetes_prevalence DECIMAL(15, 4),
	female_smokers DECIMAL(15, 4),
	male_smokers DECIMAL(15, 4),
	handwashing_facilities DECIMAL(15, 4),
	hospital_beds_per_thousand DECIMAL(15, 4),
	life_expectancy DECIMAL(15, 4),
	human_development_index DECIMAL(15, 4)
);


	-- 2. Carga de Datos
LOAD DATA LOCAL INFILE '...\\Uploads\\CovidDeaths.csv'
INTO TABLE covid_deaths
CHARACTER SET utf8
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' 
IGNORE 1 ROWS

(	iso_code,
	continent,
	location,
	@`date`,
	@population,
	@total_cases,
	@new_cases,
	@new_cases_smoothed,
	@total_deaths, 
	@new_deaths, 
	@new_deaths_smoothed,
	@total_cases_per_million,
	@new_cases_per_million,
	@new_cases_smoothed_per_million,
	@total_deaths_per_million,
	@new_deaths_per_million,
	@new_deaths_smoothed_per_million,
	@reproduction_rate,
	@icu_patients, 
	@icu_patients_per_million,
	@hosp_patients,
	@hosp_patients_per_million,
	@weekly_icu_admissions,
	@weekly_icu_admissions_per_million,
	@weekly_hosp_admissions,
	@v_weekly_hosp_admissions_per_million)
SET 
	`date` = STR_TO_DATE(@`date`, '%d/%m/%Y'),
	population = NULLIF(@population, ''),
	total_cases = NULLIF(@total_cases, ''),
	new_cases = NULLIF(TRIM(REPLACE(REPLACE(@new_cases, CHAR(160), ''),' ', '')), ''),
	new_cases_smoothed = NULLIF(@new_cases_smoothed, ''),
	total_deaths = NULLIF(@total_deaths, ''),
	new_deaths = NULLIF(@new_deaths, ''),
	new_deaths_smoothed = NULLIF(@new_deaths_smoothed, ''),
	total_cases_per_million = NULLIF(@total_cases_per_million, ''),
	new_cases_per_million = NULLIF(@new_cases_per_million, ''),
	new_cases_smoothed_per_million = NULLIF(@new_cases_smoothed_per_million, ''),
	total_deaths_per_million = NULLIF(@total_deaths_per_million, ''),
	new_deaths_per_million = NULLIF(@new_deaths_per_million, ''),
	new_deaths_smoothed_per_million = NULLIF(@new_deaths_smoothed_per_million, ''),
	reproduction_rate = NULLIF(@reproduction_rate, ''),
	icu_patients = NULLIF(@icu_patients, ''),
	icu_patients_per_million = NULLIF(@icu_patients_per_million, ''),
	hosp_patients = NULLIF(@hosp_patients, ''),
	hosp_patients_per_million = NULLIF(@hosp_patients_per_million, ''),
	weekly_icu_admissions = NULLIF(@weekly_icu_admissions, ''),
	weekly_icu_admissions_per_million = NULLIF(@weekly_icu_admissions_per_million, ''),
	weekly_hosp_admissions = NULLIF(@weekly_hosp_admissions, ''),
	weekly_hosp_admissions_per_million = 
	CASE 
        WHEN @v_weekly_hosp_admissions_per_million REGEXP '[0-9]' THEN TRIM(@v_weekly_hosp_admissions_per_million) ELSE NULL
    END;


LOAD DATA LOCAL INFILE '..\\Uploads\\CovidVaccinations.csv'
INTO TABLE covid_vaccinations
CHARACTER SET utf8
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
	
(	iso_code,
	continent,
	location,
	@`date`,
	@new_tests,
	@total_tests,
	@total_tests_per_thousand,
	@new_tests_per_thousand,
	@new_tests_smoothed,
	@new_tests_smoothed_per_thousand,
	@positive_rate,
	@tests_per_case,
	tests_units,
	@total_vaccinations,
	@people_vaccinated,
	@people_fully_vaccinated,
	@new_vaccinations,
	@new_vaccinations_smoothed,
	@total_vaccinations_per_hundred,
	@people_vaccinated_per_hundred,
	@people_fully_vaccinated_per_hundred,
	@new_vaccinations_smoothed_per_million,
	@stringency_index,
	@population_density,
	@median_age,
	@aged_65_older,
	@aged_70_older,
	@gdp_per_capita,
	@extreme_poverty,
	@cardiovasc_death_rate,
	@diabetes_prevalence,
	@female_smokers,
	@male_smokers,
	@handwashing_facilities,
	@hospital_beds_per_thousand,
	@life_expectancy,
	@human_development_index)
SET 
	`date` = STR_TO_DATE(@`date`, '%d/%m/%Y'),
	new_tests = NULLIF(@new_tests, ''),
	total_tests = NULLIF(@total_tests, ''),
	total_tests_per_thousand = NULLIF(@total_tests_per_thousand, ''),
	new_tests_per_thousand = NULLIF(@new_tests_per_thousan, ''),
	new_tests_smoothed = NULLIF(@new_tests_smoothed, ''),
	new_tests_smoothed_per_thousand = NULLIF(@new_tests_smoothed_per_thousand, ''),
	positive_rate = NULLIF(@positive_rate, ''),
	tests_per_case = NULLIF(@tests_per_case, ''),
	total_vaccinations = NULLIF(@total_vaccinations, ''),
	people_vaccinated = NULLIF(@people_vaccinated, ''),
	people_fully_vaccinated = NULLIF(@people_fully_vaccinated, ''),
	new_vaccinations = NULLIF(@new_vaccinations, ''),
	new_vaccinations_smoothed = NULLIF(@new_vaccinations_smoothed, ''),
	total_vaccinations_per_hundred = NULLIF(@total_vaccinations_per_hundred, ''),
	people_vaccinated_per_hundred = NULLIF(@people_vaccinated_per_hundred, ''),
	people_fully_vaccinated_per_hundred = NULLIF(@people_fully_vaccinated_per_hundred, ''),
	new_vaccinations_smoothed_per_million = NULLIF(@new_vaccinations_smoothed_per_million, ''),
	stringency_index = NULLIF(@stringency_index, ''),
	population_density = NULLIF(@population_density, ''),
	median_age = NULLIF(@median_age, ''),
	aged_65_older = NULLIF(@aged_65_older, ''),
	aged_70_older = NULLIF(@aged_70_older, ''),
	gdp_per_capita = NULLIF(@gdp_per_capita, ''),
	extreme_poverty = NULLIF(@extreme_poverty, ''),
	cardiovasc_death_rate = NULLIF(@cardiovasc_death_rate, ''),
	diabetes_prevalence = NULLIF(@diabetes_prevalence, ''),
	female_smokers = NULLIF(@female_smokers, ''),
	male_smokers = NULLIF(@male_smokers, ''),
	handwashing_facilities = NULLIF(@handwashing_facilities, ''),
	hospital_beds_per_thousand = NULLIF(@hospital_beds_per_thousand, ''),
	life_expectancy = NULLIF(@life_expectancy, ''),
	human_development_index = NULLIF(@human_development_index, '');

ALTER TABLE covid_deaths
MODIFY COLUMN `date` DATE;

DESCRIBE covid_deaths;

ALTER TABLE covid_vaccinations
MODIFY COLUMN `date` DATE;

DESCRIBE covid_vaccinations;


-- EXPLORACIÓN DE DATOS

	-- 1. Seleccionar Data que usaremos
SELECT location, `date`, total_cases, new_cases, total_deaths, population
FROM covid_deaths
WHERE continent IS NOT NULL
ORDER BY 1,2;


		-- Total_cases vs Total_deaths
SELECT location, `date`, total_cases, total_deaths, (total_deaths/total_cases)*100 AS death_percentage
FROM covid_deaths
WHERE continent IS NOT NULL
ORDER BY 1,2;


		-- Muestra  la probabilidad de fallecer luego de ser infectado por el virus, por país.
		-- (Datos mostrados hasta el mes de Abril de 2021)
SELECT cd.location, cd.`date`, cd.total_cases, cd.total_deaths, (total_deaths/total_cases)*100 AS death_percentage
FROM covid_deaths AS cd
INNER JOIN(
		SELECT location, MAX(`date`) as date_
		FROM covid_deaths
		GROUP BY location) as md
	ON cd.location = md.location AND cd.`date` = md.date_
WHERE continent IS NOT NULL
ORDER BY 1;


		-- Porcentaje de la población que contrajo el virus diariamente
SELECT location, `date`, population, total_cases, (total_cases/population)*100 AS case_percentage
FROM covid_deaths
WHERE continent IS NOT NULL
ORDER BY 2;


		-- Qué porcentaje de la poblacion tuvo covid por pais
SELECT location, population, MAX(total_cases) AS Highest_Infection_Count, MAX((total_cases/population))*100 AS Percent_Population_Infected
FROM covid_deaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY Percent_Population_Infected DESC;


		-- Cantidad máxima de fallecidos por País
SELECT location, MAX(total_deaths) AS Total_death_count
FROM covid_deaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY Total_death_count DESC;


/* 
Debido a que en el apartado "location" aparecen continentes, procedo a revisar la tabla en busca de esta irregularidad.
En la tabla, todos los continentes que aparecen en el campo "location", muestran 'vacíos' en el campo "continent".
Procedo a actualizar la información de la tabla cambiando la entrada de vacío ('') por nulo(NULL) para poder filtrarlo en las consultas.
Actualizo tambien las consultas previas con este nuevo filtro.
*/

UPDATE covid_deaths
SET continent = NULL WHERE continent = '';


		-- Cantidad de fallecidos por Continente
SELECT continent, MAX(total_deaths) AS total_death_count
FROM covid_deaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY Total_death_count DESC;

/*
Al notar que los resultados no eran concordantes con cifras públicas, procedo a "acceder" a los datos de los contienentes invirtiendo el filto de "location" 
para que muestre los continentes en este campo.
En la columna "location" aparecen las cifras "Mundiales", de la "Unión Europea" y datos "Internacionales". 
Incluyo estos términos en el filtro para excluirlos de la consulta final.
*/

		-- Cantidad de fallecidos por Continente (actualizado)
SELECT location, MAX(total_deaths) AS total_death_count
FROM covid_deaths
WHERE continent IS NULL
	AND location NOT IN ('World', 'European Union', 'International')
GROUP BY location
ORDER BY Total_death_count DESC;


	-- Porcentaje diario de muertes en base al número de infectados
SELECT `date`, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/SUM(new_cases)*100 death_percentage
FROM covid_deaths
WHERE continent IS NOT NULL
GROUP BY `date`
ORDER BY 1, 2;


	-- Porcentaje de muertes en base al número de infectados
SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, 
		SUM(new_deaths)/SUM(new_cases)*100 death_percentage
FROM covid_deaths
WHERE continent IS NOT NULL
ORDER BY 1, 2;


	-- Unión de Tablas
SELECT *
FROM covid_deaths AS cd
INNER JOIN covid_vaccinations AS cv
	ON cv.location = cv.location AND cv.`date` = cv.`date`;


	-- Comparación de la poblacion total y vacunados diarios por país
SELECT cd.continent, cd.location, cd.`date`, cd.population, cv.new_vaccinations
FROM covid_deaths AS cd
INNER JOIN covid_vaccinations AS cv
	ON cv.location = cv.location AND cv.`date` = cv.`date`
WHERE cd.continent IS NOT NULL;



-- SELECCIÓN DE COLSULTAS PARA LAS VISUALIZACIONES EN TABLEAU

	-- 1. Cifras Globales
SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, 
		SUM(new_deaths)/SUM(new_cases)*100 death_percentage
FROM covid_deaths
WHERE continent IS NOT NULL
ORDER BY 1, 2;

	-- 2. Números de fallecidos por continente
SELECT location, MAX(total_deaths) AS total_death_count
FROM covid_deaths
WHERE continent IS NULL
	AND location NOT IN ('World', 'European Union', 'Internaitonal')
GROUP BY location
ORDER BY total_death_count DESC;

	-- 3. Porcentaje de la población que tuvo covid por país
SELECT location, population, MAX(total_cases) AS Highest_Infection_Count, MAX((total_cases/population))*100 AS Percent_Population_Infected
FROM covid_deaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY Percent_Population_Infected DESC;

	-- 4. Infectados Regionales por Fecha
SELECT location, population,`date`, MAX(total_cases) AS Highest_Infection_Count, 
		MAX((total_cases/population))*100 AS Percent_Population_Infected
FROM covid_deaths
WHERE continent IS NOT NULL
GROUP BY location, population, `date`
ORDER BY Percent_Population_Infected DESC;

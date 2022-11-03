--let's make sure we have named the tables correctly--
--table 1- covid deaths--
SELECT * FROM [Portfolio Project (SQL Data Exploration)]..CovidDeaths;
SELECT * FROM [Portfolio Project (SQL Data Exploration)]..CovidVaccinations;

--table 2 - covid vaccinations--
SELECT Location, Date, Total_cases, New_cases, Total_deaths, Population 
FROM [Portfolio Project (SQL Data Exploration)]..CovidDeaths
ORDER BY location, date;

--comparing total cases to total deaths--
SELECT Location, Date, Total_cases, Total_deaths, (total_deaths/total_cases)*100 AS 'DeathPercentage'
FROM [Portfolio Project (SQL Data Exploration)]..CovidDeaths
ORDER BY location, date;

--knowing the death percentage for specific countries--
SELECT Location, Date, Total_cases, Total_deaths, (total_deaths/total_cases)*100 AS 'DeathPercentage'
FROM [Portfolio Project (SQL Data Exploration)]..CovidDeaths
WHERE location = 'china'
ORDER BY location, date;

--comparing the total cases by the countries population--
SELECT Location, Date, Total_cases, Population, (total_cases/population)*100 AS 'CasePercentage'
FROM [Portfolio Project (SQL Data Exploration)]..CovidDeaths
WHERE location = 'china'
ORDER BY location, date;

--now, let's see what country has the highest number of cases per population--
SELECT Location, Population, MAX(Total_cases) AS 'Highest Number of Cases', MAX(total_cases/population)*100 AS 'Case Percentage to Population'
FROM [Portfolio Project (SQL Data Exploration)]..CovidDeaths
GROUP BY Location, Population
ORDER BY [Case Percentage to Population] DESC;

--To show countries with highest death rate per population
SELECT Location, MAX(CAST(total_deaths AS INT)) AS 'Highest Death Count' 
FROM [Portfolio Project (SQL Data Exploration)]..CovidDeaths
WHERE Continent is NOT NULL
GROUP BY Location
ORDER BY [Highest Death Count] DESC;

--Let's have an analysis by continents--
--where continent is null--
SELECT Location, MAX(CAST(total_deaths AS INT)) AS 'Highest Death Count' 
FROM [Portfolio Project (SQL Data Exploration)]..CovidDeaths
WHERE Continent is NULL
GROUP BY location
ORDER BY [Highest Death Count] DESC;

--where continent is null--
SELECT continent, MAX(CAST(total_deaths AS INT)) AS 'Highest Death Count' 
FROM [Portfolio Project (SQL Data Exploration)]..CovidDeaths
WHERE Continent is NOT NULL
GROUP BY continent
ORDER BY [Highest Death Count] DESC;

--Looking at global numbers now--
SELECT Date, SUM(new_cases) AS 'Total; Cases', SUM(CAST(new_deaths AS INT)) AS 'Total Deaths', SUM(CAST(new_deaths AS INT))/SUM(new_cases)* 100 AS 'Death Percentage'
FROM [Portfolio Project (SQL Data Exploration)]..CovidDeaths
WHERE Continent is NOT NULL
GROUP BY Date
ORDER BY 1,2;

--GLOBAL NUMBERS (without the GROUP BY clause)--
SELECT SUM(new_cases) AS 'Total; Cases', SUM(CAST(new_deaths AS INT)) AS 'Total Deaths', SUM(CAST(new_deaths AS INT))/SUM(new_cases)* 100 AS 'Death Percentage'
FROM [Portfolio Project (SQL Data Exploration)]..CovidDeaths
WHERE Continent is NOT NULL
ORDER BY 1,2;

--Using JOINS function to explore data from both tables--
SELECT * FROM [Portfolio Project (SQL Data Exploration)]..CovidDeaths DEA
JOIN [Portfolio Project (SQL Data Exploration)]..CovidVaccinations VAC
	ON DEA.location = VAC.location
	AND DEA.date = VAC.date;

 --still on JOINS, total population vs total vaccinations--
 SELECT DEA.continent, DEA.location, DEA.date, DEA.population, VAC.new_vaccinations FROM [Portfolio Project (SQL Data Exploration)]..CovidDeaths DEA
JOIN [Portfolio Project (SQL Data Exploration)]..CovidVaccinations VAC
	ON DEA.location = VAC.location
	AND DEA.date = VAC.date
	ORDER BY 2,3;


Select *
From PortFolioProject..CovidDeaths$
Where continent is not null
Order BY 3,4;


--Select *
--From PortFolioProject..CovidVaccinations$
--Order By 3,4;

--Select Data that we are going to be using 

Select Location, date, total_cases, new_cases, total_deaths, Population
From PortFolioProject..CovidDeaths$
Order By 1,2;

-- Looking at Total Cases vs Total Deaths

--Shows Likehood of dying if you contract covid in your country

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases) *100 As 
   PercentagePopulationInfected
From PortFolioProject..CovidDeaths$
Where location Like '%states%'
Order By 1,2;


--Looking at total cases vs Population 
--Shows what percentage of population got covid

Select Location, date, population,  total_cases, (total_cases/population)*100 As DeathPercentage
From PortFolioProject..CovidDeaths$
--Where location Like '%states%'
Order By 1,2;

-- Looking at countries with Highest Infection Rate compared to Population

Select Location, population,  MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 As 
    PercentagePopulationInfecctected
From PortFolioProject..CovidDeaths$
--Where location Like '%states%'
Group BY Location, population
Order By PercentagePopulationInfecctected desc;

--Showing countries with highest death count per population

Select Location, MAX(CAST(total_deaths as int)) as TotalDeathCount
From PortFolioProject..CovidDeaths$
--Where location Like '%states%'
Where continent is not null
Group BY Location
Order By  TotalDeathCount desc;


--Let's Break Things Down By Continent 

Select continent, MAX(CAST(total_deaths as int)) as TotalDeathCount
From PortFolioProject..CovidDeaths$
--Where location Like '%states%'
Where continent is not  null
Group BY continent
Order By  TotalDeathCount desc;


-- Let's Break Things Down By Continent 



--Showing Continents with the highest death count per population

Select continent, MAX(CAST(total_deaths as int)) as TotalDeathCount
From PortFolioProject..CovidDeaths$
--Where location Like '%states%'
Where continent is not  null
Group BY continent
Order By  TotalDeathCount desc;


--Globel Numbers

Select SUM(new_cases) as total_cases,SUM(CAST(new_deaths as int)) as total_deaths, SUM(CAST(new_deaths as int))/SUM
(new_cases)*100 As DeathPercentage
From PortFolioProject..CovidDeaths$
--Where location Like '%states%'
Where continent is not null
--Group by date 
Order By 1,2;

 --lOOKING At Total Population vs Vacination 

Select Dea.continent, Dea.location, Dea.date, Dea.population, Vac.new_vaccinations,
SUM(CONVERT(int,Vac.new_vaccinations)) OVER (Partition By Dea.Location order by dea.location,
dea.Date)
From PortFolioProject..CovidDeaths$ Dea
JOIN PortFolioProject..CovidVaccinations$ Vac
on Dea.location = Vac.location
and Dea.date = Vac.date
WHERE Dea.continent IS NOT NULL
ORDER BY 2,3;


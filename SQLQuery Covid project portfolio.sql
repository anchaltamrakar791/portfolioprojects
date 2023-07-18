use [portfoilo project]




select * from vacination;


select location, date, total_cases, new_cases ,total_deaths, population
FROM CovidDeaths$
order by 1,2


#LOOKING AT TOTAL CASES VS Total Deaths 

select location, date, total_cases,  total_deaths ,(total_deaths/total_cases)*100 as Deathpercentage
from coviddeaths$
where location like '%states%'
order by 1,2;


#3.LOOKING AT TOTAL CASES VS POPULATION 
   shows what percentage of population got covid 
select location, date, population, total_cases,  (total_cases/population)*100 AS Death_percentage
From coviddeaths$
where location like '%states%'
order by 1,2;


#4. LOOKING AT COUNTRIES WITH HIGHEST INFECTION RATE COMPARED TO POPULATION

SELECT location, population, max(total_cases), MAX(total_cases/population)*100 AS percent_population_infected
FROM coviddeaths$
GROUP BY location, population
ORDER BY percent_population_infected desc;



#5. SHOWING COUNTRIES WITH HIGHEST DEATH COUNT PER POPULATION 

SeLECT * FROM CovidDeaths$

  SELECT location,MAX(CAST(total_deaths as int))AS totalDeathcount
  FROM CovidDeaths$
  GROUP BY location 
  ORDER BY totalDeathcount desc


 #. THINGS BREAKDOWN BY CONTINENT
  
  SHOWING CONTINENT WITH HIGHEST DEATH PER POPULATION

  SELECT continent,MAX(CAST(total_deaths as int))AS totalDeathCount
  FROM CovidDeaths$
  WHERE continent is not null 
  GROUP BY continent
  ORDER BY totalDeathCount desc;

 
 
 # GLOBAL NUMBERS 

 SELECT date, SUM(new_cases)as total_cases,SUM(CAST(total_deaths as int))as total_deaths,SUM(CAST(total_deaths as int))/SUM(new_cases)*100 as Deathpercentage 
 FROM CovidDeaths$
 WHERE continent is not null 
 GROUP BY date
 ORDER BY 1,2


 #LOOKING TOTAL_POPULATION VS VACATION

select * from VacinationC;
select * from CovidDeaths$





WITH POPVSVAC(continent, location, date, population, new_vaccinations, Rollingpeoplevaccinated)
AS 
(
select D.continent,D.location, D.date,D.population, V.new_vaccinations,
SUM(CONVERT(int,V.new_vaccinations)) over(partition by D.location order by D.location, D.date) AS Rollingpeoplevaccinated 
FROM CovidDeaths$ D
join VacinationC V
on D.location = V.location
and D.date = V.date 
where D.continent is not null 
)
select *, (Rollingpeoplevaccinated/population)*100  from POPVSVAC



--TEMP TABLE 


DROP Table if exists #percentpopulationvaccianted
CreatTable #percentpopulationvaccianted
(
  continent nvarchar(255),
  location nvarchar(255),
  date datetime,
  population numeric,
  new_vaccinations numeric,
  Rollingpeoplvaccinated numeric
)
Insert into
select D.continent,D.location, D.date,D.population, V.new_vaccinations,
SUM(CONVERT(int,V.new_vaccinations)) over(partition by D.location order by D.location, D.date) AS Rollingpeoplevaccinated 
FROM CovidDeaths$ D
join VacinationC V
on D.location = V.location
and D.date = V.date 
where D.continent is not null 
order by 2,3
select *,(Rollingpeoplevaccinated/population)*100
FROM #percentpopulationvaccinated



-----CREATING VIEW TO STORE DATA FOR LATER VISUALIZATIONS 

create view percentpopulationvaccinated AS
select D.continent,D.location, D.date,D.population, V.new_vaccinations,
SUM(CONVERT(int,V.new_vaccinations)) over(partition by D.location order by D.location, D.date) AS Rollingpeoplevaccinated 
FROM CovidDeaths$ D
join VacinationC V
on D.location = V.location
and D.date = V.date 
where D.continent is not null 
--order by 2,3































Select * from VacinationC;







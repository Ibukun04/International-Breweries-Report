/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [SALES_ID]
      ,[SALES_REP]
      ,[BRANDS]
      ,[QUANTITY]
      ,[PROFIT]
      ,[COUNTRIES]
      ,[YEARS]
  FROM [internationalBreweries].[dbo].[Sheet1]

   --what country generated the highest profit in 2019

 select countries,sum(profit) as sumofprofit,years
  from internationalBreweries..Sheet1
  where years = 2019
  group by countries,years
  order by sum(profit) desc

  --find the year with the highest profit

 select years,sum(profit) as sumofprofit
  from internationalBreweries..Sheet1
  group by years
  order by sum(profit) desc

  --the brand manager wants to know the top 10 brand consumed

 select brands,sum(quantity) as sumofquantitysold
  from internationalBreweries..Sheet1
  group by brands
  order by sum(quantity) desc

  --what are the 5 favorite malt brands in the anglophone countries

 select brands,countries,sum(quantity) as sumofquantityconsumed
  from internationalBreweries..Sheet1
  where  brands like '%malt%' and countries like '%a'
  group by countries,brands
  order by sum(quantity) desc

  --find the country with the highest consumption of beer

 with HighestConsumptionOfBeer As 
  (select countries,brands,sum(quantity) as quantityconsumed
  from internationalBreweries..Sheet1
  where brands <> 'beta malt' and brands <> 'grand malt'
  group by brands,countries
  --order by sum(quantity)
  )
 select countries, sum(quantityconsumed) as sumofquantityconsumed
  from HighestConsumptionOfBeer
  group by countries
  order by sum(quantityconsumed) desc

  --find the top 5 sales personnels

 select top 5 sales_rep,count(quantity) as qtysold
  from internationalBreweries..Sheet1
  group by sales_rep
  order by count(quantity) desc
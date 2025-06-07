
-- create sadc energy table
CREATE TABLE SADC_Energy(
  Country TEXT PRIMARY KEY,
  Population_M NUMERIC NOT NULL,
  Solar_Capacity_MW NUMERIC NOT NULL,
  Renewable_ZESA_Percent NUMERIC NOT NULL,
  Solar_ZESA_Percent NUMERIC NOT NULL,
  Main_Renewable_Source TEXT NOT NULL,
  Depends_on_Renewables TEXT NOT NULL,
  Avg_Temp NUMERIC NOT NULL,
  Exp_Temp_Rise_2050 NUMERIC NOT NULL);

-- insert values into sadc energy table
INSERT INTO SADC_Energy VALUES ('Angola', 36.7, 100, 6, 1.00, 'Hydro', 'Yes', 23.0, 2.75);
INSERT INTO SADC_Energy VALUES ('Botswana', 2.4, 100, 2.5, 1.00, 'Solar/Hydro', 'Partial', 22.5, 2.00);
INSERT INTO SADC_Energy VALUES ('DRC', 102.3, 0, 9.9, 1.00, 'Hydro', 'Yes', 25.0, 2.75);
INSERT INTO SADC_Energy VALUES ('Eswatini', 1.2, 0, 8, 1.00, 'Hydro', 'Yes', 20.5, 2.00);
INSERT INTO SADC_Energy VALUES ('Lesotho', 2.3, 0, 10, 1.00, 'Hydro', 'Yes', 15.0, 2.00);
INSERT INTO SADC_Energy VALUES ('Madagascar', 30.3, 0, 7, 5.00, 'Hydro/Solar', 'Yes', 24.0, 2.50);
INSERT INTO SADC_Energy VALUES ('Malawi', 21.0, 0, 9, 1.00, 'Hydro', 'Yes', 23.5, 2.75);
INSERT INTO SADC_Energy VALUES ('Mauritius', 1.3, 65, 2.2, 3.00, 'Hydro/Solar', 'Partial', 23.5, 1.50);
INSERT INTO SADC_Energy VALUES ('Mozambique', 33.9, 150, 8, 1.00, 'Hydro', 'Yes', 24.0, 2.50);
INSERT INTO SADC_Energy VALUES ('Namibia', 2.7, 530, 7, 5.00, 'Solar', 'Yes', 22.0, 2.50);
INSERT INTO SADC_Energy VALUES ('Seychelles', 0.1, 3.2, 0.5, 2.00, 'Solar', 'Partial', 27.0, 1.50);
INSERT INTO SADC_Energy VALUES ('South Africa', 59.3, 8288, 1.1, 5.00, 'Solar/Wind', 'No', 17.5, 2.00);
INSERT INTO SADC_Energy VALUES ('Tanzania', 67.5, 120, 3.9, 1.00, 'Hydro', 'Partial', 23.0, 2.75);
INSERT INTO SADC_Energy VALUES ('Zambia', 19.5, 1100, 8.5, 1.00, 'Hydro', 'Yes', 21.5, 2.00);
INSERT INTO SADC_Energy VALUES ('Zimbabwe', 16.7, 1575, 3.5, 5.00, 'Hydro/Solar', 'Partial', 22.0, 2.50);

-- order all nations in sadc using  renewable energies from least to most
select country, Renewable_ZESA_Percent from SADC_Energy order by Renewable_ZESA_Percent asc;

-- show the top 3 country with the highest solar electricity concentration 
select country, Solar_ZESA_Percent from SADC_Energy order by Solar_ZESA_Percent desc limit (3);

--  show total amount of people with no solar privately update all rows with zero solar capacity to have the label none then delete rows
select sum (Population_M) as total_pop, country, Solar_Capacity_MW from SADC_Energy group by country having Solar_Capacity_MW = 0 ;

--alter and update table where there is none on solar capacity to zero
ALTER TABLE SADC_Energy ADD Solar_Capacity_Label VARCHAR(10); UPDATE SADC_Energy SET Solar_Capacity_Label = 'none' WHERE Solar_Capacity_MW = 0;

-- delete any values without solar capacity
delete from SADC_Energy where Solar_Capacity_MW = 0;

-- count amount of countries with temp rise of two degrees 
select count (Country) from SADC_Energy where Exp_Temp_Rise_2050 >= 2; 

-- find the mean temp and country with the temperature closest to the mean
SELECT  COUNT(country) AS country_count,  SUM(avg_temp) AS total_temp, SUM(avg_temp) / COUNT(country) AS mean_temp FROM SADC_Energy;
WITH mean_temp AS (SELECT SUM(avg_temp) / COUNT(country) AS mean_temperature FROM SADC_Energy) SELECT country, avg_temp, ABS(avg_temp - (SELECT mean_temperature FROM mean_temp)) AS temp_diff FROM SADC_Energy ORDER BY temp_diff LIMIT 1;


-- find a nation with more than five million people and depend on hydro power
select Country, Population_M, Main_Renewable_Source from SADC_Energy where Population_M > 5 and Main_Renewable_Source like 'Hydro%'; 


-- find if countries with highest population have highest renewable zesa percent
SELECT country, Population_M, Renewable_ZESA_Percent FROM SADC_Energy ORDER BY Population_M DESC, Renewable_ZESA_Percent DESC;

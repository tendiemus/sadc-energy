
-- create sadc hiv table
CREATE TABLE SADC_HIV ( 
  id SERIAL PRIMARY KEY, 
  country TEXT NOT NULL, 
  hiv_percent_2015 NUMERIC(5,3) NOT NULL, 
  hiv_percent_2025 NUMERIC(5,1) NOT NULL, 
  avg_family_size NUMERIC(3,1) NOT NULL, 
  birth_rate_per_1k NUMERIC(4,1) NOT NULL, 
  death_rate_per_1k NUMERIC(4,1) NOT NULL, 
  unemployment_percent NUMERIC(4,1) NOT NULL);

-- insert values into sadc hiv table
INSERT INTO SADC_HIV VALUES (1, 'South Africa', 0.192, 19.0, 3.2, 19.4, 9.3, 32.7);
INSERT INTO SADC_HIV VALUES (2, 'Eswatini', 0.288, 27.4, 3.3, 23.1, 10.2, 22.4);
INSERT INTO SADC_HIV VALUES (3, 'Lesotho', 0.256, 25.0, 3.5, 24.5, 11.0, 24.8);
INSERT INTO SADC_HIV VALUES (4, 'Botswana', 0.253, 24.8, 3.5, 20.8, 8.9, 17.6);
INSERT INTO SADC_HIV VALUES (5, 'Namibia', 0.172, 16.9, 4.1, 25.3, 7.4, 19.9);
INSERT INTO SADC_HIV VALUES (6, 'Zambia', 0.154, 15.1, 5.3, 34.2, 6.1, 12.7);
INSERT INTO SADC_HIV VALUES (7, 'Zimbabwe', 0.147, 14.3, 4.8, 30.5, 8.7, 5.5);
INSERT INTO SADC_HIV VALUES (8, 'Mozambique', 0.136, 13.2, 5.1, 37.9, 9.8, 24.2);
INSERT INTO SADC_HIV VALUES (9, 'Malawi', 0.108, 10.6, 4.6, 33.7, 7.6, 20.4);
INSERT INTO SADC_HIV VALUES (10, 'Angola', 0.020, 2.1, 5.7, 43.7, 8.2, 30.0);
INSERT INTO SADC_HIV VALUES (11, 'Tanzania', 0.048, 4.7, 5.0, 36.5, 6.5, 10.3);
INSERT INTO SADC_HIV VALUES (12, 'DRC', 0.011, 1.2, 6.2, 42.1, 9.0, 46.1);
INSERT INTO SADC_HIV VALUES (13, 'Madagascar', 0.003, 0.3, 4.9, 31.9, 6.8, 1.7);
INSERT INTO SADC_HIV VALUES (14, 'Mauritius', 0.009, 0.9, 3.5, 10.2, 7.1, 6.9);
INSERT INTO SADC_HIV VALUES (15, 'Seychelles', 0.004, 0.4, 3.8, 12.4, 7.0, 4.5);


-- List all the HIV rates in SADC from most to least common
Select country, hiv_percent_2025 from SADC_HIV order by hiv_percent_2025 desc;

--list country with at least two kids and two partners and 10 - 20 percent hiv risk in SADC
select country, avg_family_size, hiv_percent_2025 from SADC_HIV where avg_family_size >= 4 and hiv_percent_2025 < 20 and hiv_percent_2025 > 10;

--calculate the annual rise of HIV/AIDS in the last ten years in each country
SELECT (hiv_percent_2025 - hiv_percent_2015) AS hiv_diff, (hiv_percent_2025 - hiv_percent_2015) / (SELECT COUNT(country) FROM SADC_HIV) AS mean_hiv
FROM SADC_HIV;

select (hiv_percent_2025 - hiv_percent_2015) / (SELECT COUNT(country) FROM SADC_HIV)/10 AS mean_hiv_in_ten_years
FROM SADC_HIV;

--find the average increase in HIV percent between 2015 and 2025
SELECT country, (hiv_percent_2025 - hiv_percent_2015)/ 10 AS ave_hiv from SADC_HIV;

--check if countries with highest hiv have highest birth and death rate show top three and 6,7,8
select country, hiv_percent_2015, hiv_percent_2025, birth_rate_per_1k, death_rate_per_1k from SADC_HIV order by hiv_percent_2025, birth_rate_per_1k, death_rate_per_1k desc limit (3) offset (2);

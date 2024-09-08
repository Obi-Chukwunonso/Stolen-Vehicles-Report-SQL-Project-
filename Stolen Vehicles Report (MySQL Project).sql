-- What day of the week are vehicles most often and least stolen?
-- What types of vehicles are most often and least often stolen? Does this vary by region?
-- What is the average of the vehicles that are stolen? Does this vary based on the vehicle type?
-- Which regions have the most and least number of stolen vehicles? What are the characteristics of the regions?
-- Most color of cars stolen



-- (1) What day of the week are vehicles most often and least stolen?

-- Vehicles are most often stolen on Mondays
SELECT 
    DAYNAME(date_stolen) AS Days,
    COUNT(date_stolen) AS NumofTimes
FROM
    stolen_vehicles_db.stolen_vehicles
GROUP BY Days
ORDER BY NumofTimes DESC;

-- Vehicles are least stolen on Sundays
SELECT 
    DAYNAME(date_stolen) AS Days,
    COUNT(date_stolen) AS NumofTimes
FROM
    stolen_vehicles_db.stolen_vehicles
GROUP BY Days
ORDER BY NumofTimes;



-- (2) What types of vehicles are most often and least often stolen? Does this vary by region?

-- These are the vehicle types most often stolen 
SELECT 
    vehicle_type, COUNT(date_stolen) AS NumStolen
FROM
    stolen_vehicles_db.stolen_vehicles AS A
        LEFT JOIN
    stolen_vehicles_db.locations AS B ON A.location_id = B.location_id
WHERE
    vehicle_type IS NOT NULL
GROUP BY vehicle_type
ORDER BY Numstolen DESC;

-- These are the vehicle types least often stolen 
SELECT 
    vehicle_type, COUNT(date_stolen) AS NumStolen
FROM
    stolen_vehicles_db.stolen_vehicles AS A
        LEFT JOIN
    stolen_vehicles_db.locations AS B ON A.location_id = B.location_id
WHERE
    vehicle_type IS NOT NULL
GROUP BY vehicle_type
ORDER BY Numstolen;


-- The vehicle types stolen varies by region
SELECT 
    vehicle_type, COUNT(date_stolen) AS NumStolen, region
FROM
    stolen_vehicles_db.stolen_vehicles AS A
        LEFT JOIN
    stolen_vehicles_db.locations AS B ON A.location_id = B.location_id
WHERE
    vehicle_type IS NOT NULL
GROUP BY vehicle_type , region
ORDER BY NumStolen DESC;


-- (3) What is the average of the vehicles that are stolen? Does this vary based on the vehicle type?

SELECT 
    vehicle_type, AVG(NumStolen) AS Average
FROM
    (SELECT 
        vehicle_type, COUNT(vehicle_desc) AS NumStolen
    FROM
        stolen_vehicles
    WHERE
        vehicle_type IS NOT NULL
    GROUP BY vehicle_type) AS A1
GROUP BY vehicle_type
ORDER BY Average DESC;

-- (4) Which regions have the most and least number of stolen vehicles? What are the characteristics of the regions?
-- Most stolen vehicles in the regions
SELECT 
    region,
    country,
    population,
    density,
    COUNT(region) AS NumStolen
FROM
    stolen_vehicles AS A
        LEFT JOIN
    locations AS B ON A.location_id = B.location_id
WHERE
    vehicle_desc IS NOT NULL
GROUP BY region , country , population , density
ORDER BY NumStolen DESC;

-- Least stolen vehicles in the regions
SELECT 
    region,
    country,
    population,
    density,
    COUNT(region) AS NumStolen
FROM
    stolen_vehicles AS A
        LEFT JOIN
    locations AS B ON A.location_id = B.location_id
WHERE
    vehicle_desc IS NOT NULL
GROUP BY region , country , population , density
ORDER BY NumStolen;


SELECT 
    make_name,
    vehicle_type,
    make_type,
    color,
    region,
    country,
    population,
    density,
    COUNT(region) AS NumStolen
FROM
    locations AS A
        LEFT JOIN
    stolen_vehicles AS B ON A.location_id = B.location_id
        LEFT JOIN
    make_details AS C ON B.make_id = C.make_id
WHERE
    vehicle_type IS NOT NULL
GROUP BY make_name , vehicle_type , make_type , color , region , country , population , density
ORDER BY NumStolen DESC;

-- (5) Most color of cars stolen
SELECT 
    color, COUNT(color) AS NumStolen
FROM
    stolen_vehicles
WHERE
    color IS NOT NULL
GROUP BY color
ORDER BY NumStolen DESC;
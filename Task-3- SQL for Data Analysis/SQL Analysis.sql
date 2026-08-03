SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';
create database ecommerce_db;
use ecommerce_db;


CREATE TABLE shipping_data (
    ID INT,
    Warehouse_block VARCHAR(10),
    Mode_of_Shipment VARCHAR(30),
    Customer_care_calls INT,
    Customer_rating INT,
    Cost_of_the_Product INT,
    Prior_purchases INT,
    Product_importance VARCHAR(20),
    Gender VARCHAR(10),
    Discount_offered INT,
    Weight_in_gms INT,
    Reached_on_Time_Y_N INT
);
 
load data local infile "C:\\Users\\EcommerceData.csv"
into table shipping_data
fields terminated by ','
enclosed  by '"'
lines terminated by '\n'
ignore 1 rows;

select* from shipping_data ;

-- Checking for Duplicates Values:
Select ID, count(*)
from shipping_data 
group by ID
having count(*)>1;


SELECT Warehouse_block, COUNT(*) AS BlockCount
FROM shipping_data 
GROUP BY Warehouse_block
ORDER BY BlockCount DESC;


SELECT Mode_of_Shipment, COUNT(*) AS ShipmentCount
FROM shipping_data 
GROUP BY Mode_of_Shipment
ORDER BY ShipmentCount DESC;



SELECT Customer_rating, COUNT(*) AS RatingCount
FROM shipping_data 
GROUP BY Customer_rating
ORDER BY Customer_rating;



SELECT Product_importance, COUNT(*) AS ImportanceCount
FROM shipping_data 
GROUP BY Product_importance
ORDER BY ImportanceCount DESC;

 

SELECT Gender, COUNT(*) AS GenderCount
FROM shipping_data 
GROUP BY Gender;

SELECT Reached_on_Time_Y_N, COUNT(*) AS DeliveryCount
FROM shipping_data 
GROUP BY Reached_on_Time_Y_N;

SELECT 
    Reached_on_Time_Y_N,
    AVG(Discount_offered) AS AvgDiscount,
    AVG(Cost_of_the_Product) AS AvgCost,
    AVG(Weight_in_gms) AS AvgWeight
FROM shipping_data 
GROUP BY Reached_on_Time_Y_N;


SELECT 
    Warehouse_block,
    AVG(Customer_rating) AS AvgRating
FROM shipping_data 
GROUP BY Warehouse_block
ORDER BY AvgRating DESC;


SELECT 
    Mode_of_Shipment, 
    SUM(CASE WHEN Reached_on_Time_Y_N = 'Y' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DelayPercentage
FROM shipping_data 
GROUP BY Mode_of_Shipment
ORDER BY DelayPercentage DESC;
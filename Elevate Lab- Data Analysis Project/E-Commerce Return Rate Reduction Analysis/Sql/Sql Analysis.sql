use ecommerce;


DROP TABLE IF EXISTS data;
drop table data;
 CREATE TABLE data (
    Order_ID VARCHAR(10) NOT NULL PRIMARY KEY,
    Product_ID VARCHAR(10) NOT NULL,
    User_ID VARCHAR(10) NOT NULL,
    Order_Date DATE NOT NULL,
    
    Product_Category VARCHAR(30) NOT NULL,
    
    Product_Price DECIMAL(10,2) NOT NULL,
    
    Order_Quantity INT NOT NULL,
    
    Discount_Applied DECIMAL(5,2) NOT NULL
        CHECK (Discount_Applied >= 0 AND Discount_Applied <= 100),
    
    Shipping_Method VARCHAR(15) NOT NULL,
    Payment_Method VARCHAR(20) NOT NULL,
    
    User_Age INT NOT NULL,
    
    User_Gender VARCHAR(10) NOT NULL
        CHECK (User_Gender IN ('Male', 'Female', 'Other')),
    
    User_Location VARCHAR(20) NOT NULL,
    
    Return_Status VARCHAR(20) NOT NULL
        CHECK (Return_Status IN ('Returned', 'Not Returned')),
    
    Return_Reason VARCHAR(20) NOT NULL,
    
    Days_to_Return INT NOT NULL,
    
    Order_Value DECIMAL(12,6) NOT NULL,
    
    Return_Cost DECIMAL(10,2) NOT NULL,
    
    Profit_Loss DECIMAL(12,6) NOT NULL,
    
    CO2_Emissions DECIMAL(10,2) NOT NULL,
    
    Packaging_Waste DECIMAL(10,2) NOT NULL,
    
    CO2_Saved DECIMAL(10,2) NOT NULL,
       
    
    Waste_Avoided DECIMAL(10,2) NOT NULL
        
);



LOAD DATA LOCAL INFILE 'C:/Users/Ghansham Belekar/Downloads/returns_sustainability_dataset.csv'
INTO TABLE data
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from data;





SELECT * 
FROM data
LIMIT 10;

DESCRIBE data;


-- Calculate Overall Return Rate
SELECT 
    COUNT(*) AS Total_Orders,
    
    SUM(CASE 
        WHEN Return_Status = 'Returned' THEN 1 
        ELSE 0 
    END) AS Returned_Orders,
    
    ROUND(
        SUM(CASE 
            WHEN Return_Status = 'Returned' THEN 1 
            ELSE 0 
        END) * 100.0 / COUNT(*),
        2
    ) AS Return_Rate_Percentage
FROM data;



-- Return Rate by Product Category
SELECT 
    Product_Category,
    COUNT(*) AS Total_Orders,
    
    SUM(CASE 
        WHEN Return_Status = 'Returned' THEN 1 
        ELSE 0 
    END) AS Returned_Orders,
    
    ROUND(
        SUM(CASE 
            WHEN Return_Status = 'Returned' THEN 1 
            ELSE 0 
        END) * 100.0 / COUNT(*),
        2
    ) AS Return_Rate
FROM data
GROUP BY Product_Category
ORDER BY Return_Rate DESC;

-- Return Count and Return Rate by Product
SELECT 
    Product_ID,
    Product_Category,

    COUNT(*) AS Total_Orders,

    SUM(
        CASE 
            WHEN Return_Status = 'Returned' THEN 1
            ELSE 0
        END
    ) AS Returned_Orders,

    ROUND(
        SUM(
            CASE 
                WHEN Return_Status = 'Returned' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS Return_Rate

FROM data

GROUP BY Product_ID, Product_Category

HAVING COUNT(*) >= 1

ORDER BY Return_Rate DESC;


-- Top 10 High-Risk Products
SELECT 
    Product_ID,
    Product_Category,

    COUNT(*) AS Total_Orders,

    SUM(
        CASE 
            WHEN Return_Status = 'Returned' THEN 1
            ELSE 0
        END
    ) AS Returned_Orders,

    ROUND(
        SUM(
            CASE 
                WHEN Return_Status = 'Returned' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS Return_Rate

FROM data

GROUP BY Product_ID, Product_Category

HAVING COUNT(*) >= 3

ORDER BY Return_Rate DESC

LIMIT 10;



-- Return Reasons
SELECT 
    Return_Reason,

    COUNT(*) AS Return_Count,

    ROUND(
        COUNT(*) * 100.0 /
        (
            SELECT COUNT(*)
            FROM `data`
            WHERE Return_Status = 'Returned'
        ),
        2
    ) AS Return_Percentage

FROM data

WHERE Return_Status = 'Returned'

GROUP BY Return_Reason

ORDER BY Return_Count DESC;


-- Top 10 High-Risk Locations
SELECT 
    User_Location,

    COUNT(*) AS Total_Orders,

    SUM(
        CASE 
            WHEN Return_Status = 'Returned' THEN 1
            ELSE 0
        END
    ) AS Returned_Orders,

    ROUND(
        SUM(
            CASE 
                WHEN Return_Status = 'Returned' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS Return_Rate

FROM data

GROUP BY User_Location

HAVING COUNT(*) >= 5

ORDER BY Return_Rate DESC

LIMIT 10;




-- Return Rate by Shipping Type
SELECT 
   Shipping_Method,

    COUNT(*) AS Total_Orders,

    SUM(
        CASE 
            WHEN Return_Status = 'Returned' THEN 1
            ELSE 0
        END
    ) AS Returned_Orders,

    ROUND(
        SUM(
            CASE 
                WHEN Return_Status = 'Returned' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS Return_Rate

FROM data

GROUP BY Shipping_Method

ORDER BY Return_Rate DESC;



-- Return Rate by Payment Method
SELECT 
    Payment_Method,

    COUNT(*) AS Total_Orders,

    SUM(
        CASE 
            WHEN Return_Status = 'Returned' THEN 1
            ELSE 0
        END
    ) AS Returned_Orders,

    ROUND(
        SUM(
            CASE 
                WHEN Return_Status = 'Returned' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS Return_Rate

FROM data

GROUP BY Payment_Method

ORDER BY Return_Rate DESC;


-- Profit/Loss Due to Returns
SELECT 
    Return_Status,

    ROUND(
        SUM(Profit_Loss),
        2
    ) AS Total_Profit_Loss,

    ROUND(
        AVG(Profit_Loss),
        2
    ) AS Average_Profit_Loss

FROM data

GROUP BY Return_Status;


-- Category-wise Profit Loss
SELECT 
    Product_Category,

    ROUND(SUM(Profit_Loss), 2) AS Total_Profit_Loss,

    SUM(
        CASE 
            WHEN Return_Status = 'Returned' THEN 1
            ELSE 0
        END
    ) AS Returned_Orders

FROM `data`

GROUP BY Product_Category

ORDER BY Total_Profit_Loss ASC;

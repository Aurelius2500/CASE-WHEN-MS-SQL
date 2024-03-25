-- Database Basics: The CASE WHEN Clause

-- In this video, we will be exploring the Houses table that we have been using in previous videos
-- In addition, we will be exploring the CASE WHEN clause and why it is useful

CREATE TABLE Houses (
Owner_ID VARCHAR(100),
Street VARCHAR(200),
[State] VARCHAR(200),
Price INT,
Price_Date DATE,
Years_since_construction INT,
Downpayment INT,
Years_since_renovation INT
);

INSERT INTO Houses (Owner_ID, Street, [State], Price, Price_Date, Years_since_construction, Downpayment, Years_since_renovation)
VALUES ('1', '240 Main Street', 'CA', 1900000, '2019-01-01', 18, 4000, 5), 
('1', '140 Maple Street', 'GA', 1300000, '2021-01-01', 5, 5000, NULL),
('2', '555 New Way', 'TX', 1100000, '2017-01-01', 12, 5400, 6),
('2', '14 Paradise Street', 'MO', 700000, '2020-01-01', 30, 21000, 6),
('4', '123 School Street', 'MI', 400000, '2019-01-01', 18, 67000, 8),
('1', '70 Smith Way', 'VA', 1500000, '2012-07-10', 12, 10000, 8),
('2', '230 Valley Way', 'TX', 1200000, '2007-02-08', 2, 56000, NULL),
('1', '23 King Drive', 'CA', 3300000, '2022-04-08', 5, 54000, NULL),
('3', '12 Felicity Way', 'RI', 2200000, '2017-04-12', 1, 56000, NULL),
('2', '34 Hollow Drive', 'FL', 1950000, '2019-05-29', 2, 34000, NULL),
('2', '345 Forest Drive', 'FL', 1900000, '2020-05-29', 2, 43000, NULL),
(NULL, '123 Rock Drive', 'MO', 1000000, '2016-03-29', 12, 65000, 6),
('3', '167 Maple Street', 'AL', 800000, '2012-01-01', 20, 3000, 2),
('1', '1346 Main Street', 'KS', 1200000, '2020-01-01', 21, 15000, 8),
('5', '1347 Main Street', 'AL', 1100000, '2023-01-01', 21, 15000, 8);

-- Now we have the following columns
-- Street is the address of the house
-- State is the U.S State in which the house is located
-- Price is the current listed price of the house
-- Price_Date is when the price was retrieved
-- Years_since_construction is how many years have passed since the house was built
-- Downpayment is the amount of money put when the house was bought
-- Years_since_renovation is how many years it has been since the house was renovated, if it was, if not, it is null

-- CASE WHEN is mostly used to create a derived column based on other conditions
SELECT *, 
CASE WHEN Owner_ID IS NULL
THEN 'No Owner on File'
ELSE 'Owner is registered'
END AS Owner_Flag
FROM Houses

-- This may seem like a simple expression. However, we can expand on it and making it more complicated
-- For example, let's do a flag that tells us if any column is null
SELECT *,
CASE WHEN Owner_ID IS NULL
OR Street IS NULL
OR State IS NULL
OR Price IS NULL
OR Price_Date IS NULL
OR Years_since_construction IS NULL 
OR Downpayment IS NULL
OR Years_since_renovation is NULL
THEN 'Missing Information'
ELSE 'No Missing Information'
END AS Null_Flag
FROM Houses

-- At its core, CASE WHEN is nothing more than a series of if-else statements executed in order, giving us a lot of flexibility
-- Let's say that we want to create a new column that first tells us if the house is in California, then if it is affordable, and then if it is new
-- Affordable will be determined at the arbitrary point of 700000
-- New will be considered if it was built or renovated in the last six years
SELECT *,
CASE WHEN State IN ('CA')
THEN 'California House'
WHEN Price <= 700000
THEN 'Affordable House'
WHEN Years_since_construction <= 6 OR Years_since_renovation <= 6 
THEN 'New House'
ELSE 'Other Houses'
END AS House_Flag
FROM Houses

-- The last part is that CASE WHEN can not only be used on the SELECT clause, but also in the WHERE and ORDER BY clauses
-- We can use it in the WHERE clause to filter by a specific, more complicated condition, such as the house flag above
-- We do not need to return it in the SELECT Clause, but we will here for demonstration purposes
SELECT *,
CASE WHEN State IN ('CA')
THEN 'California House'
WHEN Price <= 700000
THEN 'Affordable House'
WHEN Years_since_construction <= 6 OR Years_since_renovation <= 6 
THEN 'New House'
ELSE 'Other Houses'
END AS House_Flag
FROM Houses
WHERE 
	(CASE WHEN State IN ('CA')
	THEN 'California House'
	WHEN Price <= 700000
	THEN 'Affordable House'
	WHEN Years_since_construction <= 6 OR Years_since_renovation <= 6 
	THEN 'New House'
	ELSE 'Other Houses'
	END = 'Other Houses')

-- Using ORDER BY, we can give priority to the records without nulls, though there are other ways to do this as well
SELECT *,
CASE WHEN Owner_ID IS NULL
OR Street IS NULL
OR State IS NULL
OR Price IS NULL
OR Price_Date IS NULL
OR Years_since_construction IS NULL 
OR Downpayment IS NULL
OR Years_since_renovation is NULL
THEN 'Missing Information'
ELSE 'No Missing Information'
END AS Null_Flag
FROM Houses
ORDER BY 

	(CASE WHEN Owner_ID IS NULL
	OR Street IS NULL
	OR State IS NULL
	OR Price IS NULL
	OR Price_Date IS NULL
	OR Years_since_construction IS NULL 
	OR Downpayment IS NULL
	OR Years_since_renovation is NULL
	THEN 'Missing Information'
	ELSE 'No Missing Information'
	END) DESC

-- The last operation that we want to perform if we will not use the tables anymore is drop them
DROP TABLE Houses;
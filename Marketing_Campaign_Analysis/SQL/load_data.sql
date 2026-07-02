
LOAD DATA LOCAL INFILE '../data/cleaned_marketing_data.csv'
INTO TABLE marketing_customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

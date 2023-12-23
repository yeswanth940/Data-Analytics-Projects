-- question 1
CREATE SCHEMA ecommerce;
-- question 3
USE ecommerce;
DESC users_data;
-- question 4
SELECT * FROM users_data LIMIT 100;
-- question 5
SELECT COUNT(DISTINCT country) country,COUNT(DISTINCT language) language FROM users_data;
-- question 6
SELECT gender,SUM(socialNbFollowers) FROM users_data GROUP BY gender;
-- question 7
SELECT COUNT(hasprofilePicture) FROM users_data WHERE hasprofilePicture = 'True';
SELECT COUNT(hasAnyapp) FROM users_data WHERE hasAnyapp = 'True';
SELECT COUNT(hasAndroidApp) FROM users_data WHERE hasAndroidApp = 'True';
SELECT COUNT(hasIosApp) FROM users_data WHERE hasIosApp = 'True';
-- question 8
SELECT  country,SUM(productsBought) Total_number_of_buyers FROM users_data WHERE productsBought >0 GROUP BY country ORDER BY SUM(productsBought) DESC;
-- question 9
SELECT  country,SUM(productsSold) Total_number_of_sellers FROM users_data WHERE productsSold >0 GROUP BY country ORDER BY SUM(productsSold) ASC;
-- question 10
SELECT country,SUM(productsPassRate) Total_number_of_PassRate FROM users_data WHERE productsPassRate >0 GROUP BY country ORDER BY SUM(productsPassRate) DESC LIMIT 10;
-- question 11
SELECT language,COUNT(language) Total_number_of_users_languagechosed FROM users_data GROUP BY language;
-- question 12
SELECT "productsWished" as "Female",COUNT(productsWished) FROM users_data WHERE gender = 'F'AND productsWished > 0
UNION 
SELECT "socialProductsLiked",COUNT(socialProductsLiked) FROM users_data WHERE gender ='F' AND socialProductsLiked >0;
-- question 13
SELECT "productsSold" as "Male",COUNT(productsSold) FROM users_data WHERE gender = 'M' AND productsSold > 0 
UNION 
SELECT "productsBought" ,COUNT(productsBought) FROM users_data WHERE gender = 'M' AND productsBought > 0;
-- question 14
SELECT  country,SUM(productsBought) Total_number_of_buyers FROM users_data WHERE productsBought >0 GROUP BY country ORDER BY SUM(productsBought) DESC LIMIT 1;
-- question 15
SELECT country,SUM(productsSold) FROM users_data WHERE productsSold >=0 GROUP BY country  ORDER BY SUM(productsSold) ASC LIMIT 10;
-- question 16
SELECT identifierHash,daysSinceLastLogin FROM users_data ORDER BY daysSinceLastLogin ASC LIMIT 110;
-- question 17
SELECT COUNT(gender) FROM users_data WHERE gender = 'F' AND daysSinceLastLogin > 100;
-- question 18
SELECT country,COUNT(gender) FROM users_data WHERE gender = 'F' GROUP BY country;
-- question 19
SELECT country,COUNT(gender) FROM users_data WHERE gender = 'M' GROUP BY country;
-- question 20
SELECT country,AVG(productsSold),AVG(productsBought) FROM users_data WHERE gender = 'M' GROUP BY country;
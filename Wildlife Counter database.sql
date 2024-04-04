-- SCENARIO OF USE --
-- I have designed a database for a wildlife charity so that their volunteers can record local wildlife sightings.

-- The database stores:
-- Volunteers table (ID (auto-increment), first_name, surname, email address, registration date)
-- Recordings table (record number (auto-increment), volunteer ID, recording date, city, county)
-- 3 tables to store counts for three main wildlife categories: Birds, Butterflies and Other insects (species, count, date of count, habitat type, notes about the species)

-- The Recordings table contains the 'volunteer_ID' as a foreign key from the Volunteers table so the charity can see which volunteers enter the most/least recordings and when, and where the volunteers are based. 
-- The 3 species tables all store the 'record_no' from the Recordings table as a foreign key, so the charity can see which locations enter the most/least recordings. 

-- I've written queries to enable volunteers to add new records and counts, as well as to update previous counts, such as adding notes or changing the date of a previous count. 
-- I've used aggregate functions such as SUM, COUNT, MAX and AVG to allow the charity to manipulate and retrieve data. 
-- I've used joins and queries to help the charity understand how many volunteers have not added records and retrieve the volunteers’ details so they can send email prompts. 
-- I’ve written queries to delete data, for example so the charity can delete duplicate volunteers, or to enable volunteers to delete information from previous records.
-- I’ve created a stored procedure to enable the charity to add new volunteers to the database.
-- I’ve created a view to analyse which habitats are most popular with species a certain times of the year


-- I HAVE DROPPED THE DATABASE AND THE CODE BELOW IS NOW READY TO RUN IN ONE GO! -- 
-- 3 QUERIES HAVE LINES OF CODE COMMENTED OUT TO ALLOW YOU TO TEST THEM (CREATE VIEW, DELETED DUPLICATE ENTRY, TITLECASE VOLUNTEER NAMES)



-- CREATE DATABASE CALLED 'WILDLIFE_COUNT' --
CREATE DATABASE wildlife_count;
USE wildlife_count;

-- CREATE 5 TABLES IN THE DATABASE AND INSERT DATA --
-- ADD PRIMARY KEYS TO 'VOLUNTEERS' AND 'RECORDINGS' TABLES --

CREATE TABLE volunteers
(volunteer_id INT PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT, 
first_name VARCHAR(50), 
surname VARCHAR(50), 
email_address VARCHAR(200) NOT NULL, 
registration_date TIMESTAMP NOT NULL);

INSERT INTO volunteers
(first_name, surname, email_address, registration_date)
VALUES 
('John', 'Doe', 'johndoe@hotmail.com', '2019-06-20 14:45:00'),
('Aisha', 'Patel', 'apatel1980@gmail.com', '2021-08-02 09:30:00'),
('Miguel', 'Gonzalez', 'miguel.gonzalez@example.com', '2021-04-18 12:20:00'),
('Emily', 'Smith', 'emilysmith@email.com', '2021-07-15 08:10:00'),
('Michael', 'Johnson', 'm.johnson@outlook.com', '2020-10-25 16:55:00'),
('Sophia', 'Brown', 'sophiabrown@example.com', '2022-01-30 11:25:00'),
('Ethan', 'Williams', 'ethanwilliams@email.com', '2020-02-14 13:40:00'),
('Isabella', 'Jones', 'isabellajones@example.com', '2020-07-01 10:20:00'),
('Alexander', 'Martinez', 'alex.martinez@gmail.com', '2020-11-27 15:15:00'),
('Olivia', 'Taylor', 'oliviataylor@email.com', '2023-02-05 07:55:00'),
('William', 'Anderson', 'wanderson@example.com', '2021-06-30 09:05:00'),
('Emma', 'Hernandez', 'emma.h@example.com', '2021-10-30 16:35:00'),
('James', 'Lopez', 'james.lopez@example.com', '2022-06-20 14:00:00'),
('Charlotte', 'Garcia', 'cgarcia@email.com', '2020-03-08 11:50:00'),
('Benjamin', 'Wilson', 'ben_wilson@example.com', '2022-12-10 13:30:00'),
('Amelia', 'Young', 'ameliayoung@email.com', '2022-03-25 08:45:00'),
('Ben', 'Scott', 'lucasscott@example.com', '2021-11-25 09:50:00'),
('Mia', 'Nguyen', 'mia.nguyen@example.com', '2020-08-10 15:05:00'),
('Henry', 'Brown', 'hbrown@example.com', '2022-04-15 07:20:00'),
('Evelyn', 'Gonzalez', 'evelyn.g@example.com', '2023-06-18 10:00:00'),
('Liam', 'Rodriguez', 'liam_rodriguez@email.com', '2021-12-29 12:25:00'),
('Harper', 'Lewis', 'harper_lewis@example.com', '2020-05-20 14:15:00'),
('Elijah', 'Walker', 'elijah_w@example.com', '2021-02-15 08:30:00'),
('Avery', 'Hall', 'avery.hall@example.com', '2022-09-25 11:10:00'),
('Sofia', 'Allen', 'sofia_allen@email.com', '2021-10-10 10:35:00'),
('Jackson', 'King', 'jackson.king@example.com', '2019-11-29 12:00:00'),
('Aria', 'Wright', 'aria.wright@example.com', '2021-04-20 14:40:00'),
('Logan', 'Hill', 'lhill@example.com', '2023-11-05 16:20:00'),
('Ella', 'Adams', 'ella.adams@example.com', '2021-09-10 07:35:00'),
('Lucas', 'Baker', 'lucasbaker@email.com', '2022-09-05 09:20:00'),
('Craig', 'David', 'CDUK@music.com', '2023-12-25 12:20:00');

CREATE TABLE recordings
(record_no INT PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
volunteer_id INT NOT NULL, 
recording_date TIMESTAMP NOT NULL,
city VARCHAR(50), 
county VARCHAR(50));

INSERT INTO recordings
(volunteer_id, recording_date, city, county)
VALUES
(1, '2024-01-05 17:30:05', 'Manchester', 'Greater Manchester'),
(2, '2024-02-15 17:30:05', 'Bristol', 'Bristol'),
(3, '2023-11-14 17:30:05', 'London', 'Greater London'),
(4, '2019-12-10 09:00:00', 'Leeds', 'West Yorkshire'),
(5, '2021-05-03 08:40:00', 'Glasgow', 'Glasgow City'),
(5, '2022-11-20 14:30:00', 'Glasgow', 'Glasgow City'),
(6, '2022-03-16 11:10:00', 'Glasgow', 'Glasgow City'),
(1, '2022-10-19 06:00:00', 'Manchester', 'Greater Manchester'),
(7, '2023-09-01 07:30:00', 'Edinburgh', 'City of Edinburgh'),
(8, '2021-01-18 10:45:00', 'Liverpool', 'Merseyside'),
(9, '2022-06-21 05:30:00', 'Newcastle', 'Tyne and Wear'),
(10, '2023-04-29 13:20:00', 'Belfast', 'Belfast'),
(11, '2021-02-28 10:15:00', 'Leicester', 'Leicestershire'),
(12, '2022-05-20 15:00:00', 'York', 'North Yorkshire'),
(13, '2021-10-10 08:50:00', 'Brighton', 'East Sussex'),
(13, '2022-08-07 11:10:00', 'Brighton', 'East Sussex'),
(14, '2021-03-28 09:00:00', 'Oxford', 'Oxfordshire'),
(15, '2023-11-22 10:30:00', 'Cambridge', 'Cambridgeshire'),
(16, '2021-07-14 07:40:00', 'Southampton', 'Hampshire'),
(16, '2022-12-25 16:20:00', 'Southampton', 'Hampshire'),
(17, '2023-02-08 06:50:00', 'Swansea', 'Swansea'),
(18, '2022-10-05 11:50:00', 'Aberdeen', 'Aberdeen City'),
(19, '2023-05-11 10:30:00', 'Dundee', 'Dundee City'),
(20, '2021-07-06 12:20:00', 'Plymouth', 'Devon'),
(20, '2022-09-19 13:00:00', 'Plymouth', 'Devon'),
(1, '2023-03-06 09:15:00', 'Manchester', 'Greater Manchester'),
(2, '2021-01-29 14:30:00', 'Bristol', 'Bristol'),
(4, '2022-04-10 11:40:00', 'Leeds', 'West Yorkshire'),
(8, '2023-07-29 12:10:00', 'Liverpool', 'Merseyside'),
(8, '2021-11-13 10:50:00', 'Liverpool', 'Merseyside');

CREATE TABLE birds
(record_no INT NOT NULL,
bird_species VARCHAR(200), 
bird_count INT, 
date_of_count DATE,
habitat_type VARCHAR (200),
notes VARCHAR(400));

INSERT INTO birds
VALUES
(1, 'robin', 2, 20210810, 'woodland', 'Building a nest in the garden bush'),
(2, 'sparrow', 8, 20220930, 'woodland', NULL),
(3, 'blackbird', 3, 20231102, 'park', 'Feeding on fallen berries in the park'),
(4, 'starling', 15, 20231025, 'city', 'Flying in murmuration over the city'),
(5, 'wood pigeon', 6, 20240128, 'coastal', NULL),
(6, 'goldfinch', 4, 20240310, 'park', 'Visiting the bird feeder regularly'),
(7, 'chaffinch', 1, 20240215, 'park', NULL),
(8, 'greenfinch', 2, 20240120, 'garden', 'Nesting in the ivy-covered tree'),
(9, 'collared dove', 2, 20240305, 'garden', NULL),
(10, 'long-tailed tit', 6, 20220818, 'city', 'Gathering nesting material from the hedgerow'),
(11, 'great tit', 3, 20210805, 'city', NULL),
(12, 'magpie', 2, 20240312, 'park', 'Collecting shiny objects for its nest'),
(13, 'greenfinch', 1, 20240131, 'city', NULL),
(14, 'jay', 1, 20230422, 'park', NULL),
(15, 'wood pigeon', 4, 20200508, 'city', 'Feeding on seeds in the city square'),
(16, 'kestrel', 2, 20200614, 'marsh', NULL),
(17, 'house sparrow', 7, 20230629, 'coastal', NULL),
(18, 'jay', 3, 20220820, 'park', 'Squawking loudly in the park'),
(19, 'swift', 2, 20231204, 'woodland', NULL),
(20, 'rook', 1, 20230725, 'woodland', 'Nesting in the tall trees'),
(21, 'kestrel', 1, 20230708, 'wasteland', NULL),
(22, 'buzzard', 1, 20220601, 'fen', NULL),
(23, 'heron', 10, 20210927, 'coastal', 'Scavenging for food on the beach'),
(24, 'heron', 1, 20230512, 'park', 'Standing motionless by the pond'),
(25, 'kingfisher', 1, 20210407, 'city', 'Diving for fish in the river'),
(26, 'peregrine falcon', 1, 20210303, 'woodland', 'Perched on a high tree'),
(27, 'blue tit', 1, 20240124, 'river', NULL),
(28, 'blue tit', 2, 20240217, 'river', NULL),
(29, 'tufted duck', 3, 20240306, 'river', NULL),
(30, 'goldfinch', 2, 20240311, 'coastal', NULL);

CREATE TABLE butterflies
(record_no INT NOT NULL,
butterfly_species VARCHAR(200), 
butterfly_count INT, 
date_of_count DATE,
habitat_type VARCHAR (200),
notes VARCHAR(400));

INSERT INTO butterflies
VALUES
(1, 'Peacock', 5, 20240810, 'woodland', 'Basking in the sunlight on a flower bed'),
(2, 'Small Tortoiseshell', 3, 20240330, 'coastal', NULL),
(3, 'Red Admiral', 2, 20240302, 'park', 'Nectaring on buddleia bushes in the garden'),
(4, 'Brimstone', 1, 20240225, 'garden', NULL),
(9, 'Holly Blue', 4, 20240528, 'marsh', 'Fluttering around holly trees'),
(11, 'Orange Tip', 6, 20240610, 'park', NULL),
(12, 'Ringlet', 2, 20240615, 'woodland', NULL),
(13, 'Meadow Brown', 7, 20240920, 'heath', 'Grazing on wildflowers in the meadow'),
(13, 'Red Admiral', 3, 20240505, 'woodland', NULL),
(20, 'Large White', 6, 20240218, 'city', 'Laying eggs on cabbage leaves in the allotment'),
(21, 'Small White', 3, 20241005, 'garden', NULL),
(22, 'Painted Lady', 1, 20241112, 'park', NULL),
(23, 'Common Blue', 2, 20220913, 'woodland', NULL),
(24, 'Speckled Wood', 2, 20241022, 'coastal', 'Resting on a tree trunk in the woodland'),
(24, 'Comma', 4, 20240308, 'woodland', 'Basking on a sunlit stone wall'),
(26, 'Gatekeeper', 2, 20240414, 'heath', NULL),
(27, 'Silver-washed Fritillary', 1, 20240629, 'garden', NULL),
(29, 'Purple Hairstreak', 3, 20240720, 'park', 'Feeding high up in oak trees'),
(30, 'Red Admiral', 2, 20240304, 'woodland', NULL),
(30, 'Common Copper', 1, 20240125, 'woodland', NULL),
(1, 'Wall Brown', 1, 20240208, 'marsh', NULL),
(2, 'Peacock', 1, 20240301, 'woodland', NULL),
(4, 'Gatekeeper', 2, 20240727, 'city', 'Migrating across the countryside'),
(10, 'Gatekeeper', 1, 20240712, 'woodland', NULL),
(11, 'Adonis Blue', 1, 20240807, 'woodland', NULL),
(12, 'Orange Tip', 1, 20240803, 'woodland', NULL),
(15, 'Comma', 1, 20240124, 'woodland', NULL),
(16, 'Large Skipper', 2, 20240217, 'park', 'Nectaring on thistles in the field'),
(19, 'Peacock', 1, 20240306, 'woodland', NULL),
(21, 'Large White', 1, 20240511, 'coastal', NULL);

CREATE TABLE other_insects
(record_no INT NOT NULL,
insect_species VARCHAR(200), 
insect_count INT, 
date_of_count DATE,
habitat_type VARCHAR (200),
notes VARCHAR(400));

INSERT INTO other_insects
VALUES
(1, 'Ladybird', 10, 20240810, 'garden', 'Crawling on leaves in the garden'),
(2, 'Dragonfly', 3, 20240330, 'coastal', 'Hovering over the pond'),
(3, 'Buff-tailed Bumblebee', 2, 20240302, 'park', 'Collecting pollen from flowers'),
(4, 'Weevil', 1, 20240425, 'garden', NULL),
(5, 'Rose Chafer', 4, 20240428, 'marsh', 'Buzzing around roses in the backyard'),
(6, 'Click Beetle', 6, 20240510, 'park', NULL),
(7, 'Ant', 20, 20240215, 'woodland', 'Building nest mounds in the lawn'),
(8, 'Hoverfly', 7, 20240120, 'heath', 'Fluttering among flowers'),
(9, 'Grasshopper', 3, 20240905, 'woodland', NULL),
(9, 'Moth', 6, 20240818, 'city', 'Attracted to porch light at night'),
(10, 'Moth', 3, 20240705, 'garden', NULL),
(11, 'Centipede', 1, 20240312, 'park', NULL),
(12, 'Beetle', 2, 20230429, 'park', 'Crawling on fallen logs in the woods'),
(14, 'Wasp', 2, 20240522, 'coastal', 'Nesting under the eaves of the house'),
(14, 'Cricket', 4, 20240308, 'river', 'Chirping in the evening'),
(15, 'Earwig', 2, 20240214, 'heath', NULL),
(16, 'Ladybird', 1, 20240129, 'garden', 'Spinning a web in the garden shed'),
(19, 'Hoverfly', 3, 20241120, 'park', 'Mimicking a bee while foraging for nectar'),
(21, 'Hoverfly', 2, 20241204, 'city', NULL),
(22, 'Leaf hopper', 1, 20241125, 'park', NULL),
(22, 'Caterpillar', 1, 20241008, 'marsh', NULL),
(23, 'Dock beetle', 1, 20240801, 'woodland', NULL),
(27, 'Ladybird', 2, 20240927, 'city', 'Camouflaged among leaves'),
(28, 'Mayfly', 1, 20240412, 'woodland', 'Feeding on the underside of plant leaves'),
(28, 'Bee-fly', 1, 20240307, 'garden', NULL),
(29, 'Mayfly', 1, 20240503, 'garden', NULL),
(30, 'Ground Beetle', 1, 20240124, 'woodland', NULL),
(30, 'Stonefly', 2, 20240217, 'park', 'Laying eggs in streams'),
(30, 'Green shield bug', 1, 20240306, 'woodland', NULL),
(30, 'Green Lacewing', 1, 20240511, 'coastal', 'Hunting aphids in the garden');


-- ADD FOREIGN KEYS TO TABLES -- 

-- SET 'VOLUNTEER_ID' AS THE FOREIGN KEY IN RECORDINGS TABLE
ALTER TABLE recordings
ADD CONSTRAINT
fk_volunteer_id
FOREIGN KEY
(volunteer_id)
REFERENCES
volunteers
(volunteer_id);

-- SET 'RECORD_NO' AS THE FOREIGN KEY IN BIRDS, BUTTERFLIES, OTHER_INSECTS TABLES
ALTER TABLE birds
ADD CONSTRAINT
fk_birds_record_no
FOREIGN KEY
(record_no)
REFERENCES
recordings
(record_no);

ALTER TABLE butterflies
ADD CONSTRAINT
fk_butterflies_record_no
FOREIGN KEY
(record_no)
REFERENCES
recordings
(record_no);

ALTER TABLE other_insects
ADD CONSTRAINT
fk_insects_record_no
FOREIGN KEY
(record_no)
REFERENCES
recordings
(record_no);



-- USE AT LEAST 3 X QUERIES TO INSERT DATA --
	-- (SEE ALSO MY STORED PROCEDURE TO INSERT NEW VOLUNTEER AT THE BOTTOM OF THE DATABASE) -- 

-- INSERT NOTES INTO RECORD_NO '2' WHERE BIRD_SPECIES IS 'SPARROW' IN BIRDS TABLE --
UPDATE birds
SET notes = 'Chirping loudly at a cat'
WHERE record_no = 2 AND bird_species = 'sparrow';

-- CHANGE DATE OF RECORD_NO '1' WHERE BUTTERFLY_SPECIES IS 'WALL BROWN' IN BUTTERFLIES TABLE --
UPDATE butterflies
SET date_of_count = 20231210
WHERE record_no = 1 AND butterfly_species = 'Wall Brown';

-- INSERT NEW RECORD INTO RECORDINGS TABLE -- 
INSERT INTO recordings(volunteer_id, recording_date, city, county)
VALUES 
-- (31, CURRENT_TIMESTAMP, 'West Kirby', 'Wirral');
(9, CURRENT_TIMESTAMP, 'Bootle', 'Cumbria');

-- INSERT NEW COUNT INTO BIRDS TABLE -- 
INSERT INTO birds(record_no, bird_species, bird_count, date_of_count, habitat_type, notes)
VALUES 
(31, 'little egret', 2, 20240321, 'coastal', 'Looking for shrimp in the sea');



-- USE AT LEAST 5 QUERIES TO RETRIEVE DATA -- 
-- USE AT LEAST 2 AGGREGATE FUNCTIONS (COUNT, SUM, AVG, MAX) --

-- HOW MANY INSECTS COUNTED END WITH 'FLY', FROM HIGHEST TO LOWEST --
SELECT insect_species, COUNT(insect_species) AS total_count
FROM other_insects
GROUP BY insect_species
HAVING insect_species LIKE '%fly'
ORDER BY total_count DESC;

-- HOW MANY VOLUNTEERS REGISTERED IN APRIL --
SELECT
COUNT(v.volunteer_id) AS Volunteer_Count_April
FROM volunteers v
WHERE MONTHNAME(registration_date)='april';

-- HOW MANY BUTTERFLIES WERE COUNTED IN EACH HABITAT BETWEEN JANUARY - MARCH, FROM LOWEST TO HIGHEST --
SELECT
bu.habitat_type,
SUM(bu.butterfly_count) AS total_butterfly_count
FROM butterflies bu
WHERE MONTH(date_of_count) BETWEEN 1 and 3
GROUP BY bu.habitat_type
ORDER BY total_butterfly_count ASC;

-- HOW MANY BIRDS WERE COUNTED IN EACH HABITAT IN AUGUST, FROM HIGHEST TO LOWEST --

-- CREATE VIEW bird_habitats_august AS -- (UNCOMMENT THIS LINE TO CREATE VIEW CALLED 'bird_habitats_august') --
SELECT
bi.habitat_type,
SUM(bi.bird_count) AS total_bird_count
FROM birds bi
WHERE MONTHNAME(date_of_count)='August'
GROUP BY bi.habitat_type
ORDER BY total_bird_count DESC;

-- AVERAGE COUNT OF BUTTERFLIES IN EACH HABITAT, FROM LOWEST TO HIGHEST --
SELECT
bu.habitat_type,
AVG(bu.butterfly_count) AS habitat_butterfly_count
FROM butterflies bu
GROUP BY bu.habitat_type
ORDER BY habitat_butterfly_count ASC;

-- WHICH CITY COUNTED THE MOST BUTTERFLIES IN SEPTEMBER --
SELECT
r.city, 
MAX(bu.butterfly_count) AS city_butterfly_count
FROM recordings r 
INNER JOIN butterflies bu ON bu.record_no = r.record_no
WHERE bu.butterfly_count IN
(SELECT MAX(bu.butterfly_count) FROM butterflies bu
WHERE MONTHNAME(bu.date_of_count)='september')
GROUP BY r.city;



-- USE AT LEAST 1 x QUERY TO DELETE DATA -- 	
SET SQL_SAFE_UPDATES = 0; -- NOTE: YOU NEED TO DISABLE SAFE MODE TO RUN THESE QUERIES --

-- DELETE DUPLICATE VOLUNTEERS AND RETAIN THE OLDEST RECORD
    
-- CALL Insert_volunteer -- (UNCOMMENT / CALL THE 'INSERT_VOLUNTEER' STORED PROCEDURE & INSERT 'Gilda Whiteley' ENTRY TO TEST DELETE DUPLICATES QUERY)
-- ('Gilda', 'Whiteley', 'gwhiteley@hotmail.com', CURRENT_TIMESTAMP); 
DELETE t1 FROM volunteers t1
INNER JOIN volunteers t2
WHERE t1.volunteer_id > t2.volunteer_id AND t1.email_address = t2.email_address;

-- DELETE ROWS FROM OTHER_INSECTS TABLE THAT CONTAIN 'SHIELD' IN THE INSECT_SPECIES COLUMN
DELETE FROM other_insects
WHERE insect_species LIKE '%shield%';



-- USE AT LEAST 2 JOINS --

-- LEFT JOIN 'VOLUNTEERS' AND 'RECORDINGS' TABLES AND COUNT HOW MANY VOLUNTEERS HAVEN'T ADDED ANY RECORDS YET --
SELECT
COUNT(*) AS non_recorders_count -- THE * ALLOWS US TO COUNT ALL ROWS INCLUDING NULL VALUES
FROM volunteers v
LEFT JOIN recordings r ON r.volunteer_id = v.volunteer_id
WHERE r.record_no IS NULL;

-- RIGHT JOIN 'RECORDINGS' AND 'VOLUNTEERS' TABLES TO SHOW VOLUNTEERS WHO REGISTERED MORE THAN 1 YEAR AGO AND HAVEN'T ADDED ANY RECORDS YET--
SELECT
v.first_name, v.surname, v.email_address, v.registration_date,
r.record_no
FROM recordings r 
RIGHT JOIN volunteers v ON r.volunteer_id = v.volunteer_id
WHERE  v.registration_date < DATE_SUB(CURRENT_DATE(), INTERVAL 365 DAY) AND r.record_no IS NULL
ORDER BY v.first_name;

-- INNER JOIN 'RECORDINGS' AND 'OTHER_INSECTS' TABLES TO FIND WHICH CITY COUNTED THE MOST INSECTS IN FEBRUARY --
SELECT
r.city, 
MAX(insect_count) AS city_insect_count
FROM recordings r 
INNER JOIN other_insects oi ON oi.record_no = r.record_no
WHERE insect_count IN
(SELECT MAX(insect_count) FROM other_insects oi
WHERE MONTHNAME(date_of_count)='February')
GROUP BY r.city
ORDER BY city_insect_count DESC;

-- INNER JOIN 'RECORDINGS' AND 'VOLUNTEERS' TABLES. UNION ALL 'BIRDS', 'BUTTERFLIES' AND 'OTHER_INSECTS' TABLES. FIND WHICH VOLUNTEERS RECORDED THE MOST COUNTS OVERALL -- 
	-- I.E. NOT THE SUM OF THE ACTUAL SPECIES COUNTED, BUT HOW MANY TIMES THEY RECORDED COUNTS -- 
SELECT
v.volunteer_id, v.first_name, v.surname,
SUM(total_records) AS volunteers_total_records
FROM volunteers v
INNER JOIN recordings r ON r.volunteer_id = v.volunteer_id
INNER JOIN
    (SELECT record_no, COUNT(record_no) AS total_records FROM birds GROUP BY record_no 
    -- Use GROUP BY with an aggregate function (in this instance COUNT). Cannot GROUP BY an alias, so use proper column name 'record_no'
     UNION ALL 
     -- UNION combines the results of 2+ queries, UNION ALL includes duplicates so we can count all instances of the same record_no across the 3 tables
     SELECT record_no, COUNT(record_no) AS total_records FROM butterflies GROUP BY record_no
     UNION ALL
     SELECT record_no, COUNT(record_no) AS total_records FROM other_insects GROUP BY record_no) AS all_records 
     -- 'all_records' is the alias name for the total instances of record_nos across all 3 tables
     ON all_records.record_no = r.record_no
     -- INNER JOIN 'all_records' alias with the 'record_nos' in recordings table so we can get the volunteer details
GROUP BY v.volunteer_id, v.first_name, v.surname
ORDER BY volunteers_total_records DESC;



-- USE AT LEAST 2 ADDITIONAL IN-BUILT FUNCTIONS --
	-- (ROUND, MONTHNAME, CONCAT, UPPER, LOWER, SUBSTRING) -- 

-- USE ROUND() TO FIND AVERAGE COUNT OF BIRDS IN EACH HABITAT TO NEAREST WHOLE NUMBER --
SELECT
habitat_type,
ROUND(AVG(bi.bird_count)) AS habitat_bird_count
FROM birds bi
GROUP BY habitat_type
ORDER BY habitat_bird_count DESC;

-- USE MONTHNAME() TO SEARCH BY THE NAME OF THE MONTH IN THE 'DATE_OF_COUNT' TIMESTAMP --
SELECT
oi.habitat_type, oi.insect_count
FROM other_insects oi
WHERE MONTHNAME(date_of_count)='november'
ORDER BY oi.insect_count;

-- USE CONCAT(), UPPER(), LOWER(), SUBSTRING() TO SET THE FIRST LETTER OF THE FIRSTNAME AND SURNAME TO UPPERCASE, AND ALL THE LETTERS AFTER TO LOWERCASE --
	
-- CALL Insert_volunteer -- (UNCOMMENT / CALL THE 'INSERT_VOLUNTEER' STORED PROCEDURE & INSERT 'homer simpson' ENTRY TO TEST TITLECASE QUERY)
-- ('homer', 'simpson', 'homer@simpsons.com', CURRENT_TIMESTAMP);
UPDATE volunteers
SET 
first_name = CONCAT(UPPER(SUBSTRING(first_name,1,1)), LOWER(SUBSTRING(first_name FROM 2))),
surname = CONCAT(UPPER(SUBSTRING(surname,1,1)), LOWER(SUBSTRING(surname FROM 2)));



-- CREATE STORED PROCEDURE TO INSERT NEW VOLUNTEER TO VOLUNTEERS TABLE --
DELIMITER //
CREATE PROCEDURE Insert_volunteer(
IN 
first_name VARCHAR(50),
surname VARCHAR(50),
email_address VARCHAR(200),
registration_date TIMESTAMP)
BEGIN
INSERT INTO volunteers(first_name, surname, email_address, registration_date)
VALUES (first_name, surname, email_address, registration_date);
END//
DELIMITER ;

-- CALL PROCEDURE --
CALL Insert_volunteer
('Gilda', 'Whiteley', 'gwhiteley@hotmail.com', CURRENT_TIMESTAMP);

-- TEST PROCEDURE --
SELECT * FROM volunteers;



-- CREATE INDEXES ON SPECIES TABLES -- 
CREATE INDEX bird_species ON birds(bird_species);
CREATE INDEX butterfly_species ON butterflies(butterfly_species);
CREATE INDEX butterfly_count ON butterflies(butterfly_count);
CREATE INDEX insect_species ON other_insects(insect_species);
CREATE INDEX insect_count ON other_insects(insect_count);
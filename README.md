# Wildlife recordings database 
I have designed this database for a wildlife charity so that their volunteers can record local wildlife sightings.

The database stores:
- Volunteers table (ID (auto-increment), first_name, surname, email address, registration date)
- Recordings table (record number (auto-increment), volunteer ID, recording date, city, county)
- Three tables to store counts for three main wildlife categories: Birds, Butterflies and Other insects (species, count, date of count, habitat type, notes about the species)

## Data integrity
The Recordings table contains the 'volunteer_ID' as a foreign key from the Volunteers table so the charity can see which volunteers enter the most/least recordings and when, and where the volunteers are based. 

The 3 species tables all store the 'record_no' from the Recordings table as a foreign key, so the charity can see which locations enter the most/least recordings. 

## Querying the data
I've written queries to enable volunteers to add new records and counts, as well as to update previous counts, such as adding notes or changing the date of a previous count. 

I've used aggregate functions such as SUM, COUNT, MAX and AVG to allow the charity to manipulate and retrieve data. 

I've used joins and queries to help the charity understand how many volunteers have not added records and retrieve the volunteers’ details so they can send email prompts.

I’ve written queries to delete data, for example so the charity can delete duplicate volunteers, or to enable volunteers to delete information from previous records.

I’ve created a stored procedure to enable the charity to add new volunteers to the database.

I’ve created a view to analyse which habitats are most popular with species a certain times of the year.

## How to use the project
1. Download the SQL file
2. Run the SQL code to set up the database
3. Three queries have lines of code commented out to allow you to test them (i.e. create view, deleted duplicate entry, titlecase volunteer names).

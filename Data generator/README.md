# data_generator
This script generates data for a simple data warehouse that stores information from a public transport company.

## Usage
To use the script, follow these steps:
1. Run the Python script.
2. Type "T1" to initiate the generation of the first patchset, including data from 2015 to 2020. The script will prompt you to enter the number of rides you want to generate for this period.
3. Type "T2" to initiate the generation of data for the period 2021-2023. Again, the script will ask for the number of rides to generate.

## Output
The program generates two types of data:
* An Excel file containing detailed information about drivers, ticket controllers, and payrolls for each month of employment.
* SQL scripts for creating and populating a database with information about buses, bus stops, courses, rides, and controls.

## Contributors
* @Kuba Lisowski
* @Aleksander Sarzyniak

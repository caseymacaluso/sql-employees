# sql-employees

This SQL project contains all the files used during a [course](https://www.udemy.com/course/sql-mysql-for-data-analytics-and-business-intelligence/) I took from Udemy.

The project is divided up into a few folders for better organization:

- 0 - Create DB Files - This folder is reserved for the files used to generate the databases used for the project.
- 1 - Basic SQL Statements - This section covers statements like ```SELECT, INSERT, UPDATE, DELETE```, as well as getting into aggregate functions and join operations.
- 2 - Advanced Concepts - This section covers higher-level topics in SQL, such as subqueries, views, stored routines, window functions, CTEs and temporary tables.
- 3 - Tableau Content - This sections contains all the files used to generate charts in Tableau.

The Tableau dashboard can be found [here](https://public.tableau.com/app/profile/casey.macaluso/viz/EmployeesDashboard_16759017853690/Dashboard1)

Should you want to run the project yourself, the only thing you need to do is run the files in the folder marked '0 - Create DB Files' in the MySQL Workbench. Running those two files will create the databases I used for this project.

- The ```employees``` database is the main one used for the majority of the project (i.e. all the content in folders 1 and 2)
- the ```t_employees``` database is used for all the Tableau-related content (hence the 't_' prefix on the database name)

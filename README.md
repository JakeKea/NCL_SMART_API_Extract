# NCL_SMART_API_EXTRACT

Python script to pull data from the SMART API datasource and store it in the NCL Sandpit.
SMART data can be accessed from [Data_Lab_NCL_Dev].[JakeK].[smart_api_data_vw].

## History ##
### [1.0] - 26/11/2023 ###
* Initial functionality.

### [1.1] - 22/04/2024 ###
* Removed dependancy on file being executed in the correct working directory.

## Usage ##
* Ensure the settings in the .env are as desired. Typically this can remain untouched.
* Install relevant packages using the requirments.txt file by running the following in a terminal:\
  *pip install -r requirements.txt*
* Execute the SMART_API_download.py script. This can take a couple of minutes as requests are delayed to avoid overloading the APi.
  
## env Settings ##
**DATE_WINDOW**\
This determines what date range data will be grabbed for. This should be specified as a number and a unit like "2 weeks". This field accepts: days, weeks, months, years.

**WAIT_PERIOD**\
The number of seconds between API requests. 1 request is required per site and per 7 days covered by the data. This wait is necessary as the SMART API endpoint will block requests if too many are made. Recommended to set to 5 from personal testing.

**WAIT_COOLOFF**\
The number of seconds between a failed request and re-attempting. Used to wait out any instances of the SMART endpoint blocking requests if too many requests are made. If the code fails twice in a row, the execution will be aborted. Recommend to set to 60 from personal testing.

**SITES**\
Array of site codes. Each api request must specify a site. This code will pull data for all sites listed in the array. These site codes are not NHS site codes, they come from the SMART team.

**SQL_ADDRESS**\
Address of the SQL Server (Comes up as "Server Name" when attempting to connect to the NCL Sandpit in MSSQL)

**SQL_DATABASE**\
Name of the SQL Database to use (destination).

**SQL_SCHEMA**\
Name of the SQL schema (destination).

**SQL_TABLE**\
Name of the SQL table (destination).

## Documents ##
The view script for the smart data is stored here.
A sample .env file is stored here to demostrate a typical structure for the .env file.

## License ##
This repository is dual licensed under the [Open Government v3](https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/) & MIT. All code can outputs are subject to Crown Copyright.
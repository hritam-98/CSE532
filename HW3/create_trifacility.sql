drop table cse532.TRIFacility;
create table cse532.TRIFacility(FACILITY_NAME varchar(200), ST char(10), CHEMICAL varchar(200), CARCINOGEN char(10), LATITUDE double, LONGITUDE double);

import from "2021_us.csv" of del 
modified by coldel, decpt. 
method p (4, 8, 34, 43, 12, 13) 
messages "import.msg" 
insert into cse532.TRIFacility (FACILITY_NAME,  ST, CHEMICAL, CARCINOGEN, LATITUDE, LONGITUDE);

alter table cse532.TRIFacility add column geolocation db2gse.st_point;

!db2se register_spatial_column sample
-tableSchema      cse532
-tableName        TRIFacility
-columnName       geolocation
-srsName          nad83_srs_1
;

update cse532.TRIFacility 
set geolocation = db2gse.st_point(LONGITUDE,LATITUDE , 1)
;

reorg table cse532.TRIFacility ;


select count(*) from cse532.TRIFacility;


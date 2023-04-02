!erase zcta.msg;
connect to sample;

drop table cse532.zcta;

create table cse532.zcta(
  zipcode char(5)
  ,shape          db2gse.st_multipolygon
  )
  ;

!db2se import_shape sample
-fileName         tl_2022_us_zcta520.shp
-inputAttrColumns N(ZCTA5CE20)
-srsName          nad83_srs_1
-tableSchema      cse532
-tableName        zcta
-tableAttrColumns zipcode
-createTableFlag  0
-spatialColumn    shape
-typeSchema       db2gse
-typeName         st_multipolygon
-messagesFile     zcta.msg
-client 1
;

!db2se register_spatial_column sample
-tableSchema      cse532
-tableName        zcta
-columnName       shape
-srsName          nad83_srs_1
;

select count(*) from cse532.zcta;

describe table cse532.zcta;

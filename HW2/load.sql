alter table CSE532.STOCK alter column StockName set default 'XOM';

LOAD FROM "C:\Users\PC\Downloads\HomeWork2\HomeWork2\XOM.csv" OF DEL 
INSERT INTO CSE532.STOCK (
Date,OPEN, High, Low, CLOSE, AdjClose, Volume
);


alter table CSE532.STOCK alter column StockName set default 'AAL';

LOAD FROM "C:\Users\PC\Downloads\HomeWork2\HomeWork2\AAL.csv" OF DEL 
INSERT INTO CSE532.STOCK (
Date,OPEN, High, Low, CLOSE, AdjClose, Volume
);

alter table CSE532.STOCK alter column StockName drop default;


SELECT * FROM CSE532.STOCK WHERE STOCKNAME ='AAL'; 


--
--LOAD FROM "C:/Users/PC/Downloads/XOM.csv" OF DEL 
-- INSERT INTO CSE532.STOCK (
--StockName
--CONSTANTIF(TRUE) 
--CONSTANT('DDD'), 
--,Date,OPEN, High, Low, CLOSE, AdjClose, Volume
--);
--
--LOAD DATA
--CHARACTERSET UTF8
--INFILE "E:XOM.csv"
--APPEND INTO CSE532.STOCK 
--FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY "" TRAILING NULLCOLS
--(
--StockName "1", Date,OPEN, High, Low, CLOSE, AdjClose, Volume);
--
--
--OPTIONS (options)
--{ LOAD | CONTINUE_LOAD } [DATA]
--[ CHARACTERSET character_set_name ]
--[ { INFILE | INDDN } { filename | * }
--[ "OS-dependent file processing options string" ]
--[ { BADFILE | BADDN } filename ]
--[ { DISCARDFILE | DISCARDDN } filename ]
--[ { DISCARDS | DISCARDMAX } n ] ] 
--[ { INFILE | INDDN } ] ...
--[ APPEND | REPLACE | INSERT | 
--RESUME [(] { YES | NO [REPLACE] } [)]  ]
--[ LOG { YES | NO } ] 
--[ WORKDDN filename ]
--[ SORTDEVT device_type ]
--[ SORTNUM n ]
--[ { CONCATENATE [(] n [)] |
--CONTINUEIF { [ THIS | NEXT ]
--[(] ( start [ { : | - } end ] ) | LAST }
--operator  { 'char_str' | X'hex_str' } [)] } ] 
--[ PRESERVE BLANKS ]
--INTO TABLE tablename
--[ CHARACTERSET character_set_name ]
--[ SORTED [ INDEXES ] ( index_name [ ,index_name... ] ) ]
--[ PART n ]
--[ APPEND | REPLACE | INSERT | 
--RESUME [(] { YES | NO [REPLACE] } [)] ] 
--[ REENABLE [DISABLED_CONSTRAINTS] [EXCEPTIONS table_name] ]
--[ WHEN field_condition [ AND field_condition ... ] ]
--[ FIELDS  [ delimiter_spec ] ]
--[ TRAILING [ NULLCOLS ] ]
--[ SKIP n ]
--(.column_name
--{ [ RECNU
--| SYSDATE | CONSTANT value
--| SEQUENCE ( { n | MAX | COUNT } [ , increment ] )
--| [[ POSITION ( { start [ {:|-} end ] | * [+n] } ) ]
--[ datatype_spec ]
--[ NULLIF field_condition ]
--[ DEFAULTIF field_condition ]
--[ "sql string" ] ] ]  }
--[ , column_name ] ...)
--[ INTO TABLE ] ... [ BEGINDATA ]
--[ BEGINDATA]
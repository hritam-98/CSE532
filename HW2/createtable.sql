CREATE TABLE CSE532.STOCK (
  StockName char(4) NOT NULL,
  --WITH DEFAULT 'XOM', 
  --StockName char (4) 
  --DEFAULTIF KEYFLD2_CHAR < '001000' VALUE('XOM')
  --DEFAULTIF KEYFLD2_CHAR >= '001000' VALUE('AAL'),
  Date date,
  Open float,
  High float,
  Low float,
  CLOSE float,
  AdjClose float,
  Volume int
) COMPRESS YES;

CREATE INDEX StockIndex ON cse532.STOCK(StockName, Close);

--DEFAULTIF KEYFLD2_CHAR < '001000' VALUE(2311)
--       DEFAULTIF KEYFLD2_CHAR >= '001000' VALUE(-500)
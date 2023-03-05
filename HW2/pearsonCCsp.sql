--db2 -td@ -f E:pearsonCCsp.sql
--db2 "call PearsonCC('xom','aal',?)"
--SELECT x.CLOSE AS XCLOSE, a."CLOSE" AS YCLOSE FROM CSE532.Stock x, CSE532.Stock a WHERE x."DATE" =a."DATE" AND x.STOCKNAME <> a.STOCKNAME AND x.STOCKNAME ='XOM';

CREATE OR REPLACE PROCEDURE PearsonCC(
    IN STOCK1 CHAR(4), IN STOCK2 CHAR(4), OUT CC DECIMAL(4,3)
  )
  LANGUAGE SQL
  BEGIN

    DECLARE tot_xom double DEFAULT 0;
    DECLARE tot_aal double DEFAULT 0;
    DECLARE stot_xom double DEFAULT 0;
    DECLARE stot_aal double DEFAULT 0;
    DECLARE tot double DEFAULT 0;
    DECLARE N INTEGER DEFAULT 0;
    DECLARE cc_comp DOUBLE DEFAULT 0;
    DECLARE CUR_END INT DEFAULT 0;
    DECLARE x float;
   DECLARE y double;

    DECLARE CUR CURSOR FOR SELECT x.CLOSE AS XCLOSE, a.CLOSE AS YCLOSE FROM CSE532.Stock x, CSE532.Stock a WHERE x.DATE =a.DATE AND x.STOCKNAME <> a.STOCKNAME AND x.STOCKNAME = STOCK1;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET CUR_END = 1;
    OPEN CUR;
      FETCH CUR INTO x,y;
    
      WHILE CUR_END = 0 DO
         SET N=N+1;
         SET tot_xom=tot_xom+x;
         SET tot_aal=tot_aal+y;
         SET stot_xom=stot_xom+(x*x);
         SET stot_aal=stot_aal+(y*y);
          SET tot=tot+(x*y);
         FETCH CUR INTO x,y;
      END WHILE;
    	
     
   
	SET cc_comp=((N*(tot))-(tot_xom*tot_aal))/SQRT(((n*stot_xom)-(tot_xom*tot_xom))*((n*stot_aal)-(tot_aal*tot_aal)));	     
     
      --SET CC=((N*(tot))-(tot_xom*tot_aal));
    SET CC=ROUND(cc_comp,3);
    CLOSE CUR;

  END@

CALL PearsonCC('XOM','AAL',?)@
 SELECT Distinct b.KCustom '거래처',b.CustomID
 From
 (
     SELECT b.CustomID FROM DS24 AS a
             INNER JOIN DS20 AS b ON a.OrderID = b.OrderID   
             INNER JOIN DS02 AS c ON b.customid= c.customid   
     WHERE LEFT(a.Examdate,6) = '202404'            
          AND   c.Spendingclss = '1'            
     UNION ALL                                               
     SELECT b.CustomID FROM DS26 AS a
             INNER JOIN DS20 AS b ON a.OrderID = b.OrderID
             INNER JOIN DS02 AS c ON b.customid= c.customid   
     WHERE LEFT(a.FixDate,6) = '202404'
       AND  A.OutType = 4 and A.outclss not in(4)
       AND  c.Spendingclss = '0'            
     UNION ALL                                               
     SELECT b.CustomID FROM DS26 AS a
             INNER JOIN DS20 AS b ON a.OrderID = b.OrderID   
             INNER JOIN DS02 AS c ON b.customid= c.customid   
     WHERE LEFT(a.FixDate,6) = '202404'             
       AND a.Outclss = 2                                      
       AND  c.Spendingclss = '0'            
     UNION ALL                                               
     SELECT b.CustomID FROM DS26 AS a
             INNER JOIN DS20 AS b ON a.OrderID = b.OrderID   
             INNER JOIN DS02 AS c ON b.customid= c.customid   
     WHERE LEFT(a.FixDate,6) = '202404'             
       AND a.Outclss = 0                                      
       AND  c.Spendingclss = '0'            
 )    AS a
 INNER JOIN DS02 AS b ON  a.CustomID = b.CustomID      order by b.kcustom



 --select * from ds97
 --outtype:0(루즈패킹)1(carton-solid)2(carton-asserted)3(bale)4(이중비닐)
 select outtype,outclss from ds26

 select * from ds26

 

 select * from ds02	--spendingclss> 청구방법


--합격수량
SELECT
SUM(ROUND(ISNULL(A.Gross,0)*1.0936,0)), A.GROSS, A.OrderUnit,a.rollno,a.examdate 
  FROM ( SELECT AA.ExamDate, AA.OrderID, AA.CtrlQty Gross  ,BB.OrderUnit,AA.rollno,aa.examtime, aa.colorid        
                   FROM DS24 AA, DS20 BB                                                
                   WHERE LEFT(AA.ExamDate,6) = '202405'  and aa.orderid='202405057'                  
                   AND AA.OrderID = BB.OrderID AND AA.GradeClss < BB.DefectClss ) A  
				   GROUP By A.Gross, A.OrderUnit,a.orderid,a.rollno,a.examdate,a.examtime,a.colorid
				   order by a.orderid, a.colorid, a.rollno

--불합격수량
   SELECT MAX(A.ExamDate)ExamDate, A.OrderID, CASE WHEN A.OrderUnit = '0' THEN SUM(A.Gross) ELSE SUM(ROUND(ISNULL(A.Gross,0)*1.0936,0))END dQty, A.GROSS, A.OrderUnit,a.rollno
           FROM ( SELECT AA.ExamDate, AA.OrderID, AA.CtrlQty Gross    ,BB.OrderUnit     ,AA.rollno,aa.examtime         , aa.colorid                         
                   FROM DS24 AA, DS20 BB                                                
                   WHERE LEFT(AA.ExamDate,6) = '202405'          and aa.orderid='202405057'                
                   AND AA.OrderID = BB.OrderID AND AA.GradeClss >= BB.DefectClss ) A    
         GROUP BY A.OrderID ,A.OrderUnit     ,a.orderid,a.rollno,a.examdate,a.examtime           ,a.gross    ,a.colorid      
		 order by a.orderid, a.colorid, a.rollno




				   select * from ds24

				   
          SELECT LEFT(fixdate,6) fixdate ,A.OrderID, 
		  CASE WHEN B.OrderUnit='0' then SUM(OutQty)  ELSE SUM(ROUND(ISNULL(OutQty,0)*1.0936,0)) END BoxQty --,OutQty, B.OrderUnit 
		 
		  FROM DS26 A LEFT JOIN DS20 B ON A.OrderID=B.OrderId
          Where A.OutType = 1 and A.outclss not in(4)
         AND LEFT(fixdate,6) = '202405' and a.orderid='202405057'        
          GROUP BY A.OrderID,fixdate,B.OrderUnit--, outqty

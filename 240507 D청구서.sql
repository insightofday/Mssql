--알파섬유 정산
     SELECT  a.OrderNo, e.Article,
             CASE WHEN  JoinA.Outdate ='' THEN  left(C.ExamDate,4) +'-' +  substring(C.ExamDate,5,2) + '-' + Right(C.ExamDate,2) ELSE  left(JoinA.Outdate,4) +'-' +  substring(JoinA.Outdate,5,2) + '-' + Right(JoinA.Outdate,2) END fixdateA,   
             CASE WHEN f.UnitCost IS NULL THEN a.UnitCost ELSE f.UnitCost END UnitCost,  
             CASE WHEN f.JCost IS  NULL THEN a.JCost ELSE f.JCost END  JCost,            
             CASE WHEN f.DCost IS  NULL THEN a.DCost ELSE f.DCost END  DCost,            
             CASE WHEN f.PCost IS  NULL THEN a.PCost ELSE f.PCost END  PCost,            
             CASE WHEN f.RCost IS  NULL THEN a.RCost ELSE f.RCost END  RCost,            
             CASE WHEN f.JungPoCost IS  NULL THEN a.JungPoCost ELSE f.JungPoCost END  JungPoCost,
			   
			 CASE WHEN f.inqty is null then c.inqty else f.inqty END InQty,
			 CASE WHEN F.jungpo IS NULL THEN H.jungpo else f.jungpo END jungpo,
			 CASE WHEN F.dQTY IS NULL THEN D.dQty ELSE F.dQty END dQty,
			 CASE WHEN F.BoxQty IS NULL THEN B.BoxQty else F.BoxQty END BoxQty,
			 CASE WHEN F.RollQty IS NULL THEN M.BaleQty ELSE F.RollQty END RollQty,
			 CASE WHEN F.JungPoQty IS NULL THEN N.JungpoQty ELSE F.JungPoQty ENd JungPoQty,
             --CASE WHEN f.InQty IS NULL THEN (CASE WHEN a.OrderUnit=0 THEN ISNULL(c.InQty,0)  ELSE ROUND((ISNULL(c.Inqty,0)*1.0936),0) END) ELSE (CASE WHEN a.OrderUnit=0 THEN ISNULL(f.InQty,0)  ELSE ROUND((ISNULL(f.Inqty,0)*1.0936),0) END) END  InQty,     
             --CASE WHEN f.jungpo IS NULL  THEN (CASE WHEN a.OrderUnit=0 THEN ISNULL(h.jungpo,0) ELSE ROUND((ISNULL(h.jungpo,0)*1.0936),0)END) ELSE (CASE WHEN a.OrderUnit=0 THEN ISNULL(f.jungpo,0) ELSE ROUND((ISNULL(f.jungpo,0)*1.0936),0) END) END  jungpo, 
             
			 --CASE WHEN f.dQty IS NULL    THEN (CASE WHEN a.OrderUnit=0 THEN ISNULL(d.dQty,0)   ELSE ROUND((ISNULL(d.dQty,0)*1.0936),0) END)  ELSE (CASE WHEN a.OrderUnit=0 THEN ISNULL(f.dQty,0)   ELSE ROUND((ISNULL(f.dQty,0)*1.0936),0) END) END  dQty,        
             --CASE WHEN f.BoxQty IS NULL  THEN (CASE WHEN a.OrderUnit=0 THEN ISNULL(b.boxQty,0)   ELSE ROUND((ISNULL(b.boxQty,0)*1.0936),0) END) ELSE (CASE WHEN a.OrderUnit=0 THEN ISNULL(f.boxQty,0)   ELSE ROUND((ISNULL(f.boxQty,0)*1.0936),0) END) END  BoxQty,                  
             --CASE WHEN f.RollQty IS NULL THEN (CASE WHEN a.OrderUnit=0 THEN ISNULL(m.BaleQty,0)   ELSE ROUND((ISNULL(m.baleQty,0)*1.0936),0) END) ELSE (CASE WHEN a.OrderUnit=0 THEN ISNULL(f.RollQty,0)   ELSE ROUND((ISNULL(f.RollQty,0)*1.0936),0) END) END  BaleQty,               
             --CASE WHEN f.JungPoQty IS NULL THEN (CASE WHEN a.OrderUnit=0 THEN ISNULL(n.JungPoQty,0)   ELSE ROUND((ISNULL(n.JungPoQty,0)*1.0936),0) END) ELSE (CASE WHEN a.OrderUnit=0 THEN ISNULL(f.JungPoQty,0)   ELSE ROUND((ISNULL(f.JungPoQty,0)*1.0936),0) END) END  JungPoQty,               
 (((CASE WHEN f.UnitCost IS NULL THEN a.UnitCost ELSE f.UnitCost END) * (CASE WHEN f.InQty IS  NULL   THEN (CASE WHEN a.OrderUnit=0 THEN ISNULL(c.InQty,0)  ELSE ROUND((ISNULL(c.Inqty,0)*1.0936),0) END) ELSE f.InQty END)) + 
     ((CASE WHEN f.JCost IS  NULL THEN a.JCost ELSE f.JCost END) * (CASE WHEN f.jungpo IS  NULL  THEN (CASE WHEN a.OrderUnit=0 THEN ISNULL(h.jungpo,0) ELSE ROUND((ISNULL(h.jungpo,0)*1.0936),0)END) ELSE f.jungpo END)) +
    ((CASE WHEN f.DCost IS  NULL THEN a.DCost ELSE f.DCost END) * (CASE WHEN f.dQty IS  NULL    THEN (CASE WHEN a.OrderUnit=0 THEN ISNULL(d.dQty,0)   ELSE ROUND((ISNULL(d.dQty,0)*1.0936),0) END)  ELSE f.dQty END)) + 
    ((CASE WHEN f.PCost IS  NULL THEN a.PCost ELSE f.PCost END) * (CASE WHEN f.BoxQty IS  NULL THEN (CASE WHEN a.OrderUnit=0 THEN ISNULL(b.BoxQty,0)   ELSE ROUND((ISNULL(b.BoxQty,0)*1.0936),0) END) ELSE f.BoxQty END)) +            
    ((CASE WHEN f.RCost IS  NULL THEN a.RCost ELSE f.RCost END) * (CASE WHEN f.RollQty IS  NULL THEN (CASE WHEN a.OrderUnit=0 THEN ISNULL(M.BaleQty,0)   ELSE ROUND((ISNULL(m.BaleQty,0)*1.0936),0) END)  ELSE f.RollQty END)) + 
    ((CASE WHEN f.JungPoCost IS  NULL THEN a.JungPoCost ELSE f.JungPoCost END) * (CASE WHEN f.JungPoQty IS  NULL THEN (CASE WHEN a.OrderUnit=0 THEN ISNULL(n.JungPoQty,0)   ELSE ROUND((ISNULL(n.JungPoQty,0)*1.0936),0) END)  ELSE f.JungPoQty END)) ) total ,
             CASE WHEN f.OrderID IS NULL THEN '0' else '1' end uClose,
             MonthDate, 
             CASE WHEN a.OrderUnit = 0 THEN 'Y' else 'M' end unit,
             g.Width, isnull(Exchange,1) Exchange,
             a.OrderID, CASE WHEN isnull(F.CustomID,'') <> '' THEN F.totalCustom ELSE Y.KCustom END, CASE WHEN isnull(F.CustomID,'') <> '' THEN F.CustomID ELSE X.ChungucustomID END,'','','', '','','','','' ,0     
			 
			 from ds20 AS a
     inner Join
     (
        SELECT A.orderid , MAX(A.fixdate) fixdate,MAX(Outdate) OutDate  
        From (                                                 
              SELECT DISTINCT orderid ,LEFT(fixdate,6) fixdate, Outdate 
              From DS26                                        
              WHERE LEFT(fixdate,6) = '202404'        
              AND  OutType in (1,2,3,4) and outclss not in(4)       
              UNION                                            
              SELECT DISTINCT orderid ,LEFT(fixdate,6) fixdate, Outdate 
              From DS26                                        
              WHERE LEFT(fixdate,6) = '202404'        
              AND OutClss =2                                   
              UNION                                            
              SELECT DISTINCT orderid ,''   fixdate  ,'' Outdate 
              From DS24                                        
              WHERE LEFT(Examdate,6) = '202404'       
              ) A                                              
        GROUP BY A.OrderID                                     
     ) AS JoinA ON  a.OrderID = JoinA.orderid
     Left Join
     (
         SELECT LEFT(fixdate,6) fixdate ,A.OrderID, CASE WHEN B.OrderUnit='0' then SUM(OutQty)  ELSE SUM(ISNULL(OutQty,0)*1.0936) END BoxQty,B.orderunit
		 FROM DS26 A
		 LEFT JOIN DS20 B ON A.OrderID=B.OrderId
         Where A.OutType = 1 and A.outclss not in(4)
         AND LEFT(fixdate,6) = '202404'
         GROUP BY A.OrderID,fixdate,B.OrderUnit
     ) AS b ON JoinA.OrderID = b.OrderID AND JoinA.fixdate = b.FixDate
     Left Join
     (
         SELECT LEFT(fixdate,6) fixdate ,A.OrderID,  CASE WHEN B.OrderUnit='0' then SUM(OutQty)  ELSE SUM(ISNULL(OutQty,0)*1.0936) END BaleQty ,B.orderunit--SUM(OutQty) BaleQty 
		 FROM DS26 A
		 LEFT JOIN DS20 B ON A.OrderID=B.OrderId
         Where A.OutType = 3 and A.outclss not in(4)
         AND LEFT(fixdate,6) = '202404'
         GROUP BY A.OrderID, A.fixdate,B.orderunit
     ) AS M ON JoinA.OrderID = M.OrderID AND JoinA.fixdate = M.FixDate
     Left Join
     (
         SELECT LEFT(fixdate,6) fixdate ,A.OrderID, CASE WHEN B.OrderUnit='0' then SUM(OutQty)  ELSE SUM(ISNULL(OutQty,0)*1.0936) END JungPoQty ,B.orderunit
		 FROM DS26 A
		 LEFT JOIN DS20 B ON A.OrderID=B.OrderId
         Where A.outType = 5 and A.outclss not in(4)
         AND LEFT(fixdate,6) = '202404'
         GROUP BY A.OrderID, fixdate,B.OrderUnit
     ) AS N ON JoinA.OrderID = N.OrderID AND JoinA.fixdate = N.FixDate
     Left Join
     (
         SELECT LEFT(fixdate,6) fixdate ,A.OrderID, CASE WHEN B.OrderUnit = '0' THEN SUM(OutQty) ELSE SUM(ISNULL(OutQty,0) * 1.0936) END jungpo,B.orderunit
		 FROM DS26 AS A
		 LEFT JOIN DS20 AS B ON A.OrderID = B.OrderID
         Where OutType = 4 and outclss not in(4)
         AND LEFT(fixdate,6) = '202404'
         GROUP BY A.OrderID,fixdate,B.OrderUnit
     ) AS H ON JoinA.OrderID = H.OrderID AND JoinA.fixdate = H.FixDate
     Left join
     (
         SELECT MAX(A.ExamDate)ExamDate, A.OrderID,  CASE WHEN A.OrderUnit = '0' THEN SUM(A.Gross) ELSE SUM(ISNULL(A.Gross,0)*1.0936)END InQty, A.OrderUnit                  
           FROM ( SELECT AA.ExamDate, AA.OrderID, AA.CtrlQty Gross ,BB.OrderUnit                  
                   FROM DS24 AA, DS20 BB                                                
                   WHERE LEFT(AA.ExamDate,6) = '202404'                        
                   AND AA.OrderID = BB.OrderID AND AA.GradeClss < BB.DefectClss ) A     
         GROUP BY A.OrderID,A.OrderUnit                                                             
     ) AS C ON a.OrderID = C.OrderID                                  
     Left Join
     (
         SELECT MAX(A.ExamDate)ExamDate, A.OrderID, CASE WHEN A.OrderUnit = '0' THEN SUM(A.Gross) ELSE SUM(ISNULL(A.Gross,0)*1.0936)END dQty, A.OrderUnit                 
           FROM ( SELECT AA.ExamDate, AA.OrderID, AA.CtrlQty Gross       ,BB.OrderUnit                     
                   FROM DS24 AA, DS20 BB                                                
                   WHERE LEFT(AA.ExamDate,6) = '202404'                        
                   AND AA.OrderID = BB.OrderID AND AA.GradeClss >= BB.DefectClss ) A    
         GROUP BY A.OrderID ,A.OrderUnit                                                             
     ) AS D ON A.OrderID = D.OrderID 
     LEFT JOIN DS97 AS f ON a.OrderID = f.OrderID and LEFT(F.MonthDate,6) = '202404'
     INNER JOIN DS01 AS e ON a.ArticleID = e.articleid
     INNER JOIN DS13 AS g ON a.WidthID = g.WidthID
     LEFT JOIN DS20 AS X ON a.OrderID = X.OrderID
     LEFT JOIN DS02 AS Y ON X.ChunguCustomID = Y.CustomID




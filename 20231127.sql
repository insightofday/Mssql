SELECT A.OrderID, B.OrderNo, A.OutCustom, C.KCustom, A.OutClss, D.Color, D.OrderSeq, E.OutRoll, E.OutQty, 
       B.UnitClss, CASE WHEN B.UnitClss = '0' THEN 'Y' ELSE 'M' END AS UnitClssName, A.OutDate, B.CustomID
FROM Outware AS A
LEFT JOIN [Order] AS B ON A.OrderId = B.OrderID
LEFT JOIN mt_Custom AS C ON B.CustomID = C.CustomID
LEFT JOIN OrderColor AS D ON A.OrderID = D.OrderID
INNER JOIN
     (SELECT A.OrderID, A.OutSeq, A.OrderSeq, SUM(A.OutRoll) AS OutRoll, SUM(A.OutQty) As OutQty
     FROM OutWareSUb AS A
     INNER JOIN OutWare AS B ON A.OrderID = B.OrderID AND A.OutSeq = B.OutSeq
     WHERE B.OutDate = '20230127'
     GROUP BY A.OrderID, A.OutSeq, A.OrderSeq
) AS E ON A.OrderID = E.OrderID AND A.OutSeq = E.OutSeq AND D.OrderSeq = E.OrderSeq
WHERE A.OutDate <> ''
AND B.CustomID = '1013' 
AND D.OrderSeq <> 0
--AND A.OutClss <> '3'
ORDER BY A.OutDate, A.OrderID, A.OutCustom, A.TranNo, A.TranSeq 
-----------------------------------------------------------------------------

SET NoCOUNT ON  
SELECT A.OrderID, A.OrderSeq, A.LotNo, SUM(A.CtrlQty) AS CtrlQty, SUM(A.PassQty) AS PassQty, 
 SUM(A.DefectQty) AS DefectQty, SUM(A.DefectQty1) AS DefectQty1, SUM(A.LossQty) AS LossQty, 
 SUM(A.CutQty) AS CutQty, SUM(A.SampleQty) AS SampleQty 
INTO #Temp 
FROM 
    (SELECT A.OrderID, A.OrderSeq, A.LotNo, SUM(A.CtrlQty) AS CtrlQty, SUM(A.LossQty) AS LossQty, SUM(A.CutQty) AS CutQty, SUM(A.SampleQty) AS SampleQty 
    , 0 AS PassQty, 0 as DefectQty, 0 as DefectQty1 
    FROM [Inspect] AS A 
 WHERE A.OrderID <> '' 
 AND A.OutReclss = 0 
AND A.ExamDate BETWEEN '20230827' AND '20231127' 
    GROUP BY A.OrderID, A.OrderSeq, A.LotNo 

 UNION ALL 
    SELECT A.OrderID, A.OrderSeq, A.LotNo, 0 AS CtrlQty, 0 AS LossQty, 0 AS CutQty, 0 AS SampleQty 
    , SUM(A.CtrlQty) AS PassQty, 0 as DefectQty, 0 as DefectQty1 
     FROM [Inspect] AS A 
     WHERE A.GradeID = '1' 
     AND A.OutReclss = 0 
AND A.ExamDate BETWEEN '20230827' AND '20231127' 
     GROUP BY A.OrderID, A.OrderSeq, A.LotNo 
  
  UNION ALL 
     SELECT A.OrderID, A.OrderSeq, A.LotNo, 0 AS CtrlQty, 0 AS LossQty, 0 AS CutQty, 0 AS SampleQty
     , 0 AS PassQty, SUM(A.CtrlQty) as DefectQty, 0 as DefectQty1 
     FROM [INSPECT] AS A 
     WHERE A.GradeID > '1' AND A.DefectClss = '1' 
     AND A.OutReclss = 0 
AND A.ExamDate BETWEEN '20230827' AND '20231127' 
     GROUP BY A.OrderID, A.OrderSeq, A.LotNo 
  
  UNION ALL 
     SELECT A.OrderID, A.OrderSeq, A.LotNo, 0 AS CtrlQty, 0 AS LossQty, 0 AS CutQty, 0 AS SampleQty 
     , 0 AS PassQty, 0 as DefectQty, SUM(A.CtrlQty) as DefectQty1 
     FROM [INSPECT] AS A 
     WHERE A.GradeID > '1' AND A.DefectClss = '2' 
     AND A.OutReclss = 0  
AND A.ExamDate BETWEEN '20230827' AND '20231127' 
     GROUP BY A.OrderID, A.OrderSeq, A.LotNo) AS A 
  
     GROUP BY A.OrderID, A.OrderSeq, A.LotNo 
 
SELECT C.KCustom, A.OrderID, A.OrderNO, D.Article, F.WorkName,E.StuffWidth, B.OrderSeq , B.DesignNo,B.Color, B.ColorQty, A.UnitClss 
        ,G.LotNo,G.CtrlQty, G.PassQty, G.DefectQty, G.DefectQty1,G.LossQty, G.CutQty, G.SampleQty,B.UnitPrice,A.CustomID 
FROM #Temp AS G 
LEFT JOIN [Order] As A ON G.OrderID = A.OrderID 
LEFT JOIN [OrderColor] As B on G.OrderID = B.OrderID AND G.OrderSeq  = B.OrderSeq 
LEFT JOIN [mt_Custom] As C on A.CustomID = C.CustomID 
LEFT JOIN [mt_Article] As D on A.ArticleID = D.ArticleID 
LEFT JOIN [mt_StuffWidth] As E on A.WorkWidth = E.StuffWidthID 
LEFT JOIN [mt_Work] As F on A.WorkID = F.WorkID 
WHERE A.OrderID <> '' 
ORDER BY C.KCustom, A.OrderID, B.OrderSeq, Len(G.LotNo), G.LotNo 

--------------------------------------------------------------------------------
SELECT A.OrderID, A.RollSeq, A.RollNO, A.LotNo, A.OrderSeq, A.ExamNo, A.ExamDate, A.ExamTime, A.TeamID, A.PersonID, B.Name AS Person,
       A.StuffQty, A.RealQty, A.CtrlQty, A.SampleQty, A.LossQty, A.CutQty, A.StuffWeight, A.StuffWeightUnit, A.StuffWidth, A.Density,
       A.GradeID, F.Grade, A.DefectQty, A.DefectPoint, A.DefectID, C.KDefect AS Defect, A.DefectClss,
       A.CutDefectID, D.KDefect AS CutDefect, A.CutDefectClss, A.DeductQty, A.PieceCnt,
       ISNULL(G.OutSubSeq,0) AS OutFlag, A.OutReClss
FROM [Inspect] AS A
LEFT JOIN [mt_Person] AS B ON A.PersonID = B.PersonID
LEFT JOIN [mt_Defect] AS C ON A.DefectID = C.DefectID
LEFT JOIN [mt_Defect] AS D ON A.CutDefectID = D.DefectID
LEFT JOIN [mt_Grade] AS F ON A.GradeID = F.GradeID
LEFT JOIN OutwareSub AS G ON A.OrderID = G.OrderID AND A.RollSeq = G.RollSeq
WHERE A.OrderID = 'sOrderID' AND A.OrderSeq = nOrderSeq
AND A.LotNo = 'sLotNo' -- 조건에 따라 LotNo 필터링
AND A.RollSeq = nRollSeq -- 조건에 따라 RollSeq 필터링
AND ISNULL(G.OutSubSeq, 0) = 0 -- 미출고 여부에 따른 필터링
AND ISNULL(A.OutReclss, 0) = 0 -- 반품 여부에 따른 필터링
ORDER BY A.OrderID, LEN(A.LotNo), A.LotNo, A.RollNo

-------주의: SQL 인젝션 공격을 방지하기 위해 사용자 입력을 직접 쿼리에 추가하지 않는 것이 중요합니다. 
--대신 매개 변수화된 쿼리나 ORM 등을 사용하여 보안을 유지하는 것이 좋습니다.
--ORM은 "Object-Relational Mapping"의 약자로, 객체와 관계형 데이터베이스 간의 데이터를 변환하고 상호 작용하는 프로그래밍 기법 또는 도구 모음을 의미합니다.
-- ORM 프레임워크로는 Django ORM(Python), Entity Framework(C#), Hibernate(Java) 
------------------------------------------------------------------------------------------위에 쿼리랑 똑같은 것

SELECT A.OrderID, A.RollSeq, A.RollNO, A.LotNo, A.OrderSeq, A.ExamNo, A.ExamDate, A.ExamTime, A.TeamID, A.PersonID, B.Name AS Person, 
        A.StuffQty, A.RealQty, A.CtrlQty, A.SampleQty, A.LossQty, A.CutQty, A.StuffWeight, A.StuffWeightUnit, A.StuffWidth, A.Density, 
        A.GradeID, F.Grade, A.DefectQty, A.DefectPoint, A.DefectID, C.KDefect AS Defect, A.DefectClss, 
        A.CutDefectID, D.KDefect AS CutDefect, A.CutDefectClss, A.DeductQty , A.PieceCnt, 
        ISNULL(G.OutSubSeq,0) AS OutFlag, A.OutReClss 
    FROM [Inspect] AS A 
LEFT JOIN [mt_Person] AS B on A.PersonID = B.PersonID 
LEFT JOIN [mt_Defect] AS C on A.DefectID = C.DefectID
LEFT JOIN [mt_Defect] AS D on A.CutDefectID = D.DefectID --각 불량에 따른 컬럼을 따로 표출하고 싶어서 같은 테이블을 두 번 조인함
LEFT JOIN [mt_Grade] AS F on A.GradeID = F.GradeID 
LEFT JOIN OutwareSub AS G ON A.OrderID = G.OrderID AND A.RollSeq = G.RollSeq 
WHERE A.OrderID = '2023030006' AND A.OrderSeq = 1 
 AND ISNULL(A.OutReclss,0) = 0 
ORDER BY A.OrderID,LEN(A.LotNo),A.LotNo,A.RollNo 
----------------------------------------------------------------------------------
drop table #Temp

SET NOCOUNT ON 

SELECT B.OrderiD, B.OrderSeq, B.LotNo,
				--조정수량  --입고수량                                                 
       B.RollQty, B.CtrlQty, B.StuffQty,  B.CtrlQty AS InputQty, C.PassRoll, C.PassQty, 
								--제직불량절수	제직불량수량	가공불량절수	가공불량수량
       D.DefectRoll, D.DefectQty, E.FailJJRoll, E.FailJJQty, F.FailGGRoll, F.FailGGQty, 
	   --수정절수	수정수량
       B.DeductQty , G.PieceCnt                                                         
INTO #Temp                                                                              
FROM                                                                                    
       (SELECT OrderID, OrderSeq, LotNo, COUNT(*) RollQty, SUM(CtrlQty) CtrlQty, SUM(StuffQty) StuffQty, SUM(ISNULL(DeductQty, 0)) DeductQty             
       FROM [Inspect]                                                                                                                                    
       WHERE OrderID = '2023030006'                                                                                                                
       AND OutReClss = '0'                                                                                                                               
       GROUP BY OrderID, OrderSeq, LotNo) B       
	                                                                                                          
       LEFT JOIN                                                                                                                                         
       (SELECT OrderID, OrderSeq, LotNo, COUNT(*) PassRoll, SUM(CtrlQty) PassQty                                                                         
       FROM [Inspect]                                                                                                                                    
       WHERE GradeID = '1' AND OrderID = '2023030006'                                                                                              
       AND OutReClss = '0'                                                                                                                               
       GROUP BY OrderID, OrderSeq, LotNo) C on B.OrderID = C.OrderID AND B.OrderSeq = C.OrderSeq AND B.LotNo = C.LotNo       
	                               
       LEFT JOIN                                                                                                                                         
       (SELECT OrderID, OrderSeq, LotNo, COUNT(*) DefectRoll, SUM(CtrlQty) DefectQty                                                                     
       FROM [Inspect]                                                                                                                                    
       WHERE GradeID = '2' AND OrderID = '2023030006'                                                                                              
       AND OutReClss = '0'                                                                                                                               
       GROUP BY OrderID, OrderSeq, LotNo) AS D On B.OrderID = D.OrderID AND B.OrderSeq = D.OrderSeq AND B.LotNo = D.LotNo       
	                            
       LEFT JOIN                                                                                                                                         
       (SELECT OrderID, OrderSeq, LotNo, COUNT(*) FailJJRoll, SUM(CtrlQty) FailJJQty                                                                     
       FROM [Inspect]                                                                                                                                    
       WHERE GradeID = '2' AND DefectClss = '1' AND OrderID = '2023030006'                                                                         
       AND OutReClss = '0'                                                                                                                             
       GROUP BY OrderID, OrderSeq, LotNo) E on B.OrderID = E.OrderID AND B.OrderSeq = E.OrderSeq AND B.LotNo = E.LotNo       
	                               
       LEFT JOIN                                                                                                                                         
       (SELECT OrderID, OrderSeq, LotNo, COUNT(*) FailGGRoll, SUM(CtrlQty) FailGGQty                                                                     
       FROM [Inspect]                                                                                                                                    
       WHERE GradeID = '2' AND DefectClss = '2' AND OrderID = '2023030006'                                                                         
       AND OutReClss = '0'                                                                                                                               
       GROUP BY OrderID, OrderSeq, LotNo) F on B.OrderID = F.OrderID AND B.OrderSeq = F.OrderSeq AND B.LotNo = F.LotNo  
	                                    
       LEFT JOIN                                                                                                                                         
       (SELECT OrderID, OrderSeq, LotNo, COUNT(*) PieceCnt                                                                                               
       FROM [Inspect]                                                                                                                                    
       WHERE PieceCnt > 0 AND OrderID = '2023030006'                                                                                               
       AND OutReClss = '0'                                                                                                                               
       GROUP BY OrderID, OrderSeq, LotNo) G on B.OrderID = G.OrderID AND B.OrderSeq = G.OrderSeq AND B.LotNo = G.LotNo                   
	                   ------------------------------------------------------------------------------------------------------------
SELECT '',A.OrderID, A.OrderSeq, A.Color,A.DesignNo, A.ColorQty,C.UnitClss, B.LotNo, B.RollQty, B.CtrlQty, B.StuffQty, B.InputQty,   
       B.PassRoll, B.PassQty, B.DefectRoll, B.DefectQty, B.FailJJRoll, B.FailJJQty, B.FailGGRoll, B.FailGGQty,                       
       B.DeductQty , B.PieceCnt                                                                                                      
FROM [OrderColor] As A                                                                                                               
LEFT JOIN [#Temp] AS B on A.OrderID = B.OrderID AND A.OrderSeq = B.OrderSeq                                                          
LEFT JOIN [Order] As C on A.OrderID = C.OrderID                                                                                      
WHERE A.OrderSeq <> 0                                                                                                                
AND   A.OrderID = '2023030006'                                                                                                 
ORDER BY A.OrderID,A.OrderSeq, Len(B.LotNo), B.LotNo                                                                                                




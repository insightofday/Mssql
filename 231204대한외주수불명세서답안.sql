--기초재고관련 임시테이블
SELECT 0 AS Code, A.OrderID, A.CustomIDA, A.ArticleID, (SUM(A.InRoll) - SUM(A.OutRoll)) AS PrevRoll, (SUM(A.InQty) - SUM(A.OutQty)) AS PrevQty, 
A.UnitClss 
INTO #Prev 
FROM 
(    -- A<-B  (얘는 in)
     SELECT      A.OrderID, A.InCustomID AS CustomIDA, D.KCustom 'A회사이름', C.ArticleID, 0 OutRoll, 0 OutQty, A.OutRoll AS InRoll, A.OutQty AS InQty, A.UnitClss 
     FROM        [CommOut]       A 
     LEFT JOIN   [CommOutSub]    B ON A.KeyDate = B.KeyDate AND A.KeySeq = B.KeySeq 
     LEFT JOIN   [Order] AS C ON A.OrderID = C.OrderID 
	 LEFT JOIN	 [mt_Custom] AS D ON A.InCustomID = D.CustomID
     WHERE       A.OutDate > '19900101' AND A.OutDate < '20230101' 
     GROUP BY    A.OrderID, C.ArticleID, A.InCustomID, A.UnitClss, A.OutQty, A.OutRoll , D.KCustom 
			UNION ALL 
     -- A->B  (얘는 out)
     SELECT      A.OrderID, A.OutCustomID AS CustomIDA, D.KCustom 'A회사이름', C.ArticleID, A.OutRoll AS OutRoll, A.OutRealQty AS OutQty, 0 InRoll, 0 InQty, A.UnitClss 
     FROM        [CommOut]       A 
     LEFT JOIN   [CommOutSub]    B ON A.KeyDate = B.KeyDate AND A.KeySeq = B.KeySeq 
     LEFT JOIN   [Order] AS C ON A.OrderID = C.OrderID 
	 LEFT JOIN	 [mt_Custom] AS D ON A.InCustomID = D.CustomID
     WHERE       A.OutDate > '19900101' AND A.OutDate < '20230101' 
     GROUP BY    A.OrderID, C.ArticleID, A.OutCustomID, A.UnitClss, A.OutRealQty, A.OutRoll , D.KCustom 
)    A 
GROUP BY A.OrderID, A.CustomIDA, A.ArticleID, A.UnitClss
-----
select * from #Prev
-------------
drop table #Prev

------------------------------------------------------------------------------------------2
--수불일자 내에서의 데이터에 관한 테이블
SELECT   A.* 
INTO     #Subul 
FROM 
(     -- A<-B (1)  
     SELECT      1 AS Code, A.KeyDate, A.KeySeq, C.ArticleID, A.OrderID, B.OrderSeq, B.LotNo, A.UnitPrice, A.TranNo, A.OutDate AS IODate, 
				 A.OutRealQty, A.Remark, A.InCustomID CustomIDA, D.KCustom 'A고객사', A.OutCustomID CustomIDB, E.KCustom 'B고객사',
                 0 OutRoll, 0 OutQty,  
                 CASE WHEN A.OutClss = '2' THEN B.OutRoll * -1 ELSE B.OutRoll END AS InRoll, 
                 CASE WHEN A.OutClss = '2' THEN B.OutQty * -1 ELSE B.OutQty END AS InQty, 
                 A.UnitClss 
     FROM        [CommOut]       A 
     LEFT JOIN   [CommOutSub]    B ON A.KeyDate = B.KeyDate AND A.KeySeq = B.KeySeq 
     LEFT JOIN   [Order] AS C ON A.OrderID = C.OrderID 
	 LEFT JOIN	 [mt_Custom] AS D ON A.InCustomID = D.CustomID
	 LEFT JOIN	 [mt_Custom] AS E ON A.OutCustomID = E.CustomID
     WHERE       A.OutDate BETWEEN '20230101' AND '20231204' 
			UNION ALL 
     -- A->B (2)  
     SELECT      2 AS Code, A.KeyDate, A.KeySeq, C.ArticleID, A.OrderID, B.OrderSeq, B.LotNo, A.UnitPrice, A.TranNo, A.OutDate AS IODate, 
				 A.OutRealQty, A.Remark, A.OutCustomID CustomIDA, D.KCustom 'A고객사', A.InCustomID CustomIDB,  E.KCustom 'B고객사',
                 CASE WHEN A.OutClss = '2' THEN B.OutRoll * -1 ELSE B.OutRoll END AS OutRoll, 
                 CASE WHEN A.OutClss = '2' THEN B.OutQty * -1 ELSE B.OutQty END AS OutQty, 
                 0 InRoll, 0 InQty, A.UnitClss 
     FROM        [CommOut]       A 
     LEFT JOIN   [CommOutSub]    B ON A.KeyDate = B.KeyDate AND A.KeySeq = B.KeySeq 
     LEFT JOIN   [Order] AS C ON A.OrderID = C.OrderID 
	 LEFT JOIN	 [mt_Custom] AS D ON A.InCustomID = D.CustomID
	 LEFT JOIN	 [mt_Custom] AS E ON A.OutCustomID = E.CustomID
     WHERE       A.OutDate BETWEEN '20230101' AND '20231204' 
)    A


SELECT * FROM #Subul

drop table #Subul
---------------
--본격쿼리
SELECT   A.Code, A.KeyDate, A.KeySeq, 
         G.KCustom AS Custom, E.KCustom AS CustomA, ISNULL(F.KCustom, '') AS CustomB, 
         B.Article, ISNULL(C.OrderNo, '') AS OrderNo, ISNULL(D.Color, '') AS Color, A.LotNo, A.IODate, 
         A.PrevRoll, A.PrevQty, SUM(A.InRoll) AS InRoll, SUM(A.InQty) AS InQty, SUM(A.OutRoll) AS OutRoll, SUM(A.OutQty) AS OutQty,
         CASE A.Code WHEN 2 THEN A.OutRealQty ELSE 0 END AS OutRealQty, A.UnitPrice, A.Remark, 
         G.CustomID, A.CustomIDA, A.ArticleID, A.UnitClss 
FROM 
( 
     SELECT  Code, '' AS KeyDate, 0 AS KeySeq, ArticleID, OrderID, 0 AS OrderSeq, '' AS LotNo, 0 AS UnitPrice, '' AS TranNo, 
			'' AS IODate, 0 AS OutRealQty,  '' Remark, CustomIDA, '' AS CustomIDB, 
             PrevRoll, PrevQty, 0 AS OutRoll, 0 AS OutQty, 0 AS InRoll, 0 AS InQty, UnitClss 
     FROM    #Prev 
     WHERE   PrevQty <> 0 
			UNION ALL 
     SELECT  Code, KeyDate, KeySeq, ArticleID, OrderID, OrderSeq, LotNo, UnitPrice, TranNo, IODate, OutRealQty, 
             Remark, CustomIDA, CustomIDB, 
             0 AS PrevRoll, 0 AS PrevQty, OutRoll, OutQty, InRoll, InQty, UnitClss 
     FROM    #Subul 
)    A 
LEFT JOIN    [mt_Article]    AS B ON A.ArticleID = B.ArticleID 
LEFT JOIN    [Order]         AS C ON A.OrderID = C.OrderID 
LEFT JOIN    [OrderColor]    AS D ON A.OrderID = D.OrderID AND A.OrderSeq = D.OrderSeq 
LEFT JOIN    [mt_Custom]     AS E ON A.CustomIDA = E.CustomID 
LEFT JOIN    [mt_Custom]     AS F ON A.CustomIDB = F.CustomID 
LEFT JOIN    [mt_Custom]     AS G ON C.CustomID = G.CustomID 
--??이거 왜 썻지??
-->프로그램단에서 AND에 추가적인 조건을 붙이는데, 무족건 참인 이 식이 없으면 부적절한 쿼리문이 되기 때문
WHERE        1=1 
AND          A.CustomIDA <> '0001'
AND          NOT(A.CustomIDA <> '0001' AND A.CustomIDB <> '0001')
GROUP BY A.Code, A.KeyDate, A.KeySeq, G.KCustom, E.KCustom, F.KCustom, B.Article, C.OrderNo, D.Color, A.LotNo, 
         A.IODate, A.PrevRoll, A.PrevQty, A.OutRealQty, A.UnitPrice, A.Remark, G.CustomID, A.CustomIDA, A.ArticleID, A.UnitClss, A.OrderID
ORDER BY G.KCustom, A.ArticleID, A.OrderID, A.IODate, A.KeyDate, A.KeySeq

--임시테이블을 쓰는 이유: 속도향상을 위해
--unionAll:중복포함 Union:중복제거
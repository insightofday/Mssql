SELECT A.CustomID, E.KCustom, F.Article, A.OrderID, A.OrderNo, G.WorkName, A.OrderSeq, A.DesignNo, A.Color, A.ColorQty, A.UnitClss, B.InsDate, B.LotNo, 
	   --검사구역
	   B.InsRoll, B.InsQty, B.InsWgt, 
	   --출고영역
	   B.OutRoll, B.OutQty, B.OutWgt, 
	   --불량영역
	   B.DefectRoll, B.DefectQty, B.DefectWgt,
	   --입고절수(추가한 영역)
	   B.InRoll
FROM 
     (SELECT A.OrderID, A.OrderNo, A.CustomID, B.ArticleID, B.OrderSeq, B.DesignNo, B.Color, B.ColorQty, A.UnitClss, A.WorkId, A.WorkWidth, B.Sort
        FROM [order] A 
       INNER JOIN [OrderColor] B on A.OrderID = B.OrderID 
       WHERE b.OrderSeq > 0) As A 
LEFT JOIN 
--A랑레프트조인하는것:B
      (SELECT W.OrderID, W.OrderSeq, MAX(W.InsDate) AS InsDate, W.LotNo, SUM(W.OutRoll) As OutRoll, Sum(W.OutQty) As OutQty, SUM(W.OutWgt)OutWgt,
              SUM(W.InsQty)InsQty, SUM(W.InsRoll)InsRoll, SUM(W.InsWgt)InsWgt,
              SUM(W.DefectQty)DefectQty, SUM(W.DefectRoll)DefectRoll, SUM(W.DefectWgt)DefectWgt, SUM(W.InRoll)InRoll
         FROM
							------1
             (	SELECT X.OrderID, X.OrderSeq, '' AS InsDate, X.LotNo,
                      CASE WHEN Y.OutClss = '6' THEN SUM(X.OutRoll) * -1 ELSE SUM(X.OutRoll) END AS OutRoll,--outclss==출고구분
                      CASE WHEN Y.OutClss = '6' THEN SUM(X.OutQty) * -1 ELSE SUM(X.OutQty) END As OutQty, SUM(X.Weight) OutWgt,
                      0 InsQty, 0 InsRoll, 0 InsWgt, 0 DefectQty, 0 DefectRoll, 0 DefectWgt, 0 InRoll
                 FROM OutwareSub as X
                 LEFT JOIN OutWare As Y on X.OrderID = Y.OrderID AND X.OutSeq = Y.OutSeq
                GROUP BY X.OrderID,X.OrderSeq,Y.outclss,X.LotNo
               UNION All
						--------2
               SELECT A.Orderid, A.OrderSeq, MAX(A.ExamDate) AS InsDate, A.LotNo, 0 OutRoll, 0 OutQty, 0 OutWgt,
                      SUM(A.CtrlQty) as InsQty, COUNT(A.RollSeq) as InsRoll, SUM(A.StuffWeight)InsWgt,
                      0 DefectQty, 0 DefectRoll, 0 DefectWgt, 0 InRoll
                 FROM [Inspect] As A
                WHERE A.OutReClss = '0'
				AND A.ExamDate BETWEEN '20230129' AND '20231129'
                GROUP BY OrderID,OrderSeq, A.LotNo
               UNION All
					-------3
               SELECT A.Orderid, A.OrderSeq, '' AS InsDate, A.LotNo, 0 OutRoll, 0 OutQty, 0 OutWgt,
                      0 InsQty, 0 InsRoll, 0 InsWgt,
                      SUM(A.CtrlQty) as DefectQty, COUNT(A.RollSeq) as DefectRoll, SUM(A.StuffWeight)DefectWgt, 0 InRoll
                 FROM [Inspect] As A
                WHERE A.OutReClss = '0'
				  AND A.ExamDate BETWEEN '20230129' AND '20231129'
                  AND dbo.fn_GetGradeResult(A.GradeID) = '2'
                GROUP BY OrderID,OrderSeq,A.LotNo
				UNION All
					-----4!!!!!추가(입고절수부분)
				SELECT A.OrderID, A.OrderSeq, '' AS InsDate, A.LotNo, 0 OutRoll, 0 OutQty, 0 OutWgt, 0 InsQty, 0 InsRoll, 0 InsWgt, 0 DefectQty, 0 DefectRoll, 0 DefectWgt,
						SUM(A.InRoll) as Inroll
				FROM [StuffInReturn] As A
				GROUP BY OrderID,OrderSeq,A.LotNo

             ) W
         GROUP BY W.OrderID,W.OrderSeq, W.LotNo
      ) As B on A.OrderID = B.OrderiD AND A.OrderSeq = B.OrderSeq 

LEFT JOIN mt_Custom AS E on A.CustomID = E.CustomID 
LEFT JOIN mt_Article AS F on A.ArticleID = F.ArticleID 
LEFT JOIN mt_Work AS G on A.WorkID = G.WorkID 
LEFT JOIN StuffIN AS H on A.OrderID = H.OrderID
WHERE A.Orderid <> '' 
AND H.StuffDate BETWEEN '20230129' AND '20231129'--입고일자조건 추가
AND (ISNULL(B.InsQty,0) > 0 
AND ISNULL(B.InsQty,0) - ISNULL(B.OutQty,0) - ISNULL(B.DefectQty,0) > 0) 
							--sort가 정렬기준으로 쓰는 이유??sort가 뭐길래??
ORDER BY E.KCustom, A.OrderID, A.Sort


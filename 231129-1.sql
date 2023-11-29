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
				--이너 조인(INNER JOIN)은 두 테이블 간에 매칭되는 행만을 반환하며, 왼쪽 테이블과 오른쪽 테이블의 조인 조건에 부합하는 행만을 선택합니다. 
				--그래서 1:N 관계에서는 보통 이너 조인을 사용하여 부모 테이블과 연결된 자식 테이블의 행을 가져옵니다.
       INNER JOIN [OrderColor] B on A.OrderID = B.OrderID 
	   --??orderseq>0조건을 걸어둔 이유?는 orderseq가0인건 미확정인데 이걸 배제하려고 하는 것
       WHERE b.OrderSeq > 0) As A 
LEFT JOIN 
--A랑레프트조인하는것:B
      (SELECT W.OrderID, W.OrderSeq, MAX(W.InsDate) AS InsDate, W.LotNo, SUM(W.OutRoll) As OutRoll, Sum(W.OutQty) As OutQty, SUM(W.OutWgt)OutWgt,
              SUM(W.InsQty)InsQty, SUM(W.InsRoll)InsRoll, SUM(W.InsWgt)InsWgt,
              SUM(W.DefectQty)DefectQty, SUM(W.DefectRoll)DefectRoll, SUM(W.DefectWgt)DefectWgt, SUM(W.InRoll)InRoll
         FROM
		 --b에서 연산을 위해 w를 서브쿼리로 두고 각각의 테이블에서 원하는 것을 들고옴
							------1
             (	SELECT X.OrderID, X.OrderSeq, '' AS InsDate, X.LotNo,
                      CASE WHEN Y.OutClss = '6' THEN SUM(X.OutRoll) * -1 ELSE SUM(X.OutRoll) END AS OutRoll,--outclss==출고구분
                      CASE WHEN Y.OutClss = '6' THEN SUM(X.OutQty) * -1 ELSE SUM(X.OutQty) END As OutQty, SUM(X.Weight) OutWgt,
					--InsQty 열에 대해 항상 0 값을 반환한다는 의미
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
										--하단이 아니라 여기서 join을 거는 이유는 orderid로 조인을 할 경우 orderid에 해당하는 중복값이 인출되기 때문
				LEFT JOIN StuffIN AS B ON A.KeyDate = B.KeyDate AND A.KeySeq = B.KeySeq
				WHERE B.StuffDate BETWEEN '20230101' AND '20231128'
				GROUP BY A.OrderID, A.OrderSeq,A.LotNo

             ) W
         GROUP BY W.OrderID,W.OrderSeq, W.LotNo
			--키가 같은 것(orderSeq는 암묵적으로 기본키로 쓰임)
      ) As B on A.OrderID = B.OrderiD AND A.OrderSeq = B.OrderSeq 

LEFT JOIN mt_Custom AS E on A.CustomID = E.CustomID 
LEFT JOIN mt_Article AS F on A.ArticleID = F.ArticleID 
LEFT JOIN mt_Work AS G on A.WorkID = G.WorkID 

WHERE A.Orderid <> '' 
AND (ISNULL(B.InsQty,0) > 0 
AND ISNULL(B.InsQty,0) - ISNULL(B.OutQty,0) - ISNULL(B.DefectQty,0) > 0) 
							--sort가 정렬기준으로 쓰는 이유??sort가 뭐길래??
ORDER BY E.KCustom, A.OrderID, A.Sort
----!!!!!!!!!!!!!!!!!!!!!!!검사조건이 빠짐!!!!!!!!!!!!!!!!!!!!!!


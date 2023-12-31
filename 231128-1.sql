SELECT A.CustomID,E.KCustom,F.Article,A.OrderID,A.OrderNo,G.WorkName, A.OrderSeq, A.DesignNo,A.Color,A.ColorQty 
       ,A.UnitClss, B.InsDate, B.LotNo, B.InsRoll,B.InsQty, B.InsWgt, B.OutRoll,B.OutQty, B.OutWgt, B.DefectRoll, B.DefectQty, B.DefectWgt        
FROM 
     (SELECT A.AcptDate,A.OrderID,A.OrderNo,A.CustomID,B.ArticleID,B.OrderSeq,B.DesignNo,B.Color,B.ColorQty,A.UnitClss,A.WorkId,A.WorkWidth, B.Sort 
        FROM [order] A 
       INNER JOIN [OrderColor] B on A.OrderID = B.OrderID 
       WHERE b.OrderSeq > 0) As A 
LEFT JOIN 
      (SELECT W.OrderID, W.OrderSeq, MAX(W.InsDate) AS InsDate, W.LotNo, SUM(W.OutRoll) As OutRoll,Sum(W.OutQty) As OutQty, SUM(W.OutWgt)OutWgt,
              SUM(W.InsQty)InsQty, SUM(W.InsRoll)InsRoll, SUM(W.InsWgt)InsWgt,
              SUM(W.DefectQty)DefectQty, SUM(W.DefectRoll)DefectRoll, SUM(W.DefectWgt)DefectWgt
         FROM
             ( SELECT X.OrderID, X.OrderSeq, '' AS InsDate, X.LotNo,
                      CASE WHEN Y.OutClss = '6' THEN SUM(X.OutRoll) * -1 ELSE SUM(X.OutRoll) END AS OutRoll,
                      CASE WHEN Y.OutClss = '6' THEN SUM(X.OutQty) * -1 ELSE SUM(X.OutQty) END As OutQty, SUM(X.Weight) OutWgt,
                      0 InsQty, 0 InsRoll, 0 InsWgt,
                      0 DefectQty, 0 DefectRoll, 0 DefectWgt
                 FROM OutwareSub as X
                 LEFT JOIN OutWare As Y on X.OrderID = Y.OrderID AND X.OutSeq = Y.OutSeq
                GROUP BY X.OrderID,X.OrderSeq,Y.outclss,X.LotNo
               UNION All
               SELECT A.Orderid, A.OrderSeq, MAX(A.ExamDate) AS InsDate, A.LotNo, 0 OutRoll, 0 OutQty, 0 OutWgt,
                      SUM(A.CtrlQty) as InsQty, COUNT(A.RollSeq) as InsRoll, SUM(A.StuffWeight)InsWgt,
                      0 DefectQty, 0 DefectRoll, 0 DefectWgt
                 FROM [Inspect] As A
                WHERE A.OutReClss = '0'
                GROUP BY OrderID,OrderSeq, A.LotNo
               UNION All
               SELECT A.Orderid, A.OrderSeq, '' AS InsDate, A.LotNo, 0 OutRoll, 0 OutQty, 0 OutWgt,
                      0 InsQty, 0 InsRoll, 0 InsWgt,
                      SUM(A.CtrlQty) as DefectQty, COUNT(A.RollSeq) as DefectRoll, SUM(A.StuffWeight)DefectWgt
                 FROM [Inspect] As A
                WHERE A.OutReClss = '0'
                  AND dbo.fn_GetGradeResult(A.GradeID) = '2'
                GROUP BY OrderID,OrderSeq,A.LotNo
             ) W
         GROUP BY W.OrderID,W.OrderSeq, W.LotNo
      ) As B on A.OrderID = B.OrderiD AND A.OrderSeq = B.OrderSeq 
LEFT JOIN mt_Custom AS E on A.CustomID = E.CustomID 
LEFT JOIN mt_Article AS F on A.ArticleID = F.ArticleID 
LEFT JOIN mt_Work AS G on A.WorkID = G.WorkID 
WHERE A.Orderid <> '' 
AND (ISNULL(B.InsQty,0) > 0 AND ISNULL(B.InsQty,0) - ISNULL(B.OutQty,0) - ISNULL(B.DefectQty,0) > 0) 
ORDER BY E.KCustom, A.OrderID, A.Sort


------------------------------------------------------------------------------------------
 --spdMainKCustom = 1거래처
 --spdMainOrderID = 2관리번호
 --spdMainOrderNo = 3오더넘버
--spdMainWorkClss = 4가공구분
 --spdMainArticle = 5품명
 --spdMainStyleNo = 6스타일넘버(칼럼명:designNo)
 --spdMainColor = 7색상
--spdMainOrderQty = 8수주량
--spdMainOrderUnit = 9단위
 --spdMainInsDate = 10검사일자
 --spdMainLOTNO = 11 lotNO
 --spdMainInsRoll = 12검사>절수		spdMainInsQty = 13검사>수량		spdMainInsWeight = 14검사>중량

--spdMainOutRoll = 15출고>절수		spdMainOutQty = 16출고>수량		spdMainOutWeight = 17출고>중량

--spdMainNoOutRoll = 18미출고>절수	spdMainNoOutQty = 19미출고>수량		spdMainNoOutWeight = 20미출고>중량

--spdMainDefectRoll = 21불량>절수	spdMainDefectQty = 22불량>수량		spdMainDefectWeight = 23불량>중량

--spdMainOrderSeq = 24오더시퀀스>x라적혀있는데 안쓰는걸의미하는것같기도?
																														--검사일(insDate)은 마지막 날만 출력
SELECT A.CustomID, E.KCustom, F.Article, A.OrderID, A.OrderNo, G.WorkName, A.OrderSeq, A.DesignNo, A.Color, A.ColorQty, A.UnitClss, B.InsDate, B.LotNo, 
	   --검사구역
	   B.InsRoll, B.InsQty, B.InsWgt, 
	   --출고영역
	   B.OutRoll, B.OutQty, B.OutWgt, 
	   --불량영역
	   B.DefectRoll, B.DefectQty, B.DefectWgt        
FROM 
     (SELECT A.AcptDate, A.OrderID, A.OrderNo, A.CustomID, B.ArticleID, B.OrderSeq, B.DesignNo, B.Color, B.ColorQty, A.UnitClss, A.WorkId, A.WorkWidth, B.Sort 
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
              SUM(W.DefectQty)DefectQty, SUM(W.DefectRoll)DefectRoll, SUM(W.DefectWgt)DefectWgt
         FROM
							------1
             (	SELECT X.OrderID, X.OrderSeq, '' AS InsDate, X.LotNo,
                      CASE WHEN Y.OutClss = '6' THEN SUM(X.OutRoll) * -1 ELSE SUM(X.OutRoll) END AS OutRoll,--outclss==출고구분
                      CASE WHEN Y.OutClss = '6' THEN SUM(X.OutQty) * -1 ELSE SUM(X.OutQty) END As OutQty, 
								--as생략
					  SUM(X.Weight) OutWgt,
					--InsQty 열에 대해 항상 0 값을 반환한다는 의미
                      0 InsQty, 0 InsRoll, 0 InsWgt, 0 DefectQty, 0 DefectRoll, 0 DefectWgt
                 FROM OutwareSub as X
                 LEFT JOIN OutWare As Y on X.OrderID = Y.OrderID AND X.OutSeq = Y.OutSeq
                GROUP BY X.OrderID,X.OrderSeq,Y.outclss,X.LotNo
               UNION All
						--------2
               SELECT A.Orderid, A.OrderSeq, MAX(A.ExamDate) AS InsDate, A.LotNo, 0 OutRoll, 0 OutQty, 0 OutWgt,
                      SUM(A.CtrlQty) as InsQty, COUNT(A.RollSeq) as InsRoll, SUM(A.StuffWeight)InsWgt,
                      0 DefectQty, 0 DefectRoll, 0 DefectWgt
                 FROM [Inspect] As A
                WHERE A.OutReClss = '0'
                GROUP BY OrderID,OrderSeq, A.LotNo
               UNION All
					-------3
               SELECT A.Orderid, A.OrderSeq, '' AS InsDate, A.LotNo, 0 OutRoll, 0 OutQty, 0 OutWgt,
                      0 InsQty, 0 InsRoll, 0 InsWgt,
                      SUM(A.CtrlQty) as DefectQty, COUNT(A.RollSeq) as DefectRoll, SUM(A.StuffWeight)DefectWgt
                 FROM [Inspect] As A
                WHERE A.OutReClss = '0'
                  AND dbo.fn_GetGradeResult(A.GradeID) = '2'
                GROUP BY OrderID,OrderSeq,A.LotNo

             ) W
         GROUP BY W.OrderID,W.OrderSeq, W.LotNo
			--키가 같은 것(orderSeq는 암묵적으로 기본키로 쓰임)
      ) As B on A.OrderID = B.OrderiD AND A.OrderSeq = B.OrderSeq 

LEFT JOIN mt_Custom AS E on A.CustomID = E.CustomID 

LEFT JOIN mt_Article AS F on A.ArticleID = F.ArticleID 

LEFT JOIN mt_Work AS G on A.WorkID = G.WorkID 

WHERE A.Orderid <> '' 
AND A.Acptdate BETWEEN '20230128' AND '20231128' 
AND (ISNULL(B.InsQty,0) > 0 
AND ISNULL(B.InsQty,0) - ISNULL(B.OutQty,0) - ISNULL(B.DefectQty,0) > 0) 

ORDER BY E.KCustom, A.OrderID, A.Sort

select * from Inspect where CtrlQty=0
--입고입력쪽 쿼리
 SELECT  ISNULL(B.Article, '') As Article, 
            CASE WHEN ISNULL(A.DesignNo, '') = '' THEN  A.Color  
                 ELSE  A.Color + '(' + ISNULL(A.DesignNo, '') + ')' 
            END As Color,  
            ISNULL(A.ColorRoll, 0) As ColorRoll, ISNULL(A.ColorQty, 0) As ColorQty, A.OrderWeight, 
            ISNULL(C.StuffInRoll, 0) As StuffInRoll, ISNULL(C.StuffInQty, 0) As StuffInQty, ISNULL(C.StuffINWeight, 0) AS StuffWeight, ISNULL(D.PassRoll, 0) As PassRoll, ISNULL(D.PassQty, 0) As PassQty, ISNULL(D.InspectWeight, 0) AS PassWeight,
            ISNULL(E.DefectRoll, 0) As DefectRoll, ISNULL(E.DefectQty, 0) As DefectQty, ISNULL(E.DefectWeight, 0) AS DefectWeight, ISNULL(F.OutRoll, 0) As OutRoll, ISNULL(F.OutQty, 0) As OutQty, ISNULL(F.OutWeight, 0) AS OutWeight,   
            ISNULL(D.PassRoll,0) + ISNULL(E.DefectRoll, 0) - ISNULL(F.OutRoll, 0) as JRoll, ISNULL(D.PassQty,0) + ISNULL(E.DefectQty, 0) - ISNULL(F.OutQty, 0) as JQty, ISNULL(D.InspectWeight,0) + ISNULL(E.DefectWeight, 0) - ISNULL(F.OutWeight, 0) AS JWeight, A.Remark, 
            ISNULL(A.OrderWeight, 0) - ISNULL(F.OutWeight, 0) AS OutMinusWeight, ISNULL(A.OrderWeight, 0) - ISNULL(C.StuffINWeight, 0) AS StuffMinusWeight, '' AS GubunColor,  '' AS LotNo, A.OrderSeq  
  FROM OrderColor A
           LEFT JOIN mt_Article B on A.ArticleID = B.ArticleID
           LEFT JOIN (
                       SELECT A.OrderID, A.OrderSeq,
                              SUM(CASE WHEN B.StuffClss <> '3' THEN A.InRoll ELSE A.InRoll * -1 END) As StuffInRoll, 
                              SUM(CASE WHEN B.StuffClss <> '3' THEN A.Qty ELSE A.Qty * -1 END) As StuffInQty,
                              SUM(CASE WHEN B.StuffClss <> '3' THEN StuffINWeight ELSE StuffINWeight * -1 END) As StuffINWeight
                       FROM StuffINReturn AS A
                       LEFT JOIN StuffIN AS B on A.KeyDate = B.KeyDate AND A.KeySeq = B.KeySeq 
                       Group By A.OrderID, A.OrderSeq
           ) C on A.OrderID = C.OrderID and A.OrderSeq = C.OrderSeq 
           LEFT JOIN (SELECT OrderID, OrderSeq, COUNT(*) As PassRoll, SUM(CtrlQty) As PassQty, SUM(StuffWeight) AS InspectWeight 
                      FROM Inspect WHERE dbo.fn_GetGradeResult(GradeID) = '1' 
                      Group By OrderID, OrderSeq  
           ) D on A.OrderID = D.OrderID and A.OrderSeq = D.OrderSeq 
           LEFT JOIN (SELECT OrderID, OrderSeq, COUNT(*) As DefectRoll, SUM(CtrlQty) As DefectQty, SUM(StuffWeight) AS DefectWeight  
                      FROM Inspect WHERE dbo.fn_GetGradeResult(GradeID) = '2' 
                      Group By OrderID, OrderSeq  
           ) E on A.OrderID = E.OrderID and A.OrderSeq = E.OrderSeq 
           LEFT JOIN (
                       SELECT A.OrderID, A.OrderSeq, 
                              SUM(CASE WHEN B.OutClss <> '6' THEN 1 ELSE -1 END) As OutRoll, SUM(A.NOutQty) As OutQty, SUM(Weight) AS OutWeight 
                       FROM OutWareSub AS A
                       LEFT JOIN Outware AS B on A.OrderID = B.OrderID AND A.OutSeq = B.OutSeq
                       WHERE B.OutClss <> '7' 
                       GROUP BY A.OrderID, A.OrderSeq
           ) F on A.OrderID = F.OrderID and A.OrderSeq = F.OrderSeq 
 WHERE A.OrderID = '2024040022' AND A.OrderSeq > 0
 Order By A.Color, A.Sort


--수주등록
 SELECT  ISNULL(B.Article, '') As Article, 
            CASE WHEN ISNULL(A.DesignNo, '') = '' THEN  A.Color  
                 ELSE  A.Color + '(' + ISNULL(A.DesignNo, '') + ')' 
            END As Color,  
            ISNULL(A.ColorRoll, 0) As ColorRoll, ISNULL(A.ColorQty, 0) As ColorQty, A.OrderWeight, 
            ISNULL(C.StuffInRoll, 0) As StuffInRoll, ISNULL(C.StuffInQty, 0) As StuffInQty, ISNULL(C.StuffINWeight, 0) AS StuffWeight, ISNULL(D.PassRoll, 0) As PassRoll, ISNULL(D.PassQty, 0) As PassQty, ISNULL(D.InspectWeight, 0) AS PassWeight,
            ISNULL(E.DefectRoll, 0) As DefectRoll, ISNULL(E.DefectQty, 0) As DefectQty, ISNULL(E.DefectWeight, 0) AS DefectWeight, ISNULL(F.OutRoll, 0) As OutRoll, ISNULL(F.OutQty, 0) As OutQty, ISNULL(F.OutWeight, 0) AS OutWeight,   
            ISNULL(D.PassRoll,0) + ISNULL(E.DefectRoll, 0) - ISNULL(F.OutRoll, 0) as JRoll, ISNULL(D.PassQty,0) + ISNULL(E.DefectQty, 0) - ISNULL(F.OutQty, 0) as JQty, ISNULL(D.InspectWeight,0) + ISNULL(E.DefectWeight, 0) - ISNULL(F.OutWeight, 0) AS JWeight, A.Remark, 
            ISNULL(A.OrderWeight, 0) - ISNULL(F.OutWeight, 0) AS OutMinusWeight, ISNULL(A.OrderWeight, 0) - ISNULL(C.StuffINWeight, 0) AS StuffMinusWeight, '' AS GubunColor,  '' AS LotNo, A.OrderSeq  
  FROM OrderColor A
           LEFT JOIN mt_Article B on A.ArticleID = B.ArticleID
           LEFT JOIN (
                       SELECT A.OrderID, A.OrderSeq, A.LotEndClss,
                              SUM(CASE WHEN B.StuffClss <> '3' THEN A.InRoll ELSE A.InRoll * -1 END) As StuffInRoll, 
                              SUM(CASE WHEN B.StuffClss <> '3' THEN A.Qty ELSE A.Qty * -1 END) As StuffInQty,
                              SUM(CASE WHEN B.StuffClss <> '3' THEN StuffINWeight ELSE StuffINWeight * -1 END) As StuffINWeight
                       FROM StuffINReturn AS A
                       LEFT JOIN StuffIN AS B on A.KeyDate = B.KeyDate AND A.KeySeq = B.KeySeq 
                       WHERE A.LotEndClss = '0'
					  -- and a.orderid='2024040078'
                       Group By A.OrderID, A.OrderSeq, A.LotEndClss
           ) C on A.OrderID = C.OrderID and A.OrderSeq = C.OrderSeq 
           LEFT JOIN (SELECT OrderID, OrderSeq, COUNT(*) As PassRoll, SUM(CtrlQty) As PassQty, SUM(StuffWeight) AS InspectWeight 
                      FROM Inspect WHERE dbo.fn_GetGradeResult(GradeID) = '1' 
                       --AND LotEndClss = '0'
					   and orderid='2024040022'
                      Group By OrderID, OrderSeq  
           ) D on A.OrderID = D.OrderID and A.OrderSeq = D.OrderSeq 
           LEFT JOIN (SELECT OrderID, OrderSeq, COUNT(*) As DefectRoll, SUM(CtrlQty) As DefectQty, SUM(StuffWeight) AS DefectWeight  
                      FROM Inspect WHERE dbo.fn_GetGradeResult(GradeID) = '2' 
                       AND LotEndClss = '0'
					   --and orderid='2024040078'
                      Group By OrderID, OrderSeq  
           ) E on A.OrderID = E.OrderID and A.OrderSeq = E.OrderSeq 
           LEFT JOIN (
                       SELECT A.OrderID, A.OrderSeq, 
                              SUM(CASE WHEN B.OutClss <> '6' THEN 1 ELSE -1 END) As OutRoll, SUM(A.NOutQty) As OutQty, SUM(Weight) AS OutWeight 
                       FROM OutWareSub AS A
                       LEFT JOIN Outware AS B on A.OrderID = B.OrderID AND A.OutSeq = B.OutSeq
                       LEFT JOIN Inspect AS C ON A.OrderID = C.OrderID AND A.RollSeq = C.RollSeq
                       WHERE B.OutClss <> '7' 
                       AND C.LotEndClss = '0'
					  --  and a.orderid='2024040078'
                       GROUP BY A.OrderID, A.OrderSeq
           ) F on A.OrderID = F.OrderID and A.OrderSeq = F.OrderSeq 
 WHERE A.OrderID = '2024040078' AND A.OrderSeq > 0
AND C.LotEndClss = '0'
 Order By A.Color, A.Sort



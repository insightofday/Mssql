
CREATE FUNCTION fn_Format(@nValue INTEGER, @nLen SMALLINT) RETURNS VARCHAR(255)
AS
BEGIN
	DECLARE @sFormat VARCHAR(10), @sValue VARCHAR(255), @ret VARCHAR(255)
	SET @sFormat = '%0' + CAST(@nLen AS VARCHAR(2)) + 's'
	SET @sValue = CAST (@nValue AS VARCHAR(255))
	EXEC master..xp_sprintf @ret OUTPUT, @sFormat, @sValue
	RETURN @ret
END



SELECT A.OrderID, A.OrderNo, B.KCustom, C.ArticleNo, C.Article, F.StuffWidth As WorkWidthName, Z.OutSeq, Z.OutDate, Z.OutQty 
FROM [Order] AS A 
LEFT JOIN mt_Custom AS B ON A.CustomID = B.CustomID 
LEFT JOIN mt_Article AS C ON A.ArticleID = C.ArticleID 
LEFT JOIN mt_StuffWidth AS F ON A.WorkWidth = F.StuffWidthID 
LEFT JOIN OutWareLoss AS Z ON A.OrderID = Z.OrderID 
WHERE A.OrderID = '2023050115' 
ORDER BY Z.OutDate, Z.OutSeq 


SELECT SUM(A.StuffQty -  A.OutRealQty) AS JegoQty 
FROM( 
     SELECT A.OrderID, A.TotRoll As StuffRoll, A.TotQtyY As StuffQty, OutRoll = 0, OutQty = 0, OutRealQty = 0, 
     A.StuffDate As IODate, A.Custom AS Custom, A.Remark, A.StuffClss AS IOClss, cls = '1', A.InptDate 
     FROM stuffin AS A 
     WHERE A.OrderID = '2023050115' 
 UNION ALL 
     SELECT A.OrderID, StuffRoll = 0,StuffQty = 0, A.OutRoll, A.OutQty, A.OutRealQty, 
     A.OutDate As IODate, A.OutCustom AS Custom, A.Remark, A.OutClss AS IOClss, Cls = '2', A.InptDate 
     FROM OutWare As A 
     WHERE A.OrderID = '2023050115' 
 UNION ALL 
     SELECT A.OrderID, StuffRoll = 0,StuffQty = 0, 0 AS OutRoll, 0 AS OutQty, A.OutQty AS OutRealQty, 
     A.OutDate As IODate, '' AS Custom, A.Remark, '5' AS IOClss, Cls = '2', A.InptDate 
     FROM OutWareLoss As A 
     WHERE A.OrderID = '2023050115' 
) AS A 




SELECT A.CloseClss, A.AcptDate, A.OrderID, A.OrderNo, A.CustomID, B.KCustom, C.Article, C.ArticleNo, 
 D.WorkName, E.StuffWidth AS WorkWidthName, A.ChunkRate, A.LossRate, A.ColorCnt, A.DvlyDate, A.OrderQty, A.UnitClss, 
 ISNULL(F.StuffINQty, 0) AS INQty,  
 ISNULL(Y1.OutQty, 0) AS OutQty, 
 ISNULL(Y2.OutQty, 0) AS OutQtyA, 
 ISNULL(Y3.OutQty, 0) AS OutQtyS, 
 ISNULL(Y4.OutQty, 0) AS OutQtyL 
FROM [Order] AS A 
LEFT JOIN mt_Custom AS B ON A.CustomID = B.CustomID 
LEFT JOIN mt_Article AS C ON A.ArticleID = C.ArticleID 
LEFT JOIN mt_Work AS D ON A.WorkID = D.WorkID 
LEFT JOIN mt_StuffWidth AS E ON A.WorkWidth = E.StuffWidthID  
LEFT JOIN (SELECT OrderID, SUM(Qty) AS StuffINQty  
        FROM StuffAssign  
        GROUP BY OrderID) AS F ON A.OrderID = F.OrderID 
LEFT JOIN (SELECT OrderID, SUM(OutQty) AS OutQty 
         FROM Outware 
         WHERE OutClss IN ('1', '6') 
         GROUP BY OrderID) AS Y1 ON A.OrderID = Y1.OrderID 
LEFT JOIN (SELECT OrderID, SUM(OutQty) AS OutQty 
         FROM Outware 
         WHERE OutClss = '3'
         GROUP BY OrderID) AS Y2 ON A.OrderID = Y2.OrderID 
LEFT JOIN (SELECT OrderID, SUM(OutQty) AS OutQty 
         FROM Outware 
         WHERE OutClss = '9' 
         GROUP BY OrderID) AS Y3 ON A.OrderID = Y3.OrderID 
LEFT JOIN (SELECT OrderID, SUM(OutQty) AS OutQty 
         FROM OutwareLoss 
         GROUP BY OrderID) AS Y4 ON A.OrderID = Y4.OrderID 
WHERE A.OrderID <> '0000000000' 
AND ISNULL(Y4.OrderID,'') = '' 
ORDER BY ISNULL(Y1.OutQty,0) - A.OrderQty DESC,  A.OrderID 





 SELECT A.CloseClss, A.AcptDate, A.OrderID, A.OrderNo, A.CustomID, B.KCustom, C.Article, C.ArticleNo, 
 D.WorkName, E.StuffWidth AS WorkWidthName, A.ChunkRate, A.LossRate, A.ColorCnt, A.DvlyDate, A.OrderQty, A.UnitClss, 
 ISNULL(F.StuffINQty, 0) AS INQty,  
 ISNULL(Y1.OutQty, 0) AS OutQty, 
 ISNULL(Y2.OutQty, 0) AS OutQtyA, 
 ISNULL(Y3.OutQty, 0) AS OutQtyS, 
 ISNULL(Y4.OutQty, 0) AS OutQtyL 
FROM [Order] AS A 
LEFT JOIN mt_Custom AS B ON A.CustomID = B.CustomID 
LEFT JOIN mt_Article AS C ON A.ArticleID = C.ArticleID 
LEFT JOIN mt_Work AS D ON A.WorkID = D.WorkID 
LEFT JOIN mt_StuffWidth AS E ON A.WorkWidth = E.StuffWidthID  
LEFT JOIN (SELECT OrderID, SUM(Qty) AS StuffINQty  
        FROM StuffAssign  
        GROUP BY OrderID) AS F ON A.OrderID = F.OrderID 
LEFT JOIN (SELECT OrderID, SUM(OutQty) AS OutQty 
         FROM Outware 
         WHERE OutClss IN ('1', '6') 
         GROUP BY OrderID) AS Y1 ON A.OrderID = Y1.OrderID 
LEFT JOIN (SELECT OrderID, SUM(OutQty) AS OutQty 
         FROM Outware 
         WHERE OutClss = '3'
         GROUP BY OrderID) AS Y2 ON A.OrderID = Y2.OrderID 
LEFT JOIN (SELECT OrderID, SUM(OutQty) AS OutQty 
         FROM Outware 
         WHERE OutClss = '9' 
         GROUP BY OrderID) AS Y3 ON A.OrderID = Y3.OrderID 
LEFT JOIN (SELECT OrderID, SUM(OutQty) AS OutQty 
         FROM OutwareLoss 
         GROUP BY OrderID) AS Y4 ON A.OrderID = Y4.OrderID 
WHERE A.OrderID <> '0000000000' 
AND (A.OrderNO LIKE '%5%' OR A.OrderID LIKE '%5%') 
AND ISNULL(Y4.OrderID,'') = '' 
ORDER BY ISNULL(Y1.OutQty,0) - A.OrderQty DESC,  A.OrderID 
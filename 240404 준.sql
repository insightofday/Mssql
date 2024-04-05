 SELECT A.OrderID, B.OrderSeq, A.OrderNo, D.KCustom, C.Article, B.DesignNo, B.Color, A.UnRemark AS Delivery, B.ColorQty, SUM(B.NetQty) NetQty, F.NoOutQty, 
 B.Remark,SUM( G.InsQty) InsQty, SUM(G.OutQty) OutQty
 FROM [DS20] AS A 
 LEFT JOIN DS21 B ON A.OrderID = B.OrderID 
 LEFT JOIN DS01 C ON A.ArticleID = C.ArticleID 
 LEFT JOIN DS02 D ON A.CustomID = D.CustomID 
 LEFT JOIN ( 
             SELECT OrderID, ColorID, SUM(CASE WHEN gradeclss = 0 THEN 1 ELSE 0 END) InsQty 
             FROM DS24 
             GROUP BY OrderID, ColorID 
           ) E ON A.OrderID = E.OrderID AND B.ColorID = E.ColorID 
 LEFT JOIN ( 
             SELECT A.OrderID, A.ColorID, SUM(A.CtrlQty) NoOutQty 
             FROM DS24 A 
             LEFT JOIN vw_PDOutRoll_RollList B ON A.OrderID = B.OrderID AND A.RollID = B.RollID 
             WHERE ISNULL(B.RollID,0) = 0 
             GROUP BY A.OrderID, A.ColorID 
           ) F ON A.OrderID = F.OrderID AND B.ColorID = F.ColorID 
LEFT JOIN [#Temp] AS G ON B.OrderID = G.OrderID AND B.OrderSeq = G.OrderSeq
 WHERE A.OrderID = '2024020058' 
    AND B.OrderSeq = 3
 GROUP BY  A.OrderID, B.OrderSeq, A.OrderNo, D.KCustom, C.Article, B.DesignNo, B.Color, A.UnRemark , B.ColorQty, F.NoOutQty,  B.Remark




----------------------------------------------변경전
 SELECT A.OrderID, B.OrderSeq, A.OrderNo, D.KCustom, C.Article, B.DesignNo, B.Color, A.UnRemark AS Delivery, B.ColorQty, B.NetQty, E.InsQty, F.NoOutQty, B.Remark,G.InQty, G.DTPQty, G.PressQty, G.InsQty, G.OutQty 
 FROM [DS20] AS A 
 LEFT JOIN DS21 B ON A.OrderID = B.OrderID 
 LEFT JOIN DS01 C ON A.ArticleID = C.ArticleID 
 LEFT JOIN DS02 D ON A.CustomID = D.CustomID 
 LEFT JOIN ( 
             SELECT OrderID, ColorID, SUM(CASE WHEN gradeclss = 0 THEN 1 ELSE 0 END) InsQty 
             FROM DS24 
             GROUP BY OrderID, ColorID 
           ) E ON A.OrderID = E.OrderID AND B.ColorID = E.ColorID 
 LEFT JOIN ( 
             SELECT A.OrderID, A.ColorID, SUM(A.CtrlQty) NoOutQty 
             FROM DS24 A 
             LEFT JOIN vw_PDOutRoll_RollList B ON A.OrderID = B.OrderID AND A.RollID = B.RollID 
             WHERE ISNULL(B.RollID,0) = 0 
             GROUP BY A.OrderID, A.ColorID 
           ) F ON A.OrderID = F.OrderID AND B.ColorID = F.ColorID 
LEFT JOIN [#Temp] AS G ON B.OrderID = G.OrderID AND B.OrderSeq = G.OrderSeq
 WHERE A.OrderID = '2024030046' 
   AND B.OrderSeq = 4



 -------------------------------변경후
 SELECT A.OrderID, B.OrderSeq, A.OrderNo, D.KCustom, C.Article, B.DesignNo, B.Color, A.UnRemark AS Delivery, B.ColorQty, B.NetQty, F.NoOutQty, B.Remark,
 SUM( G.InsQty) InsQty, SUM(G.OutQty) OutQty 
 FROM [DS20] AS A 
 LEFT JOIN DS21 B ON A.OrderID = B.OrderID 
 LEFT JOIN DS01 C ON A.ArticleID = C.ArticleID 
 LEFT JOIN DS02 D ON A.CustomID = D.CustomID 
 LEFT JOIN ( 
             SELECT OrderID, ColorID, SUM(CASE WHEN gradeclss = 0 THEN 1 ELSE 0 END) InsQty 
             FROM DS24 
             GROUP BY OrderID, ColorID 
           ) E ON A.OrderID = E.OrderID AND B.ColorID = E.ColorID 
 LEFT JOIN ( 
             SELECT A.OrderID, A.ColorID, SUM(A.CtrlQty) NoOutQty 
             FROM DS24 A 
             LEFT JOIN vw_PDOutRoll_RollList B ON A.OrderID = B.OrderID AND A.RollID = B.RollID 
             WHERE ISNULL(B.RollID,0) = 0 
             GROUP BY A.OrderID, A.ColorID 
           ) F ON A.OrderID = F.OrderID AND B.ColorID = F.ColorID 
LEFT JOIN [#Temp] AS G ON B.OrderID = G.OrderID AND B.OrderSeq = G.OrderSeq
 WHERE A.OrderID = '2024030046' 
   AND B.OrderSeq = 4
 GROUP BY  A.OrderID, B.OrderSeq, A.OrderNo, D.KCustom, C.Article, B.DesignNo, B.Color, A.UnRemark , B.ColorQty, F.NoOutQty,  B.Remark, B.NetQty



 SELECT D.KCustom, B.OrderNo, E.Article, C.DesignNo, C.Color, A.InsQty, A.NoOutQty, B.UnRemark AS Delivery  ,A.outqty
      , A.PlanDate, A.ReferRemark, A.SpecialRemark, A.Remark, A.KeyDate, A.KeySeq, A.OrderID, A.OrderSeq, C.Remark AS outcustom  
 FROM OutwarePlan A 
 LEFT JOIN DS20 B ON A.OrderID = B.OrderID 
 LEFT JOIN DS21 C ON A.OrderID = C.OrderID AND A.OrderSeq = C.OrderSeq 
 LEFT JOIN DS02 D ON B.CustomID = D.CustomID
 LEFT JOIN DS01 E ON B.ArticleID = E.ArticleID
 WHERE 1=1 
AND A.PlanDate BETWEEN '20240404' AND '20240404' 
ORDER BY A.PlanDate, B.OrderNO 


select * from outwareplan
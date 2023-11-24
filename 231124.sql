
 SELECT A.OrderID, A.OrderNO, A.KCustom, A.Article, A.Work, A.ColorID, A.Color, A.DesignNO, A.ColorQty, A.InspectClss,
 A.OrderUnit, A.WidthID, A.Width, A.OrderSeq, A.BaseValue1, A.LimitValue1, A.BaseLength, A.Buyer, A.TagItem, A.SKClss, A.PointClss,  A.GrossClss, A.LossClss,
 SUM(A.PassRoll) AS PassRoll, SUM(A.PassQty) AS PassQty, SUM(A.DefectRoll) AS DefectRoll,
 SUM(A.DefectQty) AS DefectQty,  SUM(A.PassConQty) as PassConQty, SUM(A.DefectConQty) as DefectConQty,
 SUM(A.CutQty) AS CutQty, SUM(A.LossQty) AS LossQty,
 SUM(A.SampleQty) AS SampleQty, SUM(A.StuffQty) AS StuffQty, SUM(A.InspectQty) AS InspectQty,
 SUM(A.InspectRoll) As InspectRoll, A.GradeChk
 FROM (SELECT B.OrderID, C.OrderNO, G.Article, H.Work, B.ColorID, B.Color, B.DesignNO, B.ColorQty, C.InspectClss, C.OrderUnit, C.WidthID, E.Width, C.OrderSeq,
 KCustom = (SELECT KCustom FROM DS02 WHERE CustomID = C.CustomID),
 BaseValue1 = CASE C.CalcClss WHEN '0' THEN C.BaseValue1 ELSE C.BaseValue1*100 END,
 LimitValue1 = CASE C.CalcClss WHEN '0' THEN C.LimitValue1 ELSE C.LimitValue1*100 END,
 C.BaseLength, C.Buyer, C.TagItem, C.SKClss, C.PointClss, C.GrossClss, C.LossClss, C.GradeChk,
 PassRoll = CASE WHEN (D.GradeClss < c.DefectClss ) THEN COUNT(D.RollID) ELSE 0 END,
 PassQty = CASE WHEN (D.GradeClss < c.DefectClss) THEN SUM(D.CtrlQty) ELSE 0 END,
 DefectRoll = CASE WHEN (D.GradeClss >= c.DefectClss) THEN COUNT(D.RollID) ELSE 0 END,
 DefectQty = CASE WHEN (D.GradeClss >= c.DefectClss) THEN SUM(D.CtrlQty) ELSE 0 END,
 PassConQty = CASE WHEN (D.GradeClss < c.DefectClss) THEN SUM(D.CtrlQtyY) ELSE 0 END,
 DefectConQty = CASE WHEN (D.GradeClss >= c.DefectClss ) THEN SUM(D.CtrlQtyY) ELSE 0 END,
 SUM(D.CutQty) AS CutQty, SUM(D.LossQty) AS LossQty, SUM(D.SampleQty) AS SampleQty,
 SUM(D.StuffQty) AS StuffQty, SUM(D.CtrlQty) AS InspectQty, COUNT(D.RollID) AS InspectRoll
 FROM [DS21] B, [DS20] C, [DS24] D, [DS13] E, DS01 G, [DS19] H
 Where B.OrderID = C.OrderID And B.OrderID = D.OrderID
 AND B.ColorID = D.ColorID AND C.WidthID = E.WidthID
 AND C.ArticleID = G.ArticleID
 AND C.WorkID = H.WorkID AND C.InspectClss = '0'
 AND D.ExamDate BETWEEN '20230124' AND '20231124'
 AND C.GradeChk IS NOT null
 GROUP BY B.OrderID, C.OrderNO, c.DefectClss, C.CustomId1, C.CustomID, G.Article, H.Work, B.ColorID, B.Color, B.DesignNO, B.ColorQty,
 C.InspectClss, C.OrderUnit, C.WidthID, E.Width, C.OrderSeq, C.BaseValue1, C.LimitValue1, C.BaseLength, C.CalcClss,
 D.CalcValue1, D.CalcValue2, C.LimitValue1, C.LimitValue2,  C.BaseLength, C.Buyer, C.TagItem, C.SKClss, C.PointClss, C.GrossClss, D.GradeClss, C.LossClss, C.GradeChk) A
 GROUP BY A.OrderID, A.OrderNO, A.KCustom, A.Article, A.Work, A.ColorID, A.Color, A.DesignNO, A.ColorQty, A.InspectClss,
 A.OrderUnit , A.WidthID, A.Width, A.OrderSeq, A.BaseValue1, A.LimitValue1, A.BaseLength, A.Buyer, A.TagItem, A.SKClss, A.Pointclss, A.GrossClss, A.LossClss, A.GradeChk


 -----------------------------------------------------------------------


  SELECT A.OrderID, A.OrderNO, A.KCustom, A.Article, A.Work, A.OrderQty, A.InspectClss, A.OrderUnit, A.WidthID,
 A.Width, A.OrderSeq, A.BaseValue1, A.LimitValue1, A.BaseLength, A.Buyer, A.TagItem, A.SKClss, A.PointClss, A.GrossClss, A.LossClss,
 SUM(A.PassRoll) AS PassRoll, SUM(A.PassQty) AS PassQty, SUM(A.DefectRoll) AS DefectRoll,
 SUM(A.DefectQty) AS DefectQty, SUM(A.PassConQty) as PassConQty, SUM(A.DefectConQty) as DefectConQty,
 SUM(A.CutQty) AS CutQty, SUM(A.LossQty) AS LossQty,
 SUM(A.SampleQty) AS SampleQty, SUM(A.StuffQty) AS StuffQty, SUM(A.InspectQty) AS InspectQty,
 SUM(A.InspectRoll) AS InspectRoll, C.SKTeam, D.SKPerson, F.KCustom AS JejoCustom,
 (SELECT TOP 1 Y.KCustom FROM DS22 X, DS02 Y WHERE X.OrderID = A.OrderID AND X.CustomID2 = Y.CustomID GROUP BY Y.KCustom ORDER BY SUM(X.StuffQty) DESC) AS WorkCustom,
 B.GradeChk
 FROM (SELECT C.OrderID, C.OrderNO, G.Article, H.Work, C.OrderQty, C.InspectClss, C.OrderUnit, C.WidthID,C.GradeChk,
 KCustom = (SELECT KCustom FROM DS02 WHERE CustomID = C.CustomID),
 E.Width, C.OrderSeq,
 BaseValue1 = CASE C.CalcClss WHEN '0' THEN C.BaseValue1 ELSE C.BaseValue1*100 END,
 LimitValue1 = CASE C.CalcClss WHEN '0' THEN C.LimitValue1 ELSE C.LimitValue1*100 END,
 C.BaseLength, C.Buyer, C.TagItem, C.SKClss, C.PointClss, C.GrossClss, C.LossClss,
 PassRoll = CASE WHEN (D.GradeClss < C.DefectClss ) THEN COUNT(D.RollID) ELSE 0 END,
 PassQty = CASE WHEN (D.GradeClss < C.DefectClss) THEN SUM(D.CtrlQty) ELSE 0 END,
 DefectRoll = CASE WHEN (D.GradeClss >= C.DefectClss ) THEN COUNT(D.RollID) ELSE 0 END,
 DefectQty = CASE WHEN (D.GradeClss >= C.DefectClss) THEN SUM(D.CtrlQty) ELSE 0 END,
 PassConQty = CASE WHEN (D.GradeClss < C.DefectClss) THEN SUM(D.CtrlQtyY) ELSE 0 END,
 DefectConQty = CASE WHEN (D.GradeClss >= C.DefectClss) THEN SUM(D.CtrlQtyY) ELSE 0 END,
 SUM(D.CutQty) AS CutQty, SUM(D.LossQty) AS LossQty, SUM(D.SampleQty) AS SampleQty,
 SUM(D.StuffQty) AS StuffQty, SUM(D.CtrlQty) AS InspectQty, COUNT(D.RollID) AS InspectRoll

 FROM [DS20] C, [DS24] D, [DS13] E, DS01 G, [DS19] H
 Where C.OrderID = D.OrderID And C.WidthID = E.WidthID
 AND C.ArticleID = G.ArticleID
 AND C.WorkID = H.WorkID AND C.InspectClss = '0'
 AND D.ExamDate BETWEEN '20230124' AND '20231124'
 GROUP BY C.OrderID, C.OrderNO, C.CustomId1, C.CustomID, G.Article, H.Work, C.OrderQty,C.GradeChk,
 C.InspectClss, C.OrderUnit, C.WidthID, E.Width, C.OrderSeq, C.BaseValue1, C.LimitValue1, C.BaseLength, C.CalcClss,
 D.CalcValue1, D.CalcValue2, C.LimitValue1, C.LimitValue2, C.BaseLength, C.Buyer, C.TagItem, C.SKClss, C.PointClss, C.GrossClss, C.LossClss, D.GradeClss,C.DefectClss ) A,
 [DS20] B, [DS59] C, [DS63] D, DS02 F
 WHERE A.OrderID = B.OrderID AND B.SKTeamID *= C.SKTeamID AND B.SKPersonID *= D.SKPersonID AND B.CustomID = F.CustomID
 GROUP BY A.OrderID, A.OrderNO, A.KCustom, A.Article, A.Work, A.OrderQty, A.InspectClss,  B.GradeChk,
 A.OrderUnit , A.WidthID, A.Width, A.OrderSeq, A.BaseValue1, A.LimitValue1, A.BaseLength, A.Buyer, A.TagItem, A.SKClss, A.Pointclss, A.GrossClss, A.LossClss, C.SKTeam, D.SKPerson, F.kCustom 


 ------------------------------------------

 SELECT A.OrderID, A.OrderNO, A.KCustom, A.Article, A.Work, A.OrderQty, A.InspectClss, A.OrderUnit, A.WidthID,
 A.Width, A.OrderSeq, A.BaseValue1, A.LimitValue1, A.BaseLength, A.Buyer, A.TagItem, A.SKClss, A.PointClss, A.GrossClss, A.LossClss,
 SUM(A.PassRoll) AS PassRoll, SUM(A.PassQty) AS PassQty, SUM(A.DefectRoll) AS DefectRoll,
 SUM(A.DefectQty) AS DefectQty, SUM(A.PassConQty) as PassConQty, SUM(A.DefectConQty) as DefectConQty,
 SUM(A.CutQty) AS CutQty, SUM(A.LossQty) AS LossQty,
 SUM(A.SampleQty) AS SampleQty, SUM(A.StuffQty) AS StuffQty, SUM(A.InspectQty) AS InspectQty,
 SUM(A.InspectRoll) AS InspectRoll, C.SKTeam, D.SKPerson, F.KCustom AS JejoCustom,
 (SELECT TOP 1 Y.KCustom FROM DS22 X, DS02 Y WHERE X.OrderID = A.OrderID AND X.CustomID2 = Y.CustomID GROUP BY Y.KCustom ORDER BY SUM(X.StuffQty) DESC) AS WorkCustom,  B.GradeChk
 FROM (SELECT C.OrderID, C.OrderNO, G.Article, H.Work, C.OrderQty, C.InspectClss, C.OrderUnit, C.WidthID, C.GradeChk,
 KCustom = (SELECT KCustom FROM DS02 WHERE CustomID = C.CustomID),
 E.Width, C.OrderSeq,
 BaseValue1 = CASE C.CalcClss WHEN '0' THEN C.BaseValue1 ELSE C.BaseValue1*100 END,
 LimitValue1 = CASE C.CalcClss WHEN '0' THEN C.LimitValue1 ELSE C.LimitValue1*100 END,
 C.BaseLength, C.Buyer, C.TagItem, C.SKClss, C.PointClss, C.GrossClss, C.LossClss,
 PassRoll = CASE WHEN (D.GradeClss < C.DefectClss ) THEN COUNT(D.RollID) ELSE 0 END,
 PassQty = CASE WHEN (D.GradeClss < C.DefectClss) THEN SUM(D.CtrlQty) ELSE 0 END,
 DefectRoll = CASE WHEN (D.GradeClss >= C.DefectClss ) THEN COUNT(D.RollID) ELSE 0 END,
 DefectQty = CASE WHEN (D.GradeClss >= C.DefectClss) THEN SUM(D.CtrlQty) ELSE 0 END,
 PassConQty = CASE WHEN (D.GradeClss < C.DefectClss) THEN SUM(D.CtrlQtyY) ELSE 0 END,
 DefectConQty = CASE WHEN (D.GradeClss >= C.DefectClss) THEN SUM(D.CtrlQtyY) ELSE 0 END,
 SUM(D.CutQty) AS CutQty, SUM(D.LossQty) AS LossQty, SUM(D.SampleQty) AS SampleQty,
 SUM(D.StuffQty) AS StuffQty, SUM(D.CtrlQty) AS InspectQty, COUNT(D.RollID) AS InspectRoll
 FROM [DS20] C, [DS24] D, [DS13] E, DS01 G, [DS19] H
 Where C.OrderID = D.OrderID And C.WidthID = E.WidthID
 AND C.ArticleID = G.ArticleID
 AND C.WorkID = H.WorkID AND C.InspectClss = '0'
 AND D.ExamDate BETWEEN '20230103' AND '20231124'
 GROUP BY C.OrderID, C.OrderNO, C.CustomId1, C.CustomID, G.Article, H.Work, C.OrderQty, C.GradeChk,
 C.InspectClss, C.OrderUnit, C.WidthID, E.Width, C.OrderSeq, C.BaseValue1, C.LimitValue1, C.BaseLength, C.CalcClss,
 D.CalcValue1, D.CalcValue2, C.LimitValue1, C.LimitValue2, C.BaseLength, C.Buyer, C.TagItem, C.SKClss, C.PointClss, C.GrossClss, C.LossClss, D.GradeClss,C.DefectClss ) A,
 [DS20] B, [DS59] C, [DS63] D, DS02 F
 WHERE A.OrderID = B.OrderID AND B.SKTeamID *= C.SKTeamID AND B.SKPersonID *= D.SKPersonID AND B.CustomID = F.CustomID
 --AND A.OrderId='202301031'
 GROUP BY A.OrderID, A.OrderNO, A.KCustom, A.Article, A.Work, A.OrderQty, A.InspectClss, B.GradeChk,
 A.OrderUnit , A.WidthID, A.Width, A.OrderSeq, A.BaseValue1, A.LimitValue1, A.BaseLength, A.Buyer, A.TagItem, A.SKClss, A.Pointclss, A.GrossClss, A.LossClss, C.SKTeam, D.SKPerson, F.kCustom 




 SELECT RTRIM(TagName) AS Tag, KDefect AS Defect
 From [DS04]
 WHERE Useclss <> '*'


 SELECT MAX(Density) AS Max, MIN(Density) AS Min
 From [DS24]
 WHERE Density > 0 AND  OrderID = '202301017' AND ColorID = '001'
 AND ExamDate BETWEEN '20230223' AND '20231123'


 SELECT A.OrderID, A.SKClss, A.InspectClss, A.PointClss, A.ColorID, SUM(A.BaseQty) AS BaseQty, SUM(A.DefectQty) AS DefectQty,
 SUM(A.TotalQty) AS TotalQty, SUM(LossQty) AS LossQty, SUM(CutQty) AS CutQty, SUM(RollCnt) AS RollCnt
 FROM (SELECT B.OrderID, B.SKClss, B.InspectClss, B.PointClss, C.ColorID,
 BaseQty = CASE WHEN (C.GradeClss < B.DefectClss) THEN SUM(C.CtrlQty) ELSE 0 END,
 DefectQty = CASE WHEN (C.GradeClss >= B.DefectClss) THEN SUM(C.CtrlQty) ELSE 0 END,
 SUM(CtrlQty) AS TotalQty, SUM(LossQty) AS LossQty, SUM(CutQty) AS CutQty, COUNT(*) AS RollCnt
 FROM [DS20] B, [DS24] C
 WHERE B.OrderID = C.OrderID AND B.OrderID = '202301017'
 AND C.ColorID = '001' 
 AND C.ExamDate BETWEEN '20230223' AND '20231123'
 GROUP BY B.OrderID,B.DefectClss, B.SKClss, B.InspectClss, B.PointClss, C.ColorID, C.CalcValue1, B.BaseValue1, C.CalcValue2, B.BaseValue2, B.LimitValue1, B.LimitValue2, B.BaseLength, C.GradeClss ) A
 GROUP BY A.OrderID, A.SKClss, A.InspectClss, A.PointClss, A.ColorID  

 SELECT A.OrderID, A.OrderNo, A.OrderSeq, A.CustomID, B.KCustom,  B.ECustom, A.CustomID1, G.KCustom AS KCustom1, A.PONO,G.eCustom AS eCustom1, A.OrderDate, A.DvlyDate, A.InspectClss, A.PointClss, A.FlexRate, A.LossRate, A.ArticleID, A.CT_NO, A.Supplier, A.RefCode, A.BarCodeJ, C.Article, A.WorkID, A.WorkClss, E.[Work], A.WidthID, F.Width, FLOOR(A.Weight) AS Weight, A.WeightUnit, A.DensityX, A.DensityY, A.ReduceRate, A.UnitCost, A.SKPersonID, H.SKPerson, A.SKTeamID, A.SKPart, I.SKTeam, A.Buyer, A.Unit, A.OrderQty, A.OrderUnit, A.TagID, A.LabelID, A.BandID, A.EndClss, A.MarkClss, A.MadeClss, A.CalcClss, A.WeightClss, A.ShipClss, A.AdvnClss, A.LotClss, A.MarkClss, A.TagItem, A.TagOrderNO, A.TagArticle, A.TagRemark, A.TagArticle, A.RollClss, A.BasisClss, A.BaseValue1, A.BaseValue2, A.LimitValue1, A.LimitValue2, A.LossValue1, A.LossValue2, A.BaseLength, A.BaseUnit, A.PackClss, A.Shipmark, A.Remark, A.SKClss, A.PointClss, O.Result, O.ResultType, A.GrossClss, A.LossClss,A.DefectClss,A.InvestClss, A.NetCustomID, A.Net
customID1, M.Kcustom NetCustom, N.Kcustom NetCustom1,  A.GradeChk,  A.LabelLan, A.VinylWeight,  (SELECT TOP 1 Y.KCustom FROM DS22 X, DS02 Y WHERE X.OrderID = A.OrderID AND X.CustomID2 = Y.CustomID GROUP BY Y.KCustom ORDER BY SUM(X.StuffQty) DESC) AS WorkCustom, (SELECT TOP 1 Y.KName FROM DS24 X, DS12 Y WHERE X.OrderID = A.OrderID AND X.PersonID = Y.PersonID ORDER BY X.RollID DESC) AS InspectPerson, (SELECT FLOOR(ISNULL(MIN(WeightUnit),0)) FROM DS24 WHERE OrderID = A.OrderID AND WeightUnit > 0) AS InspectWeightMin, (SELECT FLOOR(ISNULL(MAX(WeightUnit),0)) FROM DS24 WHERE OrderID = A.OrderID AND WeightUnit > 0) AS InspectWeightMax, (SELECT MIN(ExamDate) FROM DS24 WHERE OrderID = A.OrderID) AS InspectDateMin, (SELECT MAX(ExamDate) FROM DS24 WHERE OrderID = A.OrderID) AS InspectDateMax FROM [DS20] A, DS02 B, DS02 G, DS01 C, [DS19] E, [DS13] F, [DS63] H, [DS59] I, [DS44] O, DS02 M, DS02 N  Where A.CustomID = B.CustomID AND A.CustomID1 *= G.CustomID AND A.ArticleID = C.ArticleID AND A.WorkID *= E.WorkID AND A.Widt
hID = F.WidthID AND A.SKPersonID *= H.SKPersonID AND A.SKTeamID *= I.SKTeamID AND A.OrderID *= O.OrderID   AND A.NetCustomID *= M.CustomID AND A.NetCustomID1 *= N.CustomID     AND A.OrderID = '202301031'




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
 AND D.ExamDate BETWEEN '20230123' AND '20231123'
 GROUP BY B.OrderID, C.OrderNO, c.DefectClss, C.CustomId1, C.CustomID, G.Article, H.Work, B.ColorID, B.Color, B.DesignNO, B.ColorQty,
 C.InspectClss, C.OrderUnit, C.WidthID, E.Width, C.OrderSeq, C.BaseValue1, C.LimitValue1, C.BaseLength, C.CalcClss,
 D.CalcValue1, D.CalcValue2, C.LimitValue1, C.LimitValue2,  C.BaseLength, C.Buyer, C.TagItem, C.SKClss, C.PointClss, C.GrossClss, D.GradeClss, C.LossClss, C.GradeChk) A
 GROUP BY A.OrderID, A.OrderNO, A.KCustom, A.Article, A.Work, A.ColorID, A.Color, A.DesignNO, A.ColorQty, A.InspectClss,
 A.OrderUnit , A.WidthID, A.Width, A.OrderSeq, A.BaseValue1, A.LimitValue1, A.BaseLength, A.Buyer, A.TagItem, A.SKClss, A.Pointclss, A.GrossClss, A.LossClss, A.GradeChk







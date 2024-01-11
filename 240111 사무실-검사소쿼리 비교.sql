--검사소 쿼리
 SELECT A.OrderID, B.OrderNO, B.CustomID, D.KCustom, D.ECustom, B.ArticleID, E.Article, E.ChopNo, F.Width AS WorkWidth, B.PONO,
   B.TagArticle, B.TagOrderNo, B.TagRemark, B.TagItem, B.Buyer, B.MadeClss, A.ColorID, C.DesignNo, C.Color,
   A.RollID, A.RollNO, A.ExamNo, A.ExamDate, A.ExamTime, A.PersonID, H.KName AS KPerson, H.EName AS EPerson, A.TeamClss,
   A.StuffQty, A.RealQty, A.CtrlQty, A.CtrlQtyY, A.SampleQty, A.LossQty, A.CutQty, B.OrderUnit as QtyUnit, A.Weight, B.Weight as OrderWeight, A.WeightUnit,
   A.Width, A.Density, A.GradeClss, A.LotNo, A.DefectQty, A.Demerit, B.CT_NO, B.Supplier, B.RefCode, A.JBarCode, B.TagExamDate,
   A.DefectID , A.KindClss, G.KDefect, G.TagName, A.CutDefectID, A.CalcValue1, A.CalcValue2, B.InspectClss, B.PointClss, G.EDefect,B.TagGrade, I.KDefect as CutDefect,DefectInch
 FROM [DS24] A, DS20 B, [DS21] C, [DS02] D, [DS01] E, [DS13] F, [DS04] G, [DS12] H, [DS04] I
 Where A.OrderID = B.OrderID
   AND A.OrderID = C.OrderID AND A.ColorID = C.ColorID
   AND A.DefectID *= G.DefectID
   AND A.CutDefectID *= I.DefectID
   AND A.PersonID *= H.PersonID
   AND B.CustomID = D.CustomID
   AND B.ArticleID = E.ArticleID
   AND B.WidthID *= F.WidthID
   AND A.OrderID = '201505054'
   AND A.RollID = 8 



 --사무실 쿼리
SELECT 
A.OrderID, A.OrderNo, A.OrderSeq, A.CustomID, B.KCustom,  B.ECustom, A.CustomID1, G.KCustom AS KCustom1, A.PONO, A.NetCustom,A.NetCustom2, A.OrderDate, A.DvlyDate, A.InspectClss, 
A.PointClss, A.FlexRate, A.LossRate, A.ArticleID, A.CT_NO, A.Supplier, A.RefCode, A.BarCodeJ, C.Article, A.WorkID, A.WorkClss, E.[Work], A.WidthID, F.Width, FLOOR(A.Weight) AS Weight, 
A.WeightUnit, A.DensityX, A.DensityY, A.ReduceRate, A.UnitCost, A.SKPersonID, H.SKPerson, A.SKTeamID, A.SKPart, I.SKTeam, A.Buyer, A.Unit, A.OrderQty, A.OrderUnit, A.TagID, A.LabelID, A.BandID, A.EndClss, 
A.MarkClss, A.MadeClss, A.CalcClss, A.WeightClss, A.ShipClss, A.AdvnClss, A.LotClss, A.MarkClss, A.TagItem, A.TagOrderNO, A.TagArticle, A.TagRemark, A.RollClss, A.BasisClss, A.BaseValue1, A.BaseValue2, 
A.LimitValue1, A.LimitValue2, A.LossValue1, A.LossValue2, A.BaseLength, A.BaseUnit, A.PackClss, A.Shipmark, A.Remark, A.SKClss, A.PointClss, O.Result, O.ResultType, A.GrossClss, A.LossClss,A.DefectClss,A.TagGrade, 
A.pcost, A.jcost, A.dcost, A.punit, A.junit, A.dunit,A.Rcost, A.rUnit,A.JungPocost,A.JungPoUnit, A.TagExamDate,  
(SELECT TOP 1 Y.KCustom FROM DS22 X, DS02 Y WHERE X.OrderID = A.OrderID AND X.CustomID2 = Y.CustomID GROUP BY Y.KCustom ORDER BY SUM(X.StuffQty) DESC) AS WorkCustom, 
(SELECT TOP 1 Y.KName FROM DS24 X, DS12 Y WHERE X.OrderID = A.OrderID AND X.PersonID = Y.PersonID ORDER BY X.RollID DESC) AS InspectPerson, 
(SELECT FLOOR(ISNULL(MIN(WeightUnit),0)) FROM DS24 WHERE OrderID = A.OrderID AND WeightUnit > 0) AS InspectWeightMin, 
(SELECT FLOOR(ISNULL(MAX(WeightUnit),0)) FROM DS24 WHERE OrderID = A.OrderID AND WeightUnit > 0) AS InspectWeightMax, (SELECT MIN(ExamDate) FROM DS24 WHERE OrderID = A.OrderID) AS InspectDateMin, 
(SELECT MAX(ExamDate) FROM DS24 WHERE OrderID = A.OrderID) AS InspectDateMax, P.KCustom as ChunguCustom, A.ChunguCustomID 
FROM 
[DS20] A, DS02 B, DS02 G, DS01 C, [DS19] E, [DS13] F, [DS63] H, [DS59] I, [DS44] O, [DS02] P 
Where 
A.CustomID = B.CustomID AND A.CustomID1 *= G.CustomID AND A.ArticleID = C.ArticleID AND A.WorkID = E.WorkID 
AND A.WidthID = F.WidthID AND A.SKPersonID *= H.SKPersonID AND A.SKTeamID *= I.SKTeamID AND A.OrderID *= O.OrderID 
AND A.ChunguCustomID *= P.CustomID AND A.OrderID = '202311064'

--추가시켜야 하는 부분을 기존 쿼리에서 들고오고 있기 때문에 쿼리자체를 변경할 필요는 없다!
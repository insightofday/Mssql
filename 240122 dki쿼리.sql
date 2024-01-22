--printdefectlistq
 SELECT a.OrderID,
         a.ColorID,
         b.Color,
         a.RollID,
         a.RollNo,
         a.ExamDate,
         a.KindClss,
         a.StuffQty,
         a.RealQty,
         a.CtrlQty,
         a.SampleQty,
         a.LossQty,
         a.CutQty,
         a.QtyUnit,
         a.Weight,
         a.DefectID,
         b.DesignNO,
         c.KDefect + CASE GradeClss
                     WHEN 0 THEN  '(A)'
                     WHEN 1 THEN  '(B)'
                     WHEN 2 THEN  '(C)'
                     WHEN 3 THEN  '(D)'
                     WHEN 4 THEN  '(E)'
                     WHEN 5 THEN  '(F)'
                     WHEN 6 THEN  '(S)'
                     END KDefect,
         c.EDefect + CASE GradeClss
                     WHEN 0 THEN  '(A)'
                     WHEN 1 THEN  '(B)'
                     WHEN 2 THEN  '(C)'
                     WHEN 3 THEN  '(D)'
                     WHEN 4 THEN  '(E)'
                     WHEN 5 THEN  '(F)'
                     WHEN 6 THEN  '(S)'
                     END EDefect,
         a.LotNo,
         a.GradeClss
    FROM [DS24] a,
         [DS21] b,
         [DS04] c,
         [DS20] d
   Where a.OrderID = b.OrderID
     AND a.ColorID = b.ColorID
     AND a.DefectID = c.DefectID
     AND a.OrderID = d.OrderID
     AND a.GradeClss >= d.DefectClss
     AND A.OrderID = '202312031'
 AND A.ExamDate BETWEEN '20231128' AND '20240122'


--getorderone_order
SELECT A.OrderID, A.OrderNo, A.OrderSeq, A.CustomID, B.KCustom,  B.ECustom, A.CustomID1, G.KCustom AS KCustom1, A.PONO, A.NetCustom,A.NetCustom2, A.OrderDate, A.DvlyDate, A.InspectClss, A.PointClss, A.FlexRate, A.LossRate, A.ArticleID, A.CT_NO, A.Supplier, A.RefCode, A.BarCodeJ, C.Article, A.WorkID, A.WorkClss, E.[Work], A.WidthID, F.Width, FLOOR(A.Weight) AS Weight, A.WeightUnit, A.DensityX, A.DensityY, A.ReduceRate, A.UnitCost, A.SKPersonID, H.SKPerson, A.SKTeamID, A.SKPart, I.SKTeam, A.Buyer, A.Unit, A.OrderQty, A.OrderUnit, A.TagID, A.LabelID, A.BandID, A.EndClss, A.MarkClss, A.MadeClss, A.CalcClss, A.WeightClss, A.ShipClss, A.AdvnClss, A.LotClss, A.MarkClss, A.TagItem, A.TagOrderNO, A.TagArticle, A.TagRemark, A.TagArticle, A.RollClss, A.BasisClss, A.BaseValue1, A.BaseValue2, A.LimitValue1, A.LimitValue2, A.LossValue1, A.LossValue2, A.BaseLength, A.BaseUnit, A.PackClss, A.Shipmark, A.Remark, A.SKClss, A.PointClss, O.Result, O.ResultType, A.GrossClss, A.LossClss,A.DefectClss,A.TagGrade, A.pcost, A.jcost, 
A.dcost, A.punit, A.junit, A.dunit,A.Rcost, A.rUnit,A.JungPocost,A.JungPoUnit, A.TagExamDate,  (SELECT TOP 1 Y.KCustom FROM DS22 X, DS02 Y WHERE X.OrderID = A.OrderID AND X.CustomID2 = Y.CustomID GROUP BY Y.KCustom ORDER BY SUM(X.StuffQty) DESC) AS WorkCustom, (SELECT TOP 1 Y.KName FROM DS24 X, DS12 Y WHERE X.OrderID = A.OrderID AND X.PersonID = Y.PersonID ORDER BY X.RollID DESC) AS InspectPerson, (SELECT FLOOR(ISNULL(MIN(WeightUnit),0)) FROM DS24 WHERE OrderID = A.OrderID AND WeightUnit > 0) AS InspectWeightMin, (SELECT FLOOR(ISNULL(MAX(WeightUnit),0)) FROM DS24 WHERE OrderID = A.OrderID AND WeightUnit > 0) AS InspectWeightMax, (SELECT MIN(ExamDate) FROM DS24 WHERE OrderID = A.OrderID) AS InspectDateMin, (SELECT MAX(ExamDate) FROM DS24 WHERE OrderID = A.OrderID) AS InspectDateMax, P.KCustom as ChunguCustom, A.ChunguCustomID FROM [DS20] A, DS02 B, DS02 G, DS01 C, [DS19] E, [DS13] F, [DS63] H, [DS59] I, [DS44] O, [DS02] P Where A.CustomID = B.CustomID AND A.CustomID1 *= G.CustomID AND A.ArticleID = C.ArticleID AND A.WorkID = E.WorkID AND A.WidthID = F.WidthID AND A.SKPersonID *= H.SKPersonID AND A.SKTeamID *= I.SKTeamID AND A.OrderID *= O.OrderID AND A.ChunguCustomID *= P.CustomID AND A.OrderID = '202312031'


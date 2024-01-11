--qr코드일 떄 getinspectone쿼리
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
   AND A.OrderID = '201712323'
   AND A.RollID = 20 

   --


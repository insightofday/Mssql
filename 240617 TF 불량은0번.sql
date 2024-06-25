select * from ds24

select * from ds02

SELECT ISNULL(MAX(RollSeq) + 1, 1) as MaxSeq from [DS24] WHERE OrderID = '2023120190'

select * from ds24 where orderid='2023090206' 

SELECT * from ds25 where orderid='2023090206'-- and examdate='20240617'


SELECT A.OrderID, B.OrderNO, B.CustomID,B.Remark, D.KCustom, D.ECustom, B.ArticleID, B.WorkDensity, E.Article, G.StuffWidth AS Width, B.PONO,
 B.TagArticle, B.TagArticle2, B.TagOrderNo, B.TagRemark, B.TagRemark2, B.TagRemark3, B.TagRemark4,
 B.MadeClss , B.SurFaceClss, A.OrderSeq, C.DesignNo, C.Color,
 A.RollSeq, A.RollNO, A.ExamNo, A.ExamDate, A.ExamTime, A.PersonID, I.[Name] AS Person, A.TeamID,
 A.StuffQty , A.RealQty, A.CtrlQty, A.SampleQty, A.LossQty, A.CutQty, A.UnitClss, A.StuffWeight, A.StuffWeightUnit,
 A.StuffWidth , A.Density, A.GradeID, A.LotNo, A.DefectQty, A.DefectPoint, A.CardID, A.SplitID,
 A.DefectID , A.DefectClss, H.KDefect, H.TagName, A.CutDefectID, A.CutDefectClss, B.MadeClss, B.SurFaceClss, j.WorkName, C.DesignNo
 , B.EndMark, B.TagWidth
 FROM [DS24] A, [DS20] B, [DS21] C, [DS02] D, [DS01] E, [DS13] G,
 [DS04] H, [DS12] I, [DS19] J
 Where A.OrderID = B.OrderID
 AND A.OrderID = C.OrderID AND A.OrderSeq = C.OrderSeq
 AND A.DefectID *= H.DefectID
 AND A.PersonID *= I.PersonID
 AND B.CustomID = D.CustomID
 AND B.ArticleID = E.ArticleID
 AND B.WorkWidth *= G.StuffWidthID
 AND B.WorkID = J.WorkID
 AND A.OrderID = '2023090206'
 AND A.RollSeq =23
 AND C.OrderID ='2023090206'



SELECT A.OrderID, B.OrderNO, B.CustomID,B.Remark, D.KCustom, D.ECustom, B.ArticleID, B.WorkDensity, E.Article, G.StuffWidth AS Width, B.PONO,
 B.TagArticle, B.TagArticle2, B.TagOrderNo, B.TagRemark, B.TagRemark2, B.TagRemark3, B.TagRemark4,
 B.MadeClss , B.SurFaceClss, A.OrderSeq, C.DesignNo, C.Color,
 A.RollSeq, A.RollNO, A.ExamNo, A.ExamDate, A.ExamTime, A.PersonID, I.[Name] AS Person, A.TeamID,
 A.StuffQty , A.RealQty, A.CtrlQty, A.SampleQty, A.LossQty, A.CutQty, A.UnitClss, A.StuffWeight, A.StuffWeightUnit,
 A.StuffWidth , A.Density, A.GradeID, A.LotNo, A.DefectQty, A.DefectPoint, A.CardID, A.SplitID,
 A.DefectID , A.DefectClss, H.KDefect, H.TagName, A.CutDefectID, A.CutDefectClss, B.MadeClss, B.SurFaceClss, j.WorkName, C.DesignNo
 , B.EndMark, B.TagWidth
 FROM [DS24] A, [DS20] B, [DS21] C, [DS02] D, [DS01] E, [DS13] G,
 [DS04] H, [DS12] I, [DS19] J
 Where A.OrderID = B.OrderID
 AND A.OrderID = C.OrderID AND A.OrderSeq = C.OrderSeq
 AND A.DefectID *= H.DefectID
 AND A.PersonID *= I.PersonID
 AND B.CustomID = D.CustomID
 AND B.ArticleID = E.ArticleID
 AND B.WorkWidth *= G.StuffWidthID
 AND B.WorkID = J.WorkID
 AND A.OrderID = '2023090206'
 AND A.RollSeq =24
 AND C.OrderID ='2023090206'








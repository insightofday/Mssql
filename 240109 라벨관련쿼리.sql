--몇번라벨인가용?
SELECT TagID, Tag, Width, Height, Clss, DefectClss, DefHeight, DefBaseY, DefBaseX1, DefBaseX2, DefBaseX3, DefGapY , DefGapX1, DefGapX2, DefLength, DefHCount, DefBarClss, Gap, Direct From [DS14] WHERE TagID = '002' ORDER BY [TagID] 

--세부라벨정보
SELECT TagID, TagSeq, [Name], Type, Align, X , Y, Font, Length, HMulti, VMulti, Rotation, [Text], [Space], Relation, PrevItem, BarType , BarHeight, FigureWidth, FigureHeight, Thickness, ImageFile, Width, Height, Visible FROM [DS15] WHERE TagID = '002' ORDER BY [TagID], [TagSeq]

--검사정보들고오기
SELECT A.OrderID, B.OrderNO, B.CustomID, D.KCustom, D.ECustom, B.ArticleID, B.WorkDensity, E.Article, G.StuffWidth AS Width, B.PONO,
 B.TagArticle, B.TagArticle2, B.TagOrderNo, B.TagRemark, B.TagRemark2, B.TagRemark3, B.TagRemark4,
 B.MadeClss , B.SurFaceClss, A.OrderSeq, C.DesignNo, C.Color,
 A.RollSeq, A.RollNO, A.ExamNo, A.ExamDate, A.ExamTime, A.PersonID, I.[Name] AS Person, A.TeamID,
 A.StuffQty , A.RealQty, A.CtrlQty, A.SampleQty, A.LossQty, A.CutQty, b.UnitClss, A.StuffWeight, A.StuffWeightUnit,
 A.StuffWidth , A.Density, A.GradeID, A.LotNo, A.DefectQty, A.DefectPoint, A.CardID, A.SplitID,
 A.DefectID , A.DefectClss, H.KDefect, H.TagName, A.CutDefectID, A.CutDefectClss, B.MadeClss, B.SurFaceClss, j.WorkName, C.DesignNo
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
 AND A.OrderID = '2017030105'
 AND A.RollSeq =25
 AND C.OrderID ='2017030105'



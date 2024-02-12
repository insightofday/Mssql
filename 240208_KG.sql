
SELECT A.OrderID, A.OrderNo, A.CustomID, B.KCustom, A.ArticleID, C.Article, A.WorkID, D.WorkName, 
    A.StuffWidth, E.StuffWidth AS StuffWidthName, A.WorkWidth, F.StuffWidth As WorkWidthName, 
    A.ChunkRate, A.LossRate, A.OrderForm, A.OrderClss, A.AcptDate, A.DvlyDate,  A.DvlyPlace, A.WorkingClss, 
    A.AvgUnitPrice, A.PriceClss, A.UnitCostClss, A.TagOrderNo, A.TagArticle, A.TagRemark, A.RollFlag, A.RollNoFlag, A.ExamDateFlag, 
    A.LabelID, A.BandID, A.TagClss, A.EndClss, A.MadeClss, A.RollBar, A.ShipClss, A.AdvnClss, A.LotClss, 
    A.OrderQty, A.UnitClss, A.InLength, A.CutQty, A.StuffWeight, A.WorkWeight, A.WorkWeight2, 
    A.WorkDensity, A.WorkDensity2, A.WorkGubun, A.ChinzGubun, A.NangKaGubun, A.SanForGubun, A.Remark, A.LabelWeight, A.RemarkP 
FROM [Order] AS A 
LEFT JOIN mt_Custom AS B ON A.CustomID = B.CustomID 
LEFT JOIN mt_Article AS C ON A.ArticleID = C.ArticleID 
LEFT JOIN mt_Work AS D ON A.WorkID = D.WorkID 
LEFT JOIN mt_StuffWidth AS E ON A.StuffWidth = E.StuffWidthID 
LEFT JOIN mt_StuffWidth AS F ON A.WorkWidth = F.StuffWidthID 
WHERE A.OrderID = '2020030001' 



--frmdefect에서 formload할때
SELECT A.LotNo, A.RollSeq, A.RollNo, A.CtrlQty, A.LossQty, A.StuffWeight, A.StuffWeightUnit, A.UnitClss, 
       A.GradeID, A.DefectID, B.KDefect, C.Grade, A.OutClss 
FROM Inspect AS A 
LEFT JOIN mt_Defect AS B ON A.DefectID = B.DefectID 
LEFT JOIN mt_Grade AS C ON A.GradeID = C.GradeID 
WHERE A.OrderID = '2024040019' 
AND   A.OrderSeq = 2 
AND   A.OutReclss = '0' 
AND   A.Lotno = '1' 
AND   A.OutClss = '' 
ORDER BY LEN(A.LotNo), A.LotNo, A.RollNo 


--태그정보들고오기
 SELECT A.TagID, A.TagSeq,  A.Relation,  A.TagCode    
   FROM [Mt_tagSub] A                                      
  WHERE A.TagID = '008'                    
    AND A.Type IN (1,2,3,4)                           
    AND A.Visible =1                                  

	--select * from mt_tagsub where tagid='008'

--	select * from ordercolor
	
select * from ordercolor where orderid='2024040026'                                                                                   

 SELECT A.OrderID, B.OrderNO, B.CustomID, D.KCustom, D.ECustom, C.ArticleID, B.WorkDensity, E.Article, G.StuffWidth AS Width, C.PONO,
B.TagArticle, B.TagArticle2, B.TagOrderNo, B.TagRemark, B.MadeClss, A.OrderSeq, RTRIM(C.DesignNo) AS DesignNO, RTRIM(C.Color) As Color,
A.RollSeq, A.RollNO, A.ExamNo, A.ExamDate, A.ExamTime, A.PersonID, I.[Name] AS Person, A.TeamID,
A.StuffQty, A.RealQty, A.CtrlQty, A.SampleQty, A.LossQty, A.CutQty, B.UnitClss, A.StuffWeight, A.StuffWeightUnit,
A.StuffWidth, A.Density, A.GradeID, A.LotNo, A.DefectQty, A.DefectPoint, A.CardID, A.SplitID,
A.DefectID, A.DefectClss, H.KDefect, H.TagName, A.CutDefectID, A.CutDefectClss, B.MadeClss, B.SurfaceClss, J.WorkName,
B.TaxClss, B.TagPrn1, B.TagPrn2, B.TagPrn3, B.TagPrn4, B.RollNoFlag, B.ExamDateFlag, B.DesignPrnFlag, B.WidthPrnFlag, B.BarCodePrnFlag,
A.DeductQty , A.PieceCnt,C.SKU,C.Code,C.CustPo,B.madeclss, B.TagID, B.TagCount, K.Grade 
FROM [Inspect] A 
LEFT JOIN [Order] B on A.OrderID = B.OrderID
LEFT JOIN [OrderColor] C on A.OrderID = C.OrderID AND A.OrderSeq = C.OrderSeq
LEFT JOIN [mt_Custom] D on B.CustomID = D.CustomID
LEFT JOIN [mt_Article] E On C.ArticleID = E.ArticleID
LEFT JOIN [mt_StuffWidth] G on B.WorkWidth = G.StuffWidthID 
LEFT JOIN [mt_Defect] H on A.DefectID = H.DefectID 
LEFT JOIN [mt_Person] I on A.PersonID = I.PersonID 
LEFT JOIN [mt_Work] J On B.WorkID = J.WorkID
LEFT JOIN [mt_Grade] K On A.GradeID = K.GradeID
WHERE A.OrderID <> ''
AND A.OrderID = '2024040026'
AND A.RollSeq = 8


select * from [OrderColor] where OrderID = '2024040026'

 SELECT *
   FROM [Mt_tagSub] A                                      
  WHERE A.TagID = '008'                    
    AND A.Type IN (1,2,3,4)                           
    AND A.Visible =1                                  

	 SELECT A.TagID, A.TagSeq,  A.Relation,  A.TagCode    
   FROM [Mt_tagSub] A                                      
  WHERE A.TagID = '008'                    
    AND A.Type IN (1,2,3,4)                           
    AND A.Visible =1                                  



	select * from mt_tagsub


	 SELECT *
   FROM [Mt_tagSub] A                                      
  WHERE A.TagID = '008'       


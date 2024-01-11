SELECT A.OrderID, A.OrderSeq, A.Color, A.ColorQty, B.LotNo, COUNT(B.RollSeq) As RollQty, SUM(B.CtrlQty) AS CtrlQty, SUM(B.StuffQty) AS StuffQty,
            (SELECT COUNT(*) FROM [Inspect] WHERE GradeID = '1' GROUP BY OrderID, OrderSeq, LotNo HAVING OrderID = B.OrderID AND OrderSeq = B.OrderSeq AND LotNo = B.LotNo) AS PassRoll,
            (SELECT SUM(CtrlQty) FROM [Inspect] WHERE GradeID = '1' GROUP BY OrderID, OrderSeq, LotNo HAVING OrderID = B.OrderID AND OrderSeq = B.OrderSeq AND LotNo = B.LotNo) AS PassQty,
            (SELECT COUNT(*) FROM [Inspect] WHERE GradeID = '2' GROUP BY OrderID, OrderSeq, LotNo HAVING OrderID = B.OrderID AND OrderSeq = B.OrderSeq AND LotNo = B.LotNo) AS DefectRoll,
            (SELECT SUM(CtrlQty) FROM [Inspect] WHERE GradeID = '2' GROUP BY OrderID, OrderSeq, LotNo HAVING OrderID = B.OrderID AND OrderSeq = B.OrderSeq AND LotNo = B.LotNo) AS DefectQty
      FROM [OrderColor] A
      LEFT JOIN [Inspect] B ON A.OrderID=B.OrderID   
                           AND A.OrderSeq=B.OrderSeq 
     WHERE A.OrderSeq <> 0                           
       AND A.OrderID = '2022080065'            
       AND ((0 = 0) OR (0 = 1 AND B.PersonID = ''))
     GROUP BY A.OrderID,  A.OrderSeq, A.Color, A.ColorQty, B.LotNo, B.OrderID, B.OrderSeq
     ORDER BY  A.OrderID, A.OrderSeq, LEN(B.LotNo), B.LotNo

	 ----------

 SELECT A.OrderID, A.RollSeq, A.RollNO, A.OrderSeq, K.Color, K.DesignNo, A.ExamNo, A.ExamDate, A.ExamTime, A.TeamID,  A.PersonID, B.Name AS Person,
        A.StuffQty, A.RealQty, A.CtrlQty, A.SampleQty, A.LossQty, A.CutQty, G.UnitClss, A.StuffWeight, A.StuffWeightUnit, A.StuffWidth, A.Density,
        A.GradeID, F.Grade, A.LotNo, A.DefectQty, A.DefectPoint, A.DefectID, C.KDefect AS Defect, A.DefectClss,
        A.CutDefectID, D.KDefect AS CutDefect, A.CutDefectClss, G.OrderNO, H.KCustom, G.ArticleID, I.Article, G.PONO, G.MadeClss,
        J.WorkName, G.TagArticle, G.TagOrderNo, G.TagRemark, G.TagClss, G.SurfaceClss, G.BasisID, L.StuffWidth AS Width2, A.UnitClss,
        A.P_NO, M.Joje as Joje1, N.JOje as Joje2, A.WRollingType, 
        A.CardID, A.ProcessSeq
   FROM [Inspect] A
  INNER JOIN [mt_Person] B ON A.PersonID=B.PersonID
  INNER JOIN [Order] G ON A.OrderID=G.OrderID
  INNER JOIN [OrderColor] K ON A.OrderID=K.OrderID
                           AND A.OrderSeq=K.OrderSeq
  INNER JOIN [mt_Custom] H ON G.CustomID=H.CustomID
  INNER JOIN [mt_Article] I ON G.ArticleID = I.ArticleID
  INNER JOIN [mt_Work] J ON G.WorkID = J.WorkID
  INNER JOIN [mt_StuffWidth] L ON G.WorkWidth = L.StuffWidthID
  LEFT JOIN [mt_Defect] C ON A.DefectID=C.DefectID
  LEFT JOIN [mt_Defect] D ON A.CutDefectID=D.DefectID
  LEFT JOIN [mt_Grade] F ON A.GradeID=F.GradeID
  LEFT JOIN [ds_jojeCOde] M ON A.JojeCode1 = M.JojeCode
  LEFT JOIN [ds_jojeCOde] N ON A.JojeCode2 = N.JojeCode
 WHERE A.OrderID = '2022080065'   AND A.OrderSeq = 1 ORDER BY A.OrderID, LEN(A.LotNo), A.LotNo, A.RollNo


   	 -------------------------------------------------------------------  
	 -------------------------------------------------------------------

 SELECT A.OrderID, A.RollSeq, A.RollNO, A.OrderSeq, K.Color, K.DesignNo, A.ExamNo, A.ExamDate, A.ExamTime, A.TeamID,  A.PersonID, B.Name AS Person,
        A.StuffQty, A.RealQty, A.CtrlQty, A.SampleQty, A.LossQty, A.CutQty, G.UnitClss, A.StuffWeight, A.StuffWeightUnit, A.StuffWidth, A.Density,
        A.GradeID, F.Grade, A.LotNo, A.DefectQty, A.DefectPoint, A.DefectID, C.KDefect AS Defect, A.DefectClss,
        A.CutDefectID, D.KDefect AS CutDefect, A.CutDefectClss, G.OrderNO, H.KCustom, G.ArticleID, I.Article, G.PONO, G.MadeClss,
        J.WorkName, G.TagArticle, G.TagOrderNo, G.TagRemark, G.TagClss, G.SurfaceClss, G.BasisID, L.StuffWidth AS Width2, A.UnitClss,
        A.P_NO, M.Joje as Joje1, N.JOje as Joje2, A.WRollingType, 
        A.CardID, A.ProcessSeq
   FROM [Inspect] A
  INNER JOIN [mt_Person] B ON A.PersonID=B.PersonID
  INNER JOIN [Order] G ON A.OrderID=G.OrderID
  INNER JOIN [OrderColor] K ON A.OrderID=K.OrderID
                           AND A.OrderSeq=K.OrderSeq
  INNER JOIN [mt_Custom] H ON G.CustomID=H.CustomID
  INNER JOIN [mt_Article] I ON G.ArticleID = I.ArticleID
  INNER JOIN [mt_Work] J ON G.WorkID = J.WorkID
  INNER JOIN [mt_StuffWidth] L ON G.WorkWidth = L.StuffWidthID
  LEFT JOIN [mt_Defect] C ON A.DefectID=C.DefectID
  LEFT JOIN [mt_Defect] D ON A.CutDefectID=D.DefectID
  LEFT JOIN [mt_Grade] F ON A.GradeID=F.GradeID
  LEFT JOIN [ds_jojeCOde] M ON A.JojeCode1 = M.JojeCode
  LEFT JOIN [ds_jojeCOde] N ON A.JojeCode2 = N.JojeCode
 WHERE A.OrderID = '2022080217'   AND A.OrderSeq = 1 ORDER BY A.OrderID, LEN(A.LotNo), A.LotNo, A.RollNo


     SELECT A.OrderID, A.OrderSeq, A.Color, A.ColorQty, B.LotNo, COUNT(B.RollSeq) As RollQty, SUM(B.CtrlQty) AS CtrlQty, SUM(B.StuffQty) AS StuffQty,
            (SELECT COUNT(*) FROM [Inspect] WHERE GradeID = '1' GROUP BY OrderID, OrderSeq, LotNo HAVING OrderID = B.OrderID AND OrderSeq = B.OrderSeq AND LotNo = B.LotNo) AS PassRoll,
            (SELECT SUM(CtrlQty) FROM [Inspect] WHERE GradeID = '1' GROUP BY OrderID, OrderSeq, LotNo HAVING OrderID = B.OrderID AND OrderSeq = B.OrderSeq AND LotNo = B.LotNo) AS PassQty,
            (SELECT COUNT(*) FROM [Inspect] WHERE GradeID = '2' GROUP BY OrderID, OrderSeq, LotNo HAVING OrderID = B.OrderID AND OrderSeq = B.OrderSeq AND LotNo = B.LotNo) AS DefectRoll,
            (SELECT SUM(CtrlQty) FROM [Inspect] WHERE GradeID = '2' GROUP BY OrderID, OrderSeq, LotNo HAVING OrderID = B.OrderID AND OrderSeq = B.OrderSeq AND LotNo = B.LotNo) AS DefectQty
      FROM [OrderColor] A
      LEFT JOIN [Inspect] B ON A.OrderID=B.OrderID   
                           AND A.OrderSeq=B.OrderSeq 
     WHERE A.OrderSeq <> 0                           
       AND A.OrderID = '2022080217'            
       AND ((0 = 0) OR (0 = 1 AND B.PersonID = ''))
     GROUP BY A.OrderID,  A.OrderSeq, A.Color, A.ColorQty, B.LotNo, B.OrderID, B.OrderSeq
     ORDER BY  A.OrderID, A.OrderSeq, LEN(B.LotNo), B.LotNo

   	 -------------------------------------------------------------------  
	 -------------------------------------------------------------------

     SELECT A.OrderID, A.OrderSeq, A.Color, A.ColorQty, B.LotNo, COUNT(B.RollSeq) As RollQty, SUM(B.CtrlQty) AS CtrlQty, SUM(B.StuffQty) AS StuffQty,
            (SELECT COUNT(*) FROM [Inspect] WHERE GradeID = '1' GROUP BY OrderID, OrderSeq, LotNo HAVING OrderID = B.OrderID AND OrderSeq = B.OrderSeq AND LotNo = B.LotNo) AS PassRoll,
            (SELECT SUM(CtrlQty) FROM [Inspect] WHERE GradeID = '1' GROUP BY OrderID, OrderSeq, LotNo HAVING OrderID = B.OrderID AND OrderSeq = B.OrderSeq AND LotNo = B.LotNo) AS PassQty,
            (SELECT COUNT(*) FROM [Inspect] WHERE GradeID = '2' GROUP BY OrderID, OrderSeq, LotNo HAVING OrderID = B.OrderID AND OrderSeq = B.OrderSeq AND LotNo = B.LotNo) AS DefectRoll,
            (SELECT SUM(CtrlQty) FROM [Inspect] WHERE GradeID = '2' GROUP BY OrderID, OrderSeq, LotNo HAVING OrderID = B.OrderID AND OrderSeq = B.OrderSeq AND LotNo = B.LotNo) AS DefectQty
      FROM [OrderColor] A
      LEFT JOIN [Inspect] B ON A.OrderID=B.OrderID   
                           AND A.OrderSeq=B.OrderSeq 
     WHERE A.OrderSeq <> 0                           
       AND A.OrderID = '2022090027'            
       AND ((0 = 0) OR (0 = 1 AND B.PersonID = ''))
     GROUP BY A.OrderID,  A.OrderSeq, A.Color, A.ColorQty, B.LotNo, B.OrderID, B.OrderSeq
     ORDER BY  A.OrderID, A.OrderSeq, LEN(B.LotNo), B.LotNo


 SELECT A.OrderID, A.RollSeq, A.RollNO, A.OrderSeq, K.Color, K.DesignNo, A.ExamNo, A.ExamDate, A.ExamTime, A.TeamID,  A.PersonID, B.Name AS Person,
        A.StuffQty, A.RealQty, A.CtrlQty, A.SampleQty, A.LossQty, A.CutQty, G.UnitClss, A.StuffWeight, A.StuffWeightUnit, A.StuffWidth, A.Density,
        A.GradeID, F.Grade, A.LotNo, A.DefectQty, A.DefectPoint, A.DefectID, C.KDefect AS Defect, A.DefectClss,
        A.CutDefectID, D.KDefect AS CutDefect, A.CutDefectClss, G.OrderNO, H.KCustom, G.ArticleID, I.Article, G.PONO, G.MadeClss,
        J.WorkName, G.TagArticle, G.TagOrderNo, G.TagRemark, G.TagClss, G.SurfaceClss, G.BasisID, L.StuffWidth AS Width2, A.UnitClss,
        A.P_NO, M.Joje as Joje1, N.JOje as Joje2, A.WRollingType, 
        A.CardID, A.ProcessSeq
   FROM [Inspect] A
  INNER JOIN [mt_Person] B ON A.PersonID=B.PersonID
  INNER JOIN [Order] G ON A.OrderID=G.OrderID
  INNER JOIN [OrderColor] K ON A.OrderID=K.OrderID
                           AND A.OrderSeq=K.OrderSeq
  INNER JOIN [mt_Custom] H ON G.CustomID=H.CustomID
  INNER JOIN [mt_Article] I ON G.ArticleID = I.ArticleID
  INNER JOIN [mt_Work] J ON G.WorkID = J.WorkID
  INNER JOIN [mt_StuffWidth] L ON G.WorkWidth = L.StuffWidthID
  LEFT JOIN [mt_Defect] C ON A.DefectID=C.DefectID
  LEFT JOIN [mt_Defect] D ON A.CutDefectID=D.DefectID
  LEFT JOIN [mt_Grade] F ON A.GradeID=F.GradeID
  LEFT JOIN [ds_jojeCOde] M ON A.JojeCode1 = M.JojeCode
  LEFT JOIN [ds_jojeCOde] N ON A.JojeCode2 = N.JojeCode
 WHERE A.OrderID = '2022090027'   AND A.OrderSeq = 1 ORDER BY A.OrderID, LEN(A.LotNo), A.LotNo, A.RollNo





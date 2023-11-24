
 SELECT T2.*, T1.*
        FROM ( SELECT A.OrderID, A.RollID,  A.ColorID, COUNT(B.YPos)as EA,
        SUM(CASE B.DefectSeq WHEN  1 THEN B.YPos ELSE NULL END) as D001,
        SUM(CASE B.DefectSeq WHEN  2 THEN B.YPos ELSE NULL END) AS D002,
        SUM(CASE B.DefectSeq WHEN  3 THEN B.YPos ELSE NULL END) AS D003,
        SUM(CASE B.DefectSeq WHEN  4 THEN B.YPos ELSE NULL END) AS D004,
        SUM(CASE B.DefectSeq WHEN  5 THEN B.YPos ELSE NULL END) AS D005,
        SUM(CASE B.DefectSeq WHEN  6 THEN B.YPos ELSE NULL END) AS D006,
        SUM(CASE B.DefectSeq WHEN  7 THEN B.YPos ELSE NULL END) AS D007,
        SUM(CASE B.DefectSeq WHEN  8 THEN B.YPos ELSE NULL END) AS D008,
        SUM(CASE B.DefectSeq WHEN  9 THEN B.YPos ELSE NULL END) AS D009,
        SUM(CASE B.DefectSeq WHEN 10 THEN B.YPos ELSE NULL END) AS D010,
        SUM(CASE B.DefectSeq WHEN 11 THEN B.YPos ELSE NULL END) AS D011,
        SUM(CASE B.DefectSeq WHEN 12 THEN B.YPos ELSE NULL END) AS D012,
        SUM(CASE B.DefectSeq WHEN 13 THEN B.YPos ELSE NULL END) AS D013,
        SUM(CASE B.DefectSeq WHEN 14 THEN B.YPos ELSE NULL END) AS D014,
        SUM(CASE B.DefectSeq WHEN 15 THEN B.YPos ELSE NULL END) AS D015,
        SUM(CASE B.DefectSeq WHEN  1 THEN B.Demerit ELSE NULL END) AS E001,
        SUM(CASE B.DefectSeq WHEN  2 THEN B.Demerit ELSE NULL END) AS E002,
        SUM(CASE B.DefectSeq WHEN  3 THEN B.Demerit ELSE NULL END) AS E003,
        SUM(CASE B.DefectSeq WHEN  4 THEN B.Demerit ELSE NULL END) AS E004,
        SUM(CASE B.DefectSeq WHEN  5 THEN B.Demerit ELSE NULL END) AS E005,
        SUM(CASE B.DefectSeq WHEN  6 THEN B.Demerit ELSE NULL END) AS E006,
        SUM(CASE B.DefectSeq WHEN  7 THEN B.Demerit ELSE NULL END) AS E007,
        SUM(CASE B.DefectSeq WHEN  8 THEN B.Demerit ELSE NULL END) AS E008,
        SUM(CASE B.DefectSeq WHEN  9 THEN B.Demerit ELSE NULL END) AS E009,
        SUM(CASE B.DefectSeq WHEN 10 THEN B.Demerit ELSE NULL END) AS E010,
        SUM(CASE B.DefectSeq WHEN 11 THEN B.Demerit ELSE NULL END) AS E011,
        SUM(CASE B.DefectSeq WHEN 12 THEN B.Demerit ELSE NULL END) AS E012,
        SUM(CASE B.DefectSeq WHEN 13 THEN B.Demerit ELSE NULL END) AS E013,
        SUM(CASE B.DefectSeq WHEN 14 THEN B.Demerit ELSE NULL END) AS E014,
        SUM(CASE B.DefectSeq WHEN 15 THEN B.Demerit ELSE NULL END) AS E015,
        MAX(CASE B.DefectSeq WHEN  1 THEN C.TagName ELSE NULL END) AS T001,
        MAX(CASE B.DefectSeq WHEN  2 THEN C.TagName ELSE NULL END) AS T002,
        MAX(CASE B.DefectSeq WHEN  3 THEN C.TagName ELSE NULL END) AS T003,
        MAX(CASE B.DefectSeq WHEN  4 THEN C.TagName ELSE NULL END) AS T004,
        MAX(CASE B.DefectSeq WHEN  5 THEN C.TagName ELSE NULL END) AS T005,
        MAX(CASE B.DefectSeq WHEN  6 THEN C.TagName ELSE NULL END) AS T006,
        MAX(CASE B.DefectSeq WHEN  7 THEN C.TagName ELSE NULL END) AS T007,
        MAX(CASE B.DefectSeq WHEN  8 THEN C.TagName ELSE NULL END) AS T008,
        MAX(CASE B.DefectSeq WHEN  9 THEN C.TagName ELSE NULL END) AS T009,
        MAX(CASE B.DefectSeq WHEN 10 THEN C.TagName ELSE NULL END) AS T010,
        MAX(CASE B.DefectSeq WHEN 11 THEN C.TagName ELSE NULL END) AS T011,
        MAX(CASE B.DefectSeq WHEN 12 THEN C.TagName ELSE NULL END) AS T012,
        MAX(CASE B.DefectSeq WHEN 13 THEN C.TagName ELSE NULL END) AS T013,
        MAX(CASE B.DefectSeq WHEN 14 THEN C.TagName ELSE NULL END) AS T014,
        MAX(CASE B.DefectSeq WHEN 15 THEN C.TagName ELSE NULL END) AS T015,
        MAX(CASE B.DefectSeq WHEN  1 THEN B.Loss ELSE NULL END) AS L001,
        MAX(CASE B.DefectSeq WHEN  2 THEN B.Loss ELSE NULL END) AS L002,
        MAX(CASE B.DefectSeq WHEN  3 THEN B.Loss ELSE NULL END) AS L003,
        MAX(CASE B.DefectSeq WHEN  4 THEN B.Loss ELSE NULL END) AS L004,
        MAX(CASE B.DefectSeq WHEN  5 THEN B.Loss ELSE NULL END) AS L005,
        MAX(CASE B.DefectSeq WHEN  6 THEN B.Loss ELSE NULL END) AS L006,
        MAX(CASE B.DefectSeq WHEN  7 THEN B.Loss ELSE NULL END) AS L007,
        MAX(CASE B.DefectSeq WHEN  8 THEN B.Loss ELSE NULL END) AS L008,
        MAX(CASE B.DefectSeq WHEN  9 THEN B.Loss ELSE NULL END) AS L009,
        MAX(CASE B.DefectSeq WHEN 10 THEN B.Loss ELSE NULL END) AS L010,
        MAX(CASE B.DefectSeq WHEN 11 THEN B.Loss ELSE NULL END) AS L011,
        MAX(CASE B.DefectSeq WHEN 12 THEN B.Loss ELSE NULL END) AS L012,
        MAX(CASE B.DefectSeq WHEN 13 THEN B.Loss ELSE NULL END) AS L013,
        MAX(CASE B.DefectSeq WHEN 14 THEN B.Loss ELSE NULL END) AS L014,
        MAX(CASE B.DefectSeq WHEN 15 THEN B.Loss ELSE NULL END) AS L015
    FROM [DS24] A, [DS25] B, [DS04] C
    Where A.OrderID = B.OrderID And A.ROLLID = B.ROLLID And B.DefectID = C.DefectID
        AND A.OrderID = '202301016' AND A.ColorID = '003'
    GROUP BY A.OrderID, A.RollID, A.RollNO, A.ColorID ) AS T1,
    (SELECT D.OrderID, D.RollID, D.RollNO, D.ColorID, D.PersonID, F.KName AS Person, D.LotNO, D.RealQty, D.StuffQty, D.SampleQty,
        D.CutQty, D.CtrlQty,
        WeightUnit = CASE G.WeightClss WHEN '0' THEN D.WeightUnit ELSE CAST((D.Weight*1000)/D.RealQty AS INTEGER) END,
        D.LossQty, D.DefectQty, D.GradeClss, D.ExamDate,
        CalcValue1 = CASE G.CalcClss WHEN '0' THEN D.CalcValue1 ELSE D.CalcValue1*100 END,
        CalcValue2 = CASE G.CalcClss WHEN '0' THEN D.CalcValue2 ELSE D.CalcValue2*100 END,
        EDefect = CASE D.GradeClss WHEN '6' THEN E.EDefect+'(бу)' WHEN '5' THEN E.EDefect+'(X)' ELSE E.EDefect END,
        KDefect = CASE D.GradeClss WHEN '6' THEN E.KDefect+'(бу)' WHEN '5' THEN E.KDefect+'(X)' ELSE E.KDefect END,
        JDefect = CASE D.GradeClss WHEN '6' THEN E.JDefect+'(бу)' WHEN '5' THEN E.JDefect+'(X)' ELSE E.JDefect END,
        EDefect2 = CASE D.GradeClss WHEN '6' THEN H.EDefect+'(бу)' WHEN '5' THEN H.EDefect+'(X)' ELSE H.EDefect END,
        KDefect2 = CASE D.GradeClss WHEN '6' THEN H.KDefect+'(бу)' WHEN '5' THEN H.KDefect+'(X)' ELSE H.KDefect END,
        JDefect2 = CASE D.GradeClss WHEN '6' THEN H.JDefect+'(бу)' WHEN '5' THEN H.JDefect+'(X)' ELSE H.JDefect END,
        D.Demerit , D.Density, D.ExamNO, D.Width, G.LossClss
    FROM [DS24] D, [DS04] E, [DS12] F, [DS20] G, [DS04] H
    WHERE D.DefectID *= E.DefectID AND  D.DefectID2 *= H.DefectID AND D.PersonID *= F.PersonID
        AND D.OrderID = G.OrderID
        AND D.OrderID = '202301016' AND D.ColorID = '003'
 AND D.ExamDate BETWEEN '20230123' AND '20231123'
 ) AS T2 WHERE T1.OrderID =* T2.OrderID AND T1.ColorID =* T2.ColorID AND T1.RollID =* T2.RollID
         ORDER BY  T2.OrderID, T2.ColorID,                                          
                    CASE                                                            
                        WHEN ISNUMERIC(T2.LotNo) = 1 THEN CONVERT(INT, T2.LotNo)    
                        ELSE 9999999 -- or something huge                           
                    End                                                             
,T2.LotNo, T2.RollNo                                                                


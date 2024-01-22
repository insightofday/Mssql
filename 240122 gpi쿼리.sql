--gpiÄõ¸®
 SELECT a.OrderID,
         a.ColorID,
         b.Color,
         a.RollID,
         a.RollNo,
         a.ExamDate,
         C.KindClss,
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
                     WHEN 6 THEN  '(X)'
                     END KDefect,
         c.EDefect + CASE GradeClss
                     WHEN 0 THEN  '(A)'
                     WHEN 1 THEN  '(B)'
                     WHEN 2 THEN  '(C)'
                     WHEN 3 THEN  '(D)'
                     WHEN 4 THEN  '(E)'
                     WHEN 5 THEN  '(F)'
                     WHEN 6 THEN  '(X)'
                     END EDefect,
         a.LotNo,
         a.GradeClss,
         E.KindCLss AS KINDCLSS2,
         E.Kdefect AS KDEFECT2,
         E.EDefect AS EDEFECT2
    FROM [DS24] A,
         [DS21] B,
         [DS04] C,
         [DS20] D,
         [DS04] E
   Where A.OrderID = B.OrderID
     AND A.ColorID = B.ColorID
     AND A.DefectID = C.DefectID
     AND A.DefectID2 *= E.DefectID
     AND A.OrderID = D.OrderID
     AND A.GradeClss >= D.DefectClss
     AND A.OrderID = '201611027'
     AND A.RolliD Not in ( Select B.RolliD from ds26 A, Ds27 B where A.OrderiD = B.Orderid and a.outid = b.outid And A.Outclss = 2 and A.Orderid = '201611027')
 Order by A.OrderID, B.Color, A.RollNo 



 SELECT A.DefectID, A.Display, A.KDefect, A.Edefect, A.TagName, A.KindClss, B.ButtonSeq, B.Demerit
 FROM [DS04] A, [DS05] B
 WHERE A.DefectID *= B.DefectID --and display='¿°»ö¿À¿°'
 AND A.Useclss <> '*'
 ORDER BY A.kindclss,B.ButtonSeq

 --°õÆÎÀÌ:174 ds05:72
 --¿°»ö¿À¿°:175 ds05:28

 select * from ds04

 select * from ds05

 --update ds05 set buttonseq='72' where defectid='175'
 --update ds05 set buttonseq='28' where defectid='174'

-- update ds04 set kindclss='0' where defectid='174'
 --update ds04 set kindclss='1' where defectid='175'

 --Å×½ºÆ®¿¡ ÀÓ½Ã·Î Çß´Ù°¡ ¹Ù·Î ¾÷µ«ÇÏ·Á°í
 update ds04 set
 kindclss = B.KindClss
 FROM DS04 AS A
 LEFT JOIN DMB_TSET.dbo.DS04 AS B ON A.DefectID = B.DefectID
 WHERE A.DefectID IN ('174','175')
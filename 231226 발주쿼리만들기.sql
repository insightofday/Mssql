--fillspdmain
SELECT A.OutWorkOrderDate, C.KCustom, A.TotalQty, A.TotalCost, A.MaterialCost, A.KeyDate, A.KeySeq, plandate, a.finish 
  FROM [OutWork] A
       LEFT JOIN [OutWorkSub] B ON A.KeyDate = B.KeyDate AND A.KeySeq = B.KeySeq
       LEFT JOIN [mt_Custom] C ON A.CustomID = C.CustomID
WHERE B.Subkeyseq = 1
AND A.OutWorkOrderDate BETWEEN '20231219' AND '20231226' 
ORDER BY a.plandate, A.OutWorkOrderDate, A.KeyDate, A.KeySeq DESC

--outworkorderdate==����������
--plandate==������
--kcustom==����ó
--(++ǰ��, ������ �������� ��)



--�˻��ɼǴް� fillspdmain

SELECT A.OutWorkOrderDate, C.KCustom, A.TotalQty, A.TotalCost, A.MaterialCost, A.KeyDate, A.KeySeq, plandate, a.finish 
  FROM [OutWork] A
       LEFT JOIN [OutWorkSub] B ON A.KeyDate = B.KeyDate AND A.KeySeq = B.KeySeq
       LEFT JOIN [mt_Custom] C ON A.CustomID = C.CustomID
WHERE B.Subkeyseq = 1
AND A.OutWorkOrderDate BETWEEN '20231219' AND '20231226' 
AND A.plandate BETWEEN '20230703' AND '20231227' 
ORDER BY a.plandate, A.OutWorkOrderDate, A.KeyDate, A.KeySeq DESC



--articleid�ɼǴް� fillspdmain

SELECT A.OutWorkOrderDate, C.KCustom, A.TotalQty, A.TotalCost, A.MaterialCost, A.KeyDate, A.KeySeq, plandate, a.finish ,D.article
  FROM [OutWork] A
       LEFT JOIN [OutWorkSub] B ON A.KeyDate = B.KeyDate AND A.KeySeq = B.KeySeq
       LEFT JOIN [mt_Custom] C ON A.CustomID = C.CustomID
	   LEFT JOIN mt_article D ON B.articleID = D.ArticleID
WHERE B.Subkeyseq = 1
   --AND B.ArticleID = 'A00001' 
ORDER BY a.plandate, A.OutWorkOrderDate, A.KeyDate, A.KeySeq DESC




select * from outworksub--articleID

select * from mt_Article


--fillspdmain�̻��Ѱ�

SELECT A.OutWorkOrderDate, C.KCustom, A.TotalQty, A.TotalCost, A.MaterialCost, A.KeyDate, A.KeySeq, plandate, a.finish , D.article
  FROM [OutWork] A
       LEFT JOIN [OutWorkSub] B ON A.KeyDate = B.KeyDate AND A.KeySeq = B.KeySeq
       LEFT JOIN [mt_Custom] C ON A.CustomID = C.CustomID
        LEFT JOIN mt_article D ON B.articleID = B.ArticleID
WHERE B.Subkeyseq = 1
AND A.OutWorkOrderDate BETWEEN '20231219' AND '20231226' 
ORDER BY a.plandate, A.OutWorkOrderDate, A.KeyDate, A.KeySeq DESC




select * from mt_article where articleId='A00020'


----------------------------------------------------------

--�ҿ���������(������:�űԵ�Ͻ� �ߴ� �κ�!!)
select distinct c.MaterialID, e.article, b.articleid, D.Material, sum(b.Qty*C.Amount) Tqty, b.KeySeq
from [outworksub] B
--LEFT JOIN [outworksub] B ON A.KeyDate = b.KeyDate  AND A.KeySeq = b.KeySeq
LEFT JOIN [mt_Article] E ON B.articleID = E.ArticleID
LEFT JOIN [mt_Articlesub] C ON B.articleID = c.ArticleID
LEFT JOIN [mt_Material] D ON C.MaterialID = D.MaterialID
WHERE (c.Divide ='����' or c.Divide ='����' ) and E.ArticleId = 'P10109' 
group by c.MaterialID, d.Material, e.article, b.KeySeq, b.articleid
ORDER BY b.KeySeq, e.article, d.material
--�������� ���⼭ materialID, material, Tqty�� �޾ư��� �Ǵ� ��?


--���������1
SELECT * FROM OutWorkmat WHERE KeyDate = '20231117' and keyseq = '1'

--���������2
select c.MaterialID, D.Material, sum(b.Qty*C.Amount) Tqty
from  [outworksub] B
LEFT JOIN [mt_Article] E ON B.articleID = E.ArticleID
LEFT JOIN [mt_Articlesub] C ON B.articleID = c.ArticleID
LEFT JOIN [mt_Material] D ON C.MaterialID = D.MaterialID
WHERE (c.Divide ='����' or c.Divide ='����') and E.ArticleId = 'P10109' 
group by  c.MaterialID, d.Material
ORDER BY d.material


---------------------------------------����ÿ� Ÿ�� ����!
INSERT INTO OutWorkSub (KeyDate, KeySeq, SubKeySeq , ArticleID, remark 
                         , Qty, UnitCost, Cost, Vat, TotalPrice) 
 VALUES ( '20231220', 4 , 1, 'P10108', ''  
          , 0, 0, 0, 0, 0 )  

--대한 입고쿼리

SELECT A.KeyDate '입고일자', 
CASE 
	WHEN A.StuffClss = '1' THEN '정상'
	WHEN A.StuffClss = '2' THEN '??'
	WHEN A.StuffClss = '3' THEN '???'
END '입고구분',
C.KCustom '거래처', B.Article '품명', A.OrderID '관리번호', A.TotRoll '입고절수', A.TotQty '입고수량', A.UnitClss '단위',
A.Custom '입고처', A.Remark '비고사항'
from StuffIN A 
LEFT JOIN [mt_Article] B ON A.ArticleID = B.ArticleID
LEFT JOIN [mt_Custom] C ON A.CustomID = C.CustomID



--대한외주수불명세서(끼악 어렵다~)
SELECT C.KCustom '거래처', B.Article '품명', D.orderNO 'order NO', E.Color '색상', '' 'Lot NO??', A.KeyDate '일자', 0 '입출고처??',
A.OutRoll '출고절수', A.OutQty '출고수량', F.TotRoll ' 입고절수', F.TotQty '입고수량'
FROM CommOut A
LEFT JOIN mt_Article B ON A.ArticleID = B.ArticleID
LEFT JOIN mt_Custom C ON A.OutCustomID = C.CustomID
LEFT JOIN mt_Custom G ON A.InCustomID = G.CustomID
LEFT JOIN [Order] D ON A.OrderID = D.OrderID 
LEFT JOIN [OrderColor] E ON D.OrderID = E.OrderID
LEFT JOIN StuffIN F ON A.OrderID = F.OrderID
WHERE A.KeyDate BETWEEN '20230101' AND '20231201'AND 
D.OrderNo = 'SY23-203'
ORDER BY A.KeyDate



SELECT * from CommOut 
-- Where color='화이트'
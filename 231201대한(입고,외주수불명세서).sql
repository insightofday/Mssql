--���� �԰�����

SELECT A.KeyDate '�԰�����', 
CASE 
	WHEN A.StuffClss = '1' THEN '����'
	WHEN A.StuffClss = '2' THEN '??'
	WHEN A.StuffClss = '3' THEN '???'
END '�԰���',
C.KCustom '�ŷ�ó', B.Article 'ǰ��', A.OrderID '������ȣ', A.TotRoll '�԰�����', A.TotQty '�԰����', A.UnitClss '����',
A.Custom '�԰�ó', A.Remark '������'
from StuffIN A 
LEFT JOIN [mt_Article] B ON A.ArticleID = B.ArticleID
LEFT JOIN [mt_Custom] C ON A.CustomID = C.CustomID



--���ѿ��ּ��Ҹ���(���� ��ƴ�~)
SELECT C.KCustom '�ŷ�ó', B.Article 'ǰ��', D.orderNO 'order NO', E.Color '����', '' 'Lot NO??', A.KeyDate '����', 0 '�����ó??',
A.OutRoll '�������', A.OutQty '������', F.TotRoll ' �԰�����', F.TotQty '�԰����'
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
-- Where color='ȭ��Ʈ'
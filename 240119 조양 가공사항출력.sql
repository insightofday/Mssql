select A.modifyremark, case  A.surfaceclss  when '0' then 'Surface' when '1' then 'BackSide' end '����', 
A.workWeight3, case A.unitclss when '0' then 'yds' when '1' then 'mts' end '��������', C.StuffWidth
from [Order] A
JOIN [mt_stuffwidth] C ON A.stuffwidth=C.stuffwidthID
where orderid='2024010087'



--�������ǻ���:modifyremark[order]//����:surfaceclss[order]'0'surface '1'white
--�۾��߷�:workweight3[order]//��������:unitclss[order]:0'yds'1'mts'
--�ǰ����۾���:stuffwidthid[mt_stuffwidth]


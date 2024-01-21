select A.modifyremark, case  A.surfaceclss  when '0' then 'Surface' when '1' then 'BackSide' end '사용면', 
A.workWeight3, case A.unitclss when '0' then 'yds' when '1' then 'mts' end '수량단위', C.StuffWidth
from [Order] A
JOIN [mt_stuffwidth] C ON A.stuffwidth=C.stuffwidthID
where orderid='2024010087'



--가공주의사항:modifyremark[order]//사용면:surfaceclss[order]'0'surface '1'white
--작업중량:workweight3[order]//수량단위:unitclss[order]:0'yds'1'mts'
--실가공작업폭:stuffwidthid[mt_stuffwidth]


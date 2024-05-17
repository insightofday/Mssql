
select SUM(Order_KG) OrderQty, sum(case jselname when '�ְ�' then grey_kg end) DyeDqty,
sum(case jselname when '�߰�' then grey_kg end) Dyenqty,
sum(case jselname when '�ְ�' then kg end) DyeDIns,
sum(case jselname when '�߰�' then kg end) DyeNins,
sum(case jselname when '�ְ�' then rlno end) countDpack,
sum(case jselname when '�߰�' then rlno end) countnPack
FROM
(SELECT ORDER_KG,jselname, grey_kg,kg,rlno
FROM [VIEW_DUSON]
WHERE LEFT(GSKEY,8)= '20240516'  UNION ALL
SELECT ORDER_KG,jselname, grey_kg,kg,rlno
FROM [VIEW_DUSON]
WHERE jselname='�߰�' AND 
CONVERT(datetime, LEFT(RTRIM(LTRIM(gskey)), 8), 112) between (SELECT CONVERT(datetime, LEFT(RTRIM(LTRIM(gskey)), 12), 112) FROM VIEW_DUSON WHERE left(gskey,12)= '202405151900' and gskey is not null) and (SELECT CONVERT(datetime, LEFT(RTRIM(LTRIM(gskey)), 12), 112) FROM VIEW_DUSON WHERE left(gskey,12)= '202405160659' and gskey is not null)) A



select gskey from view_duson where gskey between (SELECT CONVERT(datetime, LEFT(RTRIM(LTRIM(gskey)), 12), 112) FROM VIEW_DUSON WHERE left(gskey,12)= '202405151900' and gskey is not null) and (SELECT CONVERT(datetime, LEFT(RTRIM(LTRIM(gskey)), 12), 112) FROM VIEW_DUSON WHERE left(gskey,12)= '202405160659' and gskey is not null)



select gskey from view_duson where gskey is not null
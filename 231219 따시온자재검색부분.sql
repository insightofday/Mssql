select * from mt_material
select * from mt_MaterialClss


SELECT A.MaterialDate, A.UnitCost, A.Remark
  FROM [mt_MaterialSub] As A 
       LEFT JOIN [mt_Material] B ON A.MaterialID = B.MaterialID
 WHERE A.MaterialID = 'B009' 
ORDER BY A.MaterialDate DESC


SELECT A.MaterialID, A.Material, B.MaterialClssName, A.Color, A.Standard, C.KCustom
  FROM [mt_Material] A
     LEFT JOIN [mt_MaterialClss] AS B ON A.MaterialClss = B.MaterialClssID
       LEFT JOIN [mt_Custom] AS C ON A.CustomID = c.CustomID
WHERE A.Useclss <> '*'  
 AND B.MaterialclssID = '01'
ORDER BY A.MaterialID, A.Material DESC
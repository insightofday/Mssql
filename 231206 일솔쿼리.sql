select DISTINCT A.departID, B.Depart from  mt_Person A
LEFT JOIN mt_Depart B ON A.DepartID=B.DepartID
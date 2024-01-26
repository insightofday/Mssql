SELECT
    CAST(CASE WHEN StuffPart = '1' THEN CAST(SUBSTRING(Qty, CHARINDEX('*', Qty) + 1, LEN(Qty)) AS numeric(9, 3)) ELSE 1 END AS numeric(9, 2)) AS StuffRoll, 

    CAST(CASE WHEN StuffPart = '1' THEN SUBSTRING(Qty, 1, CHARINDEX('*', Qty) - 1) ELSE Qty END AS varchar) AS StuffUnitQty 
FROM StuffINReturn;


SELECT
  CAST(CASE WHEN StuffPart = '1' THEN SUBSTRING(Qty, CHARINDEX('*', Qty) + 1, LEN(Qty)) ELSE 1 END AS numeric(9, 0)) AS StuffRoll, 
CAST(CASE WHEN StuffPart = '1' THEN SUBSTRING(Qty, 1, CHARINDEX('*', Qty) - 1) ELSE Qty END AS numeric(9, 0)) AS StuffUnitQty 
FROM StuffINReturn;


SELECT
  CAST(CASE WHEN StuffPart = '1' THEN  CAST(SUBSTRING(Qty, CHARINDEX('*', Qty) + 1, LEN(Qty)) AS numeric(9, 0)) ELSE 1 END AS numeric(9, 0)) AS StuffRoll, 
CAST(CASE WHEN StuffPart = '1' THEN SUBSTRING(Qty, 1, CHARINDEX('*', Qty) - 1) ELSE Qty END AS numeric(9, 0)) AS StuffUnitQty 
FROM StuffINReturn;

--select * from stuffinreturn




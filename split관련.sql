select * from ds_bt

SELECT value AS SplitRemarks
FROM ds_bt
CROSS APPLY STRING_SPLIT(DS_BT.Remark,char(10))
WHERE DS_BT.Remark IS NOT NULL AND DS_BT.Remark <> ''


--select * from STRING_SPLIT(DS_BT.Remark,'  ' )
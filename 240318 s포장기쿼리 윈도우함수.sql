
SELECT workcnt,CONVERT(varchar, inptdate, 111)+' '+CONVERT(varchar(5),inptdate,114) date from packmach where MemoryAddress='%DW0120' order by date desc



SELECT workcnt, date
FROM (
    SELECT workcnt,
           CONVERT(varchar, inptdate, 111)+' '+CONVERT(varchar(5),inptdate,114) AS date,
           LAG(workcnt) OVER (ORDER BY inptdate DESC) AS prev_workcnt
    FROM packmach
    WHERE MemoryAddress='%DW0120'
) AS sub
WHERE workcnt <> prev_workcnt OR prev_workcnt IS NULL
ORDER BY date DESC;


SELECT workcnt, date
FROM (
    SELECT workcnt,
           CONVERT(varchar, inptdate, 111)+' '+CONVERT(varchar(5),inptdate,114) AS date,
           ROW_NUMBER() OVER (ORDER BY inptdate DESC) AS row_num
    FROM packmach
    WHERE MemoryAddress='%DW0120'
) AS sub
WHERE row_num = 1
ORDER BY date DESC;


 update packmach set left(workdate,6,2)+'02'+right(workdate,8,2)


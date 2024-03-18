select workcnt,CONVERT(varchar, inptdate, 111)+' '+CONVERT(varchar(5),inptdate,114) date
 from packmach where MemoryAddress='%DW0120'order by date desc --and workdate=getdate()

 select max(workcnt),workDate from packmach where MemoryAddress='%DW0120' group by workdate order by workdate desc

 SELECT sum(workcnt),substring(workDate,5,2) permonth from packmach where MemoryAddress='%DW0120' and 
 workdate=(select workcnt, inptdate from packmach where  MemoryAddress='%DW0120' group by workdate,inptdate,workcnt having inptdate=max(inptdate)), group by substring(workDate,5,2) order by permonth desc


 select workdate,substring(workdate,5,2) from packmach

 select workcnt,inptdate from packmach where MemoryAddress='%DW0120'

 select * from packmach where workcnt<>0 order by inptdate 
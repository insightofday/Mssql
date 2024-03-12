select distinct concat(a.workdate,a.worktime) '시간',substring(a.workdate,5,2)+'월'+substring(a.workdate,7,9)+'일' date,
substring(a.worktime,1,2)+'시'+substring(a.worktime,3,4)+'분' time, a.wrk_temp, worktemp1,worktemp2 from plc_tenter1 a
inner join                                                                                      
plc_dye1st b 
on concat(a.workdate,a.worktime)=concat(b.workdate,b.worktime) 
--where a.workdate between '20240301' and '20240303'
order by '시간'  


select distinct concat(a.workdate,a.worktime) '시간',substring(a.workdate,5,2)+'월'+substring(a.workdate,7,9)+'일' date,
substring(a.worktime,1,2)+'시'+substring(a.worktime,3,4)+'분' time, a.wrk_temp, worktemp1,worktemp2 from plc_tenter1 a
inner join                                                                                      
plc_dye1st b 
on concat(a.workdate,a.worktime)=concat(b.workdate,b.worktime) 
where a.workdate between  '20240205' AND '20240312'  
order by '시간'  



with buyerCTE (buyer_zip, totalmme)
as (select buyer_zip,
		   sum(mme) as totalmme
    from cse532.dea_ny
    group by buyer_zip)
select buyer_zip as ZipCodes,
	   totalmme / z.pop as MME_Normalised,
	   rank() over(order by totalmme / z.pop desc) as Rank
from buyerCTE
inner join
cse532.zip as z
on buyer_zip = z.zip
where
z.pop is not null
and
z.pop > 0
limit 10
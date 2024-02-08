select distinct *
from sfrstcr
join ssbsect
on sfrstcr_term_code=ssbsect_term_code;
 --2874

union all

select distinct *
from spbpers
join sfrstcr
on spbpers_pidm=sfrstcr_pidm


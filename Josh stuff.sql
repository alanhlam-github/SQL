select * 
from sfrstcr,sgbstdn,shrtgpa,spriden
where sfrstcr_pidm=sgbstdn_pidm
and sgbstdn_pidm=spriden_pidm
and spriden_pidm=shrtgpa_pidm
and sfrstcr_term_code >= 202010
and sfrstcr_term_code <= 202310; -- by term
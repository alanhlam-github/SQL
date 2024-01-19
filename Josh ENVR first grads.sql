select distinct sfrstcr_term_code,sfrstcr_pidm,shrdgmr_degs_code,shrdgmr_majr_code_1,spriden_ID

from sfrstcr,shrdgmr,sgbstdn,spriden

where sfrstcr_pidm=shrdgmr_pidm
and sfrstcr_pidm=spriden_pidm
and sfrstcr_pidm=sgbstdn_pidm
and SPRIDEN_CHANGE_IND IS NULL
--and stvmajr_code=shrdgmr_majr_code_1
and SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM')

and shrdgmr_majr_code_1='ENVR'
order by sfrstcr_term_code --2794 count
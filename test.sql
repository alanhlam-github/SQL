select distinct shrtckg_pidm,shrtckg_term_code,shrtckg_grde_code_final,sfrstcr_term_code

from shrtckg,shrtckn,sfrstcr

where shrtckg_pidm=shrtckn_pidm
and shrtckn_pidm=sfrstcr_pidm
and sfrstcr_term_code=202010
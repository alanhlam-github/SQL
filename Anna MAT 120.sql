select distinct shrtckn_pidm,shrtckg_grde_code_final,shrtckn_crn

from shrtckn,sfrstcr,sgbstdn,shrtckg

where shrtckn_pidm=sfrstcr_pidm
and shrtckn_pidm=shrtckg_pidm
         and shrtckg_term_code = shrtckn_term_code
         and shrtckg_tckn_seq_no = shrtckn_seq_no

and SHRTCKG_SEQ_NO = (SELECT MAX(A.SHRTCKG_SEQ_NO)
                                                   FROM SHRTCKG A
                              WHERE A.SHRTCKG_PIDM= SHRTCKN_PIDM
                                      AND A.SHRTCKG_TERM_CODE=SHRTCKN_TERM_CODE
                                      AND A.SHRTCKG_TCKN_SEQ_NO=SHRTCKN_SEQ_NO)

AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX(A.SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN A
                                WHERE A.SGBSTDN_PIDM = SFRSTCR_PIDM
                                  AND A.SGBSTDN_TERM_CODE_EFF <= 202010)
  and SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM')

and shrtckn_term_code = 202010
--and shrtckn_subj_code='MAT'
--and shrtckn_crse_numb ='120'

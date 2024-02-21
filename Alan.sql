AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX(A.SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN A
                                WHERE A.SGBSTDN_PIDM = SFRSTCR_PIDM
                                  AND A.SGBSTDN_TERM_CODE_EFF >= SFRSTCR_TERM_CODE)

and SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM'); --important for filtering


AND SPRIDEN_CHANGE_IND IS NULL --spriden distincts

select * from sirasgn; -- SIRASGN_TERM_CODE,SIRASGN_CRN,SIRASGN_PRIMARY_IND

select * from spriden; --first,last,middle names and CID

select * from sfrstcr; --term code and SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM'), sfrstcr_grde_code

select * from sgbstdn; --Term code and student type - sgbstdn_styp_code

select * from stvstyp; --for student type

select * from spbpers; --SSN,DOB, and ethnicity

select * from SHRDGMR; --AW for awarded degree

select * from stvmajr; --majors

select * from stvvetc;--veteran GI Bill certs

select * from sgrvetn; --veteran stuff 2

select * from rovvetn; --veteran stuff 3

select * from ssbsect;--course subjects info - SSBSECT_SUBJ_CODE,SSBSECT_CRSE_NUMB,SSBSECT_SEQ_NUMB

--SSBSECT_CAMP_CODE,SSBSECT_ENRL

--(+) is like a left join, NVL(sgbstdn_sess_code, 'Not Military') like IF

select * from sgrchrt;

select * from stvchrt;

select * from shrlgpa; --for GPA, shrlgpa_gpa_type_ind, shrlgpa_hours_earned, shrlgpa_activity_date

select * from shrtgpa; --might be better for GPA hours earned

select * from szhegis;--Curriculum code shrlgpa_activity_date= 21-AUG-15

select * from ssrmeet;--room locations and meet times - SSRMEET_BEGIN_TIME,SSRMEET_END_TIME,SSRMEET_BLDG_CODE,SSRMEET_ROOM_CODE

select * from spraddr; --addresses spraddr_cnty_code

select stvcnty_code,stvcnty_desc from stvcnty;--county names

select * from shrtckn;--course subj code

select * from sorhsch;

select * from shrtckg; --shrtckcn cousin, gives SHRTCKG_CODE_FINAL

select * from sortest;--sortest_admr_code,sortest_tsrc_code

select * from as_course_prereq;

select * from szhegis; --CIP code stuff

select * from rfrbase;

select * from rprawrd;

select * from STVCIPC; --CIP codes

select * from gobtpac; --gobtpac_external_user for email username

select * from sarappd; --admissions application: saraappd_apdc_code CC means accepted

select * from SOVETRM;

select * from STVGPAT;--LIFE shcholarship stuff

select * from stvterm;
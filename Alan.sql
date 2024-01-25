AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX(A.SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN A
                                WHERE A.SGBSTDN_PIDM = SFRSTCR_PIDM
                                  AND A.SGBSTDN_TERM_CODE_EFF >= 201910)
  and SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM'); --important for filtering


AND SPRIDEN_CHANGE_IND IS NULL --spriden distincts

select * from spriden; --first,last,middle names and CID

select * from sfrstcr; --term code and SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM') sfrstcr_grde_code

select * from sgbstdn; --Term code and student type

select * from stvstyp; --for student type

select * from spbpers; --SSN,DOB, and ethnicity

select * from SHRDGMR; --AW for awarded degree

select * from stvmajr; --majors

select * from stvvetc;--veteran GI Bill certs

select * from sgrvetn; --veteran stuff 2

select * from rovvetn; --veteran stuff 3

select * from ssbsect;--course subjects info ssbsect_crse_numb

--(+) is like a left join, NVL(sgbstdn_sess_code, 'Not Military') like IF

select * from sgrchrt;

select * from stvchrt;

select * from shrlgpa; --for GPA

select * from szhegis;--Curriculum code

select * from ssrmeet;--room locations and meet times

select * from spraddr; --addresses spraddr_cnty_code

select stvcnty_code,stvcnty_desc from stvcnty;--county names

select * from shrtckn;--course subj code

select * from sorhsch;

select * from shrtckg;

select * from sortest;--sortest_admr_code,sortest_tsrc_code

select * from as_course_prereq;

select * from szhegis; --CIP code stuff

select * from rfrbase;

select * from rprawrd;

select * from STVCIPC; --CIP codes
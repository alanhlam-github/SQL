AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX(A.SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN A
                                WHERE A.SGBSTDN_PIDM = SFRSTCR_PIDM
                                  AND A.SGBSTDN_TERM_CODE_EFF >= SFRSTCR_TERM_CODE)

AND SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM'); --important for filtering


AND SPRIDEN_CHANGE_IND IS NULL --spriden distincts

SELECT * FROM SIRASGN; -- SIRASGN_TERM_CODE,SIRASGN_CRN,SIRASGN_PRIMARY_IND

SELECT * FROM SPRIDEN; --first,last,middle names and CID

SELECT * FROM SFRSTCR; --term code and SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM'), sfrstcr_grde_code

SELECT * FROM SFRSTCA;

SELECT * FROM SGBSTDN; --Term code and student type - sgbstdn_styp_code
--STVCOLL_CODE=SGBSTDN_COLL_CODE_1

SELECT * FROM STVSTYP; --for student type

SELECT * FROM SPBPERS; --SSN,DOB, and ethnicity

SELECT * FROM SHRDGMR; --AW for awarded degree,SHRDGMR_GRAD_DATE == '15-OCT-22'

SELECT * FROM STVMAJR; --majors

SELECT * FROM STVVETC;--veteran GI Bill certs

SELECT * FROM SGRVETN; --veteran stuff 2

SELECT * FROM ROVVETN; --veteran stuff 3

SELECT * FROM SSBSECT;--course subjects info - SSBSECT_SUBJ_CODE,SSBSECT_CRSE_NUMB,SSBSECT_SEQ_NUMB
--SSBSECT_ENRL and SEATS_AVAIL?
SELECT * FROM SSRMEET;--room locations and meet times - SSRMEET_BEGIN_TIME,SSRMEET_END_TIME,SSRMEET_BLDG_CODE,SSRMEET_ROOM_CODE
--SSBSECT_CAMP_CODE,SSBSECT_ENRL

--(+) is like a left join, NVL(sgbstdn_sess_code, 'Not Military') like IF

SELECT * FROM SGRCHRT;

SELECT * FROM STVCHRT;

SELECT * FROM SHRLGPA; --for GPA, shrlgpa_gpa_type_ind, shrlgpa_hours_earned, shrlgpa_activity_date

SELECT * FROM SHRTGPA; --might be better for GPA hours earned

SELECT * FROM SZHEGIS;--Curriculum code shrlgpa_activity_date= 21-AUG-15

SELECT * FROM SPRADDR; --addresses spraddr_cnty_code

SELECT STVCNTY_CODE,STVCNTY_DESC FROM STVCNTY;--county names

SELECT * FROM SHRTCKN;--course subj code

SELECT * FROM SORHSCH;

SELECT * FROM SHRTCKG; --shrtckcn cousin, gives SHRTCKG_CODE_FINAL

SELECT * FROM SORTEST;--sortest_admr_code,sortest_tsrc_code

SELECT * FROM AS_COURSE_PREREQ;

SELECT * FROM SZHEGIS; --CIP code stuff

SELECT * FROM RFRBASE;

SELECT * FROM RPRAWRD;

SELECT * FROM STVCIPC; --CIP codes

SELECT * FROM GOBTPAC; --gobtpac_external_user for email username

SELECT * FROM SARAPPD; --admissions application: saraappd_apdc_code CC means accepted

SELECT * FROM SOVETRM;

SELECT * FROM STVGPAT;--LIFE shcholarship stuff

SELECT * FROM STVTERM;

SELECT * FROM SCBCRSE;--SCBCRSE_COLL_CODE
--SCBCRSE_EFF_TERM
SELECT * FROM STVCOLL;
SELECT * FROM SSBSECT;

SELECT * FROM STVTMST;--Full/Part Time Status Validation Table; STVTMST_CODE FOR JOINING, DESC FOR TITLE

SELECT * FROM SFRTMSL;--FULL/PART TIME STATUS LEVEL CODE - SFRTMSL_TMST_CODE,SFRTMSL_TERM_CODE_EFF

SELECT * FROM SFRTMST;--same as SFRTMSL?

SELECT * FROM SIRATTR; --faculty full time/part time stuff

SELECT * FROM STVCAMP;

SELECT * FROM STVDEPT; --DEPT NAME DESC STVDEPT_CODE

SELECT * FROM SPRHOLD; --Person Related Holds Repeating Table

SELECT * FROM STVHLDD;--Person Hold Type Validation Table

SELECT * FROM SARADAP; -- ADMISSIONS TABLE
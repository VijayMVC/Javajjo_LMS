-- 테이블 생성
CREATE TABLE STUDENT(
	ID VARCHAR2(12) NOT NULL,
	NAME VARCHAR(10) NOT NULL,
	PW VARCHAR2(100) NOT NULL,
	GENDER CHAR(1) NOT NULL CONSTRAINT GENDER_CHECK CHECK (GENDER IN ('M','F')),
	BIRTH DATE,
	ADDR VARCHAR2(100),
	S_CHECK CHAR(1) DEFAULT 'N',
	DELFLAG CHAR(1) CONSTRAINT DELFLAG_CHECK CHECK (DELFLAG IN ('N', 'Y')),
	CONSTRAINT USERR PRIMARY KEY (ID)
);

CREATE TABLE TEACHER(
	ID VARCHAR2(12) NOT NULL PRIMARY KEY,
	NAME VARCHAR2(10) NOT NULL,
	PW VARCHAR2(100) NOT NULL,
	SUB VARCHAR2(100) NOT NULL
);

CREATE TABLE ADMIN(
	ID VARCHAR2(12) NOT NULL PRIMARY KEY,
	NAME VARCHAR2(10) NOT NULL,
	PW VARCHAR2(100) NOT NULL
);

CREATE TABLE NOTICE_BOARD(
	SEQ NUMBER NOT NULL PRIMARY KEY,
	TITLE VARCHAR2(50) NOT NULL,
	CONTENT VARCHAR2(500),
	ID VARCHAR2(12),
	REGDATE DATE,
	READCOUNT NUMBER
);
CREATE SEQUENCE NOTICE_BOARD_SEQ START WITH 1 INCREMENT BY 1;

CREATE TABLE FAQ_BOARD(
	SEQ NUMBER NOT NULL PRIMARY KEY,
	TITLE VARCHAR2(50) NOT NULL,
	CONTENT VARCHAR2(500),
	ID VARCHAR2(12),
	REGDATE DATE,
	READCOUNT NUMBER
);
CREATE SEQUENCE FAQ_BOARD_SEQ START WITH 1 INCREMENT BY 1;


CREATE TABLE EMPTY_BOARD(
	CODE VARCHAR2(20) NOT NULL PRIMARY KEY,
	NAME VARCHAR2(10) NOT NULL,
	PERSONEL NUMBER
);

CREATE TABLE EMPTY_USER(
	CODE VARCHAR2(20) NOT NULL PRIMARY KEY,
	ID VARCHAR2(12) NOT NULL,
	REGDATE DATE
);

CREATE TABLE REQUEST_BOARD(
	SEQ NUMBER NOT NULL,
	ID VARCHAR2(12) NOT NULL,
	TITLE VARCHAR(50) NOT NULL,
	CONTENT VARCHAR(500) NOT NULL,
	REFER NUMBER NOT NULL,
	STEP NUMBER NOT NULL,
	REGDATE DATE NOT NULL,
	READCOUNT NUMBER NOT NULL,
	ANSWERED CHAR(1) NOT NULL,
	CONSTRAINT REQUEST_BOARD_PK PRIMARY KEY (SEQ)
);
CREATE SEQUENCE REQUEST_BOARD_SEQ START WITH 1 INCREMENT BY 1;

CREATE TABLE FILE_BOARD(
	SEQ NUMBER NOT NULL,
	ID VARCHAR2(12) NOT NULL,
	TITLE VARCHAR(50) NOT NULL,
	CONTENT VARCHAR(500) NOT NULL,
	REGDATE DATE NOT NULL,
	READCOUNT NUMBER NOT NULL,
	REPORT CHAR(1) NOT NULL,
	FILENAME VARCHAR2(500),
	NEWFILENAME VARCHAR2(500),
	CONSTRAINT FILE_BOARD_PK PRIMARY KEY (SEQ)
);

CREATE TABLE COURSE(
	COURSECODE VARCHAR2(10) NOT NULL PRIMARY KEY,
	COURSENAME VARCHAR2(30) NOT NULL,
	STARTDATE DATE,
	COURSECNT NUMBER NOT NULL
);

CREATE TABLE SUBJECT(
	SUBJECTCODE VARCHAR2(10) NOT NULL PRIMARY KEY,
	SUBJECTNAME VARCHAR2(30) NOT NULL,
	SUBJECTTYPE VARCHAR2(10) NOT NULL,
	EXAMTYPE VARCHAR2(10) NOT NULL
);

-- 학생-과정 테이블 연결
CREATE TABLE USERCOURSE(
	ID VARCHAR2(12) NOT NULL,
	COURSECODE VARCHAR2(10) NOT NULL,
	REGDATE DATE NOT NULL
);

CREATE TABLE COURSE_SUBJECT(
	SEQ NUMBER NOT NULL,
	COURSECODE VARCHAR2(10) NOT NULL,
	SUBJECTCODE VARCHAR2(10) NOT NULL,
	SUBJECTTIME NUMBER NOT NULL,
	CONTENT VARCHAR2(50),
	STARTDATE DATE
);

--과목-과제 연결
CREATE TABLE SUBJECT_EXAM(
	SUBJECTCODE VARCHAR2(10) NOT NULL,
	TESTCODE VARCHAR2(10),
	TESTDAY DATE
);

--문제 유형
--CREATE TABLE EXAMCATEGORY(
--	"TYPE" VARCHAR2(10) NOT NULL PRIMARY KEY,
--	EXAMTYPE VARCHAR2(10) NOT NULL
--);

--과제-문제  연결
CREATE TABLE TEST_EXAM(
	TESTCODE VARCHAR2(10) NOT NULL PRIMARY KEY,
	EXAMCODE VARCHAR2(10) NOT NULL,
	ALLOT NUMBER NOT NULL,
	EXAMNUM NUMBER NOT NULL
);

CREATE TABLE TEST(
	TESTCODE VARCHAR2(10) NOT NULL,
	TESTNAME VARCHAR2(300) NOT NULL,
	SUBJECTTYPE VARCHAR2(10) NOT NULL,
	EXAMTYPE VARCHAR2(10) NOT NULL
);


-- 서술형문제 
CREATE TABLE EXAMDESCRIPTIVE(
	EXAM VARCHAR2(500) NOT NULL,
	EXAMCODE VARCHAR2(10) NOT NULL,
	EXPLANATION VARCHAR2(700),
	STANDARD VARCHAR2(500),
	C_ANSWER VARCHAR2(500) NOT NULL
);

--서술형 답
CREATE TABLE ANSWERDESCRIPTIVE(
	ID VARCHAR2(12) NOT NULL,
	EXAMCODE VARCHAR2(10) NOT NULL,
	EXAMNUM NUMBER NOT NULL,
	ANSWER VARCHAR2(700) NOT NULL,
	ORIGINFILE VARCHAR2(500),
	NEWFILENAME VARCHAR2(500)
);

--선택형 문제
CREATE TABLE EXAMSELECT(
	EXAM VARCHAR2(500) NOT NULL,
	EXAMCODE VARCHAR2(10) NOT NULL,
	C_ANSWER NUMBER NOT NULL
);

-- 선택형 문항
CREATE TABLE CONTENTSELECT(
	EXAMCODE VARCHAR2(10) NOT NULL,
	EXAMNUM NUMBER NOT NULL,
	EXAMCONTENT VARCHAR2(500) NOT NULL
);

--선택형 답 
CREATE TABLE ANSWERSELECT(
	ID VARCHAR2(12) NOT NULL,
	EXAMCODE VARCHAR2(10) NOT NULL,
	EXAMNUM NUMBER NOT NULL,
	ANSWER NUMBER NOT NULL
);

-- 성적 테이블
CREATE TABLE SCORE(
	ID VARCHAR2(12) PRIMARY KEY NOT NULL,
	EXAMCHECK CHAR(1) DEFAULT 'N' CONSTRAINT EXAMCHECK_CHECK CHECK (EXAMCHECK IN ('N','S','Y')),
	TESTCODE VARCHAR2(30) NOT NULL,
	EXAMCODE VARCHAR2(10),
	SCORE NUMBER
);

 -- 전자결재
-- 테이블 생성
-- 결석 신청 테이블 생성
CREATE TABLE APP_FORM(
	FORM_SEQ NUMBER NOT NULL,
	APP_DATE DATE NOT NULL,
	STUDENT_ID VARCHAR2(12) NOT NULL,
	RECIPIENT_ID VARCHAR2(12) NOT NULL,
	COURSECODE VARCHAR2(10) NOT NULL,
	REASON VARCHAR2(50) NOT NULL,
	START_DATE DATE NOT NULL,
	ABSENT_DAYS NUMBER NOT NULL, -- START_DATE + ABSENT_DAYS - 1 = 마지막 결석일
	FILENAME VARCHAR2(500),
	NEWFILENAME VARCHAR2(500),
	CONSTRAINT APP_FORM_PK PRIMARY KEY(FORM_SEQ)
);

-- 신청서 SEQ 생성
CREATE SEQUENCE APP_FORM_SEQ INCREMENT BY 1 START WITH 1;



-- 승인 여부 테이블 
CREATE TABLE IS_APPROVE(
	FORM_SEQ NUMBER NOT NULL,
	STM CHAR DEFAULT 'N' NOT NULL,
	CONSTRAINT IS_APPROVE_PK PRIMARY KEY(FORM_SEQ)
);

-- 사인 테이블 생성
CREATE TABLE SIGNATURE(
	SIGNATURE_ID VARCHAR2(12) NOT NULL,
	USECHECK CHAR NOT NULL,
	FILENAME VARCHAR2(500) NOT NULL,
	NEWFILENAME VARCHAR2(500) NOT NULL,
	CONSTRAINT SIGNATURE_PK PRIMARY KEY(SIGNATURE_ID)
);

-- 반려 사유 테이블 생성
CREATE TABLE UNAPPROVED(
	FORM_SEQ NUMBER NOT NULL,
	REASON VARCHAR2(100),
	CONSTRAINT UNAPPROVED_PK PRIMARY KEY(FORM_SEQ)
);

CREATE TABLE ATTENDEDCHECK(
	SEQ NUMBER NOT NULL,
	A_CHECK CHAR(1) CONSTRAINT A_CHECK_CHECK CHECK (A_CHECK IN ('N','Y')), --퇴실은 N, 출석은 Y , 결석은 Null
	ID VARCHAR2(12) NOT NULL,
	REGDATE DATE NOT NULL, 
	CONSTRAINT ATTENDEDCHECK_PK PRIMARY KEY(SEQ)
);
CREATE SEQUENCE ATTENDEDCHECK_SEQ INCREMENT BY 1 START WITH 1;



-- 쿼리

-- 회원 관리
-- 관리자 등록
INSERT INTO ADMIN
VALUES('01099999999', '관리자', '1111');

-- 학생 회원 가입
INSERT INTO STUDENT VALUES('01022222222', '길동홍', '1111','F', '2019-05-08','서울시 강남구 찬주동', 'N','N');

-- 아이디 중복 Ajax
SELECT 1 FROM STUDENT WHERE ID ='01011111111';

-- 공지사항 게시판	
-- 게시글 리스트 조회
SELECT SEQ,TITLE,ID,REGDATE,READCOUNT
 FROM (SELECT ROWNUM RNUM,SEQ,TITLE,CONTENT,ID,REGDATE,READCOUNT
   FROM (SELECT SEQ,TITLE,CONTENT,ID,REGDATE,READCOUNT
    FROM NOTICE_BOARD ORDER BY SEQ))
  WHERE RNUM BETWEEN 1 AND 10;

-- 게시글 상세 조회
SELECT SEQ,TITLE,CONTENT,ID,REGDATE,READCOUNT 
 FROM NOTICE_BOARD WHERE SEQ = 1;

-- 게시글 작성 ( 강사, 관리자만 작성가능 )
INSERT INTO NOTICE_BOARD VALUES(NOTICE_BOARD_SEQ.NEXTVAL,'공지사항 글제목','내용','01011111111',SYSDATE,0)

-- 게시글 검색 ( 제목으로 검색 )
SELECT SEQ,TITLE,ID,REGDATE,READCOUNT
 FROM (SELECT ROWNUM RNUM,SEQ,TITLE,CONTENT,ID,REGDATE,READCOUNT
   FROM (SELECT SEQ,TITLE,CONTENT,ID,REGDATE,READCOUNT
    FROM NOTICE_BOARD ORDER BY SEQ))
  WHERE RNUM BETWEEN 1 AND 10
 AND TITLE LIKE '%공지%';
 
-- 조회수 증가
UPDATE NOTICE_BOARD SET READCOUNT = READCOUNT+1
WHERE SEQ = 1;

-- 빈강의실	
-- 모든 강의실 목록 조회
SELECT CODE,NAME,PERSONEL FROM  EMPTY_BOARD;

-- 빈 강의실 목록 조회
SELECT NAME,PERSONEL,ID,REGDATE FROM EMPTY_USER JOIN EMPTY_BOARD USING(CODE)
WHERE TO_CHAR(REGDATE,'YYYYMMDD')='20190507';

-- 예약 확인
SELECT ID FROM EMPTY_USER WHERE ID = '01011111111'
AND CODE = '1111'
AND TO_CHAR(REGDATE,'YYYYMMDD')='20190507';

-- 예약
INSERT INTO EMPTY_USER VALUES('1111','01011111111','2019-05-07');

-- 예약 취소 (취소는 본인이 예약한 사항만 취소 가능)
DELETE FROM EMPTY_USER WHERE ID = '01011111111'
AND CODE = '1111'
AND TO_CHAR(REGDATE,'YYYYMMDD')='20190507';

-- 예약완료시 대기신청
INSERT INTO EMPTY_USER VALUES('1111','01011111111',SYSDATE);

-- 강의실 추가
INSERT INTO EMPTY_BOARD VALUES('1111','ONE',10);
	
-- 1:1 건의 게시판	
-- 글 전체 조회(강사, 관리자) [페이징]
SELECT SEQ,ID,TITLE,REGDATE,READCOUNT,ANSWERED
 FROM (SELECT ROWNUM RNUM,SEQ,ID,TITLE,REFER,STEP,REGDATE,READCOUNT,ANSWERED
   FROM (SELECT SEQ,ID,TITLE,REFER,STEP,REGDATE,READCOUNT,ANSWERED
    FROM REQUEST_BOARD WHERE ANSWERED='N'
     ORDER BY REFER DESC,STEP))
  WHERE RNUM BETWEEN 리스트시작번호 AND 리스트끝번호

-- 글 전체 조회 갯수(강사,관리자)
SELECT COUNT(*) FROM REQUEST_BOARD WHERE ANSWERED = 'N'

-- 글 상세 조회(강사,관리자)
SELECT SEQ,ID,TITLE,CONTENT,REGDATE,READCOUNT,ANSWERED
 FROM REQUEST_BOARD WHERE SEQ = 글 고유 번호
 
-- 본인 질문글 조회 (학생) [페이징]
SELECT SEQ,ID,TITLE,REGDATE,READCOUNT,ANSWERED
 FROM (SELECT ROWNUM RNUM,SEQ,ID,TITLE,CONTENT,REFER,STEP,REGDATE,READCOUNT,ANSWERED
   FROM (SELECT SEQ,ID,TITLE,CONTENT,REFER,STEP,REGDATE,READCOUNT,ANSWERED
    FROM REQUEST_BOARD WHERE ID= 사용자아이디
     ORDER BY REFER DESC,STEP))
  WHERE RNUM BETWEEN 리스트시작번호 AND 리스트끝번호

-- 본인 질문글 조회 갯수 (학생)
SELECT COUNT(*) FROM REQUEST_BOARD WHERE ID = 사용자아이디

-- 글 상세 조회(학생)
SELECT SEQ,ID,TITLE,CONTENT,REGDATE,READCOUNT,ANSWERED
 FROM REQUEST_BOARD WHERE SEQ = 글 고유 번호

-- 질문글 작성(학생)
INSERT INTO REQUEST_BOARD
(SEQ,ID,TITLE,CONTENT,REFER,STEP,REGDATE,READCOUNT,ANSWERED)
VALUES(REQUEST_BOARD_SEQ.NEXTVAL,'사용자아이디', '질문제목', '질문내용', 
(SELECT NVL(MAX(REFER),0)+1 FROM REQUEST_BOARD), 0, SYSDATE, 0, 'N');

-- 답변 작성(강사, 관리자)
INSERT INTO REQUEST_BOARD
(SEQ,ID,TITLE,CONTENT,REFER,STEP,REGDATE,READCOUNT,ANSWERED)
VALUES(REQUEST_BOARD_SEQ.NEXTVAL,'답변자아이디', '답변제목.', '답변내용', 
(SELECT REFER FROM REQUEST_BOARD WHERE SEQ= 글 고유 번호), (SELECT STEP+1 FROM REQUEST_BOARD WHERE SEQ=글 고유 번호), SYSDATE, 0, 'Y')

-- 조회수 증가
UPDATE REQUEST_BOARD SET READCOUNT + 1 WHERE SEQ = 글 고유 번호

-- 답변 여부 변경
UPDATE REQUEST_BOARD SET ANSWERED = 'Y' WHERE SEQ = 글 고유 번호

-- 답변 상세 조회(학생)
SELECT SEQ,ID,TITLE,CONTENT,REGDATE,READCOUNT,ANSWERED
 FROM REQUEST_BOARD WHERE REFER = 글 번호 AND STEP='1'
 
--자료게시판	
-- 글 전체 조회[페이징]
SELECT SEQ, ID, TITLE, REGDATE, READCOUNT, REPORT
FROM (SELECT ROWNUM RNUM ,SEQ, ID, TITLE, CONTENT, REGDATE, READCOUNT, REPORT, FILENAME, NEWFILENAME
FROM FILE_BOARD
ORDER BY SEQ DESC)
WHERE RNUM BETWEEN 리스트시작번호 AND 리스트끝번호

-- 글 상세 조회
SELECT SEQ, ID, TITLE, CONTENT, REGDATE, READCOUNT, REPORT, FILENAME, NEWFILENAME
 FROM FILE_BOARD WHERE SEQ = 글 고유 번호
 
-- 글 작성
INSERT INTO FILE_BOARD
(SEQ, ID, TITLE, CONTENT, REGDATE, READCOUNT, REPORT, FILENAME, NEWFILENAME)
VALUES(FILE_BOARD_SEQ.NEXTVAL, '작성자', '자료제목', '자료내용', SYSDATE, 0, 'N', '변경전파일이름','변경후파일이름');

-- 글 수정
UPDATE FILE_BOARD SET TITLE = '새로운제목', CONTENT='새로운내용', FILENAME='새로운파일이름', NEWFILENAME='새로운파일이름';

-- 글 삭제(다중 삭제)
DELETE FROM FILE_BOARD WHERE SEQ IN (1,2);

-- 글 신고
UPDATE FILE_BOARD SET REPORT = 'Y' WHERE SEQ = 글 고유 번호

-- 조회수 증가
UPDATE FILE_BOARD SET READCOUNT = READCOUNT+1 WHERE SEQ = 글 고유 번호

-- 신고 여부 초기화
UPDATE FILE_BOARD SET REPORT = 'N' WHERE SEQ = 글 고유 번호

-- 검색 (작성자)
SELECT SEQ, ID, TITLE, REGDATE, READCOUNT, REPORT
 FROM (SELECT ROWNUM RNUM ,SEQ, ID, TITLE, CONTENT, REGDATE, READCOUNT, REPORT, FILENAME, NEWFILENAME
FROM FILE_BOARD ORDER BY SEQ DESC)
WHERE RNUM BETWEEN 1 AND 5 
 AND ID LIKE '작성자';

-- 검색(제목)
SELECT SEQ, ID, TITLE, REGDATE, READCOUNT, REPORT
 FROM (SELECT ROWNUM RNUM ,SEQ, ID, TITLE, CONTENT, REGDATE, READCOUNT, REPORT
FROM FILE_BOARD ORDER BY SEQ DESC)
WHERE RNUM BETWEEN 1 AND 5 
 AND ID LIKE '작성자' AND TITLE LIKE '%검색어%';
 
-- 검색 (작성자 + 제목)
SELECT SEQ, ID, TITLE, REGDATE, READCOUNT, REPORT
 FROM (SELECT ROWNUM RNUM ,SEQ, ID, TITLE, CONTENT, REGDATE, READCOUNT, REPORT, FILENAME, NEWFILENAME
FROM FILE_BOARD) 
ORDER BY SEQ DESC)
WHERE RNUM BETWEEN 리스트시작번호 AND 리스트끝번호 
AND WHERE ID like '%검색어%' OR TITLE like '%검색어%'

-- 회원관리 + 로그인
-- 로그인
SELECT ID,NAME,S_CHECK,DELFLAG FROM STUDENT  WHERE ID=아이디 AND PW=비밀번호

-- 비밀번호 초기화
UPDATE STUDENT SET PW ='12345' WHERE ID='아이디1';

-- 회원 탈퇴
UPDATE STUDENT SET DELFLAG = 'N' WHERE ID='01011111111';

-- 사용자 정보 조회
SELECT ID, NAME, GENDER, BIRTH, ADDR
 FROM STUDENT WHERE ID = '';

-- 수강중인 과정 조회 
SELECT COURSENAME, STARTDATE, COURSECNT
  FROM USERCOURSE U JOIN COURSE C
  USING (COURSECODE) WHERE U.ID = '01011111111';

--사용자 정보 수정
UPDATE STUDENT SET PW='0000', NAME='홍길동', GENDER='F', ADDR='서울시 강남'
 WHERE ID= '01011111111'
 
-- 로그인
SELECT ID, NAME, COURSECODE 
 FROM TEACHER
  WHERE ID='' AND PW='';
  
-- 사용자 정보 조회
SELECT ID, NAME, COURSECODE, PW 
 FROM TEACHER WHERE ID='';
 
-- 본인 과정 수강중인 학생 조회 
SELECT ID, NAME, GENDER, BIRTH, ADDR
FROM (SELECT ROWNUM RNUM, ID, NAME, GENDER, BIRTH, ADDR
  FROM STUDENT JOIN USERCOURSE
  USING(ID) WHERE COURSECODE = 'C00001');
WHERE RNUM BETWEEN 리스트시작번호 AND 리스트끝번호

-- 자기 과정에 포함된 과목 조회
SELECT SUBJECTCODE, SUBJECTNAME, SUBJECTTYPE, EXAMTYPE
  FROM SUBJECT S JOIN COURSE_SUBJECT C
  USING (SUBJECTCODE) WHERE COURSECODE = 'C00001';
 
-- 전체 과목 조회	
SELECT SUBJECT.SUBJECTNAME, SUBJECT.SUBJECTTYPE, EXAMCATEGORY.EXAMTYPE
FROM SUBJECT JOIN EXAMCATEGORY USING (TYPECODE);

-- 과목 등록
INSERT INTO SUBJECT(SUBJECTCODE, SUBJECTNAME, SUBJECTTYPE,  EXAMTYPE)
VALUES
((SELECT 'S'|| LPAD((TO_NUMBER(SUBSTR(MAX(SUBJECTCODE),2))+1),5,0)  FROM SUBJECT),
'화면 설계', 'HTML', '서술형');
INSERT INTO SUBJECT(SUBJECTCODE, SUBJECTNAME, SUBJECTTYPE,  EXAMTYPE)
VALUES
('S00001','화면 설계', 'HTML', '서술형');
INSERT INTO SUBJECT(SUBJECTCODE, SUBJECTNAME, SUBJECTTYPE,  EXAMTYPE)
VALUES
((SELECT 'S'|| LPAD((TO_NUMBER(SUBSTR(MAX(SUBJECTCODE),2))+1),5,0)  FROM SUBJECT),
'화면 설계', 'HTML', '서술형');

-- 과정에 과목 추가
INSERT INTO COURSE_SUBJECT (SEQ, COURSECODE, SUBJECTCODE, TYPECODE, CONTENT, SUBJECTTIME)
 VALUES(COURSE_SUBJECT_SEQ.NEXTVAL, '','','','','');
 
-- 과정에 과목을 추가할때 과목시간의 합 조회
SELECT SUM(SUBJECTTIME) FROM COURSE_SUBJECT
WHERE COURSECODE='C00001'
GROUP BY COURSECODE

-- 로그인
SELECT ID, NAME, PW 
 FROM ADMIN WHERE ID='' AND PW='';
 
-- 학생 회원가입 승인
UPDATE STUDENT SET S_CHECK = 'Y' WHERE ID IN ('01011111111');

-- 학생 회원가입 거절
DELETE FROM STUDENT WHERE ID IN ('01011111111');

-- 가입 대기신청자 조회
SELECT ID, NAME, PW, GENDER, BIRTH, ADDR
FROM (SELECT ROWNUM RNUM, ID, NAME, PW, GENDER, BIRTH, ADDR, DELFLAG, S_CHECK FROM STUDENT)
WHERE RNUM BETWEEN 리스트시작번호 AND 리스트끝번호 AND  S_CHECK='N'

-- 자료게시판 신고글 조회
SELECT SEQ, TITLE, ID, REGDATE, READCOUNT
FROM (SELECT ROWNUM RNUM ,SEQ, TITLE, ID, REGDATE, READCOUNT
FROM FILE_BOARD) 
ORDER BY SEQ DESC)
WHERE RNUM BETWEEN 리스트시작번호 AND 리스트끝번호 AND REPORT='Y'

-- 자료게시판 신고글 상세조회
SELECT TITLE, CONTENT, ID, REGDATE, READCOUNT, REPORT, FILENAME, NEWFILENAME
  FROM FILE_BOARD WHERE SEQ='';

-- 회원정보 조회 (학생)
SELECT ID, NAME, PW, GENDER, BIRTH, ADDR, DELFLAG
FROM (SELECT ROWNUM RNUM, ID, NAME, PW, GENDER, BIRTH, ADDR, DELFLAG, S_CHECK FROM STUDENT) 
WHERE RNUM BETWEEN 리스트시작번호 AND 리스트 끝 번호 AND S_CHECK = 'Y' AND DELFLAG='N'

-- 회원정보 조회 (강사)
SELECT ID, NAME, PW, COURSECODE
FROM (SELECT ROWNUM RNUM, ID, NAME, PW, COURSECODE FROM TEACHER)
WHERE RNUM BETWEEN 리스트시작번호 AND 리스트 끝 번호

-- 회원정보 상세 조회(학생, 일반 정보 조회)
SELECT ID, NAME, PW, GENDER, BIRTH, ADDR, DELFLAG
FROM STUDENT

-- 회원정보 상세 조회(학생, 수강중인 과정 조회)
SELECT COURSENAME, STARTDATE, ID, TIME, COURSECNT
FROM USERCOURSE U JOIN COURSE C
USING (COURSECODE) WHERE COURSECODE = SELECT COURSECODE FROM USERCOURSE WHERE ID=''

-- 학생에 과정 추가
INSERT INTO USERCOURSE(ID, COURSECODE, REGDATE)
VALUES('','',SYSDATE);

-- 학생에 과정 삭제
DELETE FROM USERCOURSE WHERE ID='' AND COURSECODE='';

-- 회원정보 수정(학생)
UPDATE STUDENT SET ID ='', NAME='', PW='',GENDER='', BIRTH='',ADDR=''
WHERE ID='';

-- 탈퇴 시키기(학생)
UPDATE STUDENT SET DELFLAG ='N' WHERE ID IN(,);

-- 회원정보 수정(강사)
UPDATE TEACHER ID='' PW='' NAME='' COURSCODE=''

-- 강사 등록
INSERT INTO TEACHER(ID, NAME,PW,COURSECODE)
VALUES('01087654321','민균전','1111','C201900002');

-- 과정테이블(COURSE)	
-- (관리자)과정 등록(ID는 강사ID를 말함)
INSERT INTO COURSE(COURSECODE, COURSENAME, STARTDATE,  COURSECNT)
VALUES
((SELECT 'C'|| LPAD((TO_NUMBER(SUBSTR(MAX(COURSECODE),2))+1),5,0)  FROM COURSE),
'송희 기반 PYTHON IT 양성과정', '2019-06-12', '1');
INSERT INTO COURSE(COURSECODE, COURSENAME, STARTDATE,  COURSECNT)
VALUES
('C201900002',
'송희 기반 PYTHON IT 양성과정', '2019-06-12', '1');

-- (관리자)학생과정 수정 (과정명, 시작날짜, 강사, 회차 변경)
UPDATE COURSE
SET COURSENAME='JAVA기반 IT콘텐츠 개발자 양성과정 짱', STARTDATE = '2019-06-12', COURSECNT = 2
WHERE COURSECODE = 'C00004'

-- (관리자)전체과정조회
SELECT COURSECODE, COURSENAME, STARTDATE, NAME
FROM COURSE JOIN TEACHER
USING(COURSECODE)
ORDER BY STARTDATE;

-- 과정 중복 조회
SELECT COURSENAME
FROM COURSE
WHERE COURSENAME = '' AND COURSECNT='';

-- 과제테이블(TESTESSAYQ, TESTSELECT) 	
-- 과제 추가
INSERT INTO TEST(TESTCODE, TESTNAME, TESTTYPE, EXAMTYPE)
VALUES(((SELECT 'T'|| LPAD((TO_NUMBER(SUBSTR(MAX(TESTCODE),2))+1),5,0)  FROM TEST), '화면구현', 'JAVA','서술형');

-- 과목유형이 동일한 과제 조회
SELECT TESTCODE,TESTNAME
FROM TEST
WHERE TESTTYPE = 'JAVA' AND EXMANTYPE = '서술형'

-- 과목-과제테이블(SUBJECT_EXAM)	
-- 과목에 과제등록(연결)
INSERT INTO SUBJECT_EXAM
(SUBJECTCODE, TESTCODE, TESTDAY)
VALUES('', '', '')

-- 과목의 과목유형과 과제유형이 동일한 과제 조회
SELECT TESTCODE, TESTNAME
FROM SUBJECT_EXAM JOIN TEST USING(TESTCODE)
WHERE SUBJECTTYPE='' AND EXAMTYPE='';

-- 과목에 해당하는 과제 조회
SELECT TESTCODE,TESTNAME, TESTDAY
FROM SUBJECT_EXAM JOIN TEST USING (TESTCODE)
WHERE SUBJECTCODE = 'S00001'

-- 문제 추가(EXAMDESCRIPTIVE, EXAMSELECT)	
--문제 등록(서술형)
INSERT INTO EXAMDESCRIPTIVE(EXAM, EXAMCODE, EXPLANATION, STANDARD, C_ANSWER)
VALUES( 'A+B는 무엇일까요', 'E00001', '연산문제', '답과 설명 모두작성 3점, 답만 작성 1점', 'A+B는 3입니다');

-- 문제 등록(선택형)
INSERT INTO EXAMSELECT(EXAM, EXAMCODE, C_ANSWER)
VALUES( 'A+B는 무엇일까요', 'E00002', 2);

-- 과제-문제테이블(TEST_EXAM)	
-- 과제에 문제등록(연결)
INSERT INTO TEST_EXAM(TESTCODE, EXAMCODE, ALLOT, EXAMNUM)
VALUES('T00001', 'E00001', 3, 1)

-- 수정(다이나믹쿼리)
UPDATE TEST_EXAM SET ALLOT=30, EXAMNUM=2
WHERE EXAMCODE = 'E00001'

-- 문제 총점 조회
SELECT SUM(ALLOT) FROM TEST_EXAM
WHERE TESTCODE='T00001'
GROUP BY EXAMCODE

-- 과제에 해당하는 문제 조회(서술형)
SELECT  EXAMNUM, EXAM, EXPLANATION, STANDARD,  ALLOT
FROM TEST_EXAM JOIN EXAMDESCRIPTIVE USING (EXAMCODE)
WHERE EXAMCODE='E00001'
ORDER BY EXAMNUM

-- 과제에 해당하는 문제 조회(선택형)
SELECT EXAMNUM, EXAM, ALLOT
FROM TEST_EXAM JOIN EXAM USING(EXAMCODE)
WHERE EXAMCODE = ''
ORDER BY EXAMNUM

-- 선택형 문항테이블(CONTENTSELECT)
-- 문항 등록
INSERT INTO CONTENTSELECT(EXAMCODE, EXAMNUM, EXAMCONTENT)
VALUES('E00001', 2, 'a+b는 2다')

-- 문항 수정
UPDATE CONTENTSELECT 
SET EXAMCONTENT='a*B는 2다'
WHERE EXAMCODE = 'E00001' AND EXAMNUM=3

-- 문제의 문항 조회
SELECT CONTENTNUM, EXAMCONTENT
FROM CONTENTSELECT 
WHERE EXAMCODE = 'E00001'
ORDER BY CONTENTNUM

-- 학생 서술형답 테이블(ANSWERDESCRIPTIVE)	
-- 등록
INSERT INTO ANSWERDESCRIPTIVE(ID, EXAMCODE, EXAMNUM, ANSWER, ORIGINFILE, NEWFILENAME)
VALUES('01094096075', 'E00001', 3, 'A+B는 A=2이고, B=3이기 때문에 5이다.', '', '');

-- 수정(답변경, 파일변경)
UPDATE ANSWERDESCRIPTIVE
SET ANSWER = 'A+B는 5이다', ORIGINFILE = '', NEWFILEANME= ''
WHERE ID = '01094096075' AND EXAMCODE ='E00001' AND EXAMNUM = 2

-- (강사)조회
SELECT  EXAMNUM, ANSWER, ORIGINFILE, NEWFILENAME
FROM ANSWERDESCRIPTIVE
WHERE ID = '01094096075' AND EXAMCODE = 'E00001'
ORDER BY EXAMNUM

-- 학생 선택형답 테이블(ANSWERSELECT)	
-- 등록
INSERT INTO ANSWERSELECT(ID, EXAMCODE, EXAMNUM, ANSWER)
VALUES ('01094096075', 'E00002', 3, 2)

-- 수정
UPDATE ANSWERSELECT
SET ANSWER = 4
WHERE ID='01094096075' AND EXAMCODE = 'E00002' AND EXAMNUM = 3

-- 조회
SELECT EXAMNUM, ANSWER
FROM ANSWERSELECT 
WHERE ID= '01094096075' AND EXAMCODE = 'E00002'
ORDER BY EXAMNUM ;

-- 선택형 문제 자동채점 	
-- 판단
-- 선택형 문제테이블의 답과 선택형 답테이블의 답이 같으면 배점을 출력
-- 배점을 성적 테이블에 저장
SELECT  1
FROM ANSWERSELECT JOIN EXAMSELECT USING (EXAMCODE)
WHERE ID= '01094096075' AND EXAMCODE = 'E00004' AND EXAMNUM = 3 AND C_ANSWER=ANSWER

-- 성적 테이블	
-- 등록_학생점수채점(서술형)
INSERT INTO SCORE
(ID, EXAMCHECK, TESTCODE, EXAMCODE, SCORE)
VALUES('01011111111', 'N', 'T00001', 'E00001', 0);

-- 등록-자동채점(선택형)
INSERT INTO SCORE
(ID, EXAMCHECK, TESTCODE, EXAMCODE, SCORE)
VALUES('01011111111', 'N', 'T00001', 'E00001', (SELECT  ALLOT
FROM ANSWERSELECT JOIN EXAMSELECT ON ANSWERSELECT.EXAMCODE=EXAMSELECT.EXAMCODE
JOIN TEST_EXAM ON EXAMSELECT.EXAMCODE=TEST_EXAM.EXAMCODE
WHERE ID= '01094096075' AND EXAMSELECT.EXAMCODE = 'E00004' AND TEST_EXAM.EXAMNUM = 3 AND C_ANSWER=ANSWER);

-- 수정
UPDATE SCORE
SET EXAMCHECK='Y', SCORE=30
WHERE ID='01011111111'
AND TESTCODE = 'T00001'
AND EXAMCODE = 'E00001';

-- 조회
SELECT ID,NAME ,SCORE
FROM SCORE JOIN STUDENT USING (ID)
WHERE ID = '01011111111'
AND TESTCODE = 'T00001'
AND EXAMCODE = 'E00001';

-- 총점 조회
SELECT SUM(SCORE), NAME,STUDENT.ID
FROM SCORE,STUDENT
WHERE SCORE.ID=STUDENT.ID
AND SCORE.ID = '01011111111'
GROUP BY EXAMCODE;

-- 결석 신청	
-- 자신의 신청내역 리스트 상태별로 조회(학생)
SELECT FORM_SEQ, APP_DATE, COURSECODE, COURSENAME, STM, START_DATE 결석시작일, RECIPIENT_ID
	FROM APP_FORM JOIN IS_APPROVE
		USING(FORM_SEQ)
			JOIN COURSE
			USING(COURSECODE)
		WHERE STUDENT_ID = '01011111111' AND IS_APPROVE.STM = 'N'
		ORDER BY FORM_SEQ DESC;

-- 클릭해서 각 신청을 상세조회(승인, 처리중)
SELECT APP_DATE, COURSENAME, REASON, START_DATE, ABSENT_DAYS, FILENAME, NEWFILENAME, STM, NAME
FROM APP_FORM A 
JOIN IS_APPROVE I USING(FORM_SEQ)
JOIN COURSE USING(COURSECODE)
JOIN STUDENT ON STUDENT.ID = A.STUDENT_ID
WHERE FORM_SEQ = '3';

-- 승인인 신청의 경우 사인 이미지 조회
SELECT SIGNATURE.NEWFILENAME
FROM SIGNATURE
JOIN APP_FORM ON APP_FORM.RECIPIENT_ID = SIGNATURE.SIGNATURE_ID
JOIN IS_APPROVE ON IS_APPROVE.FORM_SEQ = APP_FORM.FORM_SEQ
WHERE SIGNATURE.SIGNATURE_ID = '01012345678' AND APP_FORM.FORM_SEQ = '3' AND IS_APPROVE.STM = 'Y';

-- 클릭해서 각 신청을 상세조회(반려시)
SELECT A.FORM_SEQ, APP_DATE, A.REASON, START_DATE, ABSENT_DAYS, FILENAME, NEWFILENAME, STM, U.REASON AS UNAPPROVED_REASON, RECIPIENT_ID, COURSENAME
FROM APP_FORM A JOIN IS_APPROVE I ON A.FORM_SEQ = I.FORM_SEQ
				JOIN UNAPPROVED U ON I.FORM_SEQ = U.FORM_SEQ
				JOIN COURSE C ON A.COURSECODE = C.COURSECODE
WHERE A.FORM_SEQ = '2';

-- 강사, 관리자가 자신의 과정의 학생들것만의 내역서 리스트 보기
SELECT A.APP_DATE,
	   I.STM,
	   S.NAME,
	   A.FORM_SEQ,
	   (SELECT COURSENAME
		FROM COURSE
		WHERE COURSECODE = A.COURSECODE) AS COURSENAME
FROM APP_FORM A JOIN IS_APPROVE I ON A.FORM_SEQ = I.FORM_SEQ
			    JOIN STUDENT S ON A.STUDENT_ID = S.ID
WHERE A.RECIPIENT_ID = '01012345678' AND I.STM = 'N'
ORDER BY A.FORM_SEQ DESC;

-- 클릭해서 각 신청을 상세조회(승인, 처리중)
SELECT APP_DATE, A.REASON, START_DATE, ABSENT_DAYS, FILENAME, NEWFILENAME, STM
FROM APP_FORM A JOIN IS_APPROVE I ON A.FORM_SEQ = I.FORM_SEQ
WHERE A.FORM_SEQ = '3';

-- 승인인 경우 수신인의 사인 이미지를 가져옴
SELECT SIGNATURE.NEWFILENAME
FROM SIGNATURE
JOIN APP_FORM ON APP_FORM.RECIPIENT_ID = SIGNATURE.SIGNATURE_ID
JOIN IS_APPROVE ON IS_APPROVE.FORM_SEQ = APP_FORM.FORM_SEQ
WHERE SIGNATURE.SIGNATURE_ID = '01012345678' AND APP_FORM.FORM_SEQ = '3' AND IS_APPROVE.STM = 'Y';

-- 클릭해서 각 신청을 상세조회(반려시)
SELECT A.FORM_SEQ, APP_DATE, A.REASON, START_DATE, ABSENT_DAYS, FILENAME, NEWFILENAME, STM, U.REASON AS UNAPPROVE_REASON
FROM APP_FORM A JOIN IS_APPROVE I ON A.FORM_SEQ = I.FORM_SEQ
				JOIN UNAPPROVED U ON I.FORM_SEQ = U.FORM_SEQ
WHERE A.FORM_SEQ = '2';

-- 결석 신청하려는 과정을 선택
SELECT USERCOURSE.ID, COURSENAME, COURSECODE, STARTDATE
	FROM USERCOURSE JOIN COURSE USING(COURSECODE)
		WHERE USERCOURSE.ID = '01011111111'
			ORDER BY COURSENAME;

--INSERT INTO USERCOURSE
--(ID, COURSECODE, REGDATE)
--VALUES('01011111111', 'C201900001', SYSDATE);


-- 관리자를 선택
SELECT ID, NAME
FROM ADMIN;

-- 학생이 결석 신청을 함
INSERT INTO APP_FORM
			(FORM_SEQ, APP_DATE, STUDENT_ID, RECIPIENT_ID , --관리자ID
			COURSECODE, REASON, START_DATE, ABSENT_DAYS, FILENAME, NEWFILENAME) --과정ID
		VALUES
			(APP_FORM_SEQ.NEXTVAL, SYSDATE, '01011111111', '01012345678', 
		   'C201900001', '감기로 출석이 어려움', '2019-05-03', 3, '진단서.JPG', '01011111111_첨부.JPG');
		   
-- 신청 상태 테이블 연결
INSERT INTO IS_APPROVE(FORM_SEQ, STM)
VALUES((SELECT MAX(FORM_SEQ) FROM APP_FORM WHERE STUDENT_ID='01011111111'), 'N');

-- 강사 및 관리자가 미승인 사유를 작성
INSERT INTO UNAPPROVED
VALUES(2, '싫음');

-- 동시에 승인 여부 수정
UPDATE IS_APPROVE
SET STM = 'R'
WHERE FORM_SEQ = 2;

-- 강사 및 관리자가 승인을 함
UPDATE IS_APPROVE
SET STM = 'Y'
WHERE FORM_SEQ = '3';

-- 강사가 사인 이미지 등록
INSERT INTO SIGNATURE
VALUES('01012345678', 'Y', '사인.jpg', '01012345678_signature.jpg');


-- 출결 관리
-- 학생 본인의 과정 조회
SELECT COURSENAME
FROM USERCOURSE JOIN COURSE USING(COURSECODE)
WHERE ID = '01011111111';

-- 해당 과정의 출석 정보 조회
SELECT A_CHECK
FROM USERCOURSE JOIN ATTENDEDCHECK USING (ID)
WHERE ID = '01011111111';

-- 강사의 진행 과정 조회
SELECT COURSENAME
FROM COURSE JOIN TEACHER USING(COURSECODE)
WHERE TEACHER.ID='01012345678';

-- 해당 과정의 월 출결 조회
SELECT STUDENT.ID, NAME, ATTENDEDCHECK.REGDATE, A_CHECK, SEQ
 FROM USERCOURSE JOIN STUDENT ON USERCOURSE.ID=STUDENT.ID JOIN ATTENDEDCHECK ON STUDENT.ID=ATTENDEDCHECK.ID
  WHERE COURSECODE ='C00001' AND TO_CHAR(ATTENDEDCHECK.REGDATE,'YYYYMM') = '201905'
 ORDER BY NAME;
 
-- 캘린더 내의 날짜의 출석부 조회(일 출결)
SELECT STUDENT.ID, NAME, ATTENDEDCHECK.REGDATE, A_CHECK, SEQ
FROM USERCOURSE JOIN STUDENT ON USERCOURSE.ID=STUDENT.ID JOIN ATTENDEDCHECK ON STUDENT.ID=ATTENDEDCHECK.ID
WHERE COURSECODE ='C00001' AND TO_CHAR(ATTENDEDCHECK.REGDATE,'YYYYMMDD') = '20190508'
ORDER BY NAME;

-- 해당과정 학생들 출석리스트 상세보기
SELECT ID,NAME,GENDER,BIRTH,REGDATE,A_CHECK
FROM STUDENT JOIN ATTENDEDCHECK USING(ID)
WHERE ID = '01011111111';

-- 학생의 월별 출결 현황 조회
SELECT STUDENT.ID, NAME, ATTENDEDCHECK.REGDATE, A_CHECK, SEQ
 FROM USERCOURSE JOIN STUDENT ON USERCOURSE.ID=STUDENT.ID JOIN ATTENDEDCHECK ON STUDENT.ID=ATTENDEDCHECK.ID
  WHERE COURSECODE ='C00001' AND TO_CHAR(ATTENDEDCHECK.REGDATE,'YYYYMM') = '201905' AND STUDENT.ID ='01011111111'
 ORDER BY NAME;
 
-- 결석 조건에 충족한 학생 문자 발송
SELECT ID
FROM ATTENDEDCHECK
WHERE REGDATE IS NULL;

-- 
INSERT INTO ATTENDEDCHECK(SEQ, ID, REGDATE)
VALUES(ATTENDEDCHECK_SEQ.NEXTVAL, '01011111111', SYSDATE);
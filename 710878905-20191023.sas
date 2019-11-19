libname dir "C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��";
/*Chapter 3, page 17*/
proc print data=dir.tennis (obs=10);
run;

proc freq data=dir.tennis;
table x3-x12;
where x5 ne 9 and x8 ne 9;
run;

proc freq data=dir.tennis;
table x5 x8 x5*x8;
where x5=9 or x8=9;
run;

ods pdf file="D:\test.pdf";
ods pdf close;

proc freq data=dir.tennis order=freq page;
table x3-x5;
where x5 ne 9 and x8 ne 9;
/*ods select OneWayFreqs;*/
run;

ods trace on;
ods trace off;

proc print data=dir.tennis (obs=10);
var x3 x7;
run;

proc freq data=dir.tennis;
tables x3*x7;
run;
/*�Ƨ�*/
proc sort data=dir.tennis;
by x3;
run;
proc freq data=dir.tennis;
table x7;
by x3;
run;
proc print data=dir.tennis;
var x3;
proc freq data=dir.tennis;
table x3;
run;
/*Nn\bar ---> p*/
/* ASE=a.....standard error: X bar�����i�зǮt */
/* �����X�{�����: 0.5455�Ap��CI = (0.4474, 0.6435) */
/* ��ǫH��϶� : �˥��Ƥj���ɭԨϥ� */
/* H0�˩w, �b���0.5�����p�U�AASE�|�O0.0503 */
/*�Y���D��H0:���=0.5�o��Ʊ��O���u��A Z�έp�q(�`�A���t)���Ʀr�O�_�X�z? �O���O�b�j������Ƴ��|�X�{�������� */
proc freq data=dir.tennis;
table x3/binomial;
run;
/*�վ�alpha��*/
proc freq data=dir.tennis;
table x3/binomial alpha=0.025;
run;

proc freq data=dir.tennis;
table x3/binomial (ac exact wilson);
run;
/*�]�wp=0.3�A�u�|�bHo�˩w���䦳����*/
proc freq data=dir.tennis;
table x3/binomial (p=0.3);
run;
/*�]�wp=0.5*/
/*Ho: p-0.5 <= (-0.2) or p-0.5>=0.2*/
/*Ha: -0.2 < p-0.5 < 0.2*/
/*�ݾ��骺P��*/
proc freq data=dir.tennis;
table x3/binomial (equiv p=0.5);
run;
/*�վ�W�U���*/
proc freq data=dir.tennis;
table x3/binomial (equiv p=0.5 margin=0.05);
run;
/*�e��*/
proc freq data=dir.tennis;
table x3/plots=freqplot(type=dot scale=percent);
run;
ods trace on;
ods trace off;
/*output....��SE���|�Ω�! �ڳ����I��!!!*/
proc freq data=dir.tennis;
table x3/binomial (ac exact wilson);
ods select BinomialCLs;
/*ods output BinomialCLs = temp*/;
run;
ods rtf file="D:\templ.doc";
ods rtf close;
proc export data=temp outfile="D:\ex1.xls"
dbms=excel label replace;
sheet="xls";
run;

proc export data=temp outfile="D:\ex3.csv"
dbms=csv label replace;
sheet="csv";
run;

proc export data=temp outfile="D:\ex4.txt"
dbms=dlm label replace;
delimiter="&";
run;

proc freq data=dir.tennis;
table x9 / nocum;
run;

proc freq data=dir.tennis;
table x9;
table x9 / nocum;
run;

proc freq data=dir.tennis;
table x9;
table x9 /testp=(70 20 10);
run;

proc freq data=dir.tennis;
table x9;
table x9 /testp=(70 20 10) plots=deviationplot(type=dot);
run;

proc freq data=dir.tennis;
table x9 / out=x9oa outcum;
run;
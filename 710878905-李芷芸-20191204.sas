%let indir=C:\Users\ASUS\Desktop\NTPU\108-1-���O��Ƥ��R;

proc import datafile="&indir\statpack104fch4d3.xls"
out=qn dbms=excel replace;
getnames=yes;
run;

proc print data=qn (obs=5);
run;

proc contents data=qn;
ods select Variables;
run;

proc freq data=qn;
tables q:;
run;

data qn1;
set qn;
mc=cmiss(of q:);/*�P�_�򥢭�*/
if mc<1;
drop mc;
run;
proc print data=qn1;
run;
proc freq data=qn1;
tables q:;
run;
proc print data=qn;
where id=.;
run;
proc print data=qn;
where q1="";
run;

data qn2;
set qn1;
if q1="A" then qa1=1;
else if q1="B" then qa1=2;
else if q1="C" then qa1=3;
run;
proc print data=qn2;
run;

proc print data=qn2(obs=5);
run;

data ds;
array xv{3} x1-x3; /*�إߤ@�Ӱ}�C�ܼ�x1-x3*/
array yv{3} y1-y13 (2,8,6); /*�إߦC����3���A�ƭȬ�2,8,6*/
array zv{3} $ z1-z3 ("a" "b" "c"); /*�إߦr��a,b,c*/
run;
proc print data=ds;
run;
proc contents data=ds;
ods select Variables;
run;

data qn3;
set qn2;
array qv q28-q37; /*�]�w�V�q*/
array qav qa28-qa37; /*�]�w�V�q*/
do i=1 to 10; /*�Q�ΦV�q�����ܼ�*/
if qv(i)="A" then qav(i)=5;
else if qv(i)="B" then qav(i)=4;
else if qv(i)="C" then qav(i)=3;
else if qv(i)="D" then qav(i)=2;
else if qv(i)="E" then qav(i)=1;
end; /*�N�ݶ����ܬ�����*/
score=sum(of qa:);
keep id q1-q3 qa: score;
run;
proc print data=qn3;
run;
proc freq data=qn3;
tables score;
run;

/*�d��statpack104fch4d4*/
%let indir=C:\Users\NTPU\Downloads;
proc import datafile="&indir\statpack104fch4d4.xls"
out=hqn dbms=excel replace;
getnames=yes;
run;
proc print data=hqn;
run;

data hqn1;
set hqn (drop=F:); /*�Nhqn���Y F�}�Y����� �q�q���*/
rename _col0=id _col1-_col9=q1-q9;
run;
proc print data=hqn1;
run;
proc freq data=hqn1;
tables _character_;
run;


/*�d��statpack104fch4d5*/
/*���qCH5 p.36*/
libname dir "&indir";
proc print data=dir.statpack104fch4d5;
run;
proc contents data=dir.statpack104fch4d5;/*�o�{�o����ƫܦh���Τ�r�覡�O���A�ݭn�ഫ�~�����B�z*/
ods select Variables;
run;
proc freq data=dir.statpack104fch4d5;
table dmtype;
run;
data oper;
set dir.statpack104fch4d5;
dm1=substr(dmtype,1,2);/*�N�ܼƤ��S�w��l�r���X�s��t�@���ܼ� �q2�����2��*/
/*dm2=substr(dmtype,3,2);*/
/*dm3=scan(dmtype,1);/*�۰ʧ���1�ӪŮ�N����*/
dm3=scan(dmtype,1,"YR");/*�۰ʧ���1��YR�N����*/
dm4=compress(dm3);/*�����Ů�������b�@�_*/
dm5=substr(dm4,3);/*�z��X�Ʀr�A�����ɬ��r��榡*/
dmy=input(dm5,8.);/*�אּ�Ʀr�榡�A���׬�8.*/
run;
/*proc freq data=oper;*/
/*table dm2;*/
/*run;*/
proc print data=oper;
var dmtype dm3 dm4 dm5 dmy;
run;

data oper;
set dir.statpack104fch4d5;
dm1=index(dmtype,"YR");/*�M��yr�X�{���r���m*/
dm2=input(substr(dmtype,3,dm1-3),8.);/*�����z�L�ܼ�dm1�ۤv�h��C��������ӭn�����@�Ӧ��*/
run;
proc print data=oper;
var dmtype dm1 dm2;
run;


/*�d��statpack104fch4d6*/
proc import datafile="&indir\statpack104fch4d6.xls"
out=ds6 dbms=excel replace;
getnames=yes;
run;
data ds6;
set ds6;
rename _col0-_col6=v1-v7;
run;
proc freq data=ds6;
table v2;
run;
proc print data=ds6;
where v2="�Ǥh�Z"; /*��v2�̪��Ǥh�Z���ȩԥX��*/
run;

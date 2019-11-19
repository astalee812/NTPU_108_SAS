
proc import datafile="C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��\statpack104fch2d2.xlsx"out=car
   dbms=xlsx replace;
sheet="d3";
getnames=yes;
run;
data car;
set car;
label make="����"   cylinders="�T��"
		model="����"  horsepower="���O"
		type="����"     mpg_city="�@��D�����o��"
        origin="�Ͳ��ϰ�" mpg_highway="�ֳt�D�����o��"
        drivetrain="�ʤO�ǰʨt��" weight="���q"
        msrp="�s�����" wheelbase="����"
        invoice="��X����"  length="����" enginesize="����";
format invoice dollar12.;
run;

proc print data=car (obs=10) label;
var model type origin invoice mpg_city;
run;
/* 2x2�C�s�� */
/* P(X=x,Y=y) = P(X=x) x P(Y=y) but �o��Ʊ��o�ͪ��p�ܤp */
proc freq data=car;
table Origin*drivetrain;
run;

proc tabulate data=car;
class DriveTrain Origin;  /*���s*/
tables Origin, DriveTrain;
run;

proc tabulate data=car;
class DriveTrain Origin;
var msrp; /*���ܼƥX��*/
tables Origin, DriveTrain*msrp;
run;

proc tabulate data=car;
class DriveTrain Origin;
var msrp;
tables Origin, DriveTrain*msrp*(n mean); /*�W�[�ӼƥH�Υ����A�]�i�H��sum*/
run;
proc tabulate data=car;
class DriveTrain Origin;
var msrp;
tables Origin, DriveTrain*msrp*(n='�ƶq' mean='�����ƶq');
run;
/*�|�]�X�@�ӥ���*/
proc tabulate data=car;
class DriveTrain Origin;
var msrp;
tables Origin, DriveTrain*msrp*(n='�ƶq' mean='�����ƶq')
all=""*msrp=""*(n mean); /*�W�[�ӼƥH�Υ����A�]�i�H��sum*/
run;

proc tabulate data=car;
class DriveTrain Origin;
var msrp;
tables Origin, DriveTrain*msrp*(n='�ƶq' mean='�����ƶq'*f=dollar10.2)
all=""*msrp=""*(n mean*f=dollar10.2); /*�W�[�ӼƥH�Υ����A�]�i�H��sum*/
run;

proc tabulate data=car;
class DriveTrain Origin type;
var msrp;
tables Origin*type, DriveTrain*msrp*(n mean);
run;

proc tabulate data=car;
class DriveTrain Origin type;
var msrp;
tables type*(Origin all), DriveTrain*msrp*(n mean);
run;

proc tabulate data=car;
class DriveTrain Origin type;
var msrp;
tables type*(Origin all)all, DriveTrain*msrp*(n mean);
run;
/*ch3, p17*/
/*SAS���ؿ����U�غc����ɪ��qdir����m*/
libname dir "C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��";
/*dir. ²�g�i�H��������Ӹ�Ƨ������*/
proc print data=dir.tennis;
run;
proc contents data=dir.tennis; run;
/*�g��PDF��*/  /*��s�@�UODS�����O ods trace on; ods trace off*/
ods pdf file="C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��\test.pdf";
ods pdf close;
proc freq data=dir.tennis order=freq page;
table x3-x5;
where x5 ne 9 and x8 ne 9;
run;
ods trace on;
ods trace off;

proc print data=dir.tennis(obs=10);
var x3 x7;
run;
proc freq data=dir.tennis;
tables x3*x7;
run;

proc freq data=dir.tennis;
table x7;
by x3;
run;
/*�Ƨ�!!*/
proc sort data=dir.tennis;
by x3;
run;


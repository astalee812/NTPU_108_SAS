/*1*/
data ch4d10;
infile "C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��\statpack104fch4d10.dat";
input name $1-20 id $22-32 account $34-45 balance 47-52 date ;
run;
proc print data=ch4d10;
run;

data ch4d10a;
set ch4d10;
id1 = input(id,comma11.);
balance1 = put(balance,dollar.);
date1 = put(date,mmddyy10.);
run;
proc print data = ch4d10a;
run;


 %let indir=C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��\;
/*2*/
/*--2-1--*/
proc import datafile="&indir\statpack103fhw5.xls"
out=b
dbms=excel replace;
getnames=yes;
run;
proc print data= b;
run;

data b(rename=(F1 = id 
		F2 = sex 
		F3 = heart 
		F4 = uniform 
         F5 = class 
		F6 = weight 
		F7 = height 
		F8 = age));
set b;
run;
data b1;
set b;
/*2-2*/
if sex = "F" then sex = 0;
else sex = 1;
/*2-3*/
BMI = weight / ((height / 100) * (height / 100));
/*2-4*/
if BMI < 18.5 then BMI_flag = 1;
else if BMI < 24 then BMI_flag = 2;
else BMI_flag = 3;
/*2-5*/
if 65 <= heart <= 100 then heart_flag = 1;
else if heart_flag = 2;
run;
proc print data = b1;
run;

/*2-6*/
proc format;
value sex 0 = "Female" 1="Male";
value uniform 1="�P�N" 2="���P�N" ;
value class 1="�P�N" 2="���P�N" ;
label id="�s��" heart="�߸���" uniform="�O�_�P�N��ۨ�A"
   class="�O�_�P�N����O���Z" weight="�魫" 
   height="����" age="�~��";
run;

/*2-7*/
proc means n sum mean median max min std data = b1;
var heart uniform class weight height age BMI BMI_flag heart_flag;
run; 

/*2-8*/
proc univariate data = b1 plot normal;
     var heart;
run;

/*3*/
/*--3-1--*/
data c;
infile "&indir\hw1211 fish.txt";
input Variety weight 3-8 height1 10-13 height2 15-18 height3 20-23
   width 25-29 thickness 32-35 ;
run;
proc print data = c;
run;

proc format;
value Variety 1="Bream" 2="Whitewish" 3="Roach" 4="Parkki"
      5="Smelt" 6="Pike" 7="Perch";

label Variety = "�~��" weight = "���q" height1 = "���1(���Y�ܳ������}��)"
   height2 = "���2(���Y�ܳ����W�f�B)" height3 = "���3(���Y�ܳ���������)" 
   width = "��e(%)" thickness = "��p(%)";
run;

data c1;
set c;
/*3-2*/
real_width = width * height3 / 100;
/*3-3*/
weight_hat = 2.1659 + 0.1038 * height3;
/*3-4*/
array sss{3} height1 height2 height3;
array aaa{3} height1a height2a height3a;
do i = 1 to 3;
aaa{i} = sss{i} / 100;
end;
/*3-5*/
if Variety in ('3','4','5') then Variety_flag = "�p����";
else if Variety in ('1','7') then Variety_flag = "������";
else Variety_flag = "�j����";
/*3-6*/
if width < 8 then width_flag = "�髬�A��";
else width_flag = "�髬�e";
run;

/*3-7 ���*/
proc tabulate data = c1;
label height1 = "���1"  height2 = "���2" height3 = "���3";
class Variety_flag;
var height1 height2 height3;
tables (height1 height2 height3), Variety_flag * (mean std);
run;

/*3-8 ���*/
proc tabulate data=c1;
label height1 = "���1" height2 = "���2" height3 = "���3";
class width_flag;
var height1 height2 height3;
tables  (height1 height2 height3), width_flag * (mean std) all * (PRT);  /*P�� = PRT*/
run;
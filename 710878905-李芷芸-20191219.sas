%let indir=C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體;

data ds1;
input var $ @@;
n=_n_;
cards;
A B A A B E C D E E
run;
data ds2;
input var $ @@;
n=_n_;
cards;
A X X Z Y E Y X Y E
run;
data ds3;
set ds2;
rename var=newvar;
run;
data ds4;
set ds2;
rename n=newn;
run;
data ds5;
set ds2;
rename var=newvar n=newn;
run;
proc print data=ds1;
run;
proc print data=ds2;
run;
proc print data=ds3;
run;
proc print data=ds4;
run;
proc print data=ds5;
run;

data set12_row;
set ds1 ds2;
run;
proc print data=set12_row;
run;

data set13_row;
set ds1 ds3;
run;
proc print data=set13_row;
run;

data set14_row;
set ds1 ds4;
run;
proc print data=set14_row;
run;

data set15_row;
set ds1 ds5;
run;
proc print data=set15_row;
run;

proc sort data=ds1 out=ds1sort;
by var n;
run;
proc print data=ds1sort;
run;

proc sort data=ds2 out=ds2sort;
by var n;
run;
proc print data=ds2sort;
run;

proc sort data=ds4 out=ds4sort;
by var;
run;
proc print data=ds4sort;
run;

data setby12;
set ds1sort ds2sort;
by var;
run;
proc print data=setby12;
run;

data setby14;
set ds1sort ds4sort;
by var;
run;
proc print data=setby14;
run;
/*確認觀測數是否相同*/
data ds15;
merge ds1 ds5; 
run;
proc print data=ds15;
run;
/*這邊有一列會不見*/
data ds14_col;
merge ds1 ds4; 
run;
proc print data=ds14_col;
run;
/*n會被吃掉*/
data ds13_col;
merge ds1 ds3; 
run;
proc print data=ds13_col;
run;
/*少了3筆資料!!!! 阿阿阿阿阿阿*/
data merby12;
merge ds1sort ds2sort;
by var;
run;
proc print; run;

data merby12;
merge ds1sort ds2sort;
by var n;
run;
proc print; run;

data merby14;
merge ds1sort ds4sort;
by var;
run;
proc print; run;

data merby12;
merge ds1sort(in=in1) ds2sort(in=in2);
by var n;
flag1=in1;
flag2=in2;
run;
proc print; run;

data merby14;
merge ds1sort(in=in1) ds4sort(in=in2);
by var;
flag1=in1;
flag2=in2;
run;
proc print; run;

/*12/19練習*/
proc import datafile='C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\member.xls' out=ds0
dbms=excel replace;
range="LMS$A3:D87";
getnames=no;
run;
proc print data=ds0;run;

proc import datafile='C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\微積分 Calculus_191127.xls' out=ds1
dbms=excel replace;
range="XMS$A3:G67";
getnames=no;
run;
proc print data=ds1;run;

proc import datafile='C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\微積分 Calculus_191211.xls' out=ds2
dbms=excel replace;
range="XMS$A3:G67";
getnames=no;
run;
proc print data=ds2;run;

data ds1a;
set ds1(keep=F3 F6 F7);
rename F3=F1 F6=A1 F7=A2;
run;
proc print data=ds1a;
run;

data ds2a;
set ds2(keep=F3 F6 F7);
rename F3=F1 F6=A3 F7=A4;
run;
proc print data=ds2a;
run;

/*要merge by的變數(F1)，資料集都要先porc sort過，不然沒辦法跑*/
proc sort data=ds0;
by f1;
run;
proc sort data=ds1a;
by f1;
run;
proc sort data=ds2a;
by f1;
run;

data dsm;
merge ds0(in=a) ds1a(in=b) ds2a(in=c);
by F1;
flag0=a;
flag1=b;
flag2=c;
run;
proc print data=dsm;run;

/*兩週都沒有來的人*/
proc print data=dsm;
where flag1 = 0 and flag2 = 0;
run;
/*第一週沒有來的人*/
proc print data=dsm;
where flag1=0 and flag2 =1;
run;

/*第二週沒有來的人*/
proc print data=dsm;
where flag1=1 and flag2 =0;
run;

data a0 a1 a2;
set dsm;
if (flag1=0 and flag2=0) then output a0;
if (flag1=0 and flag2=1) then output a1;
if (flag1=1 and flag2=0) then output a2;
run;


data setby12;
set ds1sort ds2sort;
by var;
run;
proc print data=setby12;
run;

data setby14;
set ds1sort ds4sort;
by var;
run;
proc print data=setby14;
run;

proc sort data=setby12;
by var n;
run;

data setby12;
set setby12;
by var n;
vars=first.var;/*標記var 中每種變數值ABCD 各自的第一筆*/
vare=last.var;/*標記var 中每種變數值ABCD 各自的最後一筆*/
ns=first.n;
es=last.n;
run;
proc print data=setby12;
run;

%let indir=C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體;
data ch4d12;
infile " &indir\statpack104fch4d12.txt" firstobs=32;
input id group$ lead0 lead1 lead4 lead6;
run;
proc print data=ch4d12;
run; 

data ch4d12a;
set ch4d12;
time=0; y=lead0; output;
time=1; y=lead1; output;
time=4; y=lead4; output;
time=6; y=lead6; output;
run;
proc print data=ch4d12a; run;

proc means data=ch4d12a maxdec=2; /*小數點第二位*/
class time group;
var y;
run;
/*T Test -- 兩樣本平均數檢定! 不可以超過兩群人*/
proc ttest data=ch4d12a;
class group;
var y;
run;

proc sort data=ch4d12a;
by time group;
run;
/*根據時間來做T Test*/
proc ttest data=ch4d12a;
by time;
class group;
var y;
run;
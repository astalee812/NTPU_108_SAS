
proc import datafile="C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\statpack104fch2d2.xlsx"out=car
   dbms=xlsx replace;
sheet="d3";
getnames=yes;
run;
data car;
set car;
label make="車款"   cylinders="汽缸"
		model="車型"  horsepower="馬力"
		type="車種"     mpg_city="一般道路的油耗"
        origin="生產區域" mpg_highway="快速道路的油耗"
        drivetrain="動力傳動系統" weight="重量"
        msrp="零售價格" wheelbase="輪圈"
        invoice="賣出價格"  length="長度" enginesize="引擎";
format invoice dollar12.;
run;

proc print data=car (obs=10) label;
var model type origin invoice mpg_city;
run;
/* 2x2列連表 */
/* P(X=x,Y=y) = P(X=x) x P(Y=y) but 這件事情發生狀況很小 */
proc freq data=car;
table Origin*drivetrain;
run;

proc tabulate data=car;
class DriveTrain Origin;  /*分群*/
tables Origin, DriveTrain;
run;

proc tabulate data=car;
class DriveTrain Origin;
var msrp; /*抓變數出來*/
tables Origin, DriveTrain*msrp;
run;

proc tabulate data=car;
class DriveTrain Origin;
var msrp;
tables Origin, DriveTrain*msrp*(n mean); /*增加個數以及平均，也可以有sum*/
run;
proc tabulate data=car;
class DriveTrain Origin;
var msrp;
tables Origin, DriveTrain*msrp*(n='數量' mean='平均數量');
run;
/*會跑出一個全部*/
proc tabulate data=car;
class DriveTrain Origin;
var msrp;
tables Origin, DriveTrain*msrp*(n='數量' mean='平均數量')
all=""*msrp=""*(n mean); /*增加個數以及平均，也可以有sum*/
run;

proc tabulate data=car;
class DriveTrain Origin;
var msrp;
tables Origin, DriveTrain*msrp*(n='數量' mean='平均數量'*f=dollar10.2)
all=""*msrp=""*(n mean*f=dollar10.2); /*增加個數以及平均，也可以有sum*/
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
/*SAS的目錄底下建構資料檔直通dir的位置*/
libname dir "C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體";
/*dir. 簡寫可以直接抓取該資料夾的資料*/
proc print data=dir.tennis;
run;
proc contents data=dir.tennis; run;
/*寫成PDF檔*/  /*研究一下ODS的指令 ods trace on; ods trace off*/
ods pdf file="C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\test.pdf";
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
/*排序!!*/
proc sort data=dir.tennis;
by x3;
run;


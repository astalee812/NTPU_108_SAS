%let indir=C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體;

data employ;
infile "&indir\statpack104fch4d7.txt";
input id $ 7-12 hday date9. sal 22-29 dept $ 30-35 jobid $ 37-39 sex $ 40;
run;

data employ1;
set employ;
/*sal_c=ceil(sal);*/
/*sal_f=floor(sal);*/
/*sal_i=int(sal);*/
/*sal_r=round(sal,.1);*/
sal_lag=lag2(sal);
sal_df1=sal-sal_lag;
sal_df2=dif2(sal);
format hday date9. sal: dollar9.2;
run;
proc print data=employ1;
var sal:;
run;

proc print data=employ;
run;
proc contents data=employ;
ods select variables;
run;

data employ2;
set employ;
hday1=put(hday,date9.);
hday2=put(hday,comma8.);
hday3=put(hday,dollar10.);
hday1a=input(hday1,date9.);
hday2a=input(hday2,comma8.);
hday3a=input(hday3,dollar10.);
run;
proc print data=employ2;
var hday:;
run;
proc contents data=employ2;
ods select variables;
run;

proc import datafile="&indir\statpack104fch4d9.xls" out=heal
    dbms=excel replace;
getnames=yes;
run;
proc print data=heal (obs=10);
run;
proc contents data=heal;
ods select variables;
run;

data heala;
set heal;
array xv{9} $ SBP DBP WBC RBC SGOT SGPT TC TG PH;
array yv{9} F1-F9;
do i=1 to 9;
yv(i)=input(xv(i),8.0);
end;
run;
proc print data=heala (obs=10);
run;
proc contents data=heala;
ods select variables;
run;

data d10;
input m d y birth date7.;
cards;
7 9 1976 01dec69
;
run;
proc print data=d10;
run;

data d10a;
set d10;
date=date();
today=today();
mdy=mdy(m,d,y);
year=floor((today-mdy)/365.25);
day=day(today());
month=month(today());
year=year(today());
run;
proc print data=d10a;
run;

libname dir "C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體";




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

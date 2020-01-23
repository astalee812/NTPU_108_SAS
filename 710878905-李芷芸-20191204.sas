%let indir=C:\Users\ASUS\Desktop\NTPU\108-1-類別資料分析;

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
mc=cmiss(of q:);/*判斷遺失值*/
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
array xv{3} x1-x3; /*建立一個陣列變數x1-x3*/
array yv{3} y1-y13 (2,8,6); /*建立列筆數3筆，數值為2,8,6*/
array zv{3} $ z1-z3 ("a" "b" "c"); /*建立字串a,b,c*/
run;
proc print data=ds;
run;
proc contents data=ds;
ods select Variables;
run;

data qn3;
set qn2;
array qv q28-q37; /*設定向量*/
array qav qa28-qa37; /*設定向量*/
do i=1 to 10; /*利用向量改變變數*/
if qv(i)="A" then qav(i)=5;
else if qv(i)="B" then qav(i)=4;
else if qv(i)="C" then qav(i)=3;
else if qv(i)="D" then qav(i)=2;
else if qv(i)="E" then qav(i)=1;
end; /*將問項改變為分數*/
score=sum(of qa:);
keep id q1-q3 qa: score;
run;
proc print data=qn3;
run;
proc freq data=qn3;
tables score;
run;

/*範例statpack104fch4d4*/
%let indir=C:\Users\NTPU\Downloads;
proc import datafile="&indir\statpack104fch4d4.xls"
out=hqn dbms=excel replace;
getnames=yes;
run;
proc print data=hqn;
run;

data hqn1;
set hqn (drop=F:); /*將hqn裏頭 F開頭的資料 通通丟棄*/
rename _col0=id _col1-_col9=q1-q9;
run;
proc print data=hqn1;
run;
proc freq data=hqn1;
tables _character_;
run;


/*範例statpack104fch4d5*/
/*講義CH5 p.36*/
libname dir "&indir";
proc print data=dir.statpack104fch4d5;
run;
proc contents data=dir.statpack104fch4d5;/*發現這筆資料很多都用文字方式記錄，需要轉換才能後續處理*/
ods select Variables;
run;
proc freq data=dir.statpack104fch4d5;
table dmtype;
run;
data oper;
set dir.statpack104fch4d5;
dm1=substr(dmtype,1,2);/*將變數中特定位子字串抓出存到另一個變數 從2往後算2格*/
/*dm2=substr(dmtype,3,2);*/
/*dm3=scan(dmtype,1);/*自動抓到第1個空格就停止*/
dm3=scan(dmtype,1,"YR");/*自動抓到第1個YR就停止*/
dm4=compress(dm3);/*拿掉空格全部擠在一起*/
dm5=substr(dm4,3);/*篩選出數字，但此時為字串格式*/
dmy=input(dm5,8.);/*改為數字格式，長度為8.*/
run;
/*proc freq data=oper;*/
/*table dm2;*/
/*run;*/
proc print data=oper;
var dmtype dm3 dm4 dm5 dmy;
run;

data oper;
set dir.statpack104fch4d5;
dm1=index(dmtype,"YR");/*尋找yr出現的字串位置*/
dm2=input(substr(dmtype,3,dm1-3),8.);/*直接透過變數dm1自己去抓每筆資料應該要抓到哪一個位數*/
run;
proc print data=oper;
var dmtype dm1 dm2;
run;


/*範例statpack104fch4d6*/
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
where v2="學士班"; /*把v2裡的學士班的值拉出來*/
run;

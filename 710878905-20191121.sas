%let indir=C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體;

proc import datafile="&indir\statpack103fuch4p1.xlsx" 
	out=press dbms=xlsx replace;
getnames=yes;
run;

data press;
set press;
rename 健康編號=id 性別=gender 身高=ht 體重=wt;
label sbp="收縮壓" dbp="舒張壓" wbc="白血球個數" rbc="紅血球個數" hb="血紅素"
		hct="血比容" mcv="平均紅血球體積" mch="平均血紅素量";
run;

proc print data=press(obs=5);
run;

proc contents data=press;
ods select Variables;
run;
/*SAS 不像R需要一步一步來，SAS可以平行執行*/
data press1;
set press(keep=wt ht);
/*set press (drop = wt ht);*/
/*drop wt;*/
bmi=wt/((ht/100)**2);
inbmi=log(bmi);
format bmi 5.1;
run;

proc means data=press;
var _numeric_;
run;
proc means data=press nmiss;
var _numeric_;
run;

data press2;
set press;
nhb=n(HB);
run;
proc print data=press2;
run;
proc print data=press2;
var HB nhb;
run;
proc print data=press2;
where nhb=0;
run;

data press2_1;
set press;
nhb=n(of HB HCT);
run;

proc print data=press2_1;
var HB HCT nhb;
run;

proc print data=press2_1;
var HB HCT nhb;
where nhb=0;
run;

data press2_2;
set press;
mishb=nmiss(HB);
run;
proc print data=press2_2;
var HB mishb;
run;

data press2_3;
set press;
mishb=nmiss(of HB HCT);
run;
proc print data=press2_3;
var HB HCT mishb;
run;

data press3;
set press;
sum1 = sum(of HB HCT);
sum2 = HB+HCT;
run;
proc print data=press3;
run;
/*沒啥不一樣*/
data press3_1;
set press;
sum1 = sum(of HB HCT);
sum2 = HB+HCT;
mean1 = sum1/2;
mean2 = sum2/2;
mean3 = mean(of HB HCT);
run;
proc print data=press3_1;
run;
data press3_1;
set press;
sum1 = sum(of HB HCT);
sum2 = HB+HCT;
mean1 = sum1/2;
mean2 = sum2/2;
mean3 = mean(of HB HCT);
run;
proc print data=press3_1;
run;

%let vec = sbp dbp wbp rbc hb hct mcv mch;
data press4;
set press;
sum1 = sum(of &vec);
sum2 = sbp+dbp+wbp+rbc+hb+hct+mcv+mch;
mean1 = sum1/8;
mean2 = sum2/8;
mean3 = mean(of &vec);
run;
proc print data=press4;
var sum1-sum2 mean1-mean3;
run;

data press5;
set press;
gp0 = ht>170;
gp4 = ^gp0;/*gp4為gp0的相反*/
gp1 = 50<wt<=60;
gp2 = wt>50 and wt<=60;
gp3 = wt>50 or wt<=60;
run;
proc print data=press5;
var ht gp:;
run;
proc print data=press5;
var ht gp:;
where gp4 and gp1;
run;

data press6;
set press (keep=id gender wt ht);
if ht>170 then price =100;
proc print data=press6;
run;

data press7;
set press (keep=id gender wt ht);
if ht>170 then price =100;
else price=ht/10+80;
format price 10.;
run;
proc print data=press7;
run;

data press7_1;
set press (keep=id gender wt ht);
if ht>170 then price =100;
else if ht>165 then price=90;
format price 10.;
run;
proc print data=press7_1;
run;

data press7_2;
set press (keep=id gender wt ht);
if ht>170 then price =100;
if 165<ht<=170 then price=90;
format price 10.;
run;
proc print data=press7_2;
run;

data press8;
set press(keep=gender wt ht);
if wt < 80 then acc=1;
else acc=2;
run;
proc print data=press8;
run;

data press8_1;
set press(keep=gender wt ht);
if wt <=50 then acc=1;
else if wt<60 then acc=2;
run;
proc print data=press8_1;
run;

data press8_2;
set press8_1;
if acc=. then acc=3; /*acc="", then 3*/
run;
proc print data=press8_2;
run;

symbol1 value=dot color=red;
symbol2 value=dot color=blue;
symbol3 value=dot color=darkgreen;
proc gplot data=press8_2;
plot wt*ht=acc;
run;

data=press9;
set press;
if gender="女";
run;
proc print data=press9 (obs=5);
run;

data press9_1;
set press;
if gender in ("男" "女") then temp=1;
run;
proc print data=press9_1 (obs=5);
run;

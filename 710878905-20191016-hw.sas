proc import datafile="C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\statpack104fHW4.xlsx"out=heart
dbms=xlsx replace;
getnames=no;	
run;
proc print;run;

data heart;
set heart;
label A="編號"   B ="年齡"
		C="性別"  D="肌鈣蛋白"
		E="高血壓"     F="糖尿病"
        G="吸菸狀況" H="功能評估指標";
run;
proc print data=heart (obs=10) label;
run;
proc format;
value Cf 1="男性" 2="女性";
value Ef  0="沒有" 1="有";
value Ff 0="沒有" 1="有";
value Gf 0="沒有" 1="有";
run;
proc print data=heart (obs=10) label;
format C Cf. E Ef. F Ff. G Gf.;
run;

proc tabulate data=heart;
format C Cf. E Ef. F Ff. G Gf.;
class C E;
var D;
tables C, E*D*(mean='平均值' std="標準差"); 
run;


proc tabulate data=heart;
format C Cf. E Ef. F Ff. G Gf.;
class C E;
var D;
tables C, E*D*(mean='平均值' std="標準差") all=""*D=""*(mean='平均值' std="標準差");
run;

proc tabulate data=heart;
format C Cf. E Ef. F Ff. G Gf.;
class C G E;
var D;
tables C*G, E*D*(mean='平均值' std="標準差") all=""*D=""*(mean='平均值' std="標準差"); 
run;



/*匯出pdf*/
ODS PDF file="C:\Users\ASUS\Desktop\1016hw.pdf";
proc tabulate data=heart;
format C Cf. E Ef. F Ff. G Gf.;
class C E;
var D;
tables C, E*D*(mean='平均值' std="標準差"); 
run;
proc tabulate data=heart;
format C Cf. E Ef. F Ff. G Gf.;
class C E;
var D;
tables C, E*D*(mean='平均值' std="標準差") all=""*D=""*(mean='平均值' std="標準差");
run;
proc tabulate data=heart;
format C Cf. E Ef. F Ff. G Gf.;
class C G E;
var D;
tables C*G, E*D*(mean='平均值' std="標準差") all=""*D=""*(mean='平均值' std="標準差"); 
run;

ODS PDF close
libname dir "C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體";
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
/*排序*/
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
/* ASE=a.....standard error: X bar的漸進標準差 */
/* 報表中出現的比例: 0.5455，p的CI = (0.4474, 0.6435) */
/* 精準信賴區間 : 樣本數大的時候使用 */
/* H0檢定, 在比例0.5的狀況下，ASE會是0.0503 */
/*若標題的H0:比例=0.5這件事情是為真實， Z統計量(常態分配)的數字是否合理? 是不是在大部分資料都會出現的分布中 */
proc freq data=dir.tennis;
table x3/binomial;
run;
/*調整alpha值*/
proc freq data=dir.tennis;
table x3/binomial alpha=0.025;
run;

proc freq data=dir.tennis;
table x3/binomial (ac exact wilson);
run;
/*設定p=0.3，只會在Ho檢定那邊有改變*/
proc freq data=dir.tennis;
table x3/binomial (p=0.3);
run;
/*設定p=0.5*/
/*Ho: p-0.5 <= (-0.2) or p-0.5>=0.2*/
/*Ha: -0.2 < p-0.5 < 0.2*/
/*看整體的P值*/
proc freq data=dir.tennis;
table x3/binomial (equiv p=0.5);
run;
/*調整上下邊界*/
proc freq data=dir.tennis;
table x3/binomial (equiv p=0.5 margin=0.05);
run;
/*畫圖*/
proc freq data=dir.tennis;
table x3/plots=freqplot(type=dot scale=percent);
run;
ods trace on;
ods trace off;
/*output....用SE不會用拉! 我都用點的!!!*/
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
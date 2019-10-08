data cancer;
input smoke cancer count;
cards;
1 1 688
1 0 650
0 1 21
0 0 59
run;

proc freq data=cancer;
weight count;  /*weight是加權，依據count來加權*/
tables smoke*cancer;
run;
data mi;
input drug status count;
cards;
0 1 189
0 0 10845
1 1 104
1 0 10933
run;
proc freq data=mi;
weight count; /*加權*/
tables drug*status/riskdiff; /*風險估計值*/
run;
/*大樣本估計*/
proc freq data=mi;
weight count; /*加權*/
tables drug*status/relrisk; /*相對風險*/   /*第一個是欄，第二個是列*/
run;
/*卡方獨立性檢定*/
proc freq data=mi;
weight count; /*加權*/
tables drug*status/chisq expected; /*卡方*/   
run;
/**/
data alco;
input status alco count;
cards;
0 0 17066
0 0.5 14464
0 1.5 788
0 4 126
0 7 37
1 0 48
1 0.5 38
1 1.5 5
1 4 1
1 7 1
run;
/*遇到結果卡方值跟概度比卡方數值不一致，表示其卡方有問題是不太能用的*/
proc freq data=alco;
weight count;
table status*alco/chisq expected;
run;

proc freq data=alco;
weight count;
table alco*status/measures;
run;



proc freq data=alco;
weight count;
table alco*status/measures scores=rank;
run;
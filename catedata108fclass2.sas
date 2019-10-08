data cancer;
input smoke cancer count;
cards;
1 1 688
1 0 650
0 1 21
0 0 59
run;
proc freq data=cancer;
weight count;
tables smoke*cancer/riskdiff;
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
weight count;
tables drug*status/riskdiff;
run;
proc freq data=mi;
weight count;
tables drug*status/relrisk;
run;
proc freq data=mi;
weight count;
tables status*drug/relrisk;
run;
proc freq data=mi;
weight count;
tables drug*status/chisq expected;
run;
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
proc freq data=alco;
weight count;
tables status*alco/chisq;
run;
proc freq data=alco;
weight count;
tables alco*status/measures;
run;
proc freq data=alco;
weight count;
tables alco*status/measures scores=rank;
run;

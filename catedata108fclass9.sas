proc freq data=ch4a;
tables LOW   RACE    SMOKE    PTL    HT    UI    FTV;
run;
data ch4a;
infile "D:\Dropbox\School\catedata\108fall\catedatach4a.txt" firstobs=7;
input   ID    LOW    AGE    LWT    RACE    SMOKE    PTL    
	HT    UI    FTV     BWT;
run;
proc freq data=ch4a;
tables LOW   RACE    SMOKE    PTL    HT    UI    FTV;
run;
/* Marginal association */
proc freq data=ch4a;
tables (RACE    SMOKE    PTL    HT    UI    FTV)*low/chisq;
run;
proc sgplot data=ch4a;
histogram  AGE;
run;
proc sgplot data=ch4a;
histogram  LWT;
run;
proc format;
value ptlf
0=0
1-high=1;
value ftvf
0=0
1-2=1
3=2
4-high=3;
run;
proc logistic data=ch4a desc;
class RACE    SMOKE    PTL    HT    UI    FTV/param=ref;
model low=RACE    SMOKE    PTL    HT    UI    FTV age lwt/
	selection=backward sls=0.2;
format ptl ptlf. ftv ftvf.;
run;
proc logistic data=ch4a desc;
class RACE    SMOKE    PTL    HT    UI    FTV/param=ref ref=first;
model low=RACE    SMOKE    PTL    HT    UI  lwt/scale=none
	aggregate;
/* Model of fit Overdispersion p. 16*/
/* H0: 模型配適符合假設 (沒有過度離散)
	Ha: 模型配適不符合假設
Deviance and Pearson residual p value > 0.05
不拒絕H0; 模型配適符合假設 
*/
/*
黑人母親嬰兒過輕的勝算是白人母親的3.672倍
其他人種的母親嬰兒過輕的勝算是白人母親的2.350倍
母親體重每增加一磅, 嬰兒過輕的勝算下降 1.6%
*/
format ptl ptlf. ftv ftvf.;
run;





data p3a;
do district='NC','NE','NW','SE','SW';
	do race='B','W';
		do pay=1 to 0 by -1;
			input count @@;
			output;
		end;
	end;
end;
cards;
24 9 47 12
10 3 45 8
5 4 57 9
16 7 54 10
7 4 59 12
run;
proc freq data=p3a;
weight count;
tables district*race*pay/cmh;
run;
proc logistic data=p3a desc;
weight count;
class district race/param=ref;
model pay=district race;
run;
/* Marginal association */
proc freq data=p3a;
weight count;
tables race*pay/cmh;
run;
proc logistic data=p3a desc;
weight count;
class  race/param=ref;
model pay=race;
run;
data p3b;
do symptom=1 to 0 by -1;
	if symptom=1 then sz=18;
	else sz=22;
	infile cards delimiter=',';
	do i=1 to sz;
		input age @@;
		age1=age/12;
		output;
	end;
end;
cards;
12, 15, 42, 52, 59, 73, 82, 91, 96, 105, 114, 120, 121, 128, 130, 139, 139, 157
1, 1, 2, 8, 11, 18, 22, 31, 37, 61, 72, 81, 97, 112, 118, 127, 131, 140,151, 159, 177, 206
run;
proc logistic data=p3b desc;
model symptom=age;
run;
proc logistic data=p3b desc;
model symptom=age1;
run;
proc means data=p3b q1 median q3;
var age;
run;
data p3b1;
set p3b;
if age<=34 then age_gp=1;
else if age<=93.5 then age_gp=2;
else if age<=129 then age_gp=3;
else age_gp=4;
agesq=age*age;
run;
proc freq data=p3b1;
tables age_gp*symptom;
run;
proc gchart data=p3b1;
vbar symptom/discrete group=age_gp g100 percent;
/* 依組別, 計算百分比*/
run;
proc logistic data=p3b desc;
model symptom=age age*age;
run;
data impair;
input mental ses life @@; 
datalines;
1 1 1 1 1 9 1 1 4 1 1 3 1 0 2 1 1 0 1 0 1 1 1 3 1 1 3
1 1 7 1 0 1 1 0 2 2 1 5 2 0 6 2 1 3 2 0 1 2 1 8 2 1 2 
2 0 5 2 1 5 2 1 9 2 0 3 2 1 3 2 1 1 3 0 0 3 1 4 3 0 3
3 0 9 3 1 6 3 0 4 3 0 3 4 1 8 4 1 2 4 1 7 4 0 5 4 0 4
4 0 4 4 1 8 4 0 8 4 0 9
run;
proc logistic data=impair;
class ses /param=ref;
model mental=ses life/link=clogit;
run;
/*
P[Y<=j]/P[Y>j] 累積勝算 -- 心理較健康的勝算

社經地位較低 (SES=0) 的受訪者心理較健康的勝算是
社經地位較高者 (SES=1) 的 0.329 倍

與生命相關的事件數每增加 1 件, 較健康的勝算下降 27.3%
(0.727-1)

log(pi (x)/(1-pi(x)))= alpha+ beta x
*/
data mice;
do conc=0, 62.5, 125, 250, 500;
	do y=0, 1, 2;
		input count @@;
		if y=0 then y1=1; 
		else y1=0;
		if y=1 then y2=1; 
		else if y=2 then y2=0;
		output;
	end;
end;
cards;
15 1 281 17 0 225 22 7 283
38 59 202 144 132 9
run;
/* Continuation ratio logit */
/* Model I: survive vs death */
proc logistic data=mice desc;
weight count;
model y1=conc;
run;
/* Model II: conditional on survive, normal vs malformation */
proc logistic data=mice desc;
weight count;
model y2=conc;
run;

data life;
do race='W','B','O';
	do belief=1, 0;
		input count @@;
		output;
	end;
end;
cards;
1339 330 260 55 88 22
run;
/* Independent model */
proc genmod data=life;
class race belief;
model count=race belief/dist=poi link=log;
run;
/* Saturated model */
proc genmod data=life;
class race belief;
model count=race belief race*belief/dist=poi link=log;
run;
/* 
H0: Independent model vs Ha: Saturated model
概似比檢定 -2log(L0/L1)
-2 log L0+2 log L1
=2(11588.2590-11587.7846)< chi^2_2=5.81
*/
proc freq data=life;
weight count;
table race*belief/chisq;
run;

data pbc;
infile "D:\Dropbox\School\catedata\108fall\program\pbc.dat";
input caseno x d z1-z17;
if caseno<=312;
z7a=(z7 ^=0);
if z17 in (1 2) then z17a=1;
else z17a=z17-1; /* I+II=1; III=2; IV=3 */
stageIV=(z17=4); /* I+II+III vs IV */
run;
proc freq data=pbc;
tables z1 z3-z7;
run;
proc freq data=pbc; tables z17; run;
proc freq data=pbc;
tables (z1 z3-z6 z7a)*d/chisq;
run;
proc freq data=pbc;
tables z17*d/chisq; run;
proc logistic data=pbc desc;
class z1 z3(ref=last) z4-z6 z7a/param=ref ref=first;
model d=z1 z3-z6 z7a;
run;
proc logistic data=pbc desc;
class z1 z3(ref=last) z5-z6 z7a stageiv/param=ref ref=first;
model d=z1 z3 z5-z6 z7a z2 stageiv;
run;
/* 
勝算: 死亡的勝算 (P[d=1]/P[d=0])
男性死亡的勝算是女性的 3.034 倍
年齡每增加一歲, 死亡的勝算增加 3.9%
OR(x=c+1)/OR(x=c)=const =1.039
OR(x=c+1)=const *OR(x=c)= OR(x=c)+ (const -1)OR(x=c)
				 =1 OR(x=c)+3.9%OR(x=c)
Prediction power: ROC curve and concordance index (c)
Provide a cutoff value (pi0) -- Sensitivity, Specificity and % of correct
*/
proc logistic data=pbc desc;
class z1 z3(ref=last) z5-z6 z7a stageiv/param=ref ref=first;
model d=z1 z3 z5-z6 z7a z2 stageiv/scale=none aggregate 
	lackfit; /* Model of fit test -- 適合度檢定*/
/*
Pearson residual test
Deviance residual test
HL test 
All do not reject H0. Model of fit is proper.
*/
run;
proc logistic data=pbc desc;
class z1 z3(ref=last) z5-z6 z7a stageiv/param=ref ref=first;
model d=z1 z3 z5-z6 z7a z2 stageiv/influence;
id caseno;
ods output influence=inf;
/*
Check influential points or outliers
*/
run;
proc print data=inf; 
where difchisq>10; run;
proc logistic data=pbc desc;
class z1 z3(ref=last) z5-z6 z7a stageiv/param=ref ref=first;
model d=z1 z3 z5-z6 z7a z2 stageiv/influence;
id caseno;
ods output influence=inf;
where caseno^=253;
run;
data table5_8;
do race=1 to 0 by -1;
	do month=7 to 9;
		do y=1 to 0 by -1;
			input count @@;
			output;
		end;
	end;
end;
cards;
0 7 0 7 0 8
4 16 4 13 2 13
run;
data table5_8a;
set table5_8;
do sz=1 to count;
	output;
end;
run;
proc logistic data=table5_8a desc;
class race month/param=ref;
model y=race month;
exact race month;
run;
data gator;
input length choice $ @@;
datalines; 
1.24 I  1.30 I  1.30 I  1.32 F  1.32 F  1.40 F  1.42 I  1.42 F
1.45 I  1.45 O  1.47 I  1.47 F  1.50 I  1.52 I  1.55 I  1.60 I
1.63 I  1.65 O  1.65 I  1.65 F  1.65 F  1.68 F  1.70 I  1.73 O
1.78 I  1.78 I  1.78 O  1.80 I  1.80 F  1.85 F  1.88 I  1.93 I
1.98 I  2.03 F  2.03 F  2.16 F  2.26 F  2.31 F  2.31 F  2.36 F
2.36 F  2.39 F  2.41 F  2.44 F  2.46 F  2.56 O  2.67 F  2.72 I
2.79 F  2.84 F  3.25 O  3.28 O  3.33 F  3.56 F  3.58 F  3.66 F
3.68 O  3.71 F  3.89 F
;
proc logistic data=gator desc;
model choice=length/link=glogit;
run;

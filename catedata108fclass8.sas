/* 120.126.135.53 */
data ch3a;
do depart=1 to 2;
	do gender=1 to 2;
		do y=1 to 0 by -1;
			input count @@;
			output;
		end;
	end;
end;
cards;
686 1180 468 1259 512 313 89 19
run;
/* Conditional independent -- CMH test*/
/* Homogeneous association -- Breslow day test*/
proc freq data=ch3a;
weight count;
tables depart*gender*y/cmh;
/* Heterogeneous association*/
run;
/* Only main effect -- Homogeneous model */
proc logistic data=ch3a desc;
weight count;
class depart gender/param=ref;
model y=depart gender;
run;
/* Include interaction -- Heterogeneous model */
proc logistic data=ch3a desc;
weight count;
class depart gender/param=ref;
model y=depart gender depart*gender;
run;
/*
H0: Homogeneous model vs Ha: Heterogeneous model
AIC: 5710.989 vs 5676.131
LR test= 5704.989- 5668.131=36.857>chi^2_1=3.84
*/
proc logistic data=ch3a desc;
weight count;
class depart gender/param=ref;
model y=depart gender/scale=none aggregate;
run;
proc logistic data=ch3a desc;
weight count;
class depart gender/param=ref;
model y=depart gender/scale=p aggregate;
/* Use pearson residual to adjust dispersion */
run;
data crab;
infile "D:\Dropbox\School\catedata\108fall\program\crab.dat";
input color spine width count weight;
y=(count>0);
/* Color
2=Light
3=Light medium
4=Dark medium
5=Dark*/
/* Spine: 1= Both good; 2= One good; 3= Both bad*/
run;
proc logistic data=crab desc;
class spine/param=ref;
model y=color spine width weight/selection=backward sls=0.2;
run;
proc logistic data=crab desc;
class spine/param=ref;
model y=color spine width weight/selection=forward sle=0.2;
run;
proc logistic data=crab desc;
class spine/param=ref;
model y=color spine width weight/selection=stepwise sle=0.2 sls=0.2;
run;
proc logistic data=crab desc plots=(ROC);
model y=color width/ctable;
/* ctable -- Classification table */
run;
proc logistic data=crab desc;
model y=color width/scale=none aggregate lackfit;
/*
Test for overdispersion (ch3: page 65)
H0: phi=1 versus Ha: phi neq 1
*/
/*
Lackfit -- Hosmer Lemeshow test
*/
run;

data murder;
input person1 person2 dead count;
cards;
0 0 0 19
0 0 1 132
0 1 0 11
0 1 1 52
1 0 0 0
1 0 1 9
1 1 0 6
1 1 1 97
run;
proc freq data=murder;
weight count;
tables person1*person2*dead/cmh;
run;

data heart;
do score = 0,2,4,5;
	do hd = 1 to 0 by -1;
		input count @@;
		output;
	end;
end;
cards;
24 1355 35 603
21 192 30 224
run;
/*liner probability model*/
/*看回應概況的報表*/
proc genmod data=heart;
weight count;
model hd=score/dist=bin;
run;

/*liner probability model*/
/*看回應概況的報表*/
proc genmod data=heart desc;
weight count;
model hd=score/dist=bin;
run;

/* logit model */
proc genmod data=heart desc;
weight count;
model hd=score/dist=bin link=logit;
run;

/*probit model*/
proc genmod data=heart desc;
weight count;
model hd=score/dist=bin link=probit;
run;

data crab;
infile"C:\Users\ASUS\Desktop\NTPU\108-1-類別資料分析\crab.dat";
input color spine width count weight;
run;
/*這次是一支一支的資料! 不用wight加權*/
/*log linear model*/
proc genmod data=crab;
model count=width/dist=poi link=log;
run;

proc import
datafile="C:\Users\ASUS\Desktop\NTPU\108-1-類別資料分析\table3_4.xlsx"
out=table3_4 dbms=EXCEL replace;
run;
data table3_4a;
set table3_4;
x=year-1075;
log_km=log(train_km); /*offset*/
run;
proc genmod data=table3_4a;
model train_collisions = x / dist= poi link=log offset=log_km;
run;

proc genmod data=table3_4a;
model train_collisions = x / dist= negbin link=log offset=log_km;
run;

data ch2;
do vrace=0 to 1;
	do drace=0 to 1;
		do penalty=1 to 0 by -1;
			input count @@;
			output;
		end;
	end;
end;
cards;
19 132 11 52 0 9 6 97
run;
proc freq data=ch2;
weight count;
tables vrace*drace*penalty/cmh;
run;
data heart;
do score=0, 2, 4, 5;
	do hd=1 to 0 by -1;
		input count @@;
		output;
	end;
end;
cards;
24 1355 35 603
21 192 30 224
run;
proc genmod data=heart desc;
weight count;
model hd=score/dist=bin link=identity;
/* linear probability model */
run;
proc genmod data=heart desc;
weight count;
model hd=score/dist=bin link=logit;
/* logistic model */
run;
proc genmod data=heart desc;
weight count;
model hd=score/dist=bin link=probit;
/* Probit model */
run;
data crab;
infile "D:\Dropbox\School\catedata\108fall\program\crab.dat";
input color spine width count weight ;
run;
proc genmod data=crab;
model count=width/dist=poi link=log;
/* Log linear model */
run;
proc import 
datafile="C:\Users\ASUS\Desktop\NTPU\108-1-類別資料分析\table3_4.xlsx"
out=table3_4 DBMS=EXCEL replace;
run;
proc print; run;
data table3_4a;
set table3_4;
x=year-1975;
log_km=log(train_km); /* offset term*/
run;
proc genmod data=table3_4a;
model Train_collisions=x/dist=poi link=log offset=log_km;
run;
proc genmod data=table3_4a;
model Train_collisions=x/dist=negbin link=log offset=log_km;
run;







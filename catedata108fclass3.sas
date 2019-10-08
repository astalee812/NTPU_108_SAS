data ch2;
input school gene count;
cards;
1 1 90
1 2 12
1 3 78
2 1 13
2 2 1
2 3 6
3 1 19
3 2 13
3 3 50
run;
proc freq data=ch2;
weight count;
tables school*gene/chisq;
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
table alco*status/trend;
run;
data gamma;
do income=7.5, 20, 32.5, 60;
	do sat=1 to 4;
		input count @@;
		output;
	end;
end;
cards;
1 3 10 6
2 3 10 7
1 6 14 12
0 1 9 11
run;
proc freq data=gamma;
weight count;
tables income*sat/measures;
run;
data tea;
input row column count;
cards;
0 0 3
0 1 1
1 0 1
1 1 3
run;
proc freq data=tea;
weight count;
tables row*column/fisher exact;
run;


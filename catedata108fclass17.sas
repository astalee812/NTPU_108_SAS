data ch10d1;
do f='A','D';
	do s='A','D';
		input count @@;
		output;
	end;
end;
cards;
794 150 86 570
run;
data ch10d1a;
set ch10d1;
do i=1 to count;
	output;
end;
run;
data ch10d1b;
set ch10d1a;
subject=_n_;
array survey f s;
do time=1, 2;
	response=(survey{time}='A');
	output;
end;
run;
proc freq data=ch10d1b;
tables subject*time*response/cmh;
run;
proc logistic data=ch10d1b desc;
strata subject;
model response=time;
run;
data ch10d2;
do control='D', 'N';
	do case='D', 'N';
		input count @@;
		output;
	end;
end;
cards;
9 16 37 82
run;
data ch10d2a;
set ch10d2;
do i=1 to count;
	output;
end;
run;
data ch10d2b;
set ch10d2a;
subject=_n_;
array gp control case;
do group=1 to 2;
	response=(gp{group}='D');
	output;
end;
run;
proc freq data=ch10d2b;
tables subject*group*response/cmh;
run;
proc logistic data=ch10d2b desc;
strata subject;
model response=group;
run;
data ch10d3;
do psex=1 to 4;
	do esex=1 to 4;
		input count @@;
		output;
	end;
end;
cards;
144 2 0 0 33 4 2 0
84 14 6 1 126 29 25 5
run;
data ch10d3a;
set ch10d3;
do i=1 to count;
	output;
end;
run;
data ch10d3b;
set ch10d3a;
subject=_n_;
array type psex esex;
do survey=1 to 2;
	response=type{survey};
	output;
end;
run;
proc logistic data=ch10d3b;
model response=survey/link=clogit;
run;
proc logistic data=ch10d3b;
model response=survey/link=glogit;
run;
proc logistic data=ch10d3b;
model response=/link=glogit;
run;
data tab10_6;
do y80=1 to 4;
	do y85=1 to 4;
		input count @@;
		output;
	end;
end;
cards;
11607 100 366 124 87 13677 515 302
172 255 17819 270 63 176 286 10192
run;
data tab10_6a;
set tab10_6;
do i=1 to count;
	output;
end;
run;
data tab10_6b;
set tab10_6a;
subject=_n_;
array area y80 y85;
do year=1,2;
	response=area{year};
	output;
end;
run;
proc logistic data=tab10_6b desc;
model response=year/link=glogit;
run;

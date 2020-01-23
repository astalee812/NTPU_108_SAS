/* 120.126.135.53 */
data crab;
infile "D:\Dropbox\School\catedata\108fall\program\crab.dat";
input color spine width count weight;
y=(count>0);
run;
proc freq; table width; run;
proc format;
value widthgpf
low-<23.25=1
23.25-<24.25=2
24.25-<25.25=3
25.25-<26.25=4
26.25-<27.25=5
27.25-<28.25=6
28.25-<29.25=7
29.25-high=8;
run;
proc means data=crab;
class width;
var y;
format width widthgpf.;
run;
proc logistic data=crab desc; /* Desc -- °t¾A P[Y=1]*/
model y=width;
run;
proc format;
value colorf
2-3='Light'
4-5='Dark';
run;
proc logistic data=crab desc; /* Desc -- °t¾A P[Y=1]*/
class color/param=ref;
model y=color;
format color colorf.;
run;

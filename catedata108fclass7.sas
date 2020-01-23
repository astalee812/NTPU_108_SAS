/* 120.126.135.53 */
data crab;
infile "D:\Dropbox\School\catedata\108fall\program\crab.dat";
input color spine width count weight;
y=(count>0);
run;
proc format;
value colorf
2-3='Light'
4-5='Dark';
run;
proc logistic data=crab desc; 
class color; /* �w�]�Φ�: effect*/
model y=color;
format color colorf.;
run;
proc logistic data=crab desc; 
class color/param=ref; /* �Ѽƹ��]�w: reference */
model y=color;
format color colorf.;
run;
proc logistic data=crab desc; 
class color; /* �w�]�Φ�: effect*/
model y=color;
run;
proc logistic data=crab desc; 
class color/param=ref; /* �ѼƤƳ]�w: reference (�ϥγ̫�@�շ�Ѧ�)*/
model y=color;
run;
proc logistic data=crab desc; 
class color (ref=first)/param=ref; /* �Ѽƹ��]�w: reference  (�ϥβĤ@�շ�Ѧ�)*/
model y=color;
run;
data alco;
do status=0 to 1;
	do alco=0, 0.5, 1.5, 4, 7;
		input count @@;
		output;
	end;
end;
cards;
17066 14464 788 126 37
48 38 5 1 1
run;
proc logistic data=alco desc;
weight count;
class alco (ref=first)/param=ref;
model status=alco;
run;
proc logistic data=alco desc;
weight count;
model status=alco;
run;
data crab1;
set crab;
width1=width/100; /* ���ܳ��: ���� */
weight1=weight/1000; /* ���ܳ��: ���� */
run;
proc logistic data=crab1;
model y=width/stb; /* Standardized beta coefficient */
run;
proc logistic data=crab1;
model y=width1/stb;
run;
/* Homogeneous model -- Only main effect */
proc logistic data=crab1 desc;
class spine color/param=ref;
model y=spine color width/stb;
run;
proc freq data=crab1;
tables color*y/trend;
run;
proc logistic data=crab1 desc;
class spine/param=ref;
model y=spine color width/stb;
run;
/* Heterogeneous model -- Include interaction */
proc logistic data=crab1 desc;
class spine color/param=ref;
model y=spine color spine*color width/stb;
run;







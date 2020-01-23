data ch7d1;
do alc=1, 0;
	do cig=1, 0;
		do mar=1, 0;
			input count @@;
			output;
		end;
	end;
end;
cards;
911 538 44 456
3 43 2 279
run;
/* Independent model */
proc genmod data=ch7d1;
class alc cig mar;
model count=alc cig mar/dist=poi link=log;
run;
/* Marginal independent model */
/* AC M */
proc genmod data=ch7d1;
class alc cig mar;
model count=alc cig mar alc*cig/dist=poi link=log;
run;
/* AM C */
proc genmod data=ch7d1;
class alc cig mar;
model count=alc cig mar alc*mar/dist=poi link=log;
run;
/* A CM */
proc genmod data=ch7d1;
class alc cig mar;
model count=alc cig mar cig*mar/dist=poi link=log;
run;
/* Conditional independent */
/* AC AM */
proc genmod data=ch7d1;
class alc cig mar;
model count=alc cig mar alc*cig alc*mar/dist=poi link=log;
run;
/* AC CM */
proc genmod data=ch7d1;
class alc cig mar;
model count=alc cig mar alc*cig cig*mar/dist=poi link=log;
run;
/* AM CM */
proc genmod data=ch7d1;
class alc cig mar;
model count=alc cig mar alc*mar cig*mar/dist=poi link=log;
run;
/* Homogeneous model */
/* AC AM CM */
proc genmod data=ch7d1;
class alc cig mar;
model count=alc cig mar alc*cig alc*mar cig*mar/dist=poi link=log;
run;
/* Saturated model */
/* ACM */
proc genmod data=ch7d1;
class alc cig mar;
model count=alc cig mar alc*cig alc*mar cig*mar alc*cig*mar
	/dist=poi link=log;
run;
/* 
Model                Log Likehood           AIC      DF
Independent       11367.7894      1343.0634      4=1+3        
AC M                11588.8861        902.8701      5=1+3+1    
AM C                11541.0181        998.6060      5=1+3+1    
A CM                11743.6935        593.2551      5=1+3+1
AC AM             11762.1147        558.4127      6=1+3+2
AC CM             11964.7902        153.0618      6=1+3+2
AM CM            11916.9222        248.7977      6=1+3+2
AC AM CM      12010.6124         63.4174       7=1+3+3       v
ACM                12010.7994          65.0434       8=1+3+3+1
H0: Simple model vs Ha: Complex model
LR=-2log L0+2log L1
e.g. 
H0: AM CM vs Ha: AC AM CM
LR=-2(11916.9222-12010.6124)>chi_1^2=3.84 Reject H0
*/
/* Homogeneous model */
/* AC AM CM */
proc genmod data=ch7d1;
class alc (ref=first) cig (ref=first) mar (ref=first);
model count=alc cig mar alc*cig alc*mar cig*mar/dist=poi link=log;
run;
data ch7d2;
do g=0, 1;
	do l=0, 1;
		do s=0, 1;
			do i=0, 1;
				input count @@;
				output;
			end;
		end;
	end;
end;
cards;
7287 996 11587 759
3246 973 6134 757
10381 812 10969 380 
6123 1084 6693 513
run;
/* G L S I*/
/* GL GS GI LS LI SI */
/* SI>GS>LI>GI>GL>LS */
proc genmod data=ch7d2;
class g (ref=first) l (ref=first) s (ref=first) i (ref=first);
model count=g l s i/dist=poi link=log;
run;

proc genmod data=ch7d2;
class g (ref=first) l (ref=first) s (ref=first) i (ref=first);
model count=g l s i g*l g*i g*s i*l i*s l*s/dist=poi link=log;
run;

proc genmod data=ch7d2;
class g (ref=first) l (ref=first) s (ref=first) i (ref=first);
model count=g l s i g*l/dist=poi link=log;
run;
proc genmod data=ch7d2;
class g (ref=first) l (ref=first) s (ref=first) i (ref=first);
model count=g l s i g*s/dist=poi link=log;
run;
proc genmod data=ch7d2;
class g (ref=first) l (ref=first) s (ref=first) i (ref=first);
model count=g l s i g*i/dist=poi link=log;
run;
proc genmod data=ch7d2;
class g (ref=first) l (ref=first) s (ref=first) i (ref=first);
model count=g l s i l*s/dist=poi link=log;
run;
proc genmod data=ch7d2;
class g (ref=first) l (ref=first) s (ref=first) i (ref=first);
model count=g l s i l*i/dist=poi link=log;
run;
proc genmod data=ch7d2;
class g (ref=first) l (ref=first) s (ref=first) i (ref=first);
model count=g l s i s*i/dist=poi link=log;
run;

/*GLS GLI GSI LSI*/
proc genmod data=ch7d2;
class g (ref=first) l (ref=first) s (ref=first) i (ref=first);
model count=g l s i g*l*s/dist=poi link=log;
run;
proc genmod data=ch7d2;
class g (ref=first) l (ref=first) s (ref=first) i (ref=first);
model count=g l s i g*l*i/dist=poi link=log;
run;
proc genmod data=ch7d2;
class g (ref=first) l (ref=first) s (ref=first) i (ref=first);
model count=g l s i g*s*i/dist=poi link=log;
run;
proc genmod data=ch7d2;
class g (ref=first) l (ref=first) s (ref=first) i (ref=first);
model count=g l s i l*s*i/dist=poi link=log;
run;


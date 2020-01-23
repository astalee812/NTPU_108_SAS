data ch7d1;
do g='F', 'M';
	do i=1 to 4;
		do s=1 to 4;
			input count @@;
			output;
		end;
	end;
end;
cards;
1 3 11 2 2 3 17 3
0 1 8 5 0 2 4 2
1 1 2 1 0 3 5 1
0 0 7 3 0 1 9 6
run;
/* Independent model */
proc genmod data=ch7d1;
class g i s;
model count=g i s/link=log dist=poi;
run;
/* Marginal independent */
/* GI S */
proc genmod data=ch7d1;
class g i s;
model count=g i s g*i/link=log dist=poi;
output out=gi_p p=pred RESRAW=resid;
/* Resraw= count-pred */
run;
proc print data=gi_p; run;
/* GS I */
proc genmod data=ch7d1;
class g i s;
model count=g i s g*s/link=log dist=poi;
run;
/* G SI */
proc genmod data=ch7d1;
class g i s;
model count=g i s i*s/link=log dist=poi;
run;
/* Conditional model */
/* GI IS */
proc genmod data=ch7d1;
class g i s;
model count=g i s g*i i*s/link=log dist=poi;
run;
/* Homogeneous model -- Didn't converge  */
proc genmod data=ch7d1;
class g i s;
model count=g i s g*i i*s g*s/link=log dist=poi;
run;
data ch7d1a;
set ch7d1;
si=s*i;
run;
/* Linear by Linear model for IS*/
proc genmod data=ch7d1a;
class g i s;
model count=g i s g*i si/link=log dist=poi;
run;
/* 
Model                        LogL                      AIC                DF
1 Independent               59.7620                  125.8676        1+1+3+3=8
2 GI S                           66.0375                  119.3165        8+3=11
3 GS I                           60.4144                  130.5627        8+3=11
4 G IS                           66.4957                  130.4003        8+9=17
5 GI IS                          72.7712                  123.8492        17+3=20 
Model 4 vs Model 5  2(72.77-66.50)=12.54>chi_3^2=7.81
6 LL GI                         70.0890                  113.2137        11 (Model 2)+1=12
Model 2 vs Model 6  2*(70.0890-66.0375)= 8.103>chi_1^2=3.84 Reject H0
Model 6 vs Model 5  2*(72.7712-70.0890)=5.3644<chi_8^2= 15.50731
Do not reject H0
*/
proc freq data=ch7d1;
weight count;
tables g*i*s/cmh;
run;

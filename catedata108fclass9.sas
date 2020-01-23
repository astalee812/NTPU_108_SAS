proc freq data=ch4a;
tables LOW   RACE    SMOKE    PTL    HT    UI    FTV;
run;
data ch4a;
infile "D:\Dropbox\School\catedata\108fall\catedatach4a.txt" firstobs=7;
input   ID    LOW    AGE    LWT    RACE    SMOKE    PTL    
	HT    UI    FTV     BWT;
run;
proc freq data=ch4a;
tables LOW   RACE    SMOKE    PTL    HT    UI    FTV;
run;
/* Marginal association */
proc freq data=ch4a;
tables (RACE    SMOKE    PTL    HT    UI    FTV)*low/chisq;
run;
proc sgplot data=ch4a;
histogram  AGE;
run;
proc sgplot data=ch4a;
histogram  LWT;
run;
proc format;
value ptlf
0=0
1-high=1;
value ftvf
0=0
1-2=1
3=2
4-high=3;
run;
proc logistic data=ch4a desc;
class RACE    SMOKE    PTL    HT    UI    FTV/param=ref;
model low=RACE    SMOKE    PTL    HT    UI    FTV age lwt/
	selection=backward sls=0.2;
format ptl ptlf. ftv ftvf.;
run;
proc logistic data=ch4a desc;
class RACE    SMOKE    PTL    HT    UI    FTV/param=ref ref=first;
model low=RACE    SMOKE    PTL    HT    UI  lwt/scale=none
	aggregate;
/* Model of fit Overdispersion p. 16*/
/* H0: �ҫ��t�A�ŦX���] (�S���L������)
	Ha: �ҫ��t�A���ŦX���]
Deviance and Pearson residual p value > 0.05
���ڵ�H0; �ҫ��t�A�ŦX���] 
*/
/*
�¤H��������L�����Ӻ�O�դH���˪�3.672��
��L�H�ت���������L�����Ӻ�O�դH���˪�2.350��
�����魫�C�W�[�@�S, ����L�����Ӻ�U�� 1.6%
*/
format ptl ptlf. ftv ftvf.;
run;





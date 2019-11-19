data ch4a; 
infile "C:\Users\ASUS\Desktop\NTPU\108-1-���O��Ƥ��R\catedatach4a.txt";
input   ID    LOW    AGE    LWT    RACE    SMOKE    PTL    HT    UI    FTV     BWT;
run;
proc freq data=ch4a;
table LOW RACE SMOKE PTL HT UI FTV;
run;
/*������p��:marginal association*/
/*�[�ݨ����ܼƬO�i�H�Q�X�֪�! ���]�n�ݬ۹������ʤ���*/
proc freq data=ch4a;
tables (RACE SMOKE PTL HT UI FTV)*LOW/chisq;
run;

proc sgplot data=ch4a;
histogram age;
run;

proc sgplot data=ch4a;
histogram LWT;
run;
/*���ܼƦX��*/
proc format;
value ptlf
0=0
1-high=1;
value ftvf
0=0
1-2 =1
3=2
4-high = 3;
run;
/*��X������n���ܬ�*/
proc logistic data=ch4a desc;
class RACE SMOKE PTL HT UI FTV / param=reference;
model low = RACE SMOKE PTL HT UI FTV age lwt / selection=backward sls=0.2;
format ptl ptlf. ftv ftvf.;
run;
/*�Y���t��pearson�A�t�ײέp�ȬO���ڵ�H0�A�N��ܳo�Ӽҫ��O�O�S���L��������*/
/*H0:�ҫ��t�A�ŦX���](�S���L������)*/
/*Ha: �ҫ��t�A���ŦX���]*/
/*diviance and pearson residual p-value > 0.05*/
/*���ڵ�H0��ܼҫ��t�A�ŦX���]*/


/*���۬ݳӺ����p��*/
/*�¤H��������L�����Ӻ�O�դH���˪�3.672��*/
/*��L�H�ت���������L�����Ӻ�O�դH���˪�2.350��*/
/*�����魫�C�W�[�@�S�A����L�˪��Ӻ�U��1.6% (0.984-0.971)*/

proc logistic data=ch4a desc;
class RACE SMOKE PTL HT UI FTV / param=reference ref=first ;
model low = RACE SMOKE PTL HT UI lwt / scale=none aggregate; /*aggregate��ܧ��Ƨ@�X��*/
/*Model of fit*/
/*�L�������˵� P16*/
format ptl ptlf. ftv ftvf.;
run;
/*H0:�ҫ��t�A�ŦX���](�S���L������)*/
/*Ha: �ҫ��t�A���ŦX���]*/
/*lackfit --- HL test (�s�򫬦������ܼƾA�ΡA�p�G���O�����N����HL test)*/
/*p=0.2303 > 0.05���ڵ�H0, �ҫ��O�t�ŦX���]*/
/*�ظm�ҫ��n����*/
proc logistic data=ch4a desc;
class RACE SMOKE PTL HT UI FTV / param=reference ref=first ;
model low = RACE SMOKE PTL HT UI lwt / scale=none aggregate lackfit; /*aggregate��ܧ��Ƨ@�X��*/
format ptl ptlf. ftv ftvf.;
run;

/*�˵����ݭȥH�αӷP�I*/
/*�]�X�Ӫ��ϬOpearson residual*/
/*CI�N�ODfbeta����C�A�ƭȤ��n�Ӥj*/
/*�ĤG�����ϸs�O�R���e�᪺���p*/
/*Dfbeta*/
proc logistic data=ch4a desc;
class RACE SMOKE PTL HT UI FTV / param=reference ref=first ;
model low = RACE SMOKE PTL HT UI lwt /influence ; 
ods output influence=ch4_inf;
id id; /*���ѿ�X��ƽs��*/
format ptl ptlf. ftv ftvf.;
run;
proc print data=ch4_inf;
where DifChisq > 9 | HatDiag > 0.7;
run;
/*�s��36��77 difference pearson residual > 10*/
/*�˵��R���᪺�̤j�������p��O�_�ۮt�Ӧh*/
/*�w�����v�P�[���^�������p��: ��C���ƭȬO�_���ܦn*/
proc logistic data=ch4a(where=(id ^ in (36 77))) desc;
class RACE SMOKE PTL HT UI FTV / param=reference ref=first ;
model low = RACE SMOKE PTL HT UI lwt /influence ; 
ods output influence=ch4_inf;
id id; /*���ѿ�X��ƽs��*/
format ptl ptlf. ftv ftvf.;
run;



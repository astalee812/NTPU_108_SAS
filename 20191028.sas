data ch3a;
do depart = 1 to 2;
	do gender = 1 to 2;
		do y = 1 to 2;
			input count @@;
			output;
		end;
	end;
end;
cards;
686 1180 468 1259 512 313 89 19
run;
/*conditional independent--CMH test*/
/*Homodenouse association-- Breslow day test*/
proc freq data= ch3a;
weight count;
tables depart*gender*y / cmh; /*Heterogeneous association*/
run;
/*only main effect -- Homodenouse model*/
proc logistic data=ch3a desc;
weight count;
class depart gender / param=reference;
model y=depart gender;
run;
/*include interaction--����ҫ��A�n�ۤv�˳Ӻ��H�ΫH��϶�*/
proc logistic data=ch3a desc;
weight count;
class depart gender / param=reference;
model y=depart gender depart*gender;
run;
/*H0: �P��medol vs. Ha: ����model(���椬�@�Ϊ�)*/
/*AIC = 5710.989 vs. 5676.131*/
/*LR test = 5704.989 - 5668.131(�椬�@�έ�)=36.857 > chi^2_1 =3.84*/


/*CH5�إ߼ҫ��A�ݹw����O*/
data crab;
infile "C:\Users\ASUS\Desktop\NTPU\108-1-���O��Ƥ��R\crab.dat";
input color spine width count weight;
y=(count>0);
/* Color
2=Light
3=Light medium
4=Dark medium
5=Dark*/
/* Spine: 1= Both good; 2= One good; 3= Both bad*/
run;
/*�����z��! critria���n�]�����Y�V*/
/*�]�X�Ӫ�����|�@�B�@�B�R���ܼ�*/
/*SAS �bsls �� sle���w�]�ȳ��O0.15�A�Ѯv����ߺD��0.2*/
/*backward*/
proc logistic data=crab desc;
class spine/param=reference;
model y=color spine width weight/ selection=backward sls=0.2;
run;
/*forward*/
proc logistic data=crab desc;
class spine/param=reference;
model y=color spine width weight/ selection=forward sle=0.2;
run;
/*stepwise�v�B���h�k�Asle��sls���n�g�A��forward�Abackward�A�R�����ܼƦ��ܤj��]�O�]���ܼƦ��@�u��*/
proc logistic data=crab desc;
class spine/param=reference;
model y=color spine width weight/ selection=stepwise sle=0.2 sls=0.2;
run;

proc logistic data=crab desc plots=(ROC);
model y=color width/ctable;
/* ctable -- Classification table */
run;

/**-----**/
/*ch4*/
/*�椬�@��*/
data ch3a;
do depart = 1 to 2;
	do gender = 1 to 2;
		do y = 1 to 2;
			input count @@;
			output;
		end;
	end;
end;
cards;
686 1180 468 1259 512 313 89 19
run;
/*conditional independent--CMH test*/
/*Homodenouse association-- Breslow day test*/
proc freq data= ch3a;
weight count;
tables depart*gender*y / cmh; /*Heterogeneous association*/
run;

/*only main effect -- Homodenouse model*//*�P��ҫ�*/
proc logistic data=ch3a desc;
weight count;
class depart gender / param=reference;
model y=depart gender;
run;

/*include interaction*//*p27*//*����ҫ��Asas���|������A�H��϶��]�n�ۤv��(��19�����ܲ��Y�ƺ�)*/
/*����-���P���O���ܼƹ�󵲪G���������P*/
proc logistic data=ch3a desc;
weight count;
class depart gender / param=reference;
model y=depart gender depart*gender;
run;

/*�B�z�������*/
proc logistic data =ch3a desc ;
model y=depart gender / scale=none aggregate /*��X���*/;
/*overdispersion*/
run;
/*�ߤ@�]�w�ɼƥ�: 4 
depart(2��)*gender(2��)=4��
�� SAS ���������t�� Pearson �t�A�ײέp��
�i�H�o�{�ҫ��t�A���n*/

/*H0 : Homodenouse model v.s. H1 : include interaction*/
/*LR test=5704.989-5668.131=36.857>chi^2_1=3.84*/
/*AIC:5710.989 V.S. 5676.131*/
/*reject H0*/

/*ch5*/
/*�w����O*/

/*p4 
�P�_�O�_�n��Ѽƶi�h
SLE-�e�i��ܡA��ܭ����ܼƭn�C�J�ҫ�
SLS-�V����h�A��ܭ����ܼƭn�q�ҫ����R��*/

/*step1. ����j���Acritria���n�]�����Y�V*/
/*�]�X�Ӫ�����|�@�B�@�B�R���ܼ�*/
data crab;
infile "C:\Users\carol\Downloads\crab.dat";
input color spine width count weight;
y=(count>0);
run;

/*�V����h�k*/
proc logistic data=crab desc;
class spine/param=reference;
model y=color spine width weight/ selection=backward sls=0.2/*critria*/;
run;

/*�e�i��ܪk*/
proc logistic data=crab desc;
class spine/param=reference;
model y=color spine width weight/ selection=forward sle=0.2/*critria*/;
run;

/*�v�B�|�ѦҶi�J��R�������e*/
/*���i�J�@�ӡA��ĤG�Ӷi�J�A�P�_�O�_�ŦX��A�R���@��*/
/*�Y�ܼƦ��@�u�ʡA�e���Q�R��*/

/*�P�w�Y��-  R^2�A�|�H�۰Ѽ��ܦh�A�V�ܶV�j
������Ƥ]���@�˪��Ͷ�
�p�G�W�ɪ��Ȥ����֡A�N���n�o�Ӽҫ��F
AIC->�n��AIC�̤p���A�~�O�A�X���ҫ�
*/

/*p9 
�ӷP��-Sensitivity , a/(a+b)�A�䤶��0~100�H�A�N��O�u���w�e�f�B�z�ˬ����ʪ̪����v�v
�S����-Specificity �Ad/(c+d)�A�䤶��0~100�H�A�N��O�u�L���w�e�f�B�z�ˬ����ʪ̪����v�v
�P�_�ҫ��n���n�A�O�@�ӱ�����v*/

/*p11
receiver operating characteristic (ROC) 
�αӷP�ʸ�S���ʰ��X����*/

/*P13
concordance index - ROC���u�H�U�����n
�M��/���M�Ӧʤ��� - �[��ιw�����G���@�P�ʩΤ��@�P
https://statisticalanalysisconsulting.com/proc-logistic-concordant-and-discordant/*/

proc logistic data =crab desc plots=(ROC);
model y=color width / ctable ;
run;

/*�վ����O�ҫ���k
ch2 p36 �h����t
ch5 p16 �W�[�Z�ʰѼ�
https://www.itread01.com/content/1548069156.html*/


/*�ˬd���S���L������*/
proc logistic data =crab desc ;
model y=color width / scale=none/*1*/ aggregate /*��X���*/;
/*overdispersion*/
run;

/*�ߤ@�]�w�ɼƥ�: 108 
�ܼƤӦh�A�⤣�ǽT
p16 �f�t SAS ���������t�� Pearson �t�A�ײέp�� 
X^2 : Pearson
D : ���t*/

/*�ץ��L�������A���|�v�T���p��*/
proc logistic data =crab desc;
model y=color width / scale=p/*Pearson*/ aggregate;
/*overdispersion*/
run;

 
/* ��֤�k�A�קK�s������n�Ӥj
1.�X�֦��p�����v��
2.�X�֤@�Ӥ@�Ӱ϶� (HL�˩w) : �˵��ҫ��t�A----ch5 P17*/
proc logistic data =crab desc;
model y=color width / scale=p/*Pearson*/ aggregate lackfit/*HL�˩w*/;
/*overdispersion*/
run;
/*Hosmer �� Lemeshow �t�A���˩w
p�Ȥ���ۡA�ڵ�H1�A��ܼҫ��O�n��
�q108�Ӧ��Ĩ�10���ܼ�*/
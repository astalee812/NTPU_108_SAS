data ch7d1;
	do alc=1,0;
		do cig = 1,0;
			do mar = 1,0;
				input count @@;
			output;
		end;
	end;
end;
cards;
911 538 44 456
3 43 2 279
run;
/*independent model*/
proc genmod data=ch7d1;
class alc cig mar; 
model count=alc cig mar/dist=poisson link=log; /*poisson���t �ϥ�log���쵲���*/
run;

/*��ڿW�߼ҫ� marginal independent
AC M*/
proc genmod data=ch7d1;
class alc cig mar;
model count=alc cig mar alc*cig/dist=poi link=log;
run;
/*��ڿW�߼ҫ� marginal independent
AM C*/
proc genmod data=ch7d1;
class alc cig mar;
model count=alc cig mar mar*alc/dist=poi link=log;
run;
/*��ڿW�߼ҫ� marginal independent
MC A*/
proc genmod data=ch7d1;
class alc cig mar;
model count=alc cig mar mar*cig/dist=poi link=log;
run;

/*����W�߼ҫ� conditional independent
AC AM*/
proc genmod data=ch7d1;
class alc cig mar;
model count=alc cig mar alc*cig mar*alc/dist=poi link=log;
run;
/*����W�߼ҫ� conditional independent
AM MC*/
proc genmod data=ch7d1;
class alc cig mar;
model count=alc cig mar alc*mar mar*cig/dist=poi link=log;
run;
/*����W�߼ҫ� conditional independent
AC MC*/
proc genmod data=ch7d1;
class alc cig mar;
model count=alc cig mar alc*cig mar*cig/dist=poi link=log;
run;
/*���@���p�ҫ� homogeneous association
AC MC AM */
proc genmod data=ch7d1;
class alc cig mar;
model count=alc cig mar alc*cig mar*cig alc*mar /dist=poi link=log;
run;
/*���M�ҫ� Saturated */
proc genmod data=ch7d1;
class alc cig mar;
model count=alc cig mar alc*cig mar*cig alc*mar alc*cig*mar/dist=poi link=log;
run;

/*�p�G�q�W��U�V�ӶV�p�A��ܧڭ̪����p*/
/*
Model                    likehood(�V�j�V�n)              AIC-2(�V�p�V�n)        DF
Independent           11367.7894                              1343.0634				4=1+3(�ĪG��+�I�Z��)
AC-M                       11588.8861								902.8701			  5=1+3+1 (�ĪG��+�I�Z��+�椬�@�ζ�)
AM-C						11541.0181							    1028.6060 			5=1+3+1 
A-CM						11743.6935								623.2551			  5=1+3+1 
AC-AM                     11762.1147                              558.4127				6=1+3+2 
AM-MC					 11916.9222							  	248.7977			  6=1+3+2 
AC-MC					  11964.7902							  153.0618			   6=1+3+2 
AC MC AM			 12010.6124									63.4174				7=1+3+3	(��o��)
ACM							12010.7994							  	 65.0434			   8=1+3+3+1	

�C�W�[1�ۥѫ�
liklihood���e���@�ӻP�d��(1)=3.84�����  ****�ۥѫ�1���d���=3.84�o�ӰO�_��****

H0:simple model VS H1:Complex model

LR=-2logL0+2logL1
e.g.
H0: AM MC
H1: AC AM MC
LR=-2(11916.9222-12010.6124)>chi_1^2=3.84 Reject H0

�Q�γӺ��Ӹ���
alc*cig�Ӻ��
�Ӻ�pi(x)=p(c=1| a=x)/p(c=0| a=x))
�Ӻ��thita=pi(1)/pi(0)
log(thita)=lanya11+lanya22-lanya12-lanya21
=2.0545+0-0-0
thita=exp(2.0545)
���ܰs�������ͨ��Ҫ��Ӻ�O�S���ܰs��exp(2.0545)��
*/


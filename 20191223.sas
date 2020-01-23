/*independent model*/
proc genmod data= ch7d1;
class g i s;
model count=g i s / link=log dist=poisson;
run;
/*Marginal model*/
/*/GI S*/
proc genmod data= ch7d1;
class g i s;
model count=g i s g*i/ link=log dist=poisson;
run;
/*�o��h�[��!*/
/*Resid�p�G�O�t���A�N�O����!*/
/*Marginal model*/
/*/GI S*/
proc genmod data= ch7d1;
class g i s;
model count=g i s g*i/ link=log dist=poisson;
output out=gi_p p=pred resraw=resid; /*Resid = �Ӽ�-�w����*/
run;

/*Marginal model*/
/*/GS I*/
proc genmod data= ch7d1;
class g i s;
model count=g i s g*s/ link=log dist=poisson;
run;

/*Marginal model*/
/*/IS G*/
proc genmod data= ch7d1;
class g i s;
model count=g i s I*S/ link=log dist=poisson;
run;

/*�U�@�B�ڭ̸Ӥ��R���@�өO? �i�J��ڱ���*/
/*conditional model*/
/*GI IS*/
proc genmod data= ch7d1;
class g i s;
model count=g i s g*i i*s/ link=log dist=poisson;
run;
/*Homo*/
proc genmod data= ch7d1;
class g i s;
model count=g i s g*i i*s g*s/ link=log dist=poisson;
run;
/*�����ܼƦ�uniform���S��(���)�N�i�H�ϥ�*/
data ch7d1a;
set ch7d1;
si=s*i;  /*�h�@�Ӭۭ��ܼơA�N�i�H�إ߽u��by�u�ʼҫ�*/
run;
/*Linear by Linear model for IS---�u�ݭn�W�[�@�Ӧۥѫ״N�i�H����IS*/
/*�]��Model 5��IS���Ӧh�ۥѫ�! �ҥH�ڧ�IS�ۭ�! �ܦ��u�n�@�Ӧۥѫ�
BUT!!!! ���O�Ҧ��ܬ۳��i�H�ۭ��A�n�D��۪�!!!(�������???��Margin��model! GI�w�g���T�w�F! SI��AIC����n)
*/
proc genmod data= ch7d1a;
class g i s;
model count=g i s g*i si/ link=log dist=poisson;
run;


/*GI��IS����independent���n�AAIC�PıGI�|����n*/
/*   G_df = 2-1 = 1
Model                                  LogLinear                       AIC(�n�����)
1.Independent                       59.7620                           125.8676              df = 1+1+(4-1)+(4-1) = 8
2.Marginal GI*S                      66.0375                           119.3165              df = 8+(4-1) = 11
3.Marginal GS*I                      60.4144                           130.5627              df = 8+(4-1) = 11
4.Marginal SI*G                      66.4957                           130.4033              df = 8+(4-1)*(4-1) = 17
5.Conditional GI IS                 72.7712                           123.8492              df = 17+1*3 = 20
Homo ===> �o�Ӽҫ��S������! hessian not positive definite 
6.LL GI                                     70.0890                           113.2137              df = 11 (Model2+1=12)    

Model 4 vs Model 5 ===>   2(72.77 - 66.50) = 12.54  >  chisq(20-17) = 7.81  reject H0 (���Model 5����n)
Chisq(20 - 17) = 7.81===>�o�ӼƦr�O�d��Ӫ��A���df�۴�
Model 2 vs Model6 ===> 2(70.0890 - 66.0375) = 8.103 > chisq1^2 = 3.84 reject H0 (���Model 6����n)
Model 6 vs Model 5 ===>2(72.7712 - 70.0890) = 5.3644 < chisq8^2 = 15.50731 not reject H0 (���Model 6����n)
*/



/* cmh���G�ݭ���? (ch7 p62)
linear by linear �O�ݫD�s����  ---  �]���ۥѫפ���֡A�˩w�O�۹�]�|���@�I
���M�ҫ��O�ݤ@�����p��
�D�s���� tho = 0
�C�����޳N mu1 = mu2 = mu3
�@�����p��  r=0
*/
proc freq data=ch7d1;
weight count;
tables g*i*s/cmh;
run;

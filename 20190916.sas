data cancer;
input smoke cancer count;
cards;
1 1 688
1 0 650
0 1 21
0 0 59
run;

proc freq data=cancer;
weight count;  /*weight�O�[�v�A�̾�count�ӥ[�v*/
tables smoke*cancer;
run;
data mi;
input drug status count;
cards;
0 1 189
0 0 10845
1 1 104
1 0 10933
run;
proc freq data=mi;
weight count; /*�[�v*/
tables drug*status/riskdiff; /*���I���p��*/
run;
/*�j�˥����p*/
proc freq data=mi;
weight count; /*�[�v*/
tables drug*status/relrisk; /*�۹ﭷ�I*/   /*�Ĥ@�ӬO��A�ĤG�ӬO�C*/
run;
/*�d��W�ߩ��˩w*/
proc freq data=mi;
weight count; /*�[�v*/
tables drug*status/chisq expected; /*�d��*/   
run;
/**/
data alco;
input status alco count;
cards;
0 0 17066
0 0.5 14464
0 1.5 788
0 4 126
0 7 37
1 0 48
1 0.5 38
1 1.5 5
1 4 1
1 7 1
run;
/*�J�쵲�G�d��ȸ򷧫פ�d��ƭȤ��@�P�A��ܨ�d�観���D�O���ӯ�Ϊ�*/
proc freq data=alco;
weight count;
table status*alco/chisq expected;
run;

proc freq data=alco;
weight count;
table alco*status/measures;
run;



proc freq data=alco;
weight count;
table alco*status/measures scores=rank;
run;
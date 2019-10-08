/* practice ch2 P43.*/
data d2;
input school$ genic$ count;
cards;
1 1 90
1 2 12 
1 3 78
2 1 13
2 2 1
2 3 6
3 1 19
3 2 13
3 3 50
;
run;
proc freq data =  d2;
weight count;
table school * genic / chisq ;
run;
/*trend analysis*/
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
proc freq data=alco;
weight count;
table alco* status / trend;
run;
/*gamma analysis*/
/*���G : �`��gamma �� pearson�����A���S���ռơA�ݭn�ۤv��*/
data gamma;
do income=7.5,20,32.5,60;
 do sat =1 to 4;
  input count @@; /*@@�s���J������*/
  output;
 end;
end;
cards;
1 3 10 6
2 3 10 7
1 6 14 12
0 1 9 11
run;
proc freq data=gamma;
weight count;
table income*sat / measures;
run;
/*fisher test : �o�ӬO�����*/
/*exact �|�μƭ�*/
/*���G: �U������n(1,1)=3�����v*/
data tea;
input row column count;
cards;
0 0 3
0 1 1
1 0 1
1 1 3
run;
proc freq data=tea;
weight count;
table row*column / fisher exact;
run;
/**/
/*�Ĥ@�i�OCMH���˩w�A���󪺽u�ʬ����O�_�s�b*/
/*�ĤG�i�O�C�C�������t���A���P��ANOVA�A�º鰵���p*/
		/*������o�i���Ʀr���@��? �]���ڭ̬O2*2����ơA�ҥH���X�Ӫ����G�|�ۦP*/
/*�ĤT�i�O�˴����S���P���! Breslow Day test*/
/*�o�䪺�Ӻ��ڬݤ�����...*/
data penalty;
do vrace=0 to 1 ;
	do drace=0 to 1 ;
		do death = 0 to 1;
			input count@@;
			output;
		end;
	end;
end;
cards;
414 53 37 11 16 0 139 4
run;
proc freq data=penalty; weight count; tables vrace*drace*death / cmh ; run;
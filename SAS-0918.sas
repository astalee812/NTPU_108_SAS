/*�º��J�|�]���r�������ɭP�r�Q����*/
data ds10a;
input name $ age award $ 30. bpalce $ lang $30. wight hight; /*�ܼƭY����r�A�h�n�b�ܼƫ᭱�[�W"$"�A�r���Ƴ]�w�h�O�b$��[�J�ݭn���r����*/
cards;
�d�B��  33       ��51���k�D����
����  ���x�ȭ^�y
57  177
�_����    31       ��51���k�D����
�x�_  ���x�^��y
43   166
run;
/*���ƦL�X��*/
proc print data=ds10a;
run;
/*�D�ܼƥhŪ�����*/
data ds10a;
input #1 name $ age #3 wight hight; /* #�O�ΨӰ������쪺�Ÿ� */
cards;
�d�B��  33       ��51���k�D����
����  ���x�ȭ^�y
57  177
�_����    31       ��51���k�D����
�x�_  ���x�^��y
43   166
run;
/*���ƦL�X��*/
proc print data=ds10a;
run;
/* */
data ds10a;
input name$ age award $ 30.
					/bplace $ lang $ 30.
					/wight hight;
cards;
�d�B��  33       ��51���k�D����
����  ���x�ȭ^�y
57  177
�_����    31       ��51���k�D����
�x�_  ���x�^��y
43   166
run;
/*���ƦL�X��*/
proc print data=ds10a;
run;
/* */
data ds10a;
input name$ age award $ 30. bplace $ lang $ 30. wight hight @@;
cards;
�d�B��  33       ��51���k�D����
����  ���x�ȭ^�y
57  177
�_����    31       ��51���k�D����
�x�_  ���x�^��y
43   166
run;

 /*�ϥθ��|���覡����Ū�J*/
data ds1;
infile "C:\Users\ASUS\Downloads\statpack104fch1d1.dat";
input trt mi counts;
run;
proc print data =  ds1;
run;

/* ��r�ɦ��r���۹j�A�ϥ�delimiter��dlm�B�z */
data ch1d5;
infile "C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��\statpack104fch1d5.dat" delimiter=",";
input id $ grade1 grade2 grade3 grade4;
proc print; run;

/* ���|�Ӫ��i�H�ϥ�%let�R�W�A�H�᳣�i�H�γo�Ӹ��| */
%let indir = C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��; /*indir�i�H�ۤv�]�w�n�Τ���r*/
data ch1d5;
infile "&indir\statpack104fch1d5.dat" dlm=",";
input id $ grade1 grade2 grade3 grade4;
run;
proc print; run;
/*���w�q�ĴX�Ӷ}�lŪ��*/
data ch1d6;
infile "C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��\statpack104fch1d6.txt" firstobs=40; 
input  FTP UEMP MAN LIC GR CLEAR WM NMAN GOV HE WE HOM ACC ASR @@;
run;
proc print; run;




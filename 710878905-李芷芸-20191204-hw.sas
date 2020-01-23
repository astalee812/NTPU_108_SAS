/*-- 1 --*/
%let indir=C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��;
proc import datafile="&indir\statpack104fch4d4.xls" out=ch4d4
    dbms=excel replace;
getnames=yes;
run;
proc print data=ch4d4;
run;

data ch4d4_1;
set ch4d4 (drop=F:);
run;
proc print data=ch4d4_1;
run;
proc freq data=ch4d4_1; 
run;

data ch4d4_2;
set ch4d4_1;
if ��ı�ɶ� = '�C�ѺΨ�7~8�p��' then v1 = 1;
else if ��ı�ɶ� = '����7~8�p��' then v1 = 2;
else v1 = 3;

if ���\�ߺD = '�C�ѦY' then v2 = 1;
else if ���\�ߺD = '����' then v2 = 2;
else v2 = 3;

if �C�g�B�ʢ��� = '��' then v3 = 1;
else v3 = 2;

if �l�ҲߺD = '���l��' then v4 = 1;
else if �l�ҲߺD = '�l��' then v4 = 2;
else if �l�ҲߺD = '�l�Ҭ�5��/��' then v4 = 3;
else if �l�ҲߺD = '�l�Ҭ�15��/��' then v4 = 4;
else v4 =5;

if '�`ı�o�J�{.�~�{��?' = '�ܤ֩ΨS��' then v5 = 1;
else if '�`ı�o�J�{.�~�{��?' = '����' then v5 = 2;
else v5 = 3;

if '�`ı�o�ݴe��?' = '�ܤ֩ΨS��' then v6 = 1;
else v6 = 2;

if '�`��ı�o�G�h��?' = '�ܤ֩ΨS��' then v7=1;
else if '�`��ı�o�G�h��?' = '����' then v7 = 2;
else v7 = 3;

if '�`��ı�o�Y�h��?' = '�ܤ֩ΨS��' then v8 = 1;
else if '�`��ı�o�Y�h��?' = '����' then v8 = 2;
else v8 = 3;

if �ۧڰ��d���� = '�D�`�n' then v9 = 1;
else if �ۧڰ��d���� = '�y�L�n' then v9 = 2;
else if �ۧڰ��d���� = '�S���t�O' then v9 = 3;
else if �ۧڰ��d���� = '�y�L�t' then v9 = 4;
else v9 = 5;

score = sum(of v1-v8);
if score  <= 11 then risk = 1;
else if score <= 15 then risk = 2;
else risk = 3;
label risk = '�M�I�{��' v9 = '�ۧڰ��d����';
run;
proc format;
value v9f 1='�D�`�n' 2='�y�L�n' 3='�S���t�O' 4='�y�L�t' 5='�D�`�t';
value riskf 1='�C' 2='��' 3='��';
run;
proc freq data=ch4d4_2;
tables v9*risk;
format v9 v9f. risk riskf.;
run;

/*-- 2 --*/
proc import datafile="&indir\statpack104fch4d6.xls" out=ch4d6
    dbms=excel replace;
getnames=yes;
run;
proc print data=ch4d6(obs=5);
run;

data ch4d6_1;
set ch4d6;

v31=index( '�t��'n , '�t');
v32=index( '�t��'n , '�Z');

 if v32>0 then F3=substr( '�t��'n , 1 , index( '�t��'n , '�Z')+1);
else if v31>0 then F3=substr( '�t��'n , 1 , index( '�t��'n , '�t')+1);

if index(v5,'%��Ŧ�f%') > 0 then F5a = 1 ;
else F5a = 0;
if index(v5,'%�}���f%') > 0 then F5b = 1 ;
else F5b = 0;
if index(v5,'%������%') > 0 then F5c = 1 ;
else F5c = 0;

if index(v6,'%�L��%') > 0 then F6 = 1 ;else F6 = 0;

if �l�ҲߺD = '���l��' then F7=0;
else if �l�ҲߺD = "�l�Ҭ�1��/��" then F7=1;
else if �l�ҲߺD = "�l�Ҭ�2��/��" then F7=1;
else if �l�ҲߺD = "�l�Ҭ�3��/��" then F7=1;
else if �l�ҲߺD = "�l�Ҭ�4��/��" then F7=1;
else if �l�ҲߺD = "�l�Ҭ�5��/��" then F7=2;
else if �l�ҲߺD = "�l�Ҭ�6��/��" then F7=2;
else if �l�ҲߺD = "�l�Ҭ�7��/��" then F7=2;
else if �l�ҲߺD = "�l�Ҭ�8��/��" then F7=2;
else if �l�ҲߺD = "�l�Ҭ�10��/��" then F7=2;
else if �l�ҲߺD = "�l�Ҭ�15��/��" then F7=2;
else if �l�ҲߺD = "�l�Ҭ�20��/��" then F7=2;
else if �l�ҲߺD = "�l�Ҭ�40��/��" then F7=2;
else F7=3;
run;
proc freq data=ch4d6_1;
tables F5a*F7 F5b*F7 F5c*F7;
run;

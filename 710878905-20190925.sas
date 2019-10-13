%let indir=F:\Google ���ݵw��\�έp�M�˳n��\web\dataset\chapter1;

data ch1d6;
infile "&indir\statpack104fch1d6.txt" obs=65 firstobs=40;
input #1 ftp uemp man lic gr clear wm nman gov he
        #2  we hom acc asr;
label ftp="�C 100,000 �H����¾ĵ��e����v"
		uemp="���~�v"
		man="�C�d�H���b�s�y�~���H��"
		lic="�C 100,000 �H����j���Ӫ���v"
		gr="�C 100,000 �H�֦���j����v"
		clear="���}�ת������פ��"
		wn="�դH�����"
		nman="�C�d�H���b�D�s�y�~����v"
		gov="�C�d�H���b�D�s�y�~����v"
		he="�������~"
		we="�����P�~"
		hom="�C 100,000 �H�����ץe����v"
		acc="�C 100,000 �H�N�~���`�e����v"
		asr="�C 100,000 �Hŧ���ץe����v";
run;

proc print data=ch1d6 label; run;
proc print data=ch1d6; run;
proc print data=ch1d6 (obs=2) label;
proc print data=ch1d6;
label wm="����";
format he dollar6.2 we dollar6.1;
run;
/*input �w�]flowover�A�Y�ܬۨS���o��ȡA�|�������U�@�檺�Ĥ@�C�}�lŪ���A�ӥR��ӯʥ������*/
data ch1d7;
infile "C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��\statpack104fch1d7.txt" truncover;
input customer 7-14 state $ 15-16 zipcode 17-21 
        country $ 22-41 tel $ 42-53
        name $ 54-107;
run;
proc print data=ch1d7; run;
/*misscover : sets all empty vars to missing when reading a short line. it can also skip value*/
/*�ϥ�missover, input ���w���|����U�@���Ū����ơA�|���S���ƾڪ��ܬ۫K�ʥ�*/
/*²�����A�۰ʸɤW�򥢭ȡA��binfile����N�n*/
/*firstobs = 1�A���*/
/*obs = 20�A��ܭn��20�Ӹ�ƭȨӬ�*/
data ch1d7;
infile "C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��\statpack104fch1p1-1a.txt" firstobs=1 obs=20 missover;
input year 1-4 ServicesPolice $ 7-11 ServicesFire $ 15-19 ServicesWater $ 22-26 
  AdminLabor 30-32 AdminSupplies 39-40 AdminUtilities 46-47 ;
run;
/*Ū�J�ɮ�*/
/*dbm = csv, ��ܫ��w�S�w����ɮ�*/
proc import datafile="C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��\project\statpack104fHW3_1.csv"
	out=bank1 dbms=csv replace; /*replace��ܤ@���@��Ū*/
	getnames=yes; /*�p�G��ƨS�����W��! ���n�Uyes*/
	run;
proc print data=bank1(obs=10);run; /*obs=10��10���X�Ӭ�*/
/*�C�s��*/
proc freq data=bank1;
table edlevel*gender;
run;

proc freq data=bank1;
table gender*edlevel;
run;

proc means data=bank1;
var salbeg age salnow work;
run;


data ch1d8;
infile "&indir\statpack104fch1d8.txt";
input nm $ 7-11 cnm $ 12-19 sum 20-32 
        city $ 33-41 pre 42-53 
        wnm $ 54-58 @59 sd date9. @68 date date9. ;
label nm="�q��s��"
        cnm="�U�Ƚs��"
        sum="�`���B"
        city="��a�Φ{"
        pre="�q��"
        wnm="�t�d¾���s��"
        sd="�b��H�X���"
        date="ú����";
run;

input id $ salbeg age salnow edlevel work jobscat minority gender $;
run;
/*Ū�Jexcel��*/
proc import datafile="C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��\statpack104fch1d9.xls"
out=bank2 dbms=excel replace;
sheet="sheet1";
getnames=yes;
run;
proc print data=bank2;run;

proc import datafile="C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��\statpack104fch1p2-1b.xlsx"
out=bank3 dbms=xlsx replace;
sheet="statpack102fch1p2-1";
getnames=no;
run;
proc print data=bank3(obs=10);run;
/*SQL����case when, ���Ƨ�W��*/
proc print data=bank1(obs=10);
format jobcat jobscatf. gender $genderf. sagbeg  salnow dollar10.;
run;
proc format;
value jobscatf
	1 = "���ȭ�" 2 = "�Ȧ�M��" 3 = "�O��" 4= "��ߥ�"
	5 = "�����H��" 6 = "�Ѯv" 7 = "�u�{�v";
value $genderf "�k" = 1 "�k"=0;
run;

proc print data=bank1(obs=10);
ods select variable;
run;
/*�|��X���W�١ASAS�|���ګܦh���! �ڦb�W��ods select ��ڭn�o�F��*/
ods trace on; 
/*�粒����O�o�n���_��*/
ods trace off; 
proc contents data=bank1;
run;

data bank4;
set bank1;
format jobcat jobscatf. gender $genderf. sagbeg  salnow dollar10.;
run;
proc print data=bank4;
ods select variable;
run;
/*���qD��!! �q�q�q�q�q!!*/
libname spdata "D://";
data spdata.bank4;
set bank1;
format jobcat jobscatf. gender $genderf. sagbeg  salnow dollar10.;
run;





%let indir=C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��;
proc import datafile="&indir\statpack104fch4d2.xlsx" 
	out=press dbms=xlsx replace;
getnames=yes;
run;
data press;
set press;
rename ���d�s��=id �ʧO=gender ����=ht �魫=wt;
label sbp="���Y��" dbp="�αi��" wbc="�զ�y�Ӽ�" rbc="����y�Ӽ�" hb="�����"
		hct="���e" mcv="��������y��n" mch="����������q";
run;

data press1;
set press;
if (gender = '�k' and (hb > 18)) then hb1 = "�L��";
if (gender = '�k' and (12<= hb <= 18 )) then hb1 = "���`";
if (gender = '�k' and (hb < 12) ) then hb1 = "�L�C";
if (gender = '�k' and (hb > 18)) then hb1 = "�L��";
if (gender = '�k' and (11.5<= hb <= 18 )) then hb1 = "���`";
else if (gender = '�k' and (hb < 11.5) ) then hb1 = "�L�C";
if (gender = '�k' and (hct > 56)) then hct1 = "�L��";
if (gender = '�k' and (38<= hct <= 56 )) then hct1 = "���`";
if (gender = '�k' and (hct < 38)) then hct1 = "�L�C";
if (gender = '�k' and (hct > 48)) then hct1 = "�L��";
if (gender = '�k' and (35<= hct <= 48 )) then hct1 = "���`";
else if (gender = '�k' and (hct < 48) ) then hct1 = "�L�C";
if (gender = '�k' and (rbc > 6.30)) then rbc1 = "�L��";
if (gender = '�k' and (4.50<= rbc <= 6.30 )) then rbc1 = "���`";
if (gender = '�k' and (rbc < 4.50)) then rbc1 = "�L�C";
if (gender = '�k' and (rbc > 4.00)) then rbc1 = "�L��";
if (gender = '�k' and (4.00<= rbc <= 5.50 )) then rbc1 = "���`";
else if (gender = '�k' and (rbc < 5.50)) then rbc1 = "�L�C";
proc print data = press1;
run;

proc freq data=press1;
table gender*hb1;
run;

proc freq data=press1;
table gender * hct1;
run;

proc freq data=press1;
table gender * rbc1;
run;
proc import datafile="C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��\statpack104fHW4.xlsx"out=heart
dbms=xlsx replace;
getnames=no;	
run;
proc print;run;

data heart;
set heart;
label A="�s��"   B ="�~��"
		C="�ʧO"  D="�ٶt�J��"
		E="������"     F="�}���f"
        G="�l�Ҫ��p" H="�\���������";
run;
proc print data=heart (obs=10) label;
run;
proc format;
value Cf 1="�k��" 2="�k��";
value Ef  0="�S��" 1="��";
value Ff 0="�S��" 1="��";
value Gf 0="�S��" 1="��";
run;
proc print data=heart (obs=10) label;
format C Cf. E Ef. F Ff. G Gf.;
run;

proc tabulate data=heart;
format C Cf. E Ef. F Ff. G Gf.;
class C E;
var D;
tables C, E*D*(mean='������' std="�зǮt"); 
run;


proc tabulate data=heart;
format C Cf. E Ef. F Ff. G Gf.;
class C E;
var D;
tables C, E*D*(mean='������' std="�зǮt") all=""*D=""*(mean='������' std="�зǮt");
run;

proc tabulate data=heart;
format C Cf. E Ef. F Ff. G Gf.;
class C G E;
var D;
tables C*G, E*D*(mean='������' std="�зǮt") all=""*D=""*(mean='������' std="�зǮt"); 
run;



/*�ץXpdf*/
ODS PDF file="C:\Users\ASUS\Desktop\1016hw.pdf";
proc tabulate data=heart;
format C Cf. E Ef. F Ff. G Gf.;
class C E;
var D;
tables C, E*D*(mean='������' std="�зǮt"); 
run;
proc tabulate data=heart;
format C Cf. E Ef. F Ff. G Gf.;
class C E;
var D;
tables C, E*D*(mean='������' std="�зǮt") all=""*D=""*(mean='������' std="�зǮt");
run;
proc tabulate data=heart;
format C Cf. E Ef. F Ff. G Gf.;
class C G E;
var D;
tables C*G, E*D*(mean='������' std="�зǮt") all=""*D=""*(mean='������' std="�зǮt"); 
run;

ODS PDF close

data ch1d10;
infile"C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��\statpack104fch1d10.txt";
input name $17. id$ sal 6. district$ hiredate date7.;
label name="�m�W" id="���u�N�X" sal="�_�~"
    district="�ϰ�N�X" hiredate="�_�u���";
run;
proc print; run;
proc format;
value $district	"BR1"="Birmingham UK"
    					"BR2"="Plymouth UK"
    					"BR3"="York UK"
    					other="Incorrect code";
run;
proc print; run;
data ch1d10a;
set ch1d10;
rename sal=salary;
format hiredate mmddyy10. sal dollar10. district districtf.;
run;
proc print; run;

			1="�ѰO" 2="�줽�ǤuŪ��" 3="�O��" 4="�j�ǹ�ߥ�" 
			5-7="�䥦";
    value minorityf  
			0="�դH" 1="��L";
run;


data bank1;
set bank;
keep id salseg;
label id="�s��" salbeg="�_�~" age="�~��" 
		salnow="�{�b���~��" edlevel="�Ш|�{��" work="�u�@�g��" 
		jobscat="�u�@����" minority="�ر�" gender="�ʧO";
format jobscat jobscatf. age 10. salbag dollar10. salnow dollar10.;
run;
proc print data=bank1 label; run;

proc freq data=bank1;
table jobcat;
run;

proc sort data=bank1 out=bank2;
by salbeg descending salnow;
/*by descending salbeg salnow */
run;
data bank3;
set bank1;
obs=_n_;/*obs���[�b�᭱*/
run;
proc print data=bank4;run;

proc sort data=bank1 out=bank1a;
by jobcat minority gende;/*jobcat ���ƧǦA�� minority�ƧǦA�� gende�Ƨ�*/
proc print data=bank1a ;run;

proc sort data=bank1 out=bank1b nodupkey; /*nodupkey: ����SQL��distinct*/
by jobcat minority gende;
run;
proc print data=bank1b; run;

/*jobcat ���ƧǦA�� minority�ƧǦA�� gende�Ƨ�*/
proc print data=bank1a ;run;

proc freq data=data1;
table jobcat*minirity*gender;
run;

data car;
set car;
 label make="����"   cylinders="�T��"
		model="����"  horsepower="���O"
		type="����"     mpg_city="�@��D�����o��"
        origin="�Ͳ��ϰ�" mpg_highway="�ֳt�D�����o��"
        drivetrain="�ʤO�ǰʨt��" weight="���q"
        msrp="�s�����" wheelbase="����"
        invoice="��X����"  length="����" enginesize="����";
format invoice dollar 12.;
run;
proc freq data=cars;
table drivetrain*origin;
run;
proc print data=car1(obs=20); run;

proc export data= car2 outfile="C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��\ex1.xls"
			dbms=excel label replace;
sheet="xls";
run;

proc print data=car label;
by drivertain*origin;
run;

proc print data=car label sumlabel;
by origin drivetrain;
pageby drivetrain;
var model tyep invoice mpg_city;
sum invoice;
run;

ods pdf file="C:\Users\ASUS\Desktop\NTPU\108-1-�έp�M�˳n��\test.pdf";
ods pdf close;

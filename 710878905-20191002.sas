
data ch1d10;
infile"C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\statpack104fch1d10.txt";
input name $17. id$ sal 6. district$ hiredate date7.;
label name="姓名" id="員工代碼" sal="起薪"
    district="區域代碼" hiredate="起聘日期";
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

			1="書記" 2="辦公室工讀生" 3="保全" 4="大學實習生" 
			5-7="其它";
    value minorityf  
			0="白人" 1="其他";
run;


data bank1;
set bank;
keep id salseg;
label id="編號" salbeg="起薪" age="年齡" 
		salnow="現在的薪水" edlevel="教育程度" work="工作經驗" 
		jobscat="工作類型" minority="種族" gender="性別";
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
obs=_n_;/*obs欄位加在後面*/
run;
proc print data=bank4;run;

proc sort data=bank1 out=bank1a;
by jobcat minority gende;/*jobcat 先排序再換 minority排序再換 gende排序*/
proc print data=bank1a ;run;

proc sort data=bank1 out=bank1b nodupkey; /*nodupkey: 類似SQL的distinct*/
by jobcat minority gende;
run;
proc print data=bank1b; run;

/*jobcat 先排序再換 minority排序再換 gende排序*/
proc print data=bank1a ;run;

proc freq data=data1;
table jobcat*minirity*gender;
run;

data car;
set car;
 label make="車款"   cylinders="汽缸"
		model="車型"  horsepower="馬力"
		type="車種"     mpg_city="一般道路的油耗"
        origin="生產區域" mpg_highway="快速道路的油耗"
        drivetrain="動力傳動系統" weight="重量"
        msrp="零售價格" wheelbase="輪圈"
        invoice="賣出價格"  length="長度" enginesize="引擎";
format invoice dollar 12.;
run;
proc freq data=cars;
table drivetrain*origin;
run;
proc print data=car1(obs=20); run;

proc export data= car2 outfile="C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\ex1.xls"
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

ods pdf file="C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\test.pdf";
ods pdf close;

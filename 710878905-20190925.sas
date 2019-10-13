%let indir=F:\Google 雲端硬碟\統計套裝軟體\web\dataset\chapter1;

data ch1d6;
infile "&indir\statpack104fch1d6.txt" obs=65 firstobs=40;
input #1 ftp uemp man lic gr clear wm nman gov he
        #2  we hom acc asr;
label ftp="每 100,000 人中全職警察占的比率"
		uemp="失業率"
		man="每千人中在製造業的人數"
		lic="每 100,000 人有手槍執照的比率"
		gr="每 100,000 人擁有手槍的比率"
		clear="有破案的凶殺案比例"
		wn="白人的比例"
		nman="每千人中在非製造業的比率"
		gov="每千人中在非製造業的比率"
		he="平均時薪"
		we="平均周薪"
		hom="每 100,000 人兇殺案占的比率"
		acc="每 100,000 人意外死亡占的比率"
		asr="每 100,000 人襲擊案占的比率";
run;

proc print data=ch1d6 label; run;
proc print data=ch1d6; run;
proc print data=ch1d6 (obs=2) label;
proc print data=ch1d6;
label wm="測試";
format he dollar6.2 we dollar6.1;
run;
/*input 預設flowover，若變相沒有得到值，會直接跳下一行的第一列開始讀取，來充當該缺失的資料*/
data ch1d7;
infile "C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\statpack104fch1d7.txt" truncover;
input customer 7-14 state $ 15-16 zipcode 17-21 
        country $ 22-41 tel $ 42-53
        name $ 54-107;
run;
proc print data=ch1d7; run;
/*misscover : sets all empty vars to missing when reading a short line. it can also skip value*/
/*使用missover, input 指針不會跳到下一行來讀取資料，會讓沒有數據的變相便缺失*/
/*簡言之，自動補上遺失值，放在infile那行就好*/
/*firstobs = 1，表示*/
/*obs = 20，表示要抓20個資料值來看*/
data ch1d7;
infile "C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\statpack104fch1p1-1a.txt" firstobs=1 obs=20 missover;
input year 1-4 ServicesPolice $ 7-11 ServicesFire $ 15-19 ServicesWater $ 22-26 
  AdminLabor 30-32 AdminSupplies 39-40 AdminUtilities 46-47 ;
run;
/*讀入檔案*/
/*dbm = csv, 表示指定特定資料檔案*/
proc import datafile="C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\project\statpack104fHW3_1.csv"
	out=bank1 dbms=csv replace; /*replace表示一筆一筆讀*/
	getnames=yes; /*如果資料沒有欄位名稱! 不要下yes*/
	run;
proc print data=bank1(obs=10);run; /*obs=10取10筆出來看*/
/*列連表*/
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
label nm="訂單編號"
        cnm="顧客編號"
        sum="總金額"
        city="國家或州"
        pre="訂金"
        wnm="負責職員編號"
        sd="帳單寄出日期"
        date="繳交日期";
run;

input id $ salbeg age salnow edlevel work jobscat minority gender $;
run;
/*讀入excel檔*/
proc import datafile="C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\statpack104fch1d9.xls"
out=bank2 dbms=excel replace;
sheet="sheet1";
getnames=yes;
run;
proc print data=bank2;run;

proc import datafile="C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\statpack104fch1p2-1b.xlsx"
out=bank3 dbms=xlsx replace;
sheet="statpack102fch1p2-1";
getnames=no;
run;
proc print data=bank3(obs=10);run;
/*SQL中的case when, 把資料改名稱*/
proc print data=bank1(obs=10);
format jobcat jobscatf. gender $genderf. sagbeg  salnow dollar10.;
run;
proc format;
value jobscatf
	1 = "公務員" 2 = "銀行專員" 3 = "保全" 4= "實習生"
	5 = "約僱人員" 6 = "老師" 7 = "工程師";
value $genderf "男" = 1 "女"=0;
run;

proc print data=bank1(obs=10);
ods select variable;
run;
/*會輸出表格名稱，SAS會給我很多表格! 我在上面ods select 選我要得東西*/
ods trace on; 
/*選完之後記得要關起來*/
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
/*直通D槽!! 吼吼吼吼吼!!*/
libname spdata "D://";
data spdata.bank4;
set bank1;
format jobcat jobscatf. gender $genderf. sagbeg  salnow dollar10.;
run;





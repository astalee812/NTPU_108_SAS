/*1*/
proc import datafile='C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\member.xls' out=ds0
dbms=excel replace;
range="LMS$A3:D87";
getnames=no;
run;
proc print data=ds0;run;

proc import datafile='C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\微積分 Calculus_191127.xls' out=ds1
dbms=excel replace;
range="XMS$A3:G67";
getnames=no;
run;
proc print data=ds1;run;

proc import datafile='C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\微積分 Calculus_191211.xls' out=ds2
dbms=excel replace;
range="XMS$A3:G67";
getnames=no;
run;
proc print data=ds2;run;

data ds1a;
set ds1(keep=F3 F6 F7);
rename F3=F1 F6=A1 F7=A2;
time1=input(substr(F6,12,2),2.);
run;
proc print data=ds1a;
run;

data ds2a;
set ds2(keep=F3 F6 F7);
rename F3=F1 F6=A3 F7=A4;
time2=input(substr(F6,12,2),2.);
run;
proc print data=ds2a;
run;

/*要merge by的變數(F1)，資料集都要先porc sort過，不然沒辦法跑*/
proc sort data=ds0;
by f1;
run;
proc sort data=ds1a;
by f1;
run;
proc sort data=ds2a;
by f1;
run;

data dsm;
merge ds0(in=a) ds1a(in=b) ds2a(in=c);
by F1;
flag0=a;
flag1=b;
flag2=c;
run;
proc print data=dsm;run;
/*兩週都沒來的*/
proc print data=dsm;
where (flag1 =0 or time1>=12) and (flag2=0 or time2 >=12);
run; 

/*第一週沒來的*/
proc print data=dsm;
where (flag1 =0 or time1 >=12) and (flag2=1 and time2 <12);
run; 

/*第二週沒來的*/
proc print data=dsm;
where (flag1 =1 and time1 <12) and (flag2=0 or time2 >=12) ;
run; 



/*2-1*/
proc import datafile='C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\statpack104fHW7a.xls' out=hw7a
dbms=excel replace;
range="P6A$A2:E101";
getnames=no;
run;
proc print; run;

proc import datafile='C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\statpack104fHW7b.xls' out=hw7b
dbms=excel replace;
range="HW6B$A2:K50";
getnames=no;
run;
proc print; run;

proc import datafile='C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\statpack104fHW7c.xls' out=hw7c
dbms=excel replace;
range="HW6C$A2:K50";
getnames=no;
run;
proc print; run;

/*2-2*/
data hw7a1;
set hw7a;
if (f2=1 or f3=1 or f4=1) then q4_1 = 1 ; else q4_1 = 0;
if (f2=2 or f3=2 or f4=2) then q4_2 = 1; else q4_2 = 0;
if (f2=3 or f3=3 or f4=3) then q4_3 = 1; else q4_3 = 0;
if (f2=4 or f3=4 or f4=4) then q4_4 = 1; else q4_4 = 0;
if (f2=5 or f3=5 or f4=5) then q4_5 = 1; else q4_5 = 0;
if (f2=6 or f3=6 or f4=6) then q4_6 = 1; else q4_6 = 0;
if (f2=7 or f3=7 or f4=7) then q4_7 = 1; else q4_7 = 0;
if (f2=8 or f3=8 or f4=8) then q4_8 = 1; else q4_8 = 0;
q4_tatal = sum(q4_1,q4_2,q4_3,q4_4,q4_5,q4_6,q4_7,q4_8);
if (scan(f5,1,";")="") then f5_1 = 0; else f5_1 = scan(f5,1,";");
if (scan(f5,2,";")="") then f5_2 = 0; else f5_2 = scan(f5,2,";");
if (scan(f5,3,";")="") then f5_3 = 0; else f5_3 = scan(f5,3,";");
if (f5_1=1 or f5_2=1 or f5_3 = 1) then q2_1 = 1; else q2_1 = 0;
if (f5_1=2 or f5_2=2 or f5_3 = 2) then q2_2 = 1; else q2_2 = 0;
if (f5_1=3 or f5_2=3 or f5_3 = 3) then q2_3 = 1; else q2_3 = 0;
if (f5_1=4 or f5_2=4 or f5_3 = 4) then q2_4 = 1; else q2_4 = 0;
if (f5_1=5 or f5_2=5 or f5_3 = 5) then q2_5 = 1; else q2_5 = 0;
if (f5_1=6 or f5_2=6 or f5_3 = 6) then q2_6 = 1; else q2_6 = 0;
if (f5_1=7 or f5_2=7 or f5_3 = 7) then q2_7 = 1; else q2_7 = 0;
if (f5_1=8 or f5_2=8 or f5_3 = 8) then q2_8 = 1; else q2_8 = 0;
if (f5_1=9 or f5_2=9 or f5_3 = 9) then q2_9 = 1; else q2_9 = 0;
if (f5_1=10 or f5_2=10 or f5_3 = 10) then q2_10 = 1; else q2_10 = 0;
if (f5_1=11 or f5_2=11 or f5_3 = 11) then q2_11 = 1; else q2_11 = 0;
if (f5_1=12 or f5_2=12 or f5_3 = 12) then q2_12 = 1; else q2_12 = 0;
if (f5_1=13 or f5_2=13 or f5_3 = 13) then q2_13 = 1; else q2_13 = 0;
run;
proc print data=hw7a1;run;

/*2-3*/
proc print data=hw7b; run;
proc print data=hw7c; run;
data hw7b1;
set hw7b;
array sss{9} f3 - f11;
array aaa{9} q9_1 - q9_9;
do i = 1 to 9;
if sss{i}="A" then aaa{i} = 5;
else if sss{i} = "B" then aaa{i} = 4;
else if sss{i} = "C" then aaa{i} = 3;
else if sss{i} = "D" then aaa{i} = 2;
else if sss{i} = "E" then aaa{i} = 1;
else aaa{i} = 0;
end;
proc print data=hw7b1;

data hw7b2;
set hw7b1;
drop i;
q9_total = sum(q9_1,q9_2,q9_3,q9_4,q9_5,q9_6,q9_7,q9_8,q9_9);
if f2 = 1 then expense ="1000元以下"; else expense = "其他";
proc print data=hw7b2; run;

data hw7c1;
set hw7c;
array sss{9} f3 - f11;
array aaa{9} q9_1 - q9_9;
do i = 1 to 9;
if sss{i}="A" then aaa{i} = 5;
else if sss{i} = "B" then aaa{i} = 4;
else if sss{i} = "C" then aaa{i} = 3;
else if sss{i} = "D" then aaa{i} = 2;
else if sss{i} = "E" then aaa{i} = 1;
else aaa{i} = 0;
end;
proc print data=hw7c1;

data hw7c2;
set hw7c1;
drop i;
q9_total = sum(q9_1,q9_2,q9_3,q9_4,q9_5,q9_6,q9_7,q9_8,q9_9);
if f2 = 1 then expense ="1000元以下"; else expense = "其他";
proc print data=hw7c2; run;


/*2-4*/
/*題目上寫第二題跟第三題合併---很怪!題目出錯了?*/
proc print data=hw7a1; run;
proc print data=hw7b2; run;
proc print data=hw7c2; run;
proc sort data=hw7b2;
by f1;
run;
proc sort data=hw7c2;
by f1;
run;
data hw7com;
merge hw7b2(in=b) hw7c2(in=c);
by f1;
flag2 = b;
flag3 = c;
run;
/*編號一致*/
proc print data=hw7com;
where (flag1= 1 and flag2 = 1) ;
run;
/*編號不一致*/
proc print data=hw7com;
where (flag1= 1 or flag2 = 1) ;
run;

/*2-4題目我換成第一題跟第二根三題的合併*/
proc print data=hw7a1; run;
proc print data=hw7b2; run;
proc print data=hw7c2; run;

data hw7a2;
set hw7a1;
drop f2 f3 f4 f5;
run;
data hw7b3;
set hw7b2;
drop f3 f4 f5 f6 f7 f8 f9 f10 f11;
run;
data hw7c3;
set hw7c2;
drop f3 f4 f5 f6 f7 f8 f9 f10 f11;
run;

proc sort data=hw7a2;
by f1;
run;
proc sort data=hw7b3;
by f1;
run;
proc sort data=hw7c3;
by f1;
run;

data hw7com;
merge hw7a2(in=a) hw7b3(in=b) hw7c3(in=c);
by f1;
flag1 = a;
flag2 = b;
flag3 = c;
run;
/*編號不一致*/
proc print data=hw7com;
where flag1 = 0 or (flag2 = 0 and flag3 = 0);
run;
/*編號一致*/
proc print data=hw7com;
where flag1 = 1 and (flag2 = 1 or flag3 = 1);
run;

/*2-5*/
proc freq data=hw7com;
table expense;
where q4_1 = 1 ;
run;
proc print data=hw7com; run;


/*2-6  我不會畫直方圖...我都用EG拉的*/
/*2-7*/
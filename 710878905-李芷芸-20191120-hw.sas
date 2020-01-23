%let indir=C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體;
proc import datafile="&indir\statpack104fch4d2.xlsx" 
	out=press dbms=xlsx replace;
getnames=yes;
run;
data press;
set press;
rename 健康編號=id 性別=gender 身高=ht 體重=wt;
label sbp="收縮壓" dbp="舒張壓" wbc="白血球個數" rbc="紅血球個數" hb="血紅素"
		hct="血比容" mcv="平均紅血球體積" mch="平均血紅素量";
run;

data press1;
set press;
if (gender = '男' and (hb > 18)) then hb1 = "過高";
if (gender = '男' and (12<= hb <= 18 )) then hb1 = "正常";
if (gender = '男' and (hb < 12) ) then hb1 = "過低";
if (gender = '女' and (hb > 18)) then hb1 = "過高";
if (gender = '女' and (11.5<= hb <= 18 )) then hb1 = "正常";
else if (gender = '女' and (hb < 11.5) ) then hb1 = "過低";
if (gender = '男' and (hct > 56)) then hct1 = "過高";
if (gender = '男' and (38<= hct <= 56 )) then hct1 = "正常";
if (gender = '男' and (hct < 38)) then hct1 = "過低";
if (gender = '女' and (hct > 48)) then hct1 = "過高";
if (gender = '女' and (35<= hct <= 48 )) then hct1 = "正常";
else if (gender = '女' and (hct < 48) ) then hct1 = "過低";
if (gender = '男' and (rbc > 6.30)) then rbc1 = "過高";
if (gender = '男' and (4.50<= rbc <= 6.30 )) then rbc1 = "正常";
if (gender = '男' and (rbc < 4.50)) then rbc1 = "過低";
if (gender = '女' and (rbc > 4.00)) then rbc1 = "過高";
if (gender = '女' and (4.00<= rbc <= 5.50 )) then rbc1 = "正常";
else if (gender = '女' and (rbc < 5.50)) then rbc1 = "過低";
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
/*-- 1 --*/
%let indir=C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體;
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
if 睡覺時間 = '每天睡足7~8小時' then v1 = 1;
else if 睡覺時間 = '不足7~8小時' then v1 = 2;
else v1 = 3;

if 早餐習慣 = '每天吃' then v2 = 1;
else if 早餐習慣 = '偶而' then v2 = 2;
else v2 = 3;

if 每週運動３次 = '有' then v3 = 1;
else v3 = 2;

if 吸菸習慣 = '不吸菸' then v4 = 1;
else if 吸菸習慣 = '吸菸' then v4 = 2;
else if 吸菸習慣 = '吸菸約5支/天' then v4 = 3;
else if 吸菸習慣 = '吸菸約15支/天' then v4 = 4;
else v4 =5;

if '常覺得焦慮.憂慮嗎?' = '很少或沒有' then v5 = 1;
else if '常覺得焦慮.憂慮嗎?' = '偶而' then v5 = 2;
else v5 = 3;

if '常覺得胸悶嗎?' = '很少或沒有' then v6 = 1;
else v6 = 2;

if '常曾覺得胃痛嗎?' = '很少或沒有' then v7=1;
else if '常曾覺得胃痛嗎?' = '偶而' then v7 = 2;
else v7 = 3;

if '常曾覺得頭痛嗎?' = '很少或沒有' then v8 = 1;
else if '常曾覺得頭痛嗎?' = '偶而' then v8 = 2;
else v8 = 3;

if 自我健康評估 = '非常好' then v9 = 1;
else if 自我健康評估 = '稍微好' then v9 = 2;
else if 自我健康評估 = '沒有差別' then v9 = 3;
else if 自我健康評估 = '稍微差' then v9 = 4;
else v9 = 5;

score = sum(of v1-v8);
if score  <= 11 then risk = 1;
else if score <= 15 then risk = 2;
else risk = 3;
label risk = '危險程度' v9 = '自我健康評估';
run;
proc format;
value v9f 1='非常好' 2='稍微好' 3='沒有差別' 4='稍微差' 5='非常差';
value riskf 1='低' 2='中' 3='高';
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

v31=index( '系所'n , '系');
v32=index( '系所'n , '班');

 if v32>0 then F3=substr( '系所'n , 1 , index( '系所'n , '班')+1);
else if v31>0 then F3=substr( '系所'n , 1 , index( '系所'n , '系')+1);

if index(v5,'%心臟病%') > 0 then F5a = 1 ;
else F5a = 0;
if index(v5,'%糖尿病%') > 0 then F5b = 1 ;
else F5b = 0;
if index(v5,'%高血壓%') > 0 then F5c = 1 ;
else F5c = 0;

if index(v6,'%過敏%') > 0 then F6 = 1 ;else F6 = 0;

if 吸菸習慣 = '不吸菸' then F7=0;
else if 吸菸習慣 = "吸菸約1支/天" then F7=1;
else if 吸菸習慣 = "吸菸約2支/天" then F7=1;
else if 吸菸習慣 = "吸菸約3支/天" then F7=1;
else if 吸菸習慣 = "吸菸約4支/天" then F7=1;
else if 吸菸習慣 = "吸菸約5支/天" then F7=2;
else if 吸菸習慣 = "吸菸約6支/天" then F7=2;
else if 吸菸習慣 = "吸菸約7支/天" then F7=2;
else if 吸菸習慣 = "吸菸約8支/天" then F7=2;
else if 吸菸習慣 = "吸菸約10支/天" then F7=2;
else if 吸菸習慣 = "吸菸約15支/天" then F7=2;
else if 吸菸習慣 = "吸菸約20支/天" then F7=2;
else if 吸菸習慣 = "吸菸約40支/天" then F7=2;
else F7=3;
run;
proc freq data=ch4d6_1;
tables F5a*F7 F5b*F7 F5c*F7;
run;

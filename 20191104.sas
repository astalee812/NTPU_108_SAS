data ch4a; 
infile "C:\Users\ASUS\Desktop\NTPU\108-1-類別資料分析\catedatach4a.txt";
input   ID    LOW    AGE    LWT    RACE    SMOKE    PTL    HT    UI    FTV     BWT;
run;
proc freq data=ch4a;
table LOW RACE SMOKE PTL HT UI FTV;
run;
/*邊際關聯性:marginal association*/
/*觀看那些變數是可以被合併的! 但也要看相對應的百分比*/
proc freq data=ch4a;
tables (RACE SMOKE PTL HT UI FTV)*LOW/chisq;
run;

proc sgplot data=ch4a;
histogram age;
run;

proc sgplot data=ch4a;
histogram LWT;
run;
/*把變數合併*/
proc format;
value ptlf
0=0
1-high=1;
value ftvf
0=0
1-2 =1
3=2
4-high = 3;
run;
/*找出比較重要的變相*/
proc logistic data=ch4a desc;
class RACE SMOKE PTL HT UI FTV / param=reference;
model low = RACE SMOKE PTL HT UI FTV age lwt / selection=backward sls=0.2;
format ptl ptlf. ftv ftvf.;
run;
/*若偏差及pearson適配度統計值是不拒絕H0，就表示這個模型是是沒有過度離散的*/
/*H0:模型配適符合假設(沒有過度離散)*/
/*Ha: 模型配適不符合假設*/
/*diviance and pearson residual p-value > 0.05*/
/*不拒絕H0表示模型配適符合假設*/


/*接著看勝算比估計值*/
/*黑人母親嬰兒過輕的勝算是白人母親的3.672倍*/
/*其他人種的母親嬰兒過輕的勝算是白人母親的2.350倍*/
/*母親體重每增加一磅，嬰兒過親的勝算下降1.6% (0.984-0.971)*/

proc logistic data=ch4a desc;
class RACE SMOKE PTL HT UI FTV / param=reference ref=first ;
model low = RACE SMOKE PTL HT UI lwt / scale=none aggregate; /*aggregate表示把資料作合併*/
/*Model of fit*/
/*過度離散檢視 P16*/
format ptl ptlf. ftv ftvf.;
run;
/*H0:模型配適符合假設(沒有過度離散)*/
/*Ha: 模型配適不符合假設*/
/*lackfit --- HL test (連續型式解釋變數適用，如果都是離散就不用HL test)*/
/*p=0.2303 > 0.05不拒絕H0, 模型是配符合假設*/
/*建置模型要先看*/
proc logistic data=ch4a desc;
class RACE SMOKE PTL HT UI FTV / param=reference ref=first ;
model low = RACE SMOKE PTL HT UI lwt / scale=none aggregate lackfit; /*aggregate表示把資料作合併*/
format ptl ptlf. ftv ftvf.;
run;

/*檢視極端值以及敏感點*/
/*跑出來的圖是pearson residual*/
/*CI就是Dfbeta中的C，數值不要太大*/
/*第二陀的圖群是刪除前後的狀況*/
/*Dfbeta*/
proc logistic data=ch4a desc;
class RACE SMOKE PTL HT UI FTV / param=reference ref=first ;
model low = RACE SMOKE PTL HT UI lwt /influence ; 
ods output influence=ch4_inf;
id id; /*提供輸出資料編號*/
format ptl ptlf. ftv ftvf.;
run;
proc print data=ch4_inf;
where DifChisq > 9 | HatDiag > 0.7;
run;
/*編號36或77 difference pearson residual > 10*/
/*檢視刪除後的最大概似估計表是否相差太多*/
/*預測機率與觀測回應的關聯性: 看C的數值是否有變好*/
proc logistic data=ch4a(where=(id ^ in (36 77))) desc;
class RACE SMOKE PTL HT UI FTV / param=reference ref=first ;
model low = RACE SMOKE PTL HT UI lwt /influence ; 
ods output influence=ch4_inf;
id id; /*提供輸出資料編號*/
format ptl ptlf. ftv ftvf.;
run;



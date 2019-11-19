data ch3a;
do depart = 1 to 2;
	do gender = 1 to 2;
		do y = 1 to 2;
			input count @@;
			output;
		end;
	end;
end;
cards;
686 1180 468 1259 512 313 89 19
run;
/*conditional independent--CMH test*/
/*Homodenouse association-- Breslow day test*/
proc freq data= ch3a;
weight count;
tables depart*gender*y / cmh; /*Heterogeneous association*/
run;
/*only main effect -- Homodenouse model*/
proc logistic data=ch3a desc;
weight count;
class depart gender / param=reference;
model y=depart gender;
run;
/*include interaction--異質模型，要自己弄勝算比以及信賴區間*/
proc logistic data=ch3a desc;
weight count;
class depart gender / param=reference;
model y=depart gender depart*gender;
run;
/*H0: 同質medol vs. Ha: 異質model(有交互作用的)*/
/*AIC = 5710.989 vs. 5676.131*/
/*LR test = 5704.989 - 5668.131(交互作用值)=36.857 > chi^2_1 =3.84*/


/*CH5建立模型，看預測能力*/
data crab;
infile "C:\Users\ASUS\Desktop\NTPU\108-1-類別資料分析\crab.dat";
input color spine width count weight;
y=(count>0);
/* Color
2=Light
3=Light medium
4=Dark medium
5=Dark*/
/* Spine: 1= Both good; 2= One good; 3= Both bad*/
run;
/*先做篩選! critria不要設的太嚴苛*/
/*跑出來的報表會一步一步刪除變數*/
/*SAS 在sls 跟 sle的預設值都是0.15，老師比較習慣用0.2*/
/*backward*/
proc logistic data=crab desc;
class spine/param=reference;
model y=color spine width weight/ selection=backward sls=0.2;
run;
/*forward*/
proc logistic data=crab desc;
class spine/param=reference;
model y=color spine width weight/ selection=forward sle=0.2;
run;
/*stepwise逐步消去法，sle跟sls都要寫，先forward再backward，刪除的變數有很大原因是因為變數有共線性*/
proc logistic data=crab desc;
class spine/param=reference;
model y=color spine width weight/ selection=stepwise sle=0.2 sls=0.2;
run;

proc logistic data=crab desc plots=(ROC);
model y=color width/ctable;
/* ctable -- Classification table */
run;

/**-----**/
/*ch4*/
/*交互作用*/
data ch3a;
do depart = 1 to 2;
	do gender = 1 to 2;
		do y = 1 to 2;
			input count @@;
			output;
		end;
	end;
end;
cards;
686 1180 468 1259 512 313 89 19
run;
/*conditional independent--CMH test*/
/*Homodenouse association-- Breslow day test*/
proc freq data= ch3a;
weight count;
tables depart*gender*y / cmh; /*Heterogeneous association*/
run;

/*only main effect -- Homodenouse model*//*同質模型*/
proc logistic data=ch3a desc;
weight count;
class depart gender / param=reference;
model y=depart gender;
run;

/*include interaction*//*p27*//*異質模型，sas不會給報表，信賴區間也要自己做(用19頁的變異係數算)*/
/*異質-不同類別的變數對於結果的反應不同*/
proc logistic data=ch3a desc;
weight count;
class depart gender / param=reference;
model y=depart gender depart*gender;
run;

/*處理離散資料*/
proc logistic data =ch3a desc ;
model y=depart gender / scale=none aggregate /*整合資料*/;
/*overdispersion*/
run;
/*唯一設定檔數目: 4 
depart(2個)*gender(2個)=4個
看 SAS 報表中的偏差及 Pearson 配適度統計值
可以發現模型配適不好*/

/*H0 : Homodenouse model v.s. H1 : include interaction*/
/*LR test=5704.989-5668.131=36.857>chi^2_1=3.84*/
/*AIC:5710.989 V.S. 5676.131*/
/*reject H0*/

/*ch5*/
/*預測能力*/

/*p4 
判斷是否要選參數進去
SLE-前進選擇，選擇哪些變數要列入模型
SLS-向後消去，選擇哪些變數要從模型中刪除*/

/*step1. 先抓大概，critria不要設的太嚴苛*/
/*跑出來的報表會一步一步刪除變數*/
data crab;
infile "C:\Users\carol\Downloads\crab.dat";
input color spine width count weight;
y=(count>0);
run;

/*向後消去法*/
proc logistic data=crab desc;
class spine/param=reference;
model y=color spine width weight/ selection=backward sls=0.2/*critria*/;
run;

/*前進選擇法*/
proc logistic data=crab desc;
class spine/param=reference;
model y=color spine width weight/ selection=forward sle=0.2/*critria*/;
run;

/*逐步會參考進入跟刪除的門檻*/
/*先進入一個，選第二個進入，判斷是否符合後，刪除一個*/
/*若變數有共線性，容易被刪掉*/

/*判定係數-  R^2，會隨著參數變多，越變越大
概式函數也有一樣的趨勢
如果上升的值不夠快，就不要這個模型了
AIC->要選AIC最小的，才是適合的模型
*/

/*p9 
敏感性-Sensitivity , a/(a+b)，其介於0~100％，意思是「罹患疾病且篩檢為陽性者的機率」
特異性-Specificity ，d/(c+d)，其介於0~100％，意思是「無罹患疾病且篩檢為陰性者的機率」
判斷模型好不好，是一個條件機率*/

/*p11
receiver operating characteristic (ROC) 
用敏感性跟特異性做出的圖*/

/*P13
concordance index - ROC曲線以下的面積
和諧/不和諧百分比 - 觀察及預測結果的一致性或不一致
https://statisticalanalysisconsulting.com/proc-logistic-concordant-and-discordant/*/

proc logistic data =crab desc plots=(ROC);
model y=color width / ctable ;
run;

/*調整類別模型方法
ch2 p36 去改分配
ch5 p16 增加擾動參數
https://www.itread01.com/content/1548069156.html*/


/*檢查有沒有過度離散*/
proc logistic data =crab desc ;
model y=color width / scale=none/*1*/ aggregate /*整合資料*/;
/*overdispersion*/
run;

/*唯一設定檔數目: 108 
變數太多，算不準確
p16 搭配 SAS 報表中的偏差及 Pearson 配適度統計值 
X^2 : Pearson
D : 偏差*/

/*修正過度離散，不會影響估計值*/
proc logistic data =crab desc;
model y=color width / scale=p/*Pearson*/ aggregate;
/*overdispersion*/
run;

 
/* 整併方法，避免連續資料讓n太大
1.合併估計的機率值
2.合併一個一個區間 (HL檢定) : 檢視模型配適----ch5 P17*/
proc logistic data =crab desc;
model y=color width / scale=p/*Pearson*/ aggregate lackfit/*HL檢定*/;
/*overdispersion*/
run;
/*Hosmer 及 Lemeshow 配適度檢定
p值不顯著，拒絕H1，表示模型是好的
從108個收斂到10個變數*/
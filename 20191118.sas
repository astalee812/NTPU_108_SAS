data ch5d2;
      length Response $12;
      input Volume Rate Response @@;
      LogVolume=log(Volume);
      LogRate=log(Rate);
      datalines;
   3.70  0.825  constrict       3.50  1.09   constrict
   1.25  2.50   constrict       0.75  1.50   constrict
   0.80  3.20   constrict       0.70  3.50   constrict
   0.60  0.75   no_constrict    1.10  1.70   no_constrict
   0.90  0.75   no_constrict    0.90  0.45   no_constrict
   0.80  0.57   no_constrict    0.55  2.75   no_constrict
   0.60  3.00   no_constrict    1.40  2.33   constrict
   0.75  3.75   constrict       2.30  1.64   constrict
   3.20  1.60   constrict       0.85  1.415  constrict
   1.70  1.06   no_constrict    1.80  1.80   constrict
   0.40  2.00   no_constrict    0.95  1.36   no_constrict
   1.35  1.35   no_constrict    1.50  1.36   no_constrict
   1.60  1.78   constrict       0.60  1.50   no_constrict
   1.80  1.50   constrict       0.95  1.90   no_constrict
   1.90  0.95   constrict       1.60  0.40   no_constrict
   2.70  0.75   constrict       2.35  0.03   no_constrict
   1.10  1.83   no_constrict    1.10  2.20   constrict
   1.20  2.00   constrict       0.80  3.33   constrict
   0.95  1.90   no_constrict    0.75  1.90   no_constrict
   1.30  1.625  constrict
   ;
proc logistic data=ch5d2 
	plots(only label)=(phat leverage dpc); /*label協助標示observation*/
      model Response=LogRate LogVolume;
run;
/* dpc -- 
		(1)  plots the deletion diagnostics against the predicted 
				probabilities
		(2) colors the observations according to the confidence 
				interval displacement diagnostic 
*/
data belief;
do race='W', 'B';
	do gender='F', 'M';
		do belief=2, 1, 0;
			input count @@;
			output;
		end;
	end;
end;
cards;
371 49 74 250 45 71
64 9 15 25 5 13
run;
/*
會給兩個模型，就會有兩個對應的解釋，在類別層級資訊上，0就是baseline
在最大概似估計分析表中，會寫出是屬於類別1or類別2
以no(不相信)為基準組別，類別2(相信)的會在同一個model, 類別1(沒意見)的會在同一個model

log(\hat{pi}(yes)/ \hat{pi}(no))=1.2248-0.342 Race+0.4186Sex
log(\hat{pi}(un)/ \hat{pi}(no))=0.4871-0.2712 Race+0.1051Sex

女性相信輪迴的勝算是男性的1.52倍
女性對輪迴沒意見的勝算是男性的1.11倍
*/
proc logistic data=belief desc;
weight count;
class race gender/param=reference;
model belief=race gender / link=glogit; /*link=glogit累積勝算*/
run;

data political;
do i=1 to 5;
	do party='D', 'R';
		input count @@;
		output;
	end;
end;
cards;
80 81 171 41 55
30 46 148 84 99
run;
/* 累積機率
log(P[Y le 1] / P[Y>1]) = -1.8749+0.7205 D
logit(P[Y le 2]) = -0.6206 + 0.7205 D
logit(P[Y le 3]) = -0.1791 + 0.7205 D
logit(P[Y le 4]) = 0.9459 + 0.7205 D
民主黨比較liberal的勝算是共和黨的2.055倍
*/
proc logistic data=political desc;
weight count;
class party/param=ref; /*預設設定(最後一組)D比上R*/
model i=party/link=clogit; /*預設*/
run;
/*
民主黨比較conservative的勝算是共和黨的0.487倍
*/

/*
等比例勝算--分數檢定score test
H0:等比例勝算 v.s. Ha not H0
p value<0.0001 拒絕H0
資料不符合比例勝算假設
*/
proc logistic data=political desc;
weight count;
class party/param=ref ref=first; /*設定R比上D*/
model i=party/link=clogit; /*預設*/
run;

/* 鄰近類別勝算
log(P[Y = 1] / P[Y=2]) = -0.4663+0.3011 D
logit(P[Y = 2]) = 0.7445 + 0.3011 D
logit(P[Y le 3]) = -0.9721 + 0.3011 D
logit(P[Y le 4]) = -0.0662 + 0.3011 D
民主黨比較liberal的勝算是共和黨的1.351倍 (關聯對比累積機率來說會小一些)
*/
proc logistic data=political;
weight count;
class party/param=reference;
model i=party/link=alogit; /*adjacent categories logits*/
run;



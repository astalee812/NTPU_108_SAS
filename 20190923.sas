/* practice ch2 P43.*/
data d2;
input school$ genic$ count;
cards;
1 1 90
1 2 12 
1 3 78
2 1 13
2 2 1
2 3 6
3 1 19
3 2 13
3 3 50
;
run;
proc freq data =  d2;
weight count;
table school * genic / chisq ;
run;
/*trend analysis*/
data alco;
input status alco count;
cards;
0 0 17066
0 0.5 14464
0 1.5 788
0 4 126
0 7 37
1 0 48
1 0.5 38
1 1.5 5
1 4 1
1 7 1
run;
proc freq data=alco;
weight count;
table alco* status / trend;
run;
/*gamma analysis*/
/*結果 : 常用gamma 跟 pearson相關，但沒有組數，需要自己算*/
data gamma;
do income=7.5,20,32.5,60;
 do sat =1 to 4;
  input count @@; /*@@連續輸入不換行*/
  output;
 end;
end;
cards;
1 3 10 6
2 3 10 7
1 6 14 12
0 1 9 11
run;
proc freq data=gamma;
weight count;
table income*sat / measures;
run;
/*fisher test : 這個是不顯著*/
/*exact 會用數值*/
/*結果: 下方表格表示n(1,1)=3的機率*/
data tea;
input row column count;
cards;
0 0 3
0 1 1
1 0 1
1 1 3
run;
proc freq data=tea;
weight count;
table row*column / fisher exact;
run;
/**/
/*第一張是CMH的檢定，條件的線性相關是否存在*/
/*第二張是每列的平均差異，等同於ANOVA，純粹做關聯*/
		/*為什麼這張的數字都一樣? 因為我們是2*2的資料，所以做出來的結果會相同*/
/*第三張是檢測有沒有同質性! Breslow Day test*/
/*這邊的勝算比我看不太懂...*/
data penalty;
do vrace=0 to 1 ;
	do drace=0 to 1 ;
		do death = 0 to 1;
			input count@@;
			output;
		end;
	end;
end;
cards;
414 53 37 11 16 0 139 4
run;
proc freq data=penalty; weight count; tables vrace*drace*death / cmh ; run;
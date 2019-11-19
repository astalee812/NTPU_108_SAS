libname dir "C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體";
/*Chapter 3, page 17*/
proc print data=dir.tennis (obs=10);
run;

proc format;
	value x3f 1="男" 2="女";
	value x5f 1="正常" 2="稍大" 3="過大";
	value x6f 1="重" 2="適中" 3="輕" 4="不知道";
	value x7f 1="木頭" 2="鋁" 3="玻璃纖維" 4="石墨" 5="鋼" 6="合成" 7="其他";
	value x8f 1="尼龍線" 2="腸線" 3="不知道";
run;

data tennis;
set dir.tennis;
format x3 x3f. 
  x5 x9 x5f.
  x6 x10 x6f.
  x7 x11 x7f.
  x8 x12 x8f.;
run;
proc print data=tennis (obs=10) label;
run;

data tennis;
set tennis;
where x5 ne 9 and x8 ne 9;
run;

proc gchart data=tennis;
/*hbar x7/discrete descending type=percent;*/
/*hbar x7/discrete cfreq percent percentlabel="哈哈";*/
/*hbar x7/discrete ;*/
/*hbar x7/discrete autoref;*/
/*hbar x7/discrete autoref ref=(25,30) clipref;*/
/*hbar x7/discrete caxis=red cframe=green coutline=yellow ctext=pink;*/
/*hbar x7/discrete width=10 space=5 woutline=3;*/
hbar x7/discrete;
hbar x7/discrete autoref lautoref=3 wautoref=3;
run;

proc gchart data=tennis;
/*hbar x7/discrete descending type=percent; /*給垂直座標軸變數 並且給離散變數名稱 降冪排序 然後用百分比*/
hbar x7/discrete freq cpercent cpercentlabel="哈哈"; /*選定後表格旁要呈現的資訊 次數 及累計百分比 */
hbar x7/discrete autoref ref=(25,30) clipref;/*給參考線 在25,30 加上線 把線藏到後面*/
hbar x7/discrete autoref lautoref=3 wautoref=6;/*參考線粗細*/
hbar x7/discrete caxis=red cframe=yellow coutline=purple ctext=brown ;/*上色*/
hbar x7/discrete width=10 space=5 woutline=3;/*調整寬度 間距 直方圖外框線*/
run;

proc gchart data=tennis;
hbar x3/discrete autoref clipref type=pct freq group=x7
hbar x3/discrete autoref clipref type=pct freq group=x7/*group可將資料分類*/
gspace=2;
hbar x3/discrete clipref type=pct freq subgroup=x8/*subgroup可將兩條線合併在一起表示，紅色代表A，藍色代表B*/
gspace=2;
hbar x3/discrete clipref type=pct freq subgroup=x8 group=x7
gspace=2;
run;

proc freq data=tennis;
table x3*x7/chisq;
table x7*x3*x8;
run;

/*是軸!! 是軸!! 是軸阿!!*/
/*軸是可以被編號的!*/
proc gchart data=tennis;
hbar x3/discrete;
run;
axis label=("比") offset=(1cm, 2cm);
proc gchart data=tennis;
hbar x3 / discrete raxis=axis;
run;

axis major = (height = 1cm color=blue);
proc gchart data=tennis;
hbar x3 / discrete raxis=axis;
run;

axis minor= none;
proc gchart data=tennis;
hbar x3 / discrete raxis=axis;
run;

axis minor= (height = 1cm color=red number=2);
proc gchart data=tennis;
hbar x3 / discrete raxis=axis;
run;

axis label=(angle=90 "Gender");
proc gchart data=tennis;
hbar x3 / discrete maxis=axis; /*修改M軸*/
run;

axis label=( "Gender");
proc gchart data=tennis;
hbar x3 / discrete maxis=axis; 
run;

axis label=(rotate=45 "Gender");
proc gchart data=tennis;
hbar x3 / discrete maxis=axis; 
run;

axis value=(color=blue "BB"  color=red "GG");
proc gchart data=tennis;
hbar x3 / discrete maxis=axis; 
run;

axis value=(tick=1 color=blue "BB" j=r "oy" 
					  tick=2 color=red "GG");
proc gchart data=tennis;
hbar x3 / discrete maxis=axis; 
run;

axis order= (2 1);
proc gchart data=tennis;
hbar x3 / discrete maxis=axis; 
run;

goptions reset=axis;/*把軸設定都忘掉*/
goptions reset=all; /*把所有設定都忘掉*/

legend1 label=("ABC") value=("N" "G");
proc gchart data=tennis;
hbar x3 / discrete subgroup=x8 legend=legend1; 
run;

legend1 label=("ABC") value=("N" "G")
				position=(top left inside); /*中間偏左的框框內*/
proc gchart data=tennis;
hbar x3 / discrete subgroup=x8 legend=legend1; 
run;

legend1 label=("ABC") value=("N" "G")
				position=(bottom right inside); /*中間偏左的框框內*/
proc gchart data=tennis;
hbar x3 / discrete subgroup=x8 legend=legend1; 
run;

legend2 origin=(3cm 2cm);
proc gchart data=tennis;
hbar x3 / discrete subgroup=x8 legend=legend2; 
run;

legend2 offset=(1cm 2cm) origin=(3cm 2cm);
proc gchart data=tennis;
hbar x3 / discrete subgroup=x8 legend=legend2; 
run;

legend3 order=(2 1) shape=bar(10,2);
proc gchart data=tennis;
hbar x3 / discrete subgroup=x8 legend=legend3; 
run;

axis1 order=(5 2 3 1 4);
proc gchart data=tennis;
hbar x3 / discrete group=x7 subgroup=x8 gaxis=axis1; 
run;

proc means data=tennis;
var x2;
run;

proc gchart data=tennis;
hbar x2/space=0 range levels=5; /*levels是把數值切成五格*/
run;

proc gchart data=tennis;
hbar x2/space=0 range midpoints=(17 to 62 by 5);
run;

proc gchart data=tennis;
hbar x2/space=0 range midpoints=(17 to 62 by 5)discrete; /*精準切給你數字*/
run;

proc gchart data=tennis;
hbar x2/space=0 range levels=5;
vbar x2/space=0 range width=10;
block x2/levels=5;
run;

proc gchart data=tennis;
hbar x2/space=0 range  midpoints=(15 to 65 by 10);
vbar x2/space=0 range  midpoints=(15 to 65 by 10) width=10;
block x2/ midpoints=(15 to 65 by 10);
run;

proc gchart data=tennis;
pie x2/ midpoints=(15 to 65 by 10);
run;

proc gchart data=tennis;
block x5 / discrete group=x3 subgroup=x8; /*立體直方圖! 然後有分組*/
run;

proc gchart data=tennis;
pie x5/ discrete;
run;

proc gchart data=tennis;
pie x5/ discrete angle=95;
run;

proc freq data=tennis;
table x5;
run;
proc gchart data=tennis;
pie x5/ discrete angle=95;
run;

proc gchart data=tennis;
pie x5/ discrete explode=(1 3); /*圓餅圖突出!*/
run;

proc gchart data=tennis;
pie x5/ noheading descending clockwise ;
run;

proc gchart data=tennis;
pie x5/ noheading descending clockwise other=23 otherlabel="other" ;
run;

proc gchart data=tennis;
pie3d x5/ discrete explode=(2 3);
run;

proc gchart data=tennis;
pie x5/ discrete value=arrow detail=x8;
run;
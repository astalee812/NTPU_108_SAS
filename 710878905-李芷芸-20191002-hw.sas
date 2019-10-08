/* 1 */
/*a*/
proc import datafile="C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\homework\statpack104fHW3_1.csv"
out=bank dbms=csv replace;
getnames=yes;
run;
/*b*/
data bank2;
set bank;
label id="編號" /*變數註解*/
        salbeg="起薪"
        age="年齡"
        salnow="現在的薪水"
        edlevel="教育程度"
        work="工作經驗"
        jobscat="工作類型"
        minority="種族"
  gender="性別";
run;

/*c*/
proc sort;
by gender minority salnow;
run;

/*d*/
proc print data=bank2 label sumlabel; 
by  gender minority;
var id work age edlevel jobcat salnow;
format id id. work work. age age. edlevel edlevel.  /*數值註解*/
    jobcat jobcat. salnow salnow.;
sum salnow;
run;


/* 2 */
/*a*/
data old;
infile "C:\Users\ASUS\Desktop\NTPU\108-1-統計套裝軟體\homework\statpack104fHW3_2.txt";
input a $ 1 b $ 5-8 c 10/
        d e 5 / /
        f g h i j k /
  l 1-3 m 10-12 n o p;
label a="年齡"        b="編號"        c="行政區"        d="婚姻"        e="居住狀況"        f="健康情形"        g="健康情形(與過去相比)"
        h="高血壓"  i="糖尿病"  j="中風"        k="疼痛"        l="身高"        m="體重"        n="工作狀況"        o="收入狀況"        p="收入";
run;
proc print; run;
/*b*/
proc format;
value $a "A" = "50-66yrs(in 1996)" "B"="67+yrs(in 1996)";
value c 1 = "直轄市" 2 = "省轄市" 3 = "縣轄市" 4= "鎮" 5 = "鄉";
value d 1 = "已婚，配偶健在" 2 = "有同居老伴" 3 = "喪偶，未再婚" 
     4= "離婚，未再婚" 5 = "正式分居" 6="從未結婚";
value e 1 = "長久住" 2 = "輪流住" 3 = "長住，常探望他人" 
     4= "非長久居住在此" 5 = "其他" 9="不詳";
value f  1 = "很好" 2 = "好" 3="普通" 4="不太好" 5="很不好";
value g  1 = "較好" 2 = "差不多" 3="較差";
value h 1 = "有" 2 = "不詳" 0="沒有或不知道";
value i  1 = "有" 2 = "不詳" 0="沒有或不知道";
value j  1 = "有" 2 = "不詳" 0="沒有或不知道";
value k  1 = "沒有" 2 = "輕微不詳" 3="中度" 4="較嚴重(可忍受)" 5="非常嚴重(無法忍受)" 8="不適用" 9="不詳";
value l  998 = "不知道" 999 = "不詳";
value m  998 = "不知道" 999 = "不詳";
value n  1 = "目前有工作" 2 = "有一份工作，但暫時沒有去做" 3="僅幫助家中生意" 
   4="沒有工作，正在找工作" 5="家管" 6="沒有做上述工作" 9="不詳";
value o  1 = "有" 0 = "沒有" 9="不詳";
run;
/*c*/
proc sort ; by a c;run;

/*d*/
proc print data=old label ; 
by  a c;
var b f g h i j k;
format f f. g g. h h. i i. j j. k k.;
run;

/*e*/
proc print data=old label sumlabel; 
where o=1;
by a c;
var l m n o p;
format l l. m m. n n. o o. p p.;
sum o p;
run;
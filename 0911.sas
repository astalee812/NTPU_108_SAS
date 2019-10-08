data ds1;
input @1 trt @3 mi @5 counts 4.;
cards;
0 1    18
0 2   171
0 3 10845
1 1     5
1 2    99
1 3 10933
;
run;

data ds4;
input trt mi counts @@;
cards;
0 1 18 0 2 171 0 3 10845
1 1 5 1 2 99 1 3 10933
run;

proc contents data=ds4;
run;

data ds5;
input @1 trt $ @3 mi $3. @6 counts;
cards;
P FA 18
P NFA 171
P NA 10845
A FA 5
A NFA 99
A NA 10933
run;

data ds7;
input @12 day mmddyy10.;
cards;
 12HELLO  310/21/1946  
4 5GOODBYE611/12/1997
run;

proc contents data=ds5;
run;

data ds9;
input a b name $ 5-20 @21 m comma5. @27 tax dollar6.;
cards;
1 2 Hillary Clinton 3,234 $5,548
4 5 Donald Trump    6,735 $6,567
run;